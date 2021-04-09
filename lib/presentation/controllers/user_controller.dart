import 'package:f_202110_simple_db_webservice/data/user_repository.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  addUser() async {
    UserRespository userRespository = Get.find();

    await userRespository.getUser();
  }

  deleteUser(index) async {
    UserRespository userRespository = Get.find();
    await userRespository.deleteUser(index);
  }

  updateUser(index, user) async {
    UserRespository userRespository = Get.find();
    await userRespository.updateUser(index, user);
  }

  deleteAll() async {
    UserRespository userRespository = Get.find();
    await userRespository.deleteAll();
  }
}
