import 'package:aplicativo_inventario_2022/pages/adicionar_bem/adicionar_bem_controller.dart';
import 'package:aplicativo_inventario_2022/pages/adicionar_bem/adicionar_bem_repository.dart';
import 'package:get/get.dart';

class AdicionarBemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdicionarBemController>(
        () => AdicionarBemController(AdicionarBemRepository()));
  }
}
