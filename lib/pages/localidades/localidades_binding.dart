import 'package:aplicativo_inventario_2022/pages/localidades/localidades_controller.dart';
import 'package:aplicativo_inventario_2022/pages/localidades/localidades_repository.dart';
import 'package:get/get.dart';

class LocalidadesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalidadesController>(() => LocalidadesController(
        LocalidadesRepository(
            firestoreProvider: Get.find(), authProvider: Get.find())));
  }
}
