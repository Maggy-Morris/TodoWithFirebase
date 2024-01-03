import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todosssss/screens/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: const Color(0xff00c47a)),
        home: const SplashScreen()
        
        // StreamBuilder(
        //     stream: FirebaseAuth.instance.authStateChanges(),
        //     builder: (context, usersnapshot) {
        //       if (usersnapshot.hasData) {
        //         return const Home();
        //       } else {
        //         return const AuthScreen();
        //       }
        //     }),
            );
  }
}
