import 'package:expertisemarket/features/ServiceProvider/publish_service/cubit/publish_service_cubit.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/widget/delivery_time_section.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/widget/publish_service_button.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/widget/service_description_field.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/widget/service_images_section.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/widget/service_price_section.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/widget/service_title_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PublishServiceForm extends StatefulWidget {
  const PublishServiceForm({
    super.key,
  });

  @override
  State<PublishServiceForm> createState() =>
      _PublishServiceFormState();
}

class _PublishServiceFormState
    extends State<PublishServiceForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController
      _titleController;

  late final TextEditingController
      _descriptionController;

  late final TextEditingController
      _priceController;

  String _delivery = "Standard";

  bool _transportation = false;

  bool _negotiate = false;

  @override
  void initState() {
    super.initState();

    _titleController =
        TextEditingController();

    _descriptionController =
        TextEditingController();

    _priceController =
        TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();

    _descriptionController.dispose();

    _priceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
        PublishServiceCubit,
        PublishServiceState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  "Showcase your expertise and start\nreceiving bookings from clients.",
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.4,
                    color: Color(0xff334E68),
                  ),
                ),

                const SizedBox(height: 24),

                ServiceTitleField(
                  controller:
                      _titleController,
                ),

                ServiceDescriptionField(
                  controller:
                      _descriptionController,
                ),

                const ServiceImagesSection(),

                DeliveryTimeSection(
                  selected: _delivery,
                  onChanged: (value) {
                    setState(() {
                      _delivery = value;
                    });
                  },
                ),

                ServicePriceSection(
                  controller:
                      _priceController,
                  transportation:
                      _transportation,
                  negotiate:
                      _negotiate,
                  onTransportationChanged:
                      (value) {
                    setState(() {
                      _transportation =
                          value;
                    });
                  },
                  onNegotiateChanged:
                      (value) {
                    setState(() {
                      _negotiate = value;
                    });
                  },
                ),

                const SizedBox(height: 10),

                PublishServiceButton(
                  titleController:
                      _titleController,
                  descriptionController:
                      _descriptionController,
                  priceController:
                      _priceController,
                  delivery: _delivery,
                  transportation:
                      _transportation,
                  negotiate:
                      _negotiate,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}