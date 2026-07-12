import 'package:craftmarket/core/constants/app_images.dart';
import 'package:craftmarket/core/functions/navigations.dart';
import 'package:craftmarket/features/ServiceProvider/Screens/add_product/page/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'delete_product_dialog.dart';

class ProductActionBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.all(20),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                const SizedBox(height: 28),

                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  tileColor: const Color(0xffEBF5FF),

                  leading: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xff001A2C),
                  ),

                  title: const Text(
                    "Edit Product",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xff001A2C),
                    ),
                  ),

                  onTap: () {
                    Navigator.pop(context);

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => const EditProductScreen(),
                    //   ),
                    // );
                    naviagationPush(context, const EditProductScreen());
                  },
                ),

                const SizedBox(height: 12),

                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),

                  leading: SvgPicture.asset(
                    AppImages.deleteSvg,
                    colorFilter: const ColorFilter.mode(
                      Colors.red,
                      BlendMode.srcIn,
                    ),
                  ),

                  title: const Text(
                    "Delete Product",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  onTap: () {
                    Navigator.pop(context);
                    DeleteProductDialog.show(context);
                  },
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
