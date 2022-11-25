import 'package:aplicativo_inventario_2022/data/auth_provider.dart';
import 'package:get/get.dart';

class SplashscreenRepository {
  final AuthProvider _authProvider = Get.find();

  bool isLoggedIn() {
    return _authProvider.isLoggedIn();
  }
}
