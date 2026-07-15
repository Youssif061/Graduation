import 'package:expertisemarket/features/ServiceProvider/add_product/cubit/add_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StockField extends StatelessWidget {
  const StockField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddProductCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Stock Quantity",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff001A2C),
          ),
        ),

        const SizedBox(height: 10),

        TextFormField(
          controller: cubit.stockController,

          keyboardType: TextInputType.number,

          textInputAction: TextInputAction.done,

          decoration: InputDecoration(
            hintText: "0",

            prefixIcon: const Icon(
              Icons.inventory_2_outlined,
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
              return "Please enter stock quantity";
            }

            final stock = int.tryParse(value);

            if (stock == null) {
              return "Invalid stock quantity";
            }

            if (stock < 0) {
              return "Stock cannot be negative";
            }

            return null;
          },
        ),
      ],
    );
  }
}