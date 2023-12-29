import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  //+++++++++++++++++++++++++++++++++++++++++
  var _email = '';
  var _password = '';
  var _username = '';

  bool isLoginPage = false;
  //+++++++++++++++++++++++++++++++++++++++++
  startauthentication() {
    final validity = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (validity) {
      _formkey.currentState?.save();
      submitform(_email, _password, _username);
    }
  }

  submitform(String email, String password, String username) async {
    final auth = FirebaseAuth.instance;
    UserCredential authResult;
    try {
      if (isLoginPage) {
        authResult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String uid = authResult.user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username': username,
          'email': email,
        });
      }
    } catch (err) {
      print(err);
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!isLoginPage)
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          key: const ValueKey('username'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Incorrect Username';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _username = value!;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(),
                              ),
                              labelText: 'Enter Username',
                              labelStyle: GoogleFonts.roboto()),
                        ),
                      const SizedBox(
                        height: 20,
                      ),

                      //Email FormField
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        key: const ValueKey('email'),
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Incorrect Email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(),
                            ),
                            labelText: 'Enter Email',
                            labelStyle: GoogleFonts.roboto()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      //password formField
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        key: const ValueKey('password'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Incorrect password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value!;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(),
                            ),
                            labelText: 'Enter Password',
                            labelStyle: GoogleFonts.roboto()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        width: double.infinity,
                        height: 70,
                        child: ElevatedButton(
                          child: isLoginPage
                              ? Text('Login',
                                  style: GoogleFonts.roboto(fontSize: 16))
                              : Text('SignUp',
                                  style: GoogleFonts.roboto(fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            startauthentication();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              isLoginPage = !isLoginPage;
                            });
                          },
                          child: isLoginPage
                              ? const Text('Not a member?')
                              : const Text("Already a Member?"),
                        ),
                      ),
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
