import 'package:aplicativo_inventario_2022/model/localidade.dart';
import 'package:aplicativo_inventario_2022/pages/localidade_detail/localidade_detail_controller.dart';
import 'package:aplicativo_inventario_2022/routes/app_routes.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardInfoLocalidade extends StatelessWidget {
  final Localidade localidade;
  final int qtdBens;
  final TextStyle textStyleDados =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  final LocalidadeDetailController controller = Get.find();
  CardInfoLocalidade(
      {required this.localidade, required this.qtdBens, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 2),
              child: Text(
                'Localidade: ${localidade.nome}',
                style: textStyleDados,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 2),
              child: Text(
                'Bens cadastrados: $qtdBens',
                style: textStyleDados,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 2),
              child: Text(
                'Status: ${localidade.statusAsString}',
                style: textStyleDados,
              ),
            ),
            SizedBox(
              height: 80,
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    child: const Text('PANORÂMICAS'),
                    onPressed: () {
                      controller.goToPanoramicas();
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(3),
                  ),
                  OutlinedButton(
                    child: AutoSizeText(
                      localidade.status?.index == 2 ? 'RELATÓRIO' : 'FINALIZAR',
                      maxLines: 1,
                    ),
                    onPressed: () async {
                      controller.goToFinalizarLocalidade();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
