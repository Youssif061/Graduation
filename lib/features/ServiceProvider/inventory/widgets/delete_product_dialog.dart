import 'package:expertisemarket/features/products/models/product_model.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/cubit/inventory_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteProductDialog {
  const DeleteProductDialog._();

  static Future<void> show(
    BuildContext context,
    ProductModel product,
  ) async {
    final bool? result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
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
                Navigator.pop(context, false);
              },
              child: const Text(
                "Cancel",
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(
                "Delete",
              ),
            ),
          ],
        );
      },
    );

    if (result != true || !context.mounted) {
      return;
    }

    final cubit = context.read<InventoryCubit>();

    await cubit.deleteProduct(
      product.id,
    );

    if (!context.mounted) return;

    final state = cubit.state;

    if (state is InventoryFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            state.message,
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Product deleted successfully.",
        ),
      ),
    );
  }
}