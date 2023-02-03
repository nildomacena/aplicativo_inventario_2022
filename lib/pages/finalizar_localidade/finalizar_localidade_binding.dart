import 'package:aplicativo_inventario_2022/pages/finalizar_localidade/finalizar_localidade_controller.dart';
import 'package:aplicativo_inventario_2022/pages/finalizar_localidade/finalizar_localidade_repository.dart';
import 'package:get/get.dart';

class FinalizarLocalidadeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FinalizarLocalidadeController>(
        () => FinalizarLocalidadeController(FinalizarLocalidadeRepository()));
  }
}
