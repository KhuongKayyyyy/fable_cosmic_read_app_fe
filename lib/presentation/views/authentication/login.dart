import 'package:fable_cosmic_read_app_fe/core/theme/app_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Text(
          "Sign up with email",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
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
                  decoration: InputDecoration(
                    filled: true, // This makes sure the fillColor is applied
                    fillColor: Colors.grey[100], // Light grey background color
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
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true, // This makes sure the fillColor is applied
                    fillColor: Colors.grey[100], // Light grey background color
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
                InkWell(
                  onTap: () {},
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
    );
  }
}
