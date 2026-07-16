import 'package:expertisemarket/features/ServiceProvider/inventory/cubit/inventory_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InventoryFilterRow extends StatelessWidget {
  const InventoryFilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.filter_list),
            label: const Text("Filter"),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xff001A2C),
              side: const BorderSide(
                color: Color(0xffCBD5E1),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              _showFilterBottomSheet(context);
            },
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.sort),
            label: const Text("Sort"),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xff001A2C),
              side: const BorderSide(
                color: Color(0xffCBD5E1),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              _showSortBottomSheet(context);
            },
          ),
        ),
      ],
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (_) {
        final cubit = context.read<InventoryCubit>();

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.inventory_2),
                title: const Text("All Products"),
                onTap: () {
                  cubit.changeFilter(
                    InventoryFilter.all,
                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                title: const Text("Active"),
                onTap: () {
                  cubit.changeFilter(
                    InventoryFilter.active,
                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.warning_amber,
                  color: Colors.orange,
                ),
                title: const Text("Low Stock"),
                onTap: () {
                  cubit.changeFilter(
                    InventoryFilter.lowStock,
                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                title: const Text("Out Of Stock"),
                onTap: () {
                  cubit.changeFilter(
                    InventoryFilter.outOfStock,
                  );
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (_) {
        final cubit = context.read<InventoryCubit>();

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("Newest"),
                onTap: () {
                  cubit.changeSort(
                    InventorySort.newest,
                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Oldest"),
                onTap: () {
                  cubit.changeSort(
                    InventorySort.oldest,
                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Price : Low → High"),
                onTap: () {
                  cubit.changeSort(
                    InventorySort.priceLowHigh,
                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Price : High → Low"),
                onTap: () {
                  cubit.changeSort(
                    InventorySort.priceHighLow,
                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Name A → Z"),
                onTap: () {
                  cubit.changeSort(
                    InventorySort.nameAZ,
                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Name Z → A"),
                onTap: () {
                  cubit.changeSort(
                    InventorySort.nameZA,
                  );
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}