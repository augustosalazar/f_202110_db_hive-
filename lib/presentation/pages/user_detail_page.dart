import 'package:f_202110_simple_db_webservice/data/models/user_model.dart';
import 'package:f_202110_simple_db_webservice/presentation/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailPage extends StatefulWidget {
  UserDetailPage({Key key}) : super(key: key);

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  UserModel user = Get.arguments[0];
  int index = Get.arguments[1];

  final controllerName = TextEditingController();
  final controllerCity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    controllerName.text = user.name;
    controllerCity.text = user.city;
    return Scaffold(
      appBar: AppBar(
        title: Text("${user.name}"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await userController.deleteUser(index);
              Get.back();
            },
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextField(
              controller: controllerName,
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).accentColor,
                labelText: 'Name',
              )),
          SizedBox(
            height: 20,
          ),
          TextField(
              controller: controllerCity,
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).accentColor,
                labelText: 'City',
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    flex: 2,
                    child: ElevatedButton(
                        onPressed: () async {
                          UserModel userM = user;
                          userM.name = controllerName.text;
                          userM.city = controllerCity.text;
                          await userController.updateUser(index, userM);
                          Get.back();
                        },
                        child: Text("Save")))
              ],
            ),
          )
        ],
      ),
    );
  }
}
