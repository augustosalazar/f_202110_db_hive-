import 'package:f_202110_simple_db_webservice/data/models/userdb.dart';

import 'user_remote_model.dart';

class UserModel {
  UserModel({
    this.gender,
    this.name,
    this.email,
    this.picture,
    this.city,
  });

  factory UserModel.fromRemote(UserRemoteModel remoteModel) => UserModel(
        gender: remoteModel.gender,
        name: remoteModel.name.first + " " + remoteModel.name.last,
        city: remoteModel.location.city,
        email: remoteModel.email,
        picture: remoteModel.picture.thumbnail,
      );

  factory UserModel.fromDB(UserDB localModel) => UserModel(
        gender: localModel.gender,
        name: localModel.name,
        city: localModel.country,
        email: localModel.email,
        picture: localModel.picture,
      );

  String gender;
  String name;
  String city;
  String email;
  String picture;
}
