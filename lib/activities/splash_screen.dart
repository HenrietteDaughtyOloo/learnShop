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
              left: 80.0, top: 100, bottom:40, right:80),
            child: Image.asset('assets/images/groceryshop.png'),
            
            ),
            Padding(
              padding: const EdgeInsets.only(left: 23.0, right: 23.0, top: 23.0,bottom:23.0),
              child: FlyInText(),

             
              ),
              

              Text("Daily Freshness",
              style: TextStyle(color: Color(0xFF03787C),
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 18,
),
              ),
              
              
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
        padding: EdgeInsets.only(left: 45, right: 45, top: 15, bottom: 15),
              child: Text('Get Started',
          style: TextStyle(color:Colors.white, fontSize: 20.0),
        ),
      ),
                
               ),
               

                
              const Spacer(),
        ],
      ),
    );
  }
}
class FlyInText extends StatefulWidget {
  @override
  _FlyInTextState createState() => _FlyInTextState();
}

class _FlyInTextState extends State<FlyInText> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(1.1, 1.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Text('Grocery Delivery at \b the comfort of your house!',
      textAlign: TextAlign.center,
      style:
             TextStyle(
              fontSize:40,
              fontWeight: FontWeight.bold,
              color: Color(0xFF03787C),

              ) 
              
             ),
    );
  }


  
}