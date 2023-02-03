import 'package:aplicativo_inventario_2022/pages/adicionar_bem/adicionar_bem_binding.dart';
import 'package:aplicativo_inventario_2022/pages/adicionar_bem/adicionar_bem_page.dart';
import 'package:aplicativo_inventario_2022/pages/finalizar_localidade/finalizar_localidade_binding.dart';
import 'package:aplicativo_inventario_2022/pages/finalizar_localidade/finalizar_localidade_page.dart';
import 'package:aplicativo_inventario_2022/pages/localidade_detail/localidade_detail_binding.dart';
import 'package:aplicativo_inventario_2022/pages/localidade_detail/localidade_detail_page.dart';
import 'package:aplicativo_inventario_2022/pages/localidades/localidades_binding.dart';
import 'package:aplicativo_inventario_2022/pages/localidades/localidades_page.dart';
import 'package:aplicativo_inventario_2022/pages/login/login_binding.dart';
import 'package:aplicativo_inventario_2022/pages/login/login_page.dart';
import 'package:aplicativo_inventario_2022/pages/panoramicas/panoramicas_binding.dart';
import 'package:aplicativo_inventario_2022/pages/panoramicas/panoramicas_page.dart';
import 'package:aplicativo_inventario_2022/pages/splashscreen/splashscreen_page.dart';
import 'package:aplicativo_inventario_2022/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(name: Routes.splashscreen, page: () => SplashscreenPage()),
    GetPage(
        name: Routes.login,
        page: () => const LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: Routes.localidades,
        page: () => LocalidadesPage(),
        binding: LocalidadesBinding()),
    GetPage(
        name: Routes.localidadeDetail,
        page: () => LocalidadeDetailPage(),
        binding: LocalidadeDetailBinding()),
    GetPage(
        name: Routes.adicionarBem,
        page: () => AdicionarBemPage(),
        binding: AdicionarBemBinding()),
    GetPage(
        name: Routes.panoramicas,
        page: () => PanoramicasPage(),
        binding: PanoramicasBinding()),
    GetPage(
        name: Routes.finalizarLocalidade,
        page: () => FinalizarLocalidadePage(),
        binding: FinalizarLocalidadeBinding()),
  ];
}
