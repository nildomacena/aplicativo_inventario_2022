import 'dart:io';

import 'package:aplicativo_inventario_2022/model/localidade.dart';
import 'package:aplicativo_inventario_2022/pages/finalizar_localidade/finalizar_localidade_repository.dart';
import 'package:aplicativo_inventario_2022/routes/app_routes.dart';
import 'package:aplicativo_inventario_2022/utils/util_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FinalizarLocalidadeController extends GetxController {
  late Localidade localidade;
  TextEditingController observacoesController = TextEditingController();
  File? image;
  bool salvando = false;

  final FinalizarLocalidadeRepository repository;
  FinalizarLocalidadeController(this.repository) {
    try {
      localidade = Get.arguments['localidade'];
    } catch (e) {
      Get.back();
      UtilService.snackBarErro(mensagem: 'Erro ao buscar localidade');
    }
  }

  getImage() async {
    try {
      image = await UtilService.getImage();
      update();
    } catch (e) {
      print('Erro ao buscar imagem: $e');
    }
  }

  finalizarLocalidade() async {
    if (image == null) {
      UtilService.snackBarErro(
          mensagem: 'Tire a foto do relatório para finalizar a localidade');
      return;
    }
    salvando = true;
    update();
    try {
      await repository.finalizarLocalidade(
          localidade: localidade,
          file: image!,
          observacoes: observacoesController.text);
      Get.offAllNamed(Routes.localidades);
    } catch (e) {
      print(e);
      UtilService.snackBarErro(
          mensagem:
              'Erro ao finalizar localidade. Verifique se a mesma foi finalizada');
    } finally {
      salvando = false;
      update();
    }
  }
}
