import 'package:drift/drift.dart';
import 'package:edusav/common/services/database_services.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/core/di/current_user_provider.dart';
import 'package:edusav/features/auth/domain/auth_user.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final scanSaveProvider = Provider<ScanSaveService>((ref) {
  final db = ref.watch(databaseServiceProvider);
  final user = ref.watch(currentUserProvider);
  return ScanSaveService(db, user);
});

class ScanSaveService {
  final DatabaseService db;
  final AuthUser? currentUser;

  ScanSaveService(this.db, this.currentUser);

  Future<String> saveLesson({
    required String matiereId,
    required String titre,
    required List<dynamic> pages, // Liste des fichiers (PlatformFile ou String)
    String? niveauId,
    String? ecoleId,
  }) async {
    if (currentUser == null) throw Exception("Utilisateur non connecté");

    final uuid = const Uuid();
    final leconId = uuid.v4();

    // 1. Créer la Leçon
    await db.lecons.insert(
      LeconsCompanion.insert(
        id: leconId,
        titre: titre,
        matiereId: Value(matiereId),
        niveauId: Value(niveauId),
        ecoleId: Value(ecoleId),
        auteurId: Value(currentUser!.id),
        visibilite: Value('PRIVE'),
        dateUpd: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    // 2. Créer les Pages
    for (int i = 0; i < pages.length; i++) {
      final file = pages[i];
      final pageId = uuid.v4();
      final imagePath = file is PlatformFile ? file.path : file.toString();

      await db.pages.insertPage(
        PagesCompanion.insert(
          id: pageId,
          leconId: leconId,
          numeroPage: i + 1,
          cheminImage: Value(
            imagePath ?? '',
          ), // Chemin de l'image // À remplir plus tard avec OCR
          ordre: i,
        ),
      );
    }

    return leconId;
  }
}
