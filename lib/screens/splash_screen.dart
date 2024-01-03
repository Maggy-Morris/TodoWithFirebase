import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:todosssss/auth/authscreen.dart';
import 'dart:async';

import 'package:todosssss/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return StartState();
  }
}

class StartState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => 
        StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, usersnapshot) {
              if (usersnapshot.hasData) {
                return const Home();
              } else {
                return const AuthScreen();
              }
            }),
        
        
        
        
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 116, right: 116),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            const CircleAvatar(
              radius: 120,
              backgroundImage: AssetImage('assets/images/icon.jpg'),
            ),
            const Divider(
              color: Colors.transparent,
            ),
            SpinKitFadingCircle(
              color: Theme.of(context).primaryColor,
              size: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}
