import 'package:flutter/material.dart';
import 'package:twitch_clone/resources/auth_method.dart';
import 'package:twitch_clone/responsive/responsive.dart';
import 'package:twitch_clone/screens/home_screen.dart';
import 'package:twitch_clone/widgets/custom_button.dart';
import 'package:twitch_clone/widgets/custom_textfield.dart';
import 'package:twitch_clone/widgets/loading_indicator.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();
  bool isLoading = false;
  loginUser() async {
    setState(() {
      isLoading = true;
    });
    bool res = await _authMethods.loginUser(
        context, _emailControler.text, _passwordControler.text);

    setState(() {
      isLoading = false;
    });
    if (res) {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  @override
  void dispose() {
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
                              'Log In',
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Email',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: CustomtextField(
                                    controller: _emailControler,
                                    isPassword: false),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Password',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: CustomtextField(
                                    controller: _passwordControler,
                                    isPassword: true),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              onTap: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                        flex: 1,
                        child: Center(
                            child:
                                CustomButton(text: 'Login', onTap: loginUser)))
                  ],
                ),
              ),
            ),
    );
  }
}
