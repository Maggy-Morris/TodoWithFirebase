import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:todosssss/auth/auth_cubit.dart';
import 'package:todosssss/auth/authscreen.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todosssss/screens/home.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return StartState();
  }
}

class StartState extends State<SplashScreen> {
  late AuthCubit authCubit; // Declare AuthCubit variable

  @override
  void initState() {
    super.initState();
    authCubit = context.read<AuthCubit>(); // Initialize AuthCubit
    authCubit.checkAuthentication(); // Dispatch an event to check authentication status
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              return const Home();
            } else {
              return const AuthScreen();
            }
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 116, right: 116),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 100,
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
