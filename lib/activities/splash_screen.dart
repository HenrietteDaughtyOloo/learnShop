import 'package:flutter/material.dart';
import 'package:shop/activities/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 80.0, top: 40, bottom:40, right:80),
            child: Image.asset('assets/images/apple.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text('Grocery Delivery at the comfort of your house',
              textAlign: TextAlign.center,
              // fontSize: 36.0,
              // style:
              // Theme.of(context).textTheme.headline4),
            style:
             TextStyle(
              fontSize:20,
              fontWeight: FontWeight.bold,
              ) 
             )
             
              ),

              Text("Daily Freshness"),
              
              const Spacer(),

              GestureDetector(
                onTap: ()=>Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context){
                    return const HomeScreen();
                  }
                  ),
                ),

               child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF03787C),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(14),
                  child: Text("Get Started", 
                  style: TextStyle(color:Colors.white),
                  ),
                ),
               ),

                
              const Spacer(),
        ],
      ),
    );
  }
}