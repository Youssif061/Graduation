import 'package:expertisemarket/features/ServiceProvider/inventory/cubit/inventory_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InventorySearch extends StatefulWidget {
  const InventorySearch({
    super.key,
  });

  @override
  State<InventorySearch> createState() =>
      _InventorySearchState();
}

class _InventorySearchState
    extends State<InventorySearch> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<InventoryCubit>();

    return TextField(
      controller: _controller,
      textInputAction: TextInputAction.search,
      onChanged: cubit.search,
      decoration: InputDecoration(
        hintText: "Search by name, category...",

        prefixIcon: const Icon(
          Icons.search,
        ),

        suffixIcon: _controller.text.isEmpty
            ? null
            : IconButton(
                icon: const Icon(
                  Icons.close,
                ),
                onPressed: () {
                  _controller.clear();

                  cubit.clearSearch();
                },
              ),

        filled: true,
        fillColor: Colors.white,

        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 15,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xffCBD5E1),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xff001A2C),
            width: 1.4,
          ),
        ),
      ),
    );
  }
}