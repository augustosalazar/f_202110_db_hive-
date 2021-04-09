import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/user_list_page.dart';
import 'theme/theme.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hive for random users',
      theme: MyTheme.darkTheme,
      home: UserListPage(),
    );
  }
}
