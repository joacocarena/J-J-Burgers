import 'package:get/get.dart';

class CartController extends GetxController {
  final _products = {}.obs;

  void addProduct(List<dynamic> burger) {
    if (_products.containsKey(burger)) {
      _products[burger] += 1;
    } else {
      _products[burger] = 1;
    }

    Get.snackbar(
      'Producto añadido al carro', 'Agregaste $burger al carrito',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  get products => _products;

}