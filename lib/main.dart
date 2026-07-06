import 'package:camera/camera.dart';
import 'package:edusav/common/services/seed_service.dart';
import 'package:edusav/core/di/providers.dart';
import 'package:edusav/core/theme/app_theme.dart';
import 'package:edusav/features/auth/login_screen.dart';
import 'package:edusav/features/auth/register_screen.dart';
import 'package:edusav/features/flop/create_flashcard.dart';
import 'package:edusav/features/home/home_screen.dart';
import 'package:edusav/features/scan/camera_init.dart';
import 'package:edusav/features/scan/camera_scan_screen.dart';
import 'package:edusav/features/scan/confirm_pages_screen.dart';
import 'package:edusav/features/scan/edit_screen.dart';
import 'package:edusav/features/scan/import_document_screen.dart';
import 'package:edusav/features/scan/scan_options_screen.dart';
import 'package:edusav/features/scan/select_level_screen.dart';
import 'package:edusav/features/scan/select_subject_screen.dart';
import 'package:edusav/features/search/search_screen.dart';
import 'package:edusav/features/splash/splash_screen.dart';
import 'package:edusav/features/subjects/lesson_cahier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // recommandé pour shared_preferences / secure_storage

  final container = ProviderContainer();
  final seedService = container.read(seedServiceProvider);

  await seedService.initializeRoles();
  await seedService.initializeAdminUser();

  await initCamera();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'EDUSAV',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fr', 'FR'), Locale('en', 'US')],

      initialRoute: '/splash',

      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/select-level': (context) => const SelectLevelScreen(),
        '/select-subject': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return SelectSubjectScreen(
            niveauName: args['niveauName'] ?? '',
            ecoleName: args['ecoleName'] ?? '',
            niveauId: args['niveauId'] ?? '',
            ecoleId: args['ecoleId'] ?? '',
          );
        },
        '/scan-options': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return ScanOptionsScreen(
            niveauName: args['niveauName'] ?? '',
            ecoleName: args['ecoleName'] ?? '',
            matiereName: args['matiereName'] ?? '',
            matiereId: args['matiereId'] ?? '',
            niveauId: args['niveauId'] ?? '',
            ecoleId: args['ecoleId'] ?? '',
          );
        },
        '/camera-scan': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return CameraScanScreen(
            matiereId: args['matiereId'] ?? '',
            matiereName: args['matiereName'] ?? '',
            niveauId: args['niveauId'] ?? '',
            ecoleId: args['ecoleId'] ?? '',
            niveauName: args['niveauName'] ?? '',
            ecoleName: args['ecoleName'] ?? '',
          );
        },
        '/import-document': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return ImportDocumentScreen(
            matiereId: args['matiereId'] ?? '',
            matiereName: args['matiereName'] ?? '',
            niveauId: args['niveauId'] ?? '',
            ecoleId: args['ecoleId'] ?? '',
            niveauName: args['niveauName'] ?? '',
            ecoleName: args['ecoleName'] ?? '',
          );
        },
        '/confirm-pages': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
          return ConfirmPagesScreen(
            files: args['files'] ?? [],
            matiereId: args['matiereId'] ?? '',
            matiereName: args['matiereName'] ?? '',
            niveauId: args['niveauId'] ?? '',
            ecoleId: args['ecoleId'] ?? '',
            niveauName: args['niveauName'] ?? '',
            ecoleName: args['ecoleName'] ?? '',
            source: args['source'] ?? 'scan',
          );
        },
        '/edit-text': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
          return EditTextScreen(
            pages: args['pages'] ?? [],
            matiereId: args['matiereId'] ?? '',
            matiereName: args['matiereName'] ?? '',
            niveauId: args['niveauId'] ?? '',
            ecoleId: args['ecoleId'] ?? '',
            niveauName: args['niveauName'] ?? '',
            ecoleName: args['ecoleName'] ?? '',
          );
        },
        '/lesson-cahier': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
          return LessonCahierScreen(
            matiereId: args['matiereId'] ?? '',
            matiereName: args['matiereName'] ?? '',
            ecoleId: args['ecoleId'] ?? '',
            niveauId: args['niveauId'] ?? '',
            ecoleName: args['ecoleName'] ?? '',
            niveauName: args['niveauName'] ?? '',
          );
        },
        '/search': (context) => const SearchScreen(),
        '/create-flashcard': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
          return CreateFlashcardScreen(
            leconId: args['leconId'] ?? '',
            matiereId: args['matiereId'] ?? '',
            matiereName: args['matiereName'] ?? '',
            niveauId: args['niveauId'] ?? '',
            ecoleId: args['ecoleId'] ?? '',
          );
        },
      },
    );
  }
}
