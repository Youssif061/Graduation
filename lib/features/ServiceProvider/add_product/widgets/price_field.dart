import 'package:expertisemarket/features/ServiceProvider/add_product/cubit/add_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceField extends StatelessWidget {
  const PriceField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddProductCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Price",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff001A2C),
          ),
        ),

        const SizedBox(height: 10),

        TextFormField(
          controller: cubit.priceController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textInputAction: TextInputAction.next,

          decoration: InputDecoration(
            hintText: "Product Price",

            prefixIcon: const Icon(
              Icons.attach_money,
              color: Color(0xff64748B),
            ),

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
              return "Please enter product price";
            }

            final price = double.tryParse(value);

            if (price == null) {
              return "Invalid price";
            }

            if (price <= 0) {
              return "Price must be greater than zero";
            }

            return null;
          },
        ),
      ],
    );
  }
}