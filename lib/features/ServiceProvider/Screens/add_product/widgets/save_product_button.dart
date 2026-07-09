import 'package:craftmarket/features/ServiceProvider/widgets/main_button.dart';
import 'package:flutter/material.dart';

class SaveProductButton extends StatelessWidget {
  const SaveProductButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MainButton(
      text: "Save Product",
      background: Color(0xff1A2E44),
      onPress: () {},
    );
  }
}