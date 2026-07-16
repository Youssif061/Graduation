import 'package:flutter/material.dart';

import 'delivery_time_section.dart';
import 'publish_service_button.dart';
import 'service_description_field.dart';
import 'service_images_section.dart';
import 'service_price_section.dart';
import 'service_title_field.dart';

class PublishServiceForm extends StatefulWidget {
  const PublishServiceForm({super.key});

  @override
  State<PublishServiceForm> createState() => _PublishServiceFormState();
}

class _PublishServiceFormState extends State<PublishServiceForm> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  final priceController = TextEditingController();

  String delivery = 'Standard';

  bool transportation = false;

  bool negotiate = false;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Showcase your expertise and start\nreceiving bookings from clients.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF334E68),
              height: 1.4,
            ),
          ),

          const SizedBox(height: 24),

          ServiceTitleField(
            controller: titleController,
          ),

          ServiceDescriptionField(
            controller: descriptionController,
          ),

          const ServiceImagesSection(),

          DeliveryTimeSection(
            selected: delivery,
            onChanged: (value) {
              setState(() {
                delivery = value;
              });
            },
          ),

          ServicePriceSection(
            controller: priceController,
            transportation: transportation,
            negotiate: negotiate,
            onTransportationChanged: (value) {
              setState(() {
                transportation = value;
              });
            },
            onNegotiateChanged: (value) {
              setState(() {
                negotiate = value;
              });
            },
          ),

          const SizedBox(height: 10),

          PublishServiceButton(
            titleController: titleController,
            descriptionController: descriptionController,
            priceController: priceController,
            delivery: delivery,
            transportation: transportation,
            negotiate: negotiate,
          ),
        ],
      ),
    );
  }
}