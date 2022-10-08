import 'package:flutter/material.dart';
import 'package:twitch_clone/utils/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            primary: buttonColor,
            minimumSize: const Size(double.infinity, 45)),
        onPressed: onTap,
        child: Text(text));
  }
}
