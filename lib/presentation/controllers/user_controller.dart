import 'package:f_202110_simple_db_webservice/data/models/user_model.dart';
import 'package:f_202110_simple_db_webservice/data/user_repository.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var users = <UserModel>[].obs;

  @override
  onInit() {
    super.onInit();
    getUsers();
    getUserStream2();
  }

  addUser() async {
    UserRepository userRepository = Get.find();

    await userRepository.getUser();
  }

  deleteUser(index) async {
    UserRepository userRepository = Get.find();
    await userRepository.deleteUser(index);
  }

  updateUser(index, user) async {
    UserRepository userRepository = Get.find();
    await userRepository.updateUser(index, user);
  }

  deleteAll() async {
    UserRepository userRepository = Get.find();
    await userRepository.deleteAll();
  }

  Future<List<UserModel>> getUsers() async {
    UserRepository repository = Get.find();

    var rta = await repository.getUsers();

    users.value = rta;

    return rta;
  }

  Stream<List<UserModel>> getUserStream2() async* {
    UserRepository repository = Get.find();
    repository.getUserStream().listen((event) {
      print("EVENT");
    });
  }

  Stream<List<UserModel>> getUserStream() async* {
    UserRepository repository = Get.find();
    repository.getUserStream();
  }
}
