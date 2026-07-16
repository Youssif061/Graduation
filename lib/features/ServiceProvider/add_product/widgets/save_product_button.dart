import 'package:expertisemarket/features/ServiceProvider/add_product/cubit/add_product_cubit.dart';
import 'package:expertisemarket/features/ServiceProvider/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveProductButton extends StatelessWidget {
  const SaveProductButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductCubit, AddProductState>(
      builder: (context, state) {
        return MainButton(
          text: "Save Product",
          background: const Color(0xff001A2C),
          icon: const Icon(
            Icons.save,
            color: Colors.white,
          ),
          isLoading: state is AddProductLoading,
          onPress: () {
            context.read<AddProductCubit>().publishProduct();
          },
        );
      },
    );
  }
}