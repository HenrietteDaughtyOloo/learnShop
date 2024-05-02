import 'package:flutter/material.dart';


class CartModel extends ChangeNotifier{
  final List _groceryItems=[
    ["Banana", "10.00", "assets/images/banana.png", Colors.green],
    ["Mango", "30.00", "assets/images/mango.png", Colors.green,],
    ["water", "90.00", "assets/images/water.png", Colors.green],
    ["Apple", "20.50", "assets/images/apple.png", Colors.green],
    ["Cabbage", "100.00", "assets/images/cabage.png", Colors.green],
    ["Kales", "130.00", "assets/images/kales.png", Colors.green],
    ["Avocado", "50.00", "assets/images/avocado.png", Colors.green],

  ];

  List _cartItems =[];

  get groceryItems => _groceryItems;

  get cartItems => _cartItems;

  void addItemsToCart(int index){
    _cartItems.add(_groceryItems[index]);
    notifyListeners();
  }

  void removeItemsFromCart(int index){
    _cartItems.removeAt(index);
    notifyListeners();
  }

  String calculateTheTotalPrice(){
    double totalPriceInCart = 0;
    for (int i=0; i<_cartItems.length;i++){
      totalPriceInCart +=double.parse(_cartItems[i][1]);
  }
  return totalPriceInCart.toStringAsFixed(2);
}

void clearCart() {
   _cartItems = [];
   notifyListeners();
}

bool isItemInCart(String itemName
) {
  bool isPresent = false;
  for (var i in _cartItems)
  {
    if (itemName == i[0
    ]){isPresent = true;}
  }
  return isPresent;
  }
  }