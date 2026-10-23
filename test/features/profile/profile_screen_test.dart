import 'package:edusav/features/auth/domain/auth_user.dart';
import 'package:edusav/features/auth/presentation/auth_controller.dart';
import 'package:edusav/features/profile/profile_screen.dart';
import 'package:edusav/features/profile/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('profile displays the authenticated user details', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(ProfileAuthController.new),
          profileRoleNameProvider.overrideWith((ref) async => 'ELEVE'),
        ],
        child: const MaterialApp(home: ProfileScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Alex Student'), findsNWidgets(2));
    expect(find.text('alex@example.com'), findsOneWidget);
    expect(find.text('ELEVE'), findsOneWidget);
  });
}

class ProfileAuthController extends AuthController {
  @override
  Future<AuthState> build() async => const AuthAuthenticated(
    AuthUser(
      id: 'user-1',
      name: 'Alex Student',
      email: 'alex@example.com',
      roleId: 'student-role',
      roleName: 'ELEVE',
    ),
  );
}
