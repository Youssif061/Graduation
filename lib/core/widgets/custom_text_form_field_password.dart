import 'package:flutter/material.dart';

class CustomTextFormFieldPassword extends StatefulWidget {
  const CustomTextFormFieldPassword({
    super.key,
    this.text,
    this.Styles,
    this.Text_Color,
    this.fill_color,
    this.suffix_Icon,
    this.prefixIcon,
    this.controller,
    this.validator,
    this.width,
    this.height,
  });
  final double? width;
  final double? height;
  final String? text;
  final TextStyle? Styles;
  final Color? Text_Color;
  final Color? fill_color;
  final Widget? suffix_Icon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  @override
  State<CustomTextFormFieldPassword> createState() =>
      _CustomTextFormFieldPasswordState();
}

class _CustomTextFormFieldPasswordState
    extends State<CustomTextFormFieldPassword> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (even) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      controller: widget.controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintStyle: widget.Styles?.copyWith(color: widget.Text_Color),
        hintText: widget.text,
        fillColor: widget.fill_color,
        filled: true,
        prefixIcon: widget.prefixIcon,
        suffixIcon:
            widget.suffix_Icon ??
            IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: obscureText
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.remove_red_eye),
              color: widget.Text_Color,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      validator: widget.validator,
    );
  }
}
