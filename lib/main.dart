import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todosssss/auth/auth_cubit.dart';
import 'package:todosssss/screens/home.dart';
import 'package:todosssss/screens/splash_screen.dart';
import 'firebase_options.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(), // Provide the AuthCubit
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.dark, primaryColor: const Color(0xff00c47a)),
        home: const SplashScreen(),
        routes: {
          '/home': (context) => Home(),
        },
      ),
    );
  }
}
