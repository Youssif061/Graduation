import 'package:expertisemarket/features/ServiceProvider/add_product/cubit/add_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductNameField extends StatelessWidget {
  const ProductNameField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddProductCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Product Name",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff001A2C),
          ),
        ),

        const SizedBox(height: 10),

        TextFormField(
          controller: cubit.nameController,
          textInputAction: TextInputAction.next,

          decoration: InputDecoration(
            hintText: "Enter Product Name",

            filled: true,
            fillColor: Colors.white,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),

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
              return "Please enter product name";
            }

            if (value.trim().length < 3) {
              return "Product name is too short";
            }

            return null;
          },
        ),
      ],
    );
  }
}