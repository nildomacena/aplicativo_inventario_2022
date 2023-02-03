import 'package:aplicativo_inventario_2022/model/localidade.dart';
import 'package:aplicativo_inventario_2022/pages/localidades/localidades_repository.dart';
import 'package:aplicativo_inventario_2022/routes/app_routes.dart';
import 'package:aplicativo_inventario_2022/utils/util_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LocalidadesController extends GetxController {
  List<Localidade>? localidades;
  List<Localidade>? localidadesFiltradas;
  final LocalidadesRepository repository;
  LocalidadesController(this.repository);
  TextEditingController searchController = TextEditingController();

  @override
  onInit() {
    super.onInit();
    getLocalidades();
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        localidadesFiltradas = localidades;
      } else if (localidades != null) {
        localidadesFiltradas = localidades!
            .where((l) => l.nome
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
            .toList();
      }
      update();
    });
  }

  getLocalidades() async {
    try {
      localidadesFiltradas = localidades = await repository.getLocalidades();
      update();
    } catch (e) {
      print(e);
      UtilService.snackBarErro(
          mensagem: 'Erro ao buscar localidades. Tente novamente');
    }
  }

  signout() async {
    await repository.signOut();
    Get.offAllNamed(Routes.login);
  }

  goToLocalidade(Localidade localidade) async {
    await Get.toNamed(Routes.localidadeDetail,
        arguments: {'localidade': localidade});
    getLocalidades();
  }
}
