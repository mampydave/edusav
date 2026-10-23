import 'package:edusav/core/di/current_user_provider.dart';
import 'package:edusav/features/leader/pending_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('non-admin cannot access account validation screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          isCurrentUserAdminProvider.overrideWith((ref) async => false),
        ],
        child: const MaterialApp(home: PendingRequestsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Accès réservé à l’administrateur.'), findsOneWidget);
    expect(find.text('Aucune demande en attente'), findsNothing);
  });
}
