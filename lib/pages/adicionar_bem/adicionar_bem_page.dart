import 'dart:io';

import 'package:aplicativo_inventario_2022/pages/adicionar_bem/adicionar_bem_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';

class AdicionarBemPage extends StatelessWidget {
  final AdicionarBemController controller = Get.find();
  final TextStyle style =
      const TextStyle(fontFamily: 'Montserrat', fontSize: 19);

  AdicionarBemPage({Key? key}) : super(key: key);

  Widget row(File? image) {
    return Container(
      alignment: Alignment.center,
      color: Colors.grey,
      width: Get.width,
      height: 170,
      child: image != null
          ? GestureDetector(
              onTap: () {},
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    image,
                  ),
                  Positioned(
                      bottom: 10,
                      left: Get.width / 2 + 20,
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: controller.clearImage,
                      )),
                  Positioned(
                      bottom: 10,
                      right: Get.width / 2 + 20,
                      child: IconButton(
                        icon: const Icon(Icons.remove_red_eye),
                        onPressed: () {},
                      )),
                ],
              ),
            )
          : GestureDetector(
              onTap: () {
                controller.getImage();
              },
              child: Container(
                child: const Text(
                  'Selecionar Foto',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    patrimonioField() {
      return SizedBox(
        height: 60,
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 7,
              child: TextFormField(
                  enabled: !controller.semEtiqueta,
                  obscureText: false,
                  style: style,
                  readOnly: controller.particular,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.number,
                  controller: controller.patrimonioController,
                  focusNode: controller.patrimonioFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: controller.onPatrimonioSubmit,
                  onEditingComplete: controller.onPatrimonioComplete,
                  validator: (value) {
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: controller.particular
                          ? 'Bem particular'
                          : "Patrimônio do bem",
                      hintStyle: TextStyle(
                          color: Colors.grey[400], fontWeight: FontWeight.w400),
                      border: const UnderlineInputBorder())),
            ),
            IconButton(
                icon: const Icon(FontAwesome.qrcode),
                onPressed:
                    controller.semEtiqueta ? null : controller.scanQrCode),
            Expanded(
              flex: 5,
              child: Row(
                children: <Widget>[
                  Checkbox(
                      value: controller.semEtiqueta,
                      onChanged: controller.particular
                          ? null
                          : controller.toggleSemEtiqueta),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: controller.particular
                          ? null
                          : controller.toggleSemEtiqueta,
                      child: const AutoSizeText(
                        'Sem Etiqueta?',
                        maxLines: 1,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Bem')),
      body: SingleChildScrollView(
        child: Form(
          child: GetBuilder<AdicionarBemController>(
            builder: (_) {
              return Column(
                children: [row(controller.image), patrimonioField()],
              );
            },
          ),
        ),
      ),
    );
  }
}
