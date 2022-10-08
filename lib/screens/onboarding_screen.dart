import 'package:flutter/material.dart';
import 'package:twitch_clone/responsive/responsive.dart';
import 'package:twitch_clone/screens/login_screen.dart';
import 'package:twitch_clone/screens/signup_screen.dart';
import 'package:twitch_clone/widgets/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(
                flex: 1,
              ),
              Image.asset('assets/black.png'),
              const Text(
                "Welocme to Twitch",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                textAlign: TextAlign.center,
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              Spacer(
                flex: 1,
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                      text: 'Login',
                      onTap: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      }),
                  SizedBox(
                    height: 7,
                  ),
                  CustomButton(
                      text: 'Signup',
                      onTap: () {
                        Navigator.pushNamed(context, SignupScreen.routeName);
                      }),
                  SizedBox(height: 20)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
