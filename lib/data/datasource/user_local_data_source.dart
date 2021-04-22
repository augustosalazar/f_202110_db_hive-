import 'package:dartz/dartz.dart';
import 'package:f_202110_simple_db_webservice/data/models/user_model.dart';
import 'package:f_202110_simple_db_webservice/data/models/userdb.dart';
import 'package:hive/hive.dart';

class UserLocalDataSource {
  addUser(UserModel user) {
    Hive.box('users').add(UserDB(
        gender: user.gender,
        name: user.name,
        country: user.city,
        email: user.email,
        picture: user.picture));
  }

  Future<List<UserModel>> getUsers() async {
    return Hive.box('users').values.map<UserModel>((e) {
      return UserModel(
          name: e.name, city: e.country, email: e.email, picture: e.picture);
    }).toList();
  }

  Stream<List<UserModel>> getUserStream() {
    Hive.box('users').watch().map(
          (_) => right<NotebookFailure, List<UserModel>>(
            Hive.box('users')
                .values
                .map((e) => UserModel(
                    name: e.name,
                    city: e.country,
                    email: e.email,
                    picture: e.picture))
                .toList(),
          ),
        );
  }

  deleteAll() async {
    print("Deleting all from database");
    await Hive.box('users').clear();
  }

  deleteUser(index) async {
    await Hive.box('users').deleteAt(index);
  }

  updateUser(index, UserModel user) async {
    print("Updating entry $user");
    await Hive.box('users').putAt(
        index,
        UserDB(
            gender: user.gender,
            name: user.name,
            country: user.city,
            email: user.email,
            picture: user.picture));
  }
}

class NotebookFailure {}
