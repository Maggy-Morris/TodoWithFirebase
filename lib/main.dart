
import 'package:flutter/material.dart';
import 'package:todosssss/auth/authscreen.dart';
import 'package:todosssss/screens/home.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Color.fromARGB(255, 51, 161, 134)
      
      ),
      home: const AuthScreen(),

    );
  }
}