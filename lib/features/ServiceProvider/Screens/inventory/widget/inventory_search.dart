import 'package:flutter/material.dart';

class InventorySearch extends StatelessWidget {
  const InventorySearch({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search inventory...',
          hintStyle: const TextStyle(color: Color(0xff94A3B8), fontSize: 14),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xff94A3B8),
            size: 22,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xffE2E8F0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xffE2E8F0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xffCBD5E1), width: 1.4),
          ),
        ),
      ),
    );
  }
}
