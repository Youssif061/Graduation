import 'package:expertisemarket/features/ServiceProvider/add_product/model/product_model.dart';
import 'package:expertisemarket/features/ServiceProvider/add_product/page/edit_product_screen.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widgets/delete_product_dialog.dart';
import 'package:flutter/material.dart';

class ProductActionBottomSheet {
  const ProductActionBottomSheet._();

  static Future<void> show(
    BuildContext context,
    ProductModel product,
  ) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius:
                          BorderRadius.circular(30),
                    ),
                  ),

                  const SizedBox(height: 24),

                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                    leading: const CircleAvatar(
                      backgroundColor:
                          Color(0xffEEF5FF),
                      child: Icon(
                        Icons.edit,
                        color: Color(0xff2563EB),
                      ),
                    ),
                    title: const Text(
                      "Edit Product",
                      style: TextStyle(
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                    subtitle: const Text(
                      "Update product information",
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
                    },
                  ),

                  const SizedBox(height: 10),

                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                    leading: const CircleAvatar(
                      backgroundColor:
                          Color(0xffFEE2E2),
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
                    title: const Text(
                      "Delete Product",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                    subtitle: const Text(
                      "Remove this product permanently",
                    ),
                    onTap: () {
                      Navigator.pop(context);

                      DeleteProductDialog.show(
                        context,
                        product,
                      );
                    },
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}