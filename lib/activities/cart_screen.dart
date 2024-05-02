import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/activities/payment_screen.dart';
import 'package:shop/model/cart_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Shopping Cart',
      style:
             TextStyle(
              fontSize:25,
              color: Color(0xFF03787C),
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal

              ) 

      )),
      body: Consumer<CartModel>(
        builder: (context, value, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: value.cartItems.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Color.fromARGB(255, 180, 246, 248),                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, left: 6, right: 6),
                        child: ListTile(
                          leading: Image.asset(value.cartItems[index][2], height: 36,),
                          title: 
                          Text(value.cartItems[index][0], 
                          style:TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            ),
                            ),
                         subtitle: Text("\KES "+value.cartItems[index][1],
                                                   style:TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            ),

                         ),
                          trailing:IconButton(
                            icon: Icon(Icons.cancel,
                            // color: Color(0xFF03787C)
                            color: Color.fromARGB(255, 218, 20, 6),
                            size: 35.0,),
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
                color: Color(0xFF03787C),
                borderRadius: BorderRadius.circular(8),
              ),

                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: 
                  [Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total Price  ",
                    
                    style: TextStyle(color: Colors.white,fontSize: 18),
                    ),
                    Text('\KES '+value.calculateTheTotalPrice(),
                    style: TextStyle(color: Colors.white,
                    fontSize: 18, fontWeight: FontWeight.bold),

                    ),                 
                  ],
                ),
                

                Container(
                  margin: EdgeInsets.only(top: 0,left: 5, right: 2,bottom: 0),
                  decoration: BoxDecoration(border: Border.all(color: Colors.green.shade100),
                  borderRadius: BorderRadius.circular(15),
                  ),
                  

                  padding: EdgeInsets.all(7),
                  child: Row(children: [

                    TextButton(onPressed: (){

                      Navigator.pushReplacement(
                        context, MaterialPageRoute(
                          builder: (context){
                            double totalAmountInCart =double.parse(value.calculateTheTotalPrice());
                            return PaymentScreen(totalAmount: totalAmountInCart,
                            );
                          }
                            )
                            );

                    }, child: Text("Proceed to Pay",
                                   
                  style: TextStyle(color: Colors.white,fontSize: 18),

                  ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios, size: 17,color: Colors.white,
                  ),
                    
        
                  ],
                  ),
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
