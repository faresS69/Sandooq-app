import 'package:get/get.dart';
import '../models/user_model.dart';

class CurrentUserController extends GetxController {
  Rx<UserModel?> user = Rx<UserModel?>(null);

  void setUser(UserModel userModel) {
    user.value = userModel;
  }


  void clearUser() {
    user.value = null;
  }
}
