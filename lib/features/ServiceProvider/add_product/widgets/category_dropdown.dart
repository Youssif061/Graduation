import 'package:expertisemarket/features/ServiceProvider/add_product/cubit/add_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({super.key});

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  final List<String> categories = const [
    "Electronics",
    "Tools",
    "Furniture",
    "Machines",
    "Safety",
    "Accessories",
    "Other",
  ];

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddProductCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Category",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff001A2C),
          ),
        ),

        const SizedBox(height: 10),

        DropdownButtonFormField<String>(
          value: selectedCategory,

          decoration: InputDecoration(
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

          hint: const Text("Select Category"),

          items: categories.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Text(category),
            );
          }).toList(),

          onChanged: (value) {
            setState(() {
              selectedCategory = value;
            });

            cubit.categoryController.text = value ?? "";
          },

          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please select category";
            }

            return null;
          },
        ),
      ],
    );
  }
}