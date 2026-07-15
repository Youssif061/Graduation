import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'publish_service_state.dart';

class PublishServiceCubit extends Cubit<PublishServiceState> {
  PublishServiceCubit() : super(const PublishServiceInitial());

  final ImagePicker _picker = ImagePicker();

  final List<File> images = [];

  Future<void> pickImages() async {
    try {
      final List<XFile> pickedImages = await _picker.pickMultiImage(
        imageQuality: 80,
      );

      if (pickedImages.isEmpty) return;

      images.addAll(
        pickedImages.map(
          (image) => File(image.path),
        ),
      );

      emit(const PublishServiceImagesChanged());
    } catch (e) {
      emit(
        PublishServiceFailure(
          e.toString(),
        ),
      );
    }
  }

  void removeImage(int index) {
    if (index < 0 || index >= images.length) return;

    images.removeAt(index);

    emit(const PublishServiceImagesChanged());
  }

  Future<void> publishService({
    required String title,
    required String description,
    required String delivery,
    required String price,
    required bool transportation,
    required bool negotiate,
  }) async {
    try {
      emit(const PublishServiceLoading());

      /// Upload Images To Firebase Storage

      /// Save Service To Firestore

      await Future.delayed(
        const Duration(seconds: 2),
      );

      emit(const PublishServiceSuccess());
    } catch (e) {
      emit(
        PublishServiceFailure(
          e.toString(),
        ),
      );
    }
  }
}