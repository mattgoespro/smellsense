import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:smellsense/providers/scent.provider.dart';
import 'package:smellsense/screens/main-menu/main-menu.screen.dart';
import 'package:smellsense/storage/storage.dart';

final getIt = GetIt.instance;

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('The Main Menu should show', (WidgetTester tester) async {
    getIt.registerSingleton<SmellSenseStorage>(SmellSenseStorage());
    getIt.registerSingleton<ScentProvider>(ScentProvider());
    await tester.pumpWidget(MainMenuScreen());
    // expect(find.text('Get started'), findsOneWidget);
    // expect(find.text('Shop'), findsOneWidget);
    // expect(find.text('About'), findsOneWidget);
    // expect(find.text('Help'), findsOneWidget);
    // expect(find.text('no exist sadge'), findsOneWidget);
  });
}
