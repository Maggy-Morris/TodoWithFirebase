import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todosssss/auth/auth_cubit.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
   

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          final authCubit = context.read<AuthCubit>();
          authCubit.navigateToNextScreen(context);
        } else if (state is AuthFailure) {
          Fluttertoast.showToast(msg: 'Authentication Failed');
        }
      },
      builder: (context, state) {
        final authCubit = context.read<AuthCubit>();
        final isLoginPage = authCubit.isLoginPage;
 var email = '';
    var password = '';
    var username = '';
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.all(30),
                height: 200,
                child: CircleAvatar(
                  radius: 100,
                  
              backgroundImage: AssetImage('assets/images/icon2.jpg'),
            
                  ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: formkey,
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
                              username = value!;
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
                            email = value!;
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
                            password = value!;
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
                          padding: EdgeInsets.all(5),
                          width: double.infinity,
                          height: 70,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            onPressed: () async{
                              if (isLoginPage) {
                                authCubit.signIn(email, password);
                              } else {
                                authCubit.signUp(email, password, username);
                              }
                            },
                            child: isLoginPage
                                ? Text('Login',
                                    style: GoogleFonts.roboto(fontSize: 16))
                                : Text('SignUp',
                                    style: GoogleFonts.roboto(fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: TextButton(
                  onPressed: () {
                    authCubit
                        .toggleAuthMode(); // Toggle between login and sign-up mode

                    
                  },
                  child: isLoginPage
                      ? Text(
                          'Not a member?',
                          style: GoogleFonts.roboto(
                              fontSize: 16, color: Colors.white),
                        )
                      : Text(
                          "Already a Member?",
                          style: GoogleFonts.roboto(
                              fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
