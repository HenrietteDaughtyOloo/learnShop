import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/activities/cart_screen.dart';
import 'package:shop/model/cart_model.dart';

import '../components/grocery_item_file.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context){
        return CartScreen();
      },
      ),
      ),
      backgroundColor: const Color.fromARGB(255, 33, 6, 38),
      child: Icon(Icons.shopping_bag),
      ),
      body: SafeArea(
        child: 
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const SizedBox(height: 40),
       const Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: 
        Text('Hello There')
        ),

      const SizedBox(height: 4),
      
      Padding(padding: EdgeInsets.symmetric(horizontal: 24.0),
       child: Text("Let's Order fresh Items for you",
                   style:
             TextStyle(
              fontSize:20,
              fontWeight: FontWeight.bold,
              ) 

       ),
       ),

       const SizedBox(height: 24),

       const Padding(padding: EdgeInsets.symmetric(horizontal: 24.0),

       child: Divider(
        thickness: 4,
       ),
            ),

            const SizedBox(height: 24),

            const Padding(padding: EdgeInsets.symmetric(horizontal: 24.0),
       child: Text("Fresh Items",
                   style:
             TextStyle(
              fontSize:16,
              ) 

       ),
       ),

       Expanded(child:Consumer<CartModel>(
        builder:(context, value,child){
          return  GridView.builder(
            itemCount: value.groceryItems.length,
            padding: EdgeInsets.all(12.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,  childAspectRatio:1/1.2,), itemBuilder: (context, index){
        return GroceryItemFile(
          itemName: value.groceryItems[index][0],
          itemPrice: value.groceryItems[index][1],
          imagePath: value.groceryItems[index][2],
          color: value.groceryItems[index][3],
          onPressed: () {
            Provider.of<CartModel>(context, listen: false).addItemsToCart(index);
          },

        );
       });
        }
       ))



      ],)
    ),
    );
}
}