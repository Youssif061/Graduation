import 'dart:io';

import 'package:expertisemarket/features/ServiceProvider/publish_service/cubit/publish_service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'publish_section_card.dart';

class ServiceImagesSection extends StatelessWidget {
  const ServiceImagesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PublishSectionCard(
      title: "Attach Photos",

      child: BlocBuilder<
          PublishServiceCubit,
          PublishServiceState>(
        builder: (context, state) {
          final cubit =
              context.read<PublishServiceCubit>();

          return Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              InkWell(
                borderRadius:
                    BorderRadius.circular(16),
                onTap: cubit.pickImages,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 30,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xffF8FAFC,
                    ),
                    borderRadius:
                        BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(
                        0xffCBD5E1,
                      ),
                    ),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.add_a_photo_outlined,
                        size: 36,
                        color: Color(
                          0xff64748B,
                        ),
                      ),

                      SizedBox(height: 12),

                      Text(
                        "Click to upload images",
                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      SizedBox(height: 6),

                      Text(
                        "Upload images that represent your service.",
                        textAlign:
                            TextAlign.center,
                        style: TextStyle(
                          color: Color(
                            0xff64748B,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (cubit.images.isNotEmpty) ...[
                const SizedBox(height: 18),

                SizedBox(
                  height: 100,

                  child: ListView.separated(
                    scrollDirection:
                        Axis.horizontal,

                    itemCount:
                        cubit.images.length,

                    separatorBuilder:
                        (_, __) =>
                            const SizedBox(
                              width: 10,
                            ),

                    itemBuilder:
                        (context, index) {
                      final File image =
                          cubit.images[index];

                      return Stack(
                        children: [

                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),
                            child: Image.file(
                              image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),

                          Positioned(
                            top: 4,
                            right: 4,
                            child: InkWell(
                              onTap: () {
                                cubit.removeImage(
                                  index,
                                );
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.all(
                                  4,
                                ),
                                decoration:
                                    const BoxDecoration(
                                  color: Colors.red,
                                  shape:
                                      BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 16,
                                  color:
                                      Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}