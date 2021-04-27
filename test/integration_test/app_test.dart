import 'package:f_202110_simple_db_webservice/data/models/userdb.dart';
import 'package:f_202110_simple_db_webservice/data/user_repository.dart';
import 'package:f_202110_simple_db_webservice/presentation/controllers/user_controller.dart';
import 'package:f_202110_simple_db_webservice/presentation/pages/user_list_page.dart';
import 'package:f_202110_simple_db_webservice/presentation/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<List<Box>> _openBox() async {
  List<Box> boxList = [];
  var dir = await path_provider.getApplicationDocumentsDirectory();
  if (Hive.isBoxOpen("users") == false) {
    Hive.init(dir.path);
    Hive.registerAdapter(UserDBAdapter());
    var user_session = await Hive.openBox("users");
    boxList.add(user_session);
    return boxList;
  }
}

Future<Widget> createHomeScreen() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _openBox();
  Get.put(UserRepository());
  Get.put(UserController());
  return GetMaterialApp(home: UserListPage());
}

void main() {
  group('Integration test', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('Add & delete user', (tester) async {
      Widget w = await createHomeScreen();
      await tester.pumpWidget(w);

      await tester.tap(find.widgetWithIcon(FloatingActionButton, Icons.add));
      await tester.pumpAndSettle(Duration(seconds: 5));

      expect(find.byType(ListItem), findsOneWidget);

      expect(find.widgetWithIcon(IconButton, Icons.delete), findsOneWidget);
      await tester.tap(find.widgetWithIcon(IconButton, Icons.delete));
      await tester.pumpAndSettle(Duration(seconds: 5));
      expect(find.byType(ListItem), findsNothing);
    });

    testWidgets("Detail and delete", (tester) async {
      Widget w = await createHomeScreen();
      await tester.pumpWidget(w);

      await tester.tap(find.widgetWithIcon(FloatingActionButton, Icons.add));
      await tester.pumpAndSettle(Duration(seconds: 5));

      expect(find.byType(ListItem), findsOneWidget);

      await tester.tap(find.byType(ListItem));
      await tester.pumpAndSettle(Duration(seconds: 5));

      // edit name

      await tester.enterText(
          find.byWidgetPredicate((Widget widget) =>
              widget is TextField && widget.decoration.labelText == 'Name'),
          'A new name');

      await tester.enterText(find.byKey(Key('TextFieldCity')), 'A new city');

      // save
      expect(find.byType(ElevatedButton), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle(Duration(seconds: 5));

      expect(find.byType(ListItem), findsOneWidget);

      expect(find.text('A new name'), findsOneWidget);
      expect(find.text('A new city'), findsOneWidget);
    });
  });
}
