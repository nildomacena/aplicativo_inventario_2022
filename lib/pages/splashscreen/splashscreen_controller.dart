import 'package:aplicativo_inventario_2022/pages/splashscreen/splashscreen_repository.dart';
import 'package:aplicativo_inventario_2022/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashscreenController extends GetxController {
  final SplashscreenRepository repository;
  SplashscreenController(this.repository);

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      print(value);
      Get.toNamed(Routes.login);
    });
  }
}
