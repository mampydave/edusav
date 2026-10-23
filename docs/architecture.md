# Architecture

EDUSAV uses a feature-first, layered architecture. Code for one capability lives under `lib/features/<feature>/`; shared infrastructure belongs in `lib/core/`. The current migration starts with authentication. Existing features may still use legacy providers under `lib/core/di` until migrated.

## Layers

| Folder | Responsibility | May depend on |
| --- | --- | --- |
| `presentation/` | Flutter screens, widgets, Riverpod controllers, and provider wiring | `application/`, `domain/`, Flutter, Riverpod |
| `application/` | Use cases that coordinate user workflows and policies | `domain/` |
| `domain/` | Feature entities, repository contracts, and domain abstractions | Dart only |
| `data/` | Repository implementations, persistence, platform adapters, and mapping | `domain/`, Drift, platform packages |

Dependency direction is inward: presentation calls application operations; application depends on domain contracts; data implements those contracts. Domain code must not import Flutter, Riverpod, Drift, or platform packages. A feature should not query another feature's DAOs directly; expose a domain/application contract when cross-feature behavior is needed.

## Naming

- Files and directories use `lower_snake_case.dart`.
- Types use `UpperCamelCase`: `AuthUser`, `AuthRepository`, `DriftAuthRepository`.
- Variables, methods, and Riverpod providers use `lowerCamelCase`: `restoreAuthSession`, `authRepositoryProvider`.
- Use cases describe an action or workflow: `Login`, `RegisterStudent`, `RestoreAuthSession`.
- Repository interfaces describe the capability; implementations identify the technology, such as `DriftAuthRepository`.
- Keep UI copy localized; use English for new code identifiers. Avoid vague names such as `Helper`, `Manager`, or `Model` without a feature-specific qualifier.

## Authentication Example

```text
features/auth/
  presentation/  auth_controller.dart, auth_providers.dart, screens
  application/   auth_use_cases.dart
  domain/        auth_user.dart, auth_repository.dart, password_hasher.dart
  data/          drift_auth_repository.dart, sha256_password_hasher.dart
```

`AuthController` exposes `AsyncValue<AuthState>` to the UI. Use cases own authentication decisions and session workflow. `AuthRepository` is the domain contract; `DriftAuthRepository` owns database and secure-storage access. `AuthUser` is independent of Drift's generated `Utilisateur` row.

## Testing

- Unit-test application use cases with fake domain contracts; these tests should not need Flutter widgets or a real database.
- Test data adapters against an in-memory Drift database where practical.
- Test presentation separately for loading, success, and error behavior.
- Put tests under `test/features/<feature>/<layer>/` and name them `<subject>_test.dart`.
- Run `flutter analyze` and `flutter test` before merging.

## Migration

Migrate one vertical feature slice at a time. Keep existing routes and database schema stable unless a feature explicitly requires a change. New code should follow these boundaries; move legacy providers and files when their feature is migrated rather than doing a broad mechanical rewrite.