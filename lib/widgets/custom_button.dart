import 'package:flutter/material.dart';

class CustomButtton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const CustomButtton({required this.text, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(text)));
  }
}
