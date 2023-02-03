import 'package:aplicativo_inventario_2022/model/bem.dart';
import 'package:aplicativo_inventario_2022/model/localidade.dart';
import 'package:aplicativo_inventario_2022/pages/localidade_detail/localidade_detail_repository.dart';
import 'package:aplicativo_inventario_2022/routes/app_routes.dart';
import 'package:aplicativo_inventario_2022/utils/util_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LocalidadeDetailController extends GetxController {
  final LocalidadeDetailRepository repository;
  late Localidade localidade;
  List<Bem>? bens;
  List<Bem>? bensFiltrados;
  TextEditingController searchController = TextEditingController();

  LocalidadeDetailController(this.repository) {
    if (Get.arguments != null && Get.arguments['localidade'] != null) {
      localidade = Get.arguments['localidade'];
      getBens();
    } else {
      Get.offAllNamed(Routes.localidades);
    }

    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        bensFiltrados = bens;
      } else if (bens != null) {
        bensFiltrados = bens!
            .where((b) =>
                b.descricao
                    .toLowerCase()
                    .contains(searchController.text.toLowerCase()) ||
                (b.patrimonio != null &&
                    b.patrimonio!
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase())))
            .toList();
      }
      update();
    });
  }

  getBens() async {
    try {
      bensFiltrados = bens = await repository.getBens(localidade.id);
      localidade = await repository.getLocalidadeById(localidade.id);
      if (bens != null &&
          bens!.isNotEmpty &&
          localidade.status == Status.nao_iniciado) {
        localidade.status = Status.em_andamento;
      }
      update();
    } catch (e) {
      print(e);
      UtilService.snackBarErro(mensagem: 'Erro ao buscar localidades');
    }
  }

  goToPanoramicas() async {
    await Get.toNamed(Routes.panoramicas,
        arguments: {'localidade': localidade});
    getBens();
  }

  goToAdicionarBem() async {
    await Get.toNamed(Routes.adicionarBem,
        arguments: {'localidade': localidade});
    getBens();
  }

  goToBem(Bem bem) async {
    await Get.toNamed(Routes.adicionarBem,
        arguments: {'localidade': localidade, 'bem': bem});
    getBens();
  }

  goToFinalizarLocalidade() async {
    await Get.toNamed(Routes.finalizarLocalidade,
        arguments: {'localidade': localidade});
    getBens();
  }
}
