import 'package:aplicativo_inventario_2022/pages/login/login_controller.dart';
import 'package:aplicativo_inventario_2022/pages/login/login_repository.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(LoginRepository()));
  }
}
