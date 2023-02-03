import 'package:aplicativo_inventario_2022/model/localidade.dart';
import 'package:aplicativo_inventario_2022/pages/finalizar_localidade/finalizar_localidade_controller.dart';
import 'package:aplicativo_inventario_2022/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinalizarLocalidadePage extends StatelessWidget {
  final FinalizarLocalidadeController controller = Get.find();

  FinalizarLocalidadePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(controller.localidade.nome),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                child: GetBuilder<FinalizarLocalidadeController>(
                  builder: (_) {
                    return Container(
                        height: 80,
                        color: controller.image != null &&
                                !controller.localidade.possuiImagemRelatorio
                            ? Colors.grey
                            : Colors.white,
                        alignment: Alignment.center,
                        child: controller.image != null
                            ? Image.file(
                                controller.image!,
                                fit: BoxFit.cover,
                              )
                            : controller.localidade.possuiImagemRelatorio
                                ? Image.network(
                                    controller.localidade.imagemRelatorio!,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(Icons.photo));
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: controller.getImage,
                  child: Text(controller.localidade.possuiImagemRelatorio
                      ? 'ALTERAR FOTO DO RELATÓRIO'
                      : controller.image == null
                          ? 'ADICIONAR FOTO DO RELATÓRIO'
                          : 'ALTERAR FOTO')),
              const Divider(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: TextField(
                    maxLines: 8,
                    textCapitalization: TextCapitalization.sentences,
                    controller: controller.observacoesController,
                    decoration: const InputDecoration(hintText: 'Observações'),
                    style:
                        const TextStyle(fontFamily: 'Montserrat', fontSize: 19),
                  ),
                ),
              ),
              if (controller.localidade.status != Status.finalizado)
                GetBuilder<FinalizarLocalidadeController>(
                  builder: (_) {
                    return Container(
                        height: 60,
                        alignment: Alignment.center,
                        child: Container(
                          height: 50,
                          width: 200,
                          child: ElevatedButton(
                            onPressed: controller.image == null
                                ? null
                                : controller.finalizarLocalidade,
                            child: Text(
                              controller.salvando
                                  ? 'SALVANDO...'
                                  : 'FINALIZAR LOCALIDADE',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ));
                  },
                ),
            ],
          ),
        ));
  }
}
