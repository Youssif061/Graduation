import 'package:expertisemarket/features/ServiceProvider/publish_service/cubit/publish_service_cubit.dart';
import 'package:expertisemarket/features/ServiceProvider/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PublishServiceButton extends StatelessWidget {
  const PublishServiceButton({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.priceController,
    required this.delivery,
    required this.transportation,
    required this.negotiate,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;

  final String delivery;
  final bool transportation;
  final bool negotiate;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
        PublishServiceCubit,
        PublishServiceState>(
      listener: (context, state) {
        if (state
            is PublishServiceSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            const SnackBar(
              content: Text(
                'Service Published Successfully',
              ),
            ),
          );
        }

        if (state
            is PublishServiceFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        return MainButton(
          background:
              const Color(0xFF22C55E),
          onPress: state
                  is PublishServiceLoading
              ? null
              : () {
                  context
                      .read<
                          PublishServiceCubit>()
                      .publishService(
                        title:
                            titleController.text,
                        description:
                            descriptionController
                                .text,
                        delivery: delivery,
                        price:
                            priceController.text,
                        transportation:
                            transportation,
                        negotiate:
                            negotiate,
                      );
                },
          child: state
                  is PublishServiceLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child:
                      CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Text(
                      'Publish Service',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                    ),
                  ],
                ),
        );
      },
    );
  }
}