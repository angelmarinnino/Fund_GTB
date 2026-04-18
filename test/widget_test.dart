import 'package:flutter_test/flutter_test.dart';

import 'package:fondos_app/main.dart';

void main() {
  testWidgets('La app arranca y muestra la vista de fondos', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const FundsApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('Fondos'), findsWidgets);
  });
}
