import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/category_dropdown.dart';
import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/description_field.dart';
import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/price_field.dart';
import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/product_name_field.dart';
import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/save_product_button.dart';
import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/stock_field.dart';
import 'package:expertisemarket/features/ServiceProvider/add_product/widgets/upload_image_card.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: const Color(0xff001A2C),

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),

        centerTitle: true,

        title: const Text(
          "Add New Product",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Color(0xff001A2C),
          ),
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xffE2E8F0)),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              UploadImageCard(),

              SizedBox(height: 24),

              ProductNameField(),

              SizedBox(height: 20),

              CategoryDropdown(),

              SizedBox(height: 20),

              DescriptionField(),

              SizedBox(height: 20),

              PriceField(),

              SizedBox(height: 20),

              StockField(),

              SizedBox(height: 32),

              SaveProductButton(),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
