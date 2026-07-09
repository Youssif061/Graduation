import 'package:craftmarket/core/styles/coloras.dart';
import 'package:flutter/material.dart';

class DeleteProductDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,

      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),

          title: const Text("Delete Product"),

          content: const Text(
            "Are you sure you want to delete this product?\n\nThis action cannot be undone.",
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Cancel", style: TextStyle(color: AppColors.darkColor)),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),

              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Product Deleted Successfully")),
                );
              },

              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
