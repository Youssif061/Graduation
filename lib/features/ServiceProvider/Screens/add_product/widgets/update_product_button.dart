import 'package:flutter/material.dart';

class UpdateProductButton extends StatelessWidget {
  const UpdateProductButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton.icon(
        onPressed: () {

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Product Updated Successfully"),
            ),
          );

        },

        icon: const Icon(
          Icons.edit,
          color: Colors.white,
        ),

        label: const Text(
          "Update Product",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),

        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff001A2C),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}