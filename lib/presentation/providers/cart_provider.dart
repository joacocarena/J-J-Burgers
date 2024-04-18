import 'package:flutter/material.dart';
import 'package:jj_burgers/presentation/models/burger_model.dart';

class CartNotifier extends ChangeNotifier {
  final List<Burger> _items = [];
  bool hayProdEnCarro = false;

  List<Burger> get items => _items;

  void addItem(Burger burger) {
    _items.add(burger);
    notifyListeners();
  }

  void removeItem(Burger burger) {
    _items.remove(burger);
    (_items.isNotEmpty) ? hayProdEnCarro = true : hayProdEnCarro = false;
    notifyListeners();
  }

  int get itemLength => _items.length;
}