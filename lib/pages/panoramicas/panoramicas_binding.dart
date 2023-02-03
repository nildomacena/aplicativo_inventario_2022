import 'package:aplicativo_inventario_2022/pages/panoramicas/panoramicas_controller.dart';
import 'package:aplicativo_inventario_2022/pages/panoramicas/panoramicas_repository.dart';
import 'package:get/get.dart';

class PanoramicasBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PanoramicasController>(
        () => PanoramicasController(PanoramicasRepository()));
  }
}
