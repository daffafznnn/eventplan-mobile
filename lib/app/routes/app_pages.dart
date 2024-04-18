import 'package:get/get.dart';

import '../middlewares/auth_middleware.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_login_view.dart';
import '../modules/events/bindings/events_binding.dart';
import '../modules/events/views/events_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/menu_navigation/bindings/menu_navigation_binding.dart';
import '../modules/menu_navigation/views/menu_navigation_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MENU_NAVIGATION;

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
    GetPage(
      name: _Paths.MENU_NAVIGATION,
      page: () => MenuNavigationView(),
      binding: MenuNavigationBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EVENTS,
      page: () => const EventsView(),
      binding: EventsBinding(),
    ),
  ];
}
