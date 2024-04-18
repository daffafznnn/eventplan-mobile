import 'package:get/get.dart';

class MenuNavigationController extends GetxController {
  var currentIndex = 0.obs;
  var currentPage = '/home'.obs; // Menambahkan getter untuk halaman saat ini

  void changePage(int index) {
    currentIndex.value = index;
    switch (index) {
      case 0:
        currentPage.value = '/home';
        break;
      case 1:
        currentPage.value = '/events';
        break;
        case 3:
        currentPage.value = '/profile';
        break;
      default:
        currentPage.value =
            '/home'; // Kembali ke halaman home jika tidak ada yang cocok
    }
  }
}
