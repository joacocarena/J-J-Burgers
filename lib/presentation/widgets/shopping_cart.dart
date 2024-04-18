import '../models/burger_model.dart';

class ShoppingCart {
  final List<Burger> _items = [];

  void addProduct(Burger product) {
    _items.add(product);
  }

  void removeProduct(Burger product) {
    _items.remove(product);
  }

  double calculateTotal() {
    double total = 0;
    for (final item in _items) {
      total += item.price;
    }
    return total;
  }

  List<Burger> get items => _items;
}