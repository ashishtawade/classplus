import 'package:custom_greetings_app/src/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders login choices on launch', (tester) async {
    await tester.pumpWidget(const GreetingsApp());

    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.text('Use Email'), findsOneWidget);
    expect(find.text('Enter as Guest'), findsOneWidget);
  });
}
