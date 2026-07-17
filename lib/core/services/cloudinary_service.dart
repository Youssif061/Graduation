import 'package:cloudinary_public/cloudinary_public.dart';

class CloudinaryService {
  static final cloudinary = CloudinaryPublic(
    'dthf8pnj',
    'expertise_market',
    cache: false,
  );

  static Future<String> uploadImage(String imagePath) async {
    CloudinaryResponse response = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(imagePath),
    );

    return response.secureUrl;
  }
}
