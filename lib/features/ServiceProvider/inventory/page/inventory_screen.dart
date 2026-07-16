import 'package:expertisemarket/features/ServiceProvider/add_product/page/add_product_screen.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/cubit/inventory_cubit.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widget/inventory_filter_row.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widget/inventory_header.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widget/inventory_list.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widget/inventory_search.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widget/inventory_stats_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({
    super.key,
  });

  @override
  State<InventoryScreen> createState() =>
      _InventoryScreenState();
}

class _InventoryScreenState
    extends State<InventoryScreen> {
  @override
  void initState() {
    super.initState();

    final providerId = FirebaseAuth.instance.currentUser?.uid ?? 'unknown';
    context.read<InventoryCubit>().loadInventory(
          providerId: providerId,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      body: SafeArea(
        child: BlocBuilder<
            InventoryCubit,
            InventoryState>(
          builder: (context, state) {
            if (state is InventoryLoading) {
              return const Center(
                child:
                    CircularProgressIndicator(),
              );
            }

            if (state is InventoryFailure) {
              return Center(
                child: Text(
                  state.message,
                ),
              );
            }

            if (state is InventoryLoaded) {
              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const InventoryHeader(),

                    const SizedBox(height: 24),

                    InventoryStatsGrid(
                      products:
                          state.products,
                    ),

                    const SizedBox(height: 18),

                    const InventorySearch(),

                    const SizedBox(height: 14),

                    const InventoryFilterRow(),

                    const SizedBox(height: 22),

                    InventoryList(
                      products:
                          state.products,
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),

      floatingActionButton:
          SizedBox(
        width: 62,
        height: 62,
        child: FloatingActionButton(
          backgroundColor:
              const Color(0xff001A2C),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const AddProductScreen(),
              ),
            );
            if (context.mounted) {
              final providerId = FirebaseAuth.instance.currentUser?.uid ?? 'unknown';
              context.read<InventoryCubit>().loadInventory(
                    providerId: providerId,
                  );
            }
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}