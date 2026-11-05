import 'package:flutter_test/flutter_test.dart';
import 'package:thekaa/main.dart';

void main() {
  testWidgets('ThekaaApp renders successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const ThekaaApp());
    expect(find.text('THEKAA'), findsOneWidget);
  });
}
