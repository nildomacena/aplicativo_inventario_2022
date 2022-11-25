import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;
  final TextInputFormatter? inputFormatter;
  final TextInputType? textInputType;
  final bool? obscure;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final EdgeInsets? padding;
  final Widget? preffix;
  final int maxLines;
  const CustomTextField(
      {required this.label,
      required this.controller,
      this.textInputType,
      this.preffix,
      this.obscure,
      this.maxLines = 1,
      this.padding = EdgeInsets.zero,
      this.inputFormatter,
      this.focusNode,
      this.textInputAction,
      this.onSubmitted,
      this.validator,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* const SizedBox(
            height: 10,
          ), */
          Text(
            label,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Get.theme.primaryColor),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            autofocus: false,
            controller: controller,
            focusNode: focusNode,
            onFieldSubmitted: onSubmitted,
            keyboardType: textInputType,
            validator: validator,
            textInputAction: textInputAction,
            obscureText: obscure ?? false,
            maxLines: maxLines,
            inputFormatters: inputFormatter != null ? [inputFormatter!] : null,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Get.theme.primaryColor),
            decoration: InputDecoration(
                prefix: preffix,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
          ),
        ],
      ),
    );
  }
}
