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
  });

  final String? text;
  final Color? Text_Styles;
  final TextStyle? Styles;
  final Color? fill_color;
  final Widget? suffix_Icon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
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






 // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10),
        //   borderSide: BorderSide(color: AppColors.graykcolor),
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10),
        //   borderSide: BorderSide.none,
        // ),
        // focusedErrorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10),
        //   borderSide: BorderSide.none,
        // ),
        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10),
        //   borderSide: BorderSide.none,
        // ),