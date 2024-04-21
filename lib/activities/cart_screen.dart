// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/model/cart_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Shopping Cart')),
      body: Consumer<CartModel>(
        builder: (context, value, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: value.cartItems.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, left: 6, right: 6),
                        child: ListTile(
                          leading: Image.asset(value.cartItems[index][2], height: 36,),
                          title: Text(value.cartItems[index][0]),
                         subtitle: Text("\$"+value.cartItems[index][1]),
                          trailing:IconButton(
                            icon: Icon(Icons.cancel),
                             onPressed: ()=>Provider.of<CartModel>(context,listen: false).removeItemsFromCart(index),
                          )
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(padding: const EdgeInsets.all(36.0),
              child: Container(decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),

                padding: EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: 
                  [Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total Price",
                    style: TextStyle(color: Colors.green[100],),
                    ),
                    Text('\$'+value.calculateTheTotalPrice(),
                    style: TextStyle(color: Colors.white,
                    fontSize: 18, fontWeight: FontWeight.bold),

                    ),                 
                  ],
                ),

                Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.green.shade100),
                  borderRadius: BorderRadius.circular(12),
                  ),

                  padding: EdgeInsets.all(12),
                  child: Row(children: [Text("Proceed to Pay",
                  
                  style: TextStyle(color: Colors.white,),

                  ),
                  Icon(
                    Icons.arrow_forward_ios, size: 17,color: Colors.white,
                  )
                  ],),
                )
                ],

              ),
              ),)
            ],
          );
        },
      ),
    );
  }
}
