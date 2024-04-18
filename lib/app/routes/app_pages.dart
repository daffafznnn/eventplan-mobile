import 'package:get/get.dart';

import '../middlewares/auth_middleware.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_login_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      // Terapkan middleware RequiresLoginMiddleware untuk memeriksa apakah pengguna sudah login sebelum mengakses halaman home
      // middlewares: [RequiresLoginMiddleware()],
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthLoginView(),
      binding: AuthBinding(),
      // Terapkan middleware RequiresGuestMiddleware untuk memeriksa apakah pengguna belum login sebelum mengakses halaman login
      middlewares: [RequiresGuestMiddleware()],
    ),
  ];
}
