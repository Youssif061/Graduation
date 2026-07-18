import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';

class CloudinaryService {
  static final cloudinary = CloudinaryPublic(
    'dthf8pnj',
    'expertise_market',
    cache: false,
  );

  static Future<String> uploadImage(String imagePath) async {
    final file = File(imagePath);

    if (!await file.exists()) {
      throw Exception("Image not found");
    }

    try {
      final response = await cloudinary
          .uploadFile(
            CloudinaryFile.fromFile(
              imagePath,
              folder: "expertise_market/profile_images",
            ),
          )
          .timeout(const Duration(seconds: 30));

      return response.secureUrl;
    } catch (e) {
      throw Exception("Failed to upload image");
    }
  }
}
