import 'package:flutter_test/flutter_test.dart';
import 'package:booyahhub/main.dart';

void main() {
  testWidgets('App starts with Splash Screen rendering BOOYAHHUB', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp(isSupabaseInitialized: false));

    // Verify that the splash screen shows BOOYAHHUB.
    expect(find.text('BOOYAHHUB'), findsOneWidget);
    expect(find.text('FREE FIRE ARENA'), findsOneWidget);
  });
}
