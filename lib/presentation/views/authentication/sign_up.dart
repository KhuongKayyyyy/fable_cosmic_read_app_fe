import 'package:fable_cosmic_read_app_fe/core/router/routes.dart';
import 'package:fable_cosmic_read_app_fe/core/theme/app_theme.dart';
import 'package:fable_cosmic_read_app_fe/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController =
      TextEditingController(text: "test1@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "123456789");
  final TextEditingController _passwordConfirmController =
      TextEditingController(text: "123456789");
  final AuthenticationBloc _authenticationBloc = AuthenticationBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Sign up with email",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Welcome !!!",
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Fable is a reading app that brings stories to life, offering a vast library of books for users to explore anytime, anywhere.",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[400],
                        fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true, // This makes sure the fillColor is applied
                      fillColor:
                          Colors.grey[100], // Light grey background color
                      hintText: "Email", // Hint text
                      hintStyle: const TextStyle(
                        color: Colors.grey, // Grey color for the hint text
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3.0, color: AppTheme.secondaryColor),
                        borderRadius:
                            BorderRadius.circular(10), // Rounded borders
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppTheme.primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Password",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true, // This makes sure the fillColor is applied
                      fillColor:
                          Colors.grey[100], // Light grey background color
                      hintText: "Password", // Hint text
                      hintStyle: const TextStyle(
                        color: Colors.grey, // Grey color for the hint text
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3.0, color: AppTheme.secondaryColor),
                        borderRadius:
                            BorderRadius.circular(10), // Rounded borders
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppTheme.primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Confirm Password",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _passwordConfirmController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true, // This makes sure the fillColor is applied
                      fillColor:
                          Colors.grey[100], // Light grey background color
                      hintText: "Password", // Hint text
                      hintStyle: const TextStyle(
                        color: Colors.grey, // Grey color for the hint text
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3.0, color: AppTheme.secondaryColor),
                        borderRadius:
                            BorderRadius.circular(10), // Rounded borders
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppTheme.primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BlocListener<AuthenticationBloc, AuthenticationState>(
                    bloc: _authenticationBloc,
                    listener: (context, state) {
                      if (state is AuthenticationSuccess) {
                        EasyLoading.showSuccess('Sign up successful');
                        context.go(Routes.login);
                      } else if (state is AuthenticationFailure) {
                        EasyLoading.showError(state.message);
                      } else if (state is AuthenticationLoading) {
                        EasyLoading.show(status: 'Signing up...');
                      }
                    },
                    child: InkWell(
                      onTap: () {
                        _authenticationBloc.add(SignUpRequested(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2, color: Colors.black),
                            color: AppTheme.secondaryColor),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.email_outlined),
                            SizedBox(width: 10),
                            Text(
                              "Sign up with email",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'By signing up, you agree to our ',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle Terms of Service tap
                            },
                        ),
                        TextSpan(
                          text: ' and ',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle Privacy Policy tap
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
