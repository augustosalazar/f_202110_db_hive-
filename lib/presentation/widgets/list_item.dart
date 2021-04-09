import 'package:f_202110_simple_db_webservice/data/models/user_model.dart';
import 'package:f_202110_simple_db_webservice/presentation/pages/user_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ListItem extends StatelessWidget {
  final UserModel user;
  final int index;
  ListItem(this.user, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
            onTap: () {
              Get.to(() => UserDetailPage(), arguments: [user, index]);
            },
            title: Text('${user.name}'),
            subtitle: Text(user.city),
            leading: CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.transparent,
              child: ClipOval(child: Image.network(user.picture)),
            )),
      ),
    );
  }
}
