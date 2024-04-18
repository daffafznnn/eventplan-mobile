import 'package:get/get.dart';

import '../controllers/menu_navigation_controller.dart';

class MenuNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuNavigationController>(
      () => MenuNavigationController(),
    );
  }
}
