import 'package:flutter/material.dart';
import 'package:twitch_clone/resources/auth_method.dart';
import 'package:twitch_clone/screens/home_screen.dart';
import 'package:twitch_clone/widgets/custom_button.dart';
import 'package:twitch_clone/widgets/custom_textfield.dart';

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
  void signUpUser() async {
    bool res = await _authMethods.signUpUser(context, _emailControler.text,
        _usernameControler.text, _passwordControler.text);

    if (res) {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              const Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: CustomTextField(controller: _emailControler),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Username ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: CustomTextField(controller: _usernameControler),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Password',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: CustomTextField(controller: _passwordControler),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(text: 'Sign Up', onTap: signUpUser)
            ],
          ),
        ),
      ),
    );
  }
}
