import 'dart:io';

import 'package:aplicativo_inventario_2022/pages/adicionar_bem/adicionar_bem_repository.dart';
import 'package:aplicativo_inventario_2022/utils/util_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdicionarBemController extends GetxController {
  final AdicionarBemRepository repository;

  File? image;

  bool particular = false;
  bool semEtiqueta = false;
  bool desfazimento = false;
  bool salvando = false;
  bool alterar =
      false; //Variável que verifica se a tela é para alterar algum bem já existente ou cadastrar um novo
  TextEditingController patrimonioController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController numeroSerieController = TextEditingController();
  TextEditingController observacoesController = TextEditingController();

  FocusNode patrimonioFocus = FocusNode();
  FocusNode descricaoFocus = FocusNode();
  FocusNode numeroSerieFocus = FocusNode();
  FocusNode observacoesFocus = FocusNode();

  AdicionarBemController(this.repository);

  onPatrimonioSubmit(String? string) {
    patrimonioFocus.unfocus();
    descricaoFocus.requestFocus();
  }

  onPatrimonioComplete() {
    /*  descricaoController.text =
        utilService.getDescricaoPorTombamento(patrimonioController.text); */
    /* Localidade localidade = await fireService
                      .verificaBemJaCadastrado(patrimonioController.text);
                  if (localidade != null) {
                    Get.dialog(AlertDialog(
                      title: const Text('Bem Já inventariado'),
                      content: Text(
                          'O bem ${descricaoController.text ?? ''} já foi inventariado na localidade ${localidade.nome}'),
                      actions: [
                        FlatButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Get.back();
                          },
                        )
                      ],
                    ));
                  } */
  }

  validatorPatrimonio(String? patrimonio) {
    if (patrimonio == null ||
        patrimonio.isEmpty && !semEtiqueta && !particular) {
      salvando = false;
      update();
      return "Digite o patrimônio do bem";
    }
    return null;
  }

  getImage() async {
    try {
      image = await UtilService.getImage();
      update();
    } catch (e) {
      print('Erro ao buscar imagem: $e');
    }
  }

  clearImage() async {
    bool? excluir = await Get.dialog(AlertDialog(
      title: const Text('Confirmação'),
      content: const Text('Deseja realmente excluir a imagem?'),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          child: const Text('Excluir'),
          onPressed: () {
            Get.back(result: true);
          },
        ),
      ],
    ));
    if (excluir == null || !excluir) return;
    image = null;
    update();
  }

  toggleSemEtiqueta([bool? value]) {
    semEtiqueta = value ?? !semEtiqueta;
    update();
  }

  scanQrCode() async {
    try {
      String qrCode = await UtilService.scanQrCode();
      patrimonioController.text = qrCode;
      update();
      print('qrCode: $qrCode');
    } catch (e) {
      UtilService.snackBarErro(mensagem: 'Erro ao scanear');
    }
  }
}
