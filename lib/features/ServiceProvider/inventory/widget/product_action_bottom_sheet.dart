import 'package:expertisemarket/features/products/models/product_model.dart';
import 'package:expertisemarket/features/ServiceProvider/add_product/page/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/cubit/inventory_cubit.dart';

import 'delete_product_dialog.dart';

class ProductActionBottomSheet {
  static void show(
    BuildContext context,
    ProductModel product,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(20),

          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),

          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                ),

                const SizedBox(height: 25),

                ListTile(
                  leading: const Icon(
                    Icons.edit,
                  ),

                  title: const Text(
                    "Edit Product",
                  ),

                  onTap: () async {
                    Navigator.pop(context);

                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            EditProductScreen(
                          product: product,
                        ),
                      ),
                    );
                    if (context.mounted) {
                      final providerId = FirebaseAuth.instance.currentUser?.uid ?? 'unknown';
                      context.read<InventoryCubit>().loadInventory(
                            providerId: providerId,
                          );
                    }
                  },
                ),

                ListTile(
                  leading: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),

                  title: const Text(
                    "Delete Product",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),

                  onTap: () {
                    Navigator.pop(context);

                    DeleteProductDialog.show(
                      context,
                      product,
                    );
                  },
                ),

                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }
}