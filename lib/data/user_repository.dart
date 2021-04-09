import 'package:f_202110_simple_db_webservice/data/models/user_model.dart';

import 'datasource/user_local_data_source.dart';
import 'datasource/user_remote_data_source.dart';

class UserRespository {
  UserRemoteDatatasource userRemoteDatatasource;
  UserLocalDataSource userLocalDataSource;

  UserRespository() {
    userRemoteDatatasource = UserRemoteDatatasource();
    userLocalDataSource = UserLocalDataSource();
  }

  getUser() async {
    UserModel user = await userRemoteDatatasource.getUser();
    userLocalDataSource.addUser(user);
  }

  deleteAll() async {
    await userLocalDataSource.deleteAll();
  }

  updateUser(index, user) async {
    await userLocalDataSource.updateUser(index, user);
  }

  deleteUser(index) async {
    await userLocalDataSource.deleteUser(index);
  }
}
