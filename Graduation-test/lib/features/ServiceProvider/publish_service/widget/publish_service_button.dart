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
    return BlocBuilder<
        PublishServiceCubit,
        PublishServiceState>(
      builder: (context, state) {
        final cubit =
            context.read<PublishServiceCubit>();

        final bool isLoading =
            state is PublishServiceLoading;

        return MainButton(
          text: "Publish Service",

          isLoading: isLoading,

          background:
              const Color(0xff22C55E),

          onPress: isLoading
              ? null
              : () async {
                  if (titleController.text
                      .trim()
                      .isEmpty) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Please enter service title",
                        ),
                      ),
                    );
                    return;
                  }

                  if (descriptionController
                      .text
                      .trim()
                      .isEmpty) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Please enter service description",
                        ),
                      ),
                    );
                    return;
                  }

                  if (priceController.text
                      .trim()
                      .isEmpty) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Please enter service price",
                        ),
                      ),
                    );
                    return;
                  }

                  await cubit.publishService(
                    title: titleController.text
                        .trim(),
                    description:
                        descriptionController
                            .text
                            .trim(),
                    delivery: delivery,
                    price:
                        priceController.text,
                    transportation:
                        transportation,
                    negotiate: negotiate,
                  );
                },
        );
      },
    );
  }
}