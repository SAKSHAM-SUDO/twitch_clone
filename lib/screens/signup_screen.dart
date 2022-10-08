import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:twitch_clone/resources/auth_method.dart';
import 'package:twitch_clone/responsive/responsive.dart';
import 'package:twitch_clone/screens/home_screen.dart';
import 'package:twitch_clone/screens/login_screen.dart';
import 'package:twitch_clone/widgets/custom_button.dart';
import 'package:twitch_clone/widgets/custom_textfield.dart';
import 'package:twitch_clone/widgets/loading_indicator.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();
  final TextEditingController _usernameControler = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();
  bool isLoading = false;
  void signUpUser() async {
    setState(() {
      isLoading = true;
    });
    bool res = await _authMethods.signUpUser(context, _emailControler.text,
        _usernameControler.text, _passwordControler.text);
    setState(() {
      isLoading = false;
    });
    if (res) {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  @override
  void dispose() {
    _usernameControler.dispose();
    _emailControler.dispose();
    _passwordControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const LoadingIndicator()
          : Responsive(
              // child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: size.height * 0.1,
                    // ),

                    Flexible(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // mainAxisSize: MainAxisSize.,

                        children: [
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Email',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CustomtextField(
                                  controller: _emailControler,
                                  isPassword: false)
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Username ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CustomtextField(
                                  controller: _usernameControler,
                                  isPassword: false),
                            ],
                          ),
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Password',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CustomtextField(
                                  controller: _passwordControler,
                                  isPassword: true),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, LoginScreen.routeName);
                              },
                              child: Text(
                                'Already have an account?',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomButton(text: 'Sign Up', onTap: signUpUser),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
      // ),
    );
  }
}
