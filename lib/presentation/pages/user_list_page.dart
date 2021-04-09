import 'package:f_202110_simple_db_webservice/data/models/user_model.dart';
import 'package:f_202110_simple_db_webservice/data/models/userdb.dart';
import 'package:f_202110_simple_db_webservice/presentation/controllers/user_controller.dart';
import 'package:f_202110_simple_db_webservice/presentation/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive demo"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await userController.deleteAll();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(child: dbList()),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await userController.addUser();
        },
      ),
    );
  }

  Widget dbList() {
    final userBox = Hive.box("users");
    return ValueListenableBuilder(
      valueListenable: userBox.listenable(),
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: userBox.length,
          itemBuilder: (context, index) {
            final user = userBox.getAt(index) as UserDB;
            final userM = UserModel.fromDB(user);
            return ListItem(userM, index);
            //return Text(userM.name);
          },
        );
      },
    );
  }
}
