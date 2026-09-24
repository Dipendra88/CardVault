import 'package:flutter_test/flutter_test.dart';
import 'package:cardvault/main.dart';

void main() {
  testWidgets('CardVault app loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const CardVaultApp());

    expect(find.text('CardVault'), findsOneWidget);
    expect(find.text('Welcome back, Deep 👋'), findsOneWidget);
    expect(find.text('Available Credit'), findsOneWidget);
    expect(find.text('Recent Transactions'), findsOneWidget);
  });
}
