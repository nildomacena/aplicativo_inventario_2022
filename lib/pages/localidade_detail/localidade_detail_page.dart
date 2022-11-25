import 'package:aplicativo_inventario_2022/model/bem.dart';
import 'package:aplicativo_inventario_2022/pages/localidade_detail/localidade_detail_controller.dart';
import 'package:aplicativo_inventario_2022/pages/localidade_detail/widgets/card_info_localidade.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalidadeDetailPage extends StatelessWidget {
  final LocalidadeDetailController controller = Get.find();

  LocalidadeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getBens();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: GetBuilder<LocalidadeDetailController>(
            builder: (_) {
              return Column(
                children: [
                  CardInfoLocalidade(
                      localidade: controller.localidade,
                      qtdBens: controller.bens?.length ?? 0),
                  Container(
                    width: Get.width,
                    height: 50,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton.icon(
                        onPressed: controller.goToAdicionarBem,
                        icon: const Icon(Icons.add),
                        label: const Text('Adicionar Bem')),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _.bens?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      Bem bem = _.bens![index];
                      return ListTile(
                        title: Text(bem.titulo),
                        subtitle: Text(bem.titulo),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
