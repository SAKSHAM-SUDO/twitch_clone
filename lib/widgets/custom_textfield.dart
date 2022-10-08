import 'package:flutter/material.dart';
import 'package:twitch_clone/utils/colors.dart';

// class CustomTextField extends StatelessWidget {
//   final Function(String)? onTap;
//   final TextEditingController controller;
//   CustomTextField({Key? key, required this.controller, this.onTap})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       onSubmitted: onTap,
//       controller: controller,
//       decoration: const InputDecoration(
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: buttonColor, width: 2)),
//           enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: secondaryBackgroundColor))),
//     );
//   }
// }
class CustomtextField extends StatefulWidget {
  final Function(String)? onTap;
  final TextEditingController controller;
  final bool isPassword;

  const CustomtextField(
      {Key? key,
      this.onTap,
      required this.controller,
      required this.isPassword})
      : super(key: key);

  @override
  State<CustomtextField> createState() => _CustomtextFieldState();
}

class _CustomtextFieldState extends State<CustomtextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: widget.onTap,
      controller: widget.controller,
      obscureText: widget.isPassword,
      decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: buttonColor, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: secondaryBackgroundColor))),
    );
  }
}
