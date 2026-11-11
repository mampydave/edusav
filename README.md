# EDUSAV

Application Flutter d'apprentissage avec stockage local Drift, gestion d'etat Riverpod, numerisation de documents et revision par flashcards.

## Prerequis

- Flutter et Dart compatibles avec le SDK defini dans `pubspec.yaml`.
- Android Studio ou Xcode selon la plateforme cible.

## Demarrage

```sh
flutter pub get
flutter run
```

Pour activer Supabase, fournir l'URL du projet et la clé publique `anon` au lancement :

```sh
flutter run --dart-define=SUPABASE_URL=https://<project-ref>.supabase.co --dart-define=SUPABASE_PUBLISHABLE_KEY=<publishable-key>
```

Sans ces valeurs, l'application démarre en mode local Drift. Ne jamais intégrer une clé `service_role` dans l'application mobile.

## Verification

```sh
flutter analyze
flutter test
```

## Architecture

Consulter [docs/architecture.md](docs/architecture.md) pour les responsabilites des couches, la direction des dependances, la nomenclature et la migration par fonctionnalite.
