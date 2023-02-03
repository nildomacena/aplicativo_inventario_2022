import 'package:aplicativo_inventario_2022/data/auth_provider.dart';
import 'package:aplicativo_inventario_2022/data/firestore_provider.dart';
import 'package:aplicativo_inventario_2022/utils/util_service.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    utilService.initApp();
    Get.put(AuthProvider(), permanent: true);
    Get.put(FirestoreProvider(), permanent: true);
  }
}
