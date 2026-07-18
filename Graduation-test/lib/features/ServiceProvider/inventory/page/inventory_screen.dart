import 'package:expertisemarket/features/ServiceProvider/add_product/page/add_product_screen.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/cubit/inventory_cubit.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widgets/inventory_filter_row.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widgets/inventory_header.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widgets/inventory_list.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widgets/inventory_search.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widgets/inventory_stats_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InventoryCubit>().loadInventory();
    });
  }

  Future<void> _refresh() async {
    await context.read<InventoryCubit>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      body: SafeArea(
        child: BlocConsumer<
            InventoryCubit,
            InventoryState>(
          listener: (context, state) {
            if (state is InventoryFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            //-----------------------------------
            // Loading
            //-----------------------------------

            if (state is InventoryLoading) {
              return const Center(
                child:
                    CircularProgressIndicator(),
              );
            }

            //-----------------------------------
            // Loaded
            //-----------------------------------

            if (state is InventoryLoaded) {
              return RefreshIndicator(
                onRefresh: _refresh,
                child: SingleChildScrollView(
                  physics:
                      const AlwaysScrollableScrollPhysics(),
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

                      const SizedBox(
                        height: 22,
                      ),

                      InventoryStatsGrid(
                        products:
                            state.products,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      const InventorySearch(),

                      const SizedBox(
                        height: 14,
                      ),

                      const InventoryFilterRow(),

                      const SizedBox(
                        height: 22,
                      ),

                      InventoryList(
                        products:
                            state.products,
                      ),

                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              );
            }

            //-----------------------------------
            // Error لأول مرة
            //-----------------------------------

            if (state is InventoryFailure) {
              return Center(
                child: Padding(
                  padding:
                      const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.inventory_2_outlined,
                        size: 70,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        state.message,
                        textAlign:
                            TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<
                                  InventoryCubit>()
                              .loadInventory();
                        },
                        child: const Text(
                          "Try Again",
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),

      floatingActionButton:
          FloatingActionButton(
        backgroundColor:
            const Color(0xff001A2C),
        foregroundColor: Colors.white,
        elevation: 8,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
        ),
        onPressed: () async {
          final result =
              await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AddProductScreen(),
            ),
          );

          if (result == true &&
              mounted) {
            context
                .read<InventoryCubit>()
                .refresh();
          }
        },
      ),
    );
  }
}