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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Product Images",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xff001A2C),
              ),
            ),

            const SizedBox(height: 12),

            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: cubit.pickImages,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xffEEF5FF),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xffCBD5E1),
                  ),
                ),
                child: _buildContent(cubit),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContent(AddProductCubit cubit) {
    final hasImages =
        cubit.images.isNotEmpty || cubit.existingImages.isNotEmpty;

    if (!hasImages) {
      return SizedBox(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_upload_outlined,
              size: 50,
              color: Color(0xff64748B),
            ),

            const SizedBox(height: 14),

            const Text(
              "Upload Product Images",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "PNG, JPG or WEBP",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [

        /// Existing Images
        ...List.generate(
          cubit.existingImages.length,
          (index) {
            return _NetworkImage(
              image: cubit.existingImages[index],
              onDelete: () {
                cubit.removeExistingImage(index);
              },
            );
          },
        ),

        /// New Images
        ...List.generate(
          cubit.images.length,
          (index) {
            return _LocalImage(
              image: cubit.images[index],
              onDelete: () {
                cubit.removeImage(index);
              },
            );
          },
        ),

        InkWell(
          onTap: cubit.pickImages,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xffCBD5E1),
              ),
            ),
            child: const Icon(
              Icons.add_a_photo,
              size: 38,
            ),
          ),
        ),
      ],
    );
  }
}

class _NetworkImage extends StatelessWidget {
  const _NetworkImage({
    required this.image,
    required this.onDelete,
  });

  final String image;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            image,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),

        Positioned(
          right: 4,
          top: 4,
          child: GestureDetector(
            onTap: onDelete,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(
                Icons.close,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LocalImage extends StatelessWidget {
  const _LocalImage({
    required this.image,
    required this.onDelete,
  });

  final File image;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            image,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),

        Positioned(
          right: 4,
          top: 4,
          child: GestureDetector(
            onTap: onDelete,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(
                Icons.close,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}