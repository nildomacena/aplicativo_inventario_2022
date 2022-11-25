import 'package:aplicativo_inventario_2022/model/localidade.dart';
import 'package:aplicativo_inventario_2022/pages/localidades/localidades_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalidadesPage extends StatelessWidget {
  final LocalidadesController controller = Get.find();
  LocalidadesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localidades'),
        actions: [
          IconButton(
              onPressed: controller.signout,
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: GetBuilder<LocalidadesController>(builder: (_) {
        if (controller.localidades == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: () async {
            await controller.getLocalidades();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 5, right: 5),
                  height: 45,
                  width: MediaQuery.of(context).size.width * 8,
                  child: TextField(
                    autofocus: false,
                    controller: TextEditingController(),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.localidades!.length,
                    itemBuilder: (context, index) {
                      Localidade localidade =
                          controller.localidadesFiltradas![index];
                      return Container(
                        margin: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 5, right: 5),
                        height: 80,
                        width: MediaQuery.of(context).size.width * 8,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(22))),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                localidade.nome,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                localidade.statusAsString,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                          onPressed: () {
                            controller.goToLocalidade(localidade);
                          },
                        ),
                      );
                    }),
              ],
            ),
          ),
        );
      }),
    );
  }
}
