import 'package:aplicativo_inventario_2022/pages/localidade_detail/localidade_detail_controller.dart';
import 'package:aplicativo_inventario_2022/pages/localidade_detail/localidade_detail_repository.dart';
import 'package:get/get.dart';

class LocalidadeDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalidadeDetailController>(() =>
        LocalidadeDetailController(LocalidadeDetailRepository(Get.find())));
  }
}
