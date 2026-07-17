import 'package:expertisemarket/features/ServiceProvider/add_product/cubit/add_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddProductCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Description",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff001A2C),
          ),
        ),

        const SizedBox(height: 10),

        TextFormField(
          controller: cubit.descriptionController,
          maxLines: 5,
          minLines: 4,
          textInputAction: TextInputAction.newline,

          decoration: InputDecoration(
            hintText:
                "Write a complete description about your product...",

            hintStyle: TextStyle(
              color: Colors.grey.shade500,
            ),

            filled: true,
            fillColor: Colors.white,

            contentPadding: const EdgeInsets.all(18),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xffCBD5E1),
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xff001A2C),
                width: 1.5,
              ),
            ),
          ),

          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Please enter description";
            }

            if (value.trim().length < 20) {
              return "Description must be at least 20 characters";
            }

            return null;
          },
        ),
      ],
    );
  }
}