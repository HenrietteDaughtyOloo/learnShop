import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/model/cart_model.dart';
import 'activities/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'activities/payment_screen.dart';


Future<void> main() async {
  String envPath = '${Directory.current.path}/.env';
  print('Loading .env file from: $envPath');
  
  try {
    await dotenv.load(fileName: envPath);
    print("ENV Loaded: ${dotenv.env}");
  } catch (e) {
    print("Error loading .env file: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

@override
Widget build(BuildContext context){
    return ChangeNotifierProvider(create: (context) => CartModel(),
      child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      ),
    );
}
}