// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:edusav/main.dart';
import 'package:edusav/features/auth/presentation/auth_controller.dart';

void main() {
  testWidgets('app redirects unauthenticated users to login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(TestAuthController.new),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back'), findsOneWidget);
  });
}

class TestAuthController extends AuthController {
  @override
  Future<AuthState> build() async => const AuthUnauthenticated();

  @override
  Future<void> checkCurrentUser() async {
    state = const AsyncData(AuthUnauthenticated());
  }
}
