import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier{
  final List _groceryItems=[
    ["Banana", "4.00", "assets/images/banana.png", Colors.green],
    ["Mango", "5.00", "assets/images/mango.jpg", Colors.orange],
    ["water", "10.00", "assets/images/water.jpg", Colors.blue],
    ["Apple", "4.50", "assets/images/apple.jpg", Colors.red],


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