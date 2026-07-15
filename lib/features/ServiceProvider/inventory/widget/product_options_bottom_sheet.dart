import 'package:expertisemarket/features/ServiceProvider/add_product/model/product_model.dart';
import 'package:expertisemarket/features/ServiceProvider/add_product/page/edit_product_screen.dart';
import 'package:flutter/material.dart';

import 'delete_product_dialog.dart';

class ProductOptionsBottomSheet {
  static void show(
    BuildContext context,
    ProductModel product,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text("Edit Product"),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditProductScreen(
                        product: product,
                      ),
                    ),
                  );
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),

                title: const Text(
                  "Delete Product",
                ),

                onTap: () {
                  Navigator.pop(context);

                  DeleteProductDialog.show(
                    context,
                    product,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}