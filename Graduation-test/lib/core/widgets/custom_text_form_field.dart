import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.text,
    this.Text_Styles,
    this.Styles,
    this.fill_color,
    this.suffix_Icon,
    this.prefixIcon,
    this.keyboardType,
    this.validator,
    this.controller,
  });

  final String? text;
  final Color? Text_Styles;
  final TextStyle? Styles;
  final Color? fill_color;
  final Widget? suffix_Icon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        // prefixIcon: Icon(Icons.email),
        suffixIcon: suffix_Icon,
        prefixIcon: prefixIcon,
        fillColor: fill_color,
        filled: true,
        //labelText:  "Enter your email",
        hintStyle: Styles?.copyWith(color: Text_Styles),
        hintText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
    );
  }
}
