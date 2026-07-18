import 'package:expertisemarket/features/ServiceProvider/widgets/main_button.dart';
import 'package:flutter/material.dart';

class SendProposalButton extends StatelessWidget {
  const SendProposalButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return MainButton(
      text: "Send Proposal",
      isLoading: isLoading,
      background: const Color(0xff001A2C),
      onPress: onPressed,
    );
  }
}