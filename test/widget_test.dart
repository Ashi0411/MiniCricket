import 'package:flutter_test/flutter_test.dart';
import 'package:mini_cricket/main.dart';

void main() {
  testWidgets('Mini Cricket smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MiniCricketApp());

    expect(find.text('Mini Cricket'), findsOneWidget);
    expect(find.text('Runs'), findsOneWidget);
    expect(find.text('Balls'), findsOneWidget);
    expect(find.text('Bat'), findsOneWidget);
  });
}
