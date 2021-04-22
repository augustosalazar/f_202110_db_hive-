import 'package:f_202110_simple_db_webservice/data/models/userdb.dart';
import 'package:f_202110_simple_db_webservice/data/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'presentation/controllers/user_controller.dart';
import 'presentation/home.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<List<Box>> _openBox() async {
  List<Box> boxList = [];
  var dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(UserDBAdapter());
  var user_session = await Hive.openBox("users");
  boxList.add(user_session);
  return boxList;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _openBox();
  Get.put(UserRepository());
  Get.put(UserController());
  runApp(Home());
}
