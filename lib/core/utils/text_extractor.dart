// lib/features/scan/utils/text_extractor.dart
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sync_pdf;

// ─────────────────────────────────────────────────────────────────────────────
// Résultat enrichi : texte + chemins vers les régions visuelles détectées
// ─────────────────────────────────────────────────────────────────────────────

class ExtractionResult {
  final String text;

  /// Chemins locaux vers les images à afficher dans l'éditeur.
  /// - PDF  : rendu de chaque page en PNG (via pdfx)
  /// - Image: zones sans texte détectées (figures, schémas, dessins…)
  final List<String> imagePaths;

  const ExtractionResult({required this.text, required this.imagePaths});
}

// ─────────────────────────────────────────────────────────────────────────────
// Point d'entrée principal
// ─────────────────────────────────────────────────────────────────────────────

Future<ExtractionResult> extractFromFile(dynamic file) async {
  try {
    String path;
    if (file is PlatformFile) {
      if (file.path == null) {
        return const ExtractionResult(text: "Fichier invalide", imagePaths: []);
      }
      path = file.path!;
    } else if (file is String) {
      path = file;
    } else {
      return const ExtractionResult(
        text: "Erreur : format de fichier non supporté",
        imagePaths: [],
      );
    }

    final extension = path.split('.').last.toLowerCase();

    if (extension == 'pdf') return _extractFromPdf(path);
    if (['jpg', 'jpeg', 'png'].contains(extension)) {
      return _extractFromImage(path);
    }
    return ExtractionResult(
      text: "Format non supporté : .$extension",
      imagePaths: [],
    );
  } catch (e) {
    return ExtractionResult(text: "Erreur d'extraction : $e", imagePaths: []);
  }
}

/// Compat descendante — retourne uniquement le texte
Future<String> extractTextFromFile(dynamic file) async =>
    (await extractFromFile(file)).text;

// ─────────────────────────────────────────────────────────────────────────────
// PDF
// Texte  → SyncfusionPDF
// Images → pdfx (remplace pdf_render, compatible Flutter moderne / NDK 27+)
// ─────────────────────────────────────────────────────────────────────────────

Future<ExtractionResult> _extractFromPdf(String path) async {
  final fileBytes = await File(path).readAsBytes();
  final document = sync_pdf.PdfDocument(inputBytes: fileBytes);
  final tempDir = await getTemporaryDirectory();

  final StringBuffer fullText = StringBuffer();
  final List<String> imagePaths = [];

  // 1. Texte page par page via Syncfusion
  for (int i = 0; i < document.pages.count; i++) {
    fullText.write("=== Page ${i + 1} ===\n\n");
    final pageText = sync_pdf.PdfTextExtractor(
      document,
    ).extractText(startPageIndex: i, endPageIndex: i);
    fullText.write(pageText.trimRight());
    fullText.write("\n\n\n");
  }
  document.dispose();

  // 2. Rendu visuel de chaque page via pdfx
  try {
    final pdfDoc = await PdfDocument.openFile(path);
    for (int i = 1; i <= pdfDoc.pagesCount; i++) {
      try {
        final page = await pdfDoc.getPage(i);
        final pageImage = await page.render(
          width: page.width * 2,
          height: page.height * 2,
          format: PdfPageImageFormat.png,
        );
        await page.close();
        if (pageImage != null) {
          final pngPath = '${tempDir.path}/pdf_page_$i.png';
          await File(pngPath).writeAsBytes(pageImage.bytes);
          imagePaths.add(pngPath);
        }
      } catch (_) {}
    }
    await pdfDoc.close();
  } catch (_) {}

  return ExtractionResult(text: fullText.toString(), imagePaths: imagePaths);
}

// ─────────────────────────────────────────────────────────────────────────────
// Image PNG/JPG
// ─────────────────────────────────────────────────────────────────────────────

Future<ExtractionResult> _extractFromImage(String path) async {
  final inputImage = InputImage.fromFilePath(path);
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  final recognizedText = await textRecognizer.processImage(inputImage);
  textRecognizer.close();

  // Texte : logique originale inchangée
  final text = _reconstructSpatialLayout(recognizedText);

  // Images : zones visuelles sans texte
  final imagePaths = await _detectImageRegions(path, recognizedText);

  return ExtractionResult(text: text, imagePaths: imagePaths);
}

// ─────────────────────────────────────────────────────────────────────────────
// Détection des régions visuelles (figures, dessins, schémas)
//
// Algorithme :
//  1. Masque booléen ligne par ligne : chaque ligne Y couverte par un bloc
//     OCR est marquée "texte".
//  2. Scan des plages continues de lignes NON-texte → zones candidates.
//  3. Filtrage :
//     - hauteur < MIN_RATIO * imgH  → trop petit (interligne, marge)
//     - contenu quasi-blanc          → fond vide sans dessin
//  4. Rognage + sauvegarde PNG temporaire.
// ─────────────────────────────────────────────────────────────────────────────

const double _minRegionRatio = 0.06;
const int _cropPadding = 8;

Future<List<String>> _detectImageRegions(
  String imagePath,
  RecognizedText recognized,
) async {
  final List<String> result = [];
  try {
    final raw = await File(imagePath).readAsBytes();
    final decoded = img.decodeImage(raw);
    if (decoded == null) return result;

    final int imgH = decoded.height;
    final int imgW = decoded.width;
    final tempDir = await getTemporaryDirectory();

    // Cas trivial : zéro texte → toute la page est une figure
    if (recognized.blocks.isEmpty) {
      result.add(imagePath);
      return result;
    }

    // 1. Masque ligne par ligne
    final List<bool> lineHasText = List.filled(imgH, false);
    for (final block in recognized.blocks) {
      final top = block.boundingBox.top.floor().clamp(0, imgH - 1);
      final bottom = block.boundingBox.bottom.ceil().clamp(0, imgH - 1);
      for (int y = top; y <= bottom; y++) {
        lineHasText[y] = true;
      }
    }

    // 2 & 3. Plages sans texte + filtrage
    final double minHeight = imgH * _minRegionRatio;
    int? regionStart;

    void flush(int endExclusive) {
      if (regionStart == null) return;
      final int rTop = regionStart!;
      final int rBot = endExclusive - 1;

      if ((rBot - rTop) >= minHeight) {
        final int cropTop = (rTop - _cropPadding).clamp(0, imgH - 1);
        final int cropBot = (rBot + _cropPadding).clamp(0, imgH - 1);
        final int cropH = cropBot - cropTop + 1;

        if (cropH > 0) {
          final cropped = img.copyCrop(
            decoded,
            x: 0,
            y: cropTop,
            width: imgW,
            height: cropH,
          );
          if (!_isBlank(cropped)) {
            final ts = DateTime.now().microsecondsSinceEpoch;
            final p = '${tempDir.path}/region_$ts.png';
            File(p).writeAsBytesSync(img.encodePng(cropped));
            result.add(p);
          }
        }
      }
      regionStart = null;
    }

    for (int y = 0; y < imgH; y++) {
      if (!lineHasText[y]) {
        regionStart ??= y;
      } else {
        flush(y);
      }
    }
    flush(imgH);
  } catch (_) {}

  return result;
}

/// Retourne true si > 97 % des pixels échantillonnés sont quasi-blancs (luma > 240).
bool _isBlank(img.Image region) {
  int total = 0;
  int bright = 0;
  for (int y = 0; y < region.height; y += 2) {
    for (int x = 0; x < region.width; x += 2) {
      final pixel = region.getPixel(x, y);
      final luma = (0.299 * pixel.r + 0.587 * pixel.g + 0.114 * pixel.b)
          .round();
      if (luma > 240) bright++;
      total++;
    }
  }
  if (total == 0) return true;
  return (bright / total) > 0.97;
}

// ─────────────────────────────────────────────────────────────────────────────
// Reconstruction spatiale OCR — logique originale inchangée
// ─────────────────────────────────────────────────────────────────────────────

String _reconstructSpatialLayout(RecognizedText recognizedText) {
  final List<_TextElement> elements = [];

  for (final block in recognizedText.blocks) {
    for (final line in block.lines) {
      for (final element in line.elements) {
        final bbox = element.boundingBox;
        elements.add(
          _TextElement(
            text: element.text,
            top: bbox.top,
            bottom: bbox.bottom,
            left: bbox.left,
            right: bbox.right,
          ),
        );
      }
    }
  }

  if (elements.isEmpty) return "";

  elements.sort((a, b) {
    final avgHeight = (a.height + b.height) / 2;
    final tolerance = avgHeight * 0.6;
    final aCenterY = (a.top + a.bottom) / 2;
    final bCenterY = (b.top + b.bottom) / 2;
    if ((aCenterY - bCenterY).abs() <= tolerance) {
      return a.left.compareTo(b.left);
    }
    return aCenterY.compareTo(bCenterY);
  });

  final List<List<_TextElement>> rows = [];
  List<_TextElement> currentRow = [elements.first];

  for (int i = 1; i < elements.length; i++) {
    final prev = currentRow.last;
    final curr = elements[i];
    final avgHeight = (prev.height + curr.height) / 2;
    final tolerance = avgHeight * 0.6;
    final prevCenterY = (prev.top + prev.bottom) / 2;
    final currCenterY = (curr.top + curr.bottom) / 2;

    if ((currCenterY - prevCenterY).abs() <= tolerance) {
      currentRow.add(curr);
    } else {
      rows.add(currentRow);
      currentRow = [curr];
    }
  }
  rows.add(currentRow);

  double pageWidth = 0;
  for (final el in elements) {
    if (el.right > pageWidth) pageWidth = el.right;
  }
  final double spaceUnit = pageWidth * 0.01;

  final StringBuffer buffer = StringBuffer();

  for (int rowIdx = 0; rowIdx < rows.length; rowIdx++) {
    final row = rows[rowIdx];
    final StringBuffer rowBuffer = StringBuffer();

    for (int i = 0; i < row.length; i++) {
      if (i == 0) {
        rowBuffer.write(row[i].text);
      } else {
        final gap = row[i].left - row[i - 1].right;
        if (gap > spaceUnit * 3) {
          final spacesToInsert = (gap / spaceUnit).round().clamp(2, 12);
          rowBuffer.write(' ' * spacesToInsert);
        } else {
          rowBuffer.write(' ');
        }
        rowBuffer.write(row[i].text);
      }
    }

    buffer.write(rowBuffer.toString());

    if (rowIdx < rows.length - 1) {
      final currRowBottom = row
          .map((e) => e.bottom)
          .reduce((a, b) => a > b ? a : b);
      final nextRowTop = rows[rowIdx + 1]
          .map((e) => e.top)
          .reduce((a, b) => a < b ? a : b);
      final verticalGap = nextRowTop - currRowBottom;
      final avgLineHeight =
          row.map((e) => e.height).reduce((a, b) => a + b) / row.length;

      if (verticalGap > avgLineHeight * 1.5) buffer.write('\n');
      buffer.write('\n');
    }
  }

  return buffer.toString();
}

class _TextElement {
  final String text;
  final double top, bottom, left, right;

  _TextElement({
    required this.text,
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
  });

  double get height => bottom - top;
}
