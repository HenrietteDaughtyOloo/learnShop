import 'package:flutter/material.dart';

class GroceryItemFile extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String imagePath;
  final color;
  final void Function()? onPressed;
  
  GroceryItemFile({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.imagePath,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.all(12.0),
    child:Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(backgroundBlendMode: color(100),
      borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        Image.asset(imagePath,height: 54,),
        Text(itemName),

       MaterialButton(
        onPressed: onPressed,
          color:color[800],
          child:Text(
          '\$'+itemPrice,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)
          )
       )
      ],),
    ),
    );

  }
}