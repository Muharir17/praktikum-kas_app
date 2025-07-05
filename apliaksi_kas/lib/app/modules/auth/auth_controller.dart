import 'package:get/get.dart';
import '../../routes/app_pages.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var isLoading = false.obs;
  var showPassword = false.obs;

  Future<void> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Username dan Password tidak boleh kosong');
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));

    isLoggedIn.value = true;
    isLoading.value = false;

    Get.offAllNamed(Routes.HOME);
  }

  void logout() {
    isLoggedIn.value = false;
    Get.offAllNamed(Routes.LOGIN);
  }
}
