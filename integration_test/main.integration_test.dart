import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:smellsense/screens/main-menu/main-menu.screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Main menu test", (WidgetTester tester) async {
    await tester.pumpWidget(MainMenuScreen());
    await tester.pump(Duration(seconds: 10));
  });
}
