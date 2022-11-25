import 'package:aplicativo_inventario_2022/model/bem.dart';
import 'package:aplicativo_inventario_2022/model/localidade.dart';
import 'package:aplicativo_inventario_2022/pages/localidade_detail/localidade_detail_repository.dart';
import 'package:aplicativo_inventario_2022/routes/app_routes.dart';
import 'package:aplicativo_inventario_2022/utils/util_service.dart';
import 'package:get/get.dart';

class LocalidadeDetailController extends GetxController {
  final LocalidadeDetailRepository repository;
  late Localidade localidade;
  List<Bem>? bens;

  LocalidadeDetailController(this.repository) {
    if (Get.arguments != null && Get.arguments['localidade'] != null) {
      localidade = Get.arguments['localidade'];
      getBens();
    } else {
      Get.offAllNamed(Routes.localidades);
    }
  }

  getBens() async {
    try {
      bens = await repository.getBens(localidade.id);
      update();
    } catch (e) {
      UtilService.snackBarErro(mensagem: 'Erro ao buscar localidades');
    }
  }

  goToAdicionarBem() {
    Get.toNamed(Routes.adicionarBem);
  }
}
