import 'package:aplicativo_inventario_2022/pages/splashscreen/splashscreen_controller.dart';
import 'package:aplicativo_inventario_2022/pages/splashscreen/splashscreen_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashscreenPage extends StatelessWidget {
  final SplashscreenController controller =
      Get.put(SplashscreenController(SplashscreenRepository()));

  SplashscreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
