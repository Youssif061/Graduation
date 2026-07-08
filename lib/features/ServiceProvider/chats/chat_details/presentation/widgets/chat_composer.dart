import 'package:expertisemarket/core/constants/app_sizes.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:flutter/material.dart';

class ChatComposer extends StatelessWidget {
  const ChatComposer({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onAttachmentTap,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onAttachmentTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.s,
          AppSizes.s,
          AppSizes.md,
          AppSizes.s,
        ),
        decoration: const BoxDecoration(
          color: AppColors.marketCard,
          border: Border(top: BorderSide(color: AppColors.marketBorder)),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: onAttachmentTap,
              icon: const Icon(
                Icons.add_circle_outline,
                color: AppColors.marketTextSub,
              ),
            ),
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.marketInputBg,
                  borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                ),
                child: TextField(
                  controller: controller,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => onSend(),
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppSizes.md,
                      vertical: 14,
                    ),
                    suffixIcon: Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: AppColors.marketTextSub,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSizes.s),
            Material(
              color: AppColors.marketText,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onSend,
                customBorder: const CircleBorder(),
                child: const SizedBox(
                  width: 48,
                  height: 48,
                  child: Icon(
                    Icons.send,
                    size: AppSizes.iconM,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
