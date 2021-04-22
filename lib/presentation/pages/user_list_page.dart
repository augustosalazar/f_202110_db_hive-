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
        child: dbList(),

        // child: GetBuilder<UserController>(
        //     builder: (_) => FutureBuilder<List<UserModel>>(
        //           future: userController.getUsers(),
        //           builder: (context, snapshot) {
        //             print("got new values.");
        //             if (snapshot.hasData) {
        //               return Text('${userController.users.length}');
        //             }
        //             return Text('...');
        //           },
        //         )),
        //
        //

        // child: StreamBuilder(
        //   stream: userController.getUserStream(),
        //   builder: (context, snapshot) {
        //     if (!snapshot.hasData) {
        //       return Text("loading");
        //     }
        //     List<UserModel> data = snapshot.data;
        //     return Text('${data.length}');
        //   },
        // )

        // child: GetX<UserController>(builder: (controller) {
        //   return FutureBuilder<List<UserModel>>(
        //     future: controller.getUsers(),
        //     builder: (context, snapshot) {
        //       print("got new values.");
        //       if (snapshot.hasData) {
        //         return Text('${controller.users.length}');
        //       }
        //       return Text('...');
        //     },
        //   );
        // })
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
          },
        );
      },
    );
  }

  Widget dbList2(data) {
    print("dbList2 ${data.length}");
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final user = data[index];
        return ListItem(user, index);
      },
    );
  }
}
