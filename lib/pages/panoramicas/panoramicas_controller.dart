import 'dart:io';

import 'package:aplicativo_inventario_2022/model/localidade.dart';
import 'package:aplicativo_inventario_2022/pages/localidade_detail/localidade_detail_repository.dart';
import 'package:aplicativo_inventario_2022/pages/localidades/localidades_repository.dart';
import 'package:aplicativo_inventario_2022/pages/panoramicas/panoramicas_repository.dart';
import 'package:aplicativo_inventario_2022/utils/util_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PanoramicasController extends GetxController {
  late Localidade localidade;
  final PanoramicasRepository repository;
  File? imagem;
  List<File> imagens = [];
  bool salvando = false;

  PanoramicasController(this.repository) {
    if (Get.arguments == null || Get.arguments['localidade'] == null) {
      Get.back();
      UtilService.snackBarErro(mensagem: 'Localidade nao encontrada');
    }
    localidade = Get.arguments['localidade'];
    updateLocalidade();
  }

  updateLocalidade() async {
    try {
      localidade = await repository.updateLocalidade(localidade);
      update();
    } catch (e) {
      debugPrint(e.toString());
      UtilService.snackBarErro(mensagem: 'Erro ao buscar localidade');
    }
  }

  getImage() async {
    try {
      imagem = await UtilService.getImage();
      if (imagem != null) imagens.add(imagem!);
      update();
    } catch (e) {
      print('erro ao buscar imagem');
    }
  }

  excluirNovaPanoramica(File panoramica) {
    imagens.remove(panoramica);
    update();
  }

  excluirPanoramica(String panoramica) async {
    bool? result = await Get.dialog(AlertDialog(
      title: const Text('Confirmação'),
      content: const Text(
          'Deseja realmente excluir essa imagem?\nEssa ação é irreversível.'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('CANCELAR'),
        ),
        TextButton(
          onPressed: () {
            Get.back(result: true);
          },
          child: const Text('EXCLUIR'),
        ),
      ],
    ));
    if (result == null) return;

    localidade = await repository.excluirPanoramica(localidade, panoramica);
    update();
  }

  saveImage() async {
    if (imagem == null || imagens.isEmpty) {
      UtilService.snackBarErro(mensagem: 'Selecione uma imagem para ser salva');
    }
    salvando = true;
    update();
    try {
      await repository.salvarPanoramica(files: imagens, localidade: localidade);
      updateLocalidade();
      imagens = [];
      update();
      Get.back();
      UtilService.snackBar(
          titulo: 'Imagens salvas',
          mensagem: 'As imagens panoramicas foram salvas');
    } catch (e) {
      print(e);
      UtilService.snackBarErro(mensagem: 'Erro ao salvar imagem $e');
    } finally {
      salvando = false;
      update();
    }
  }
}
