import 'package:expertisemarket/features/products/models/product_model.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/cubit/inventory_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteProductDialog {
  static void show(
    BuildContext context,
    ProductModel product,
  ) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),

          title: const Text(
            "Delete Product",
          ),

          content: Text(
            "Are you sure you want to delete '${product.name}'?\n\nThis action cannot be undone.",
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),

              onPressed: () async {
                Navigator.pop(context);

                await context
                    .read<InventoryCubit>()
                    .deleteProduct(product.id);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Product Deleted Successfully",
                      ),
                    ),
                  );
                }
              },

              child: const Text(
                "Delete",
              ),
            ),
          ],
        );
      },
    );
  }
}