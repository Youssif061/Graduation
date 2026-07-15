import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/widget/delivery_time_section.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/widget/publish_service_button.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/widget/service_description_field.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/widget/service_images_section.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/widget/service_price_section.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/widget/service_title_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// استيراد الحزم الخاصة بالـ Bloc والـ Cubit لحل المشكلة
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/cubit/publish_service_cubit.dart';

class PublishServiceScreen extends StatefulWidget {
  const PublishServiceScreen({super.key});

  @override
  State<PublishServiceScreen> createState() =>
      _PublishServiceScreenState();
}

class _PublishServiceScreenState
    extends State<PublishServiceScreen> {
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
    // لفينا هنا الـ Scaffold بـ BlocProvider لضمان وصول الـ PublishServiceButton للـ Cubit بنجاح
    return BlocProvider(
      create: (context) => PublishServiceCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xffF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.white,
          scrolledUnderElevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: SvgPicture.asset(
              AppImages.backSvg,
              width: 20,
              height: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Publish Your Service',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xff001A2C),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Showcase your expertise and start\nreceiving bookings from clients.',
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.4,
                    color: Color(0xff334E68),
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

                PublishServiceButton(
                  titleController: titleController,
                  descriptionController:
                      descriptionController,
                  priceController: priceController,
                  delivery: delivery,
                  transportation: transportation,
                  negotiate: negotiate,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}