import 'dart:io';

import 'package:expertisemarket/features/ServiceProvider/add_product/cubit/add_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadImageCard extends StatelessWidget {
  const UploadImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductCubit, AddProductState>(
      builder: (context, state) {
        final cubit = context.read<AddProductCubit>();

        final hasImages =
            cubit.images.isNotEmpty ||
            cubit.existingImages.isNotEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Product Images",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff001A2C),
              ),
            ),

            const SizedBox(height: 12),

            InkWell(
              onTap: cubit.pickImages,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xffEEF5FF),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xffCBD5E1),
                    width: 1.5,
                  ),
                ),
                child: !hasImages
                    ? SizedBox(
                        height: 170,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.cloud_upload_outlined,
                              size: 46,
                              color: Color(0xff64748B),
                            ),

                            const SizedBox(height: 12),

                            const Text(
                              "Upload Product Images",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: Color(0xff001A2C),
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              "JPG, PNG or WEBP",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [

                              /// Existing Images
                              ...List.generate(
                                cubit.existingImages.length,
                                (index) {
                                  return Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12),
                                        child: Image.network(
                                          cubit.existingImages[index],
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                      Positioned(
                                        top: 4,
                                        right: 4,
                                        child: InkWell(
                                          onTap: () {
                                            cubit.removeExistingImage(index);
                                          },
                                          child: Container(
                                            padding:
                                                const EdgeInsets.all(4),
                                            decoration:
                                                const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),

                              /// New Images
                              ...List.generate(
                                cubit.images.length,
                                (index) {
                                  final File image =
                                      cubit.images[index];

                                  return Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12),
                                        child: Image.file(
                                          image,
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                      Positioned(
                                        top: 4,
                                        right: 4,
                                        child: InkWell(
                                          onTap: () {
                                            cubit.removeImage(index);
                                          },
                                          child: Container(
                                            padding:
                                                const EdgeInsets.all(4),
                                            decoration:
                                                const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),

                              InkWell(
                                onTap: cubit.pickImages,
                                borderRadius:
                                    BorderRadius.circular(12),
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(12),
                                    border: Border.all(
                                      color:
                                          const Color(0xffCBD5E1),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.add_a_photo,
                                    size: 36,
                                    color: Color(0xff001A2C),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}