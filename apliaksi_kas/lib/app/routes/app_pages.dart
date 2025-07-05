import 'package:aplikasi_kas/app/modules/auth/auth_controller.dart';
import 'package:aplikasi_kas/app/modules/auth/login_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
    ),
  ];
}
