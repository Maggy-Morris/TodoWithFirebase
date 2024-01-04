import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Events

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  const AuthSignIn(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String username;

  const AuthSignUp(this.email, this.password, this.username);

  @override
  List<Object?> get props => [email, password, username];
}

class ToggleAuthMode extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class CheckAuthentication extends AuthEvent {
  @override
  List<Object?> get props => [];
}

// Cubit
class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoginPage = true;

  AuthCubit() : super(AuthInitial());
  void signIn(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthSuccess(authResult.user!));
    } catch (e) {
      print("Authentication Failed: $e");
      Fluttertoast.showToast(msg: e.toString());

      emit(AuthFailure(e.toString()));
    }
  }

  void signUp(String email, String password, String username) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = authResult.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'username': username,
        'email': email,
      });
      emit(AuthSuccess(authResult.user!));
    } catch (e) {
      print("Authentication Failed: $e");
      Fluttertoast.showToast(msg: e.toString());
      emit(AuthFailure(e.toString()));
    }
  }

  void toggleAuthMode() {
    isLoginPage = !isLoginPage;
    emit(AuthInitial());
  }

  void navigateToNextScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home');
  }

  void checkAuthentication() {
    final user = _auth.currentUser;
    if (user != null) {
      emit(AuthSuccess(user));
    } else {
      emit(AuthFailure('User not authenticated'));
    }
  }
}
