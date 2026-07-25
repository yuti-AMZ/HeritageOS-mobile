import 'package:flutter_test/flutter_test.dart';
import 'package:heritageos/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const HeritageOSApp());
    expect(find.text('HeritageOS'), findsOneWidget);
  });
}
