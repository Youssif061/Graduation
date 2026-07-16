import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/cubit/publish_service_cubit.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/repository/publish_service_repository.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/widget/publish_service_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PublishServiceScreen extends StatelessWidget {
  const PublishServiceScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PublishServiceCubit(
        PublishServiceRepository(),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xffF8FAFC),

        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,

          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              AppImages.backSvg,
              width: 20,
              height: 20,
            ),
          ),

          title: const Text(
            "Publish Your Service",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xff001A2C),
            ),
          ),

          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              height: 1,
              color: const Color(0xffE2E8F0),
            ),
          ),
        ),

        body: const SafeArea(
          child: PublishServiceForm(),
        ),
      ),
    );
  }
}