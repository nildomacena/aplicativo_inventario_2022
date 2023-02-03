import 'dart:convert';
import 'dart:io';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;

class UtilService {
  List<Map<String, dynamic>> jsonBens = [];

  UtilService() {
    initApp();
  }

  initApp() async {
    String data = await rootBundle.loadString('assets/bens-json.json');
    List<dynamic> jsonResult = json.decode(data);
    for (var value in jsonResult) {
      jsonBens.add(value);
    }
  }

  String? buscarDescricao(String tombamento) {
    return jsonBens
        .where((element) => element['id'].toString() == tombamento)
        .first['Denominação'];
  }

  static void snackBarErro(
      {String? titulo,
      String? mensagem,
      bool embaixo = false,
      Duration? duration}) {
    Get.snackbar(
      titulo ?? 'Erro',
      mensagem ?? 'Erro durante a operação',
      snackPosition: embaixo ? SnackPosition.BOTTOM : SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.only(top: 20, bottom: 10, left: 5, right: 5),
      duration: duration ?? const Duration(seconds: 5),
    );
  }

  static void snackBar(
      {required String titulo,
      required String mensagem,
      bool embaixo = false,
      Duration? duration}) {
    Get.snackbar(
      titulo,
      mensagem,
      snackPosition: embaixo ? SnackPosition.BOTTOM : SnackPosition.TOP,
      margin: const EdgeInsets.only(top: 20, bottom: 10, left: 5, right: 5),
      duration: duration ?? const Duration(seconds: 5),
    );
  }

  static String tratarErroFirebase(FirebaseException erro) {
    switch (erro.code) {
      case 'email-already-exists':
        return 'Email já cadastrado';
      case 'invalid-email':
        return 'Email inválido';
      case 'invalid-password':
        return 'Senha inválida. Digite pelo menos 6 caracteres';
      case 'wrong-password':
        return 'Senha incorreta. Verifique a senha e tente novamente.';
      case 'user-not-found':
        return 'Usuário não encontrado. Verifique as informações e tente novamente';
      default:
        return erro.code;
    }
  }

  static Future<File?> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        maxHeight: 1080,
        maxWidth: 1080,
        imageQuality: 50);
    if (image == null) return null;
    return File(image.path);
  }

  static Future<String> scanQrCode() async {
    var result = await BarcodeScanner.scan(
        options: const ScanOptions(restrictFormat: [BarcodeFormat.qr]));
    return result.rawContent;
  }
}

UtilService utilService = UtilService();
