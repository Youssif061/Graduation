import 'package:expertisemarket/features/ServiceProvider/add_product/page/add_product_screen.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widget/inventory_filter_row.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widget/inventory_header.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widget/inventory_list.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widget/inventory_search.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widget/inventory_stats_grid.dart';
import 'package:flutter/material.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InventoryHeader(),

              SizedBox(height: 24),

              InventoryStatsGrid(),

              SizedBox(height: 18),

              InventorySearch(),

              SizedBox(height: 14),

              InventoryFilterRow(),

              SizedBox(height: 22),

              InventoryList(),
            ],
          ),
        ),
      ),

      floatingActionButton: SizedBox(
        width: 62,
        height: 62,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddProductScreen()),
            );
          },
          backgroundColor: const Color(0xFF001A2C),
          elevation: 10,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: 30, color: Colors.white),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
