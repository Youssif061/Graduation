import 'dart:io';

import 'package:expertisemarket/features/ServiceProvider/publish_service/model/service_model.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/repository/publish_service_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'publish_service_state.dart';

class PublishServiceCubit extends Cubit<PublishServiceState> {
  PublishServiceCubit(
    this.repository,
  ) : super(
          const PublishServiceInitial(),
        );

  final PublishServiceRepository repository;

  final ImagePicker _picker = ImagePicker();

  final List<File> images = [];

  //--------------------------------------------------
  // Pick Images
  //--------------------------------------------------

  Future<void> pickImages() async {
    try {
      final List<XFile> pickedImages =
          await _picker.pickMultiImage(
        imageQuality: 80,
      );

      if (pickedImages.isEmpty) {
        return;
      }

      images.addAll(
        pickedImages.map(
          (image) => File(image.path),
        ),
      );

      emit(
        const PublishServiceImagesChanged(),
      );
    } catch (e) {
      emit(
        PublishServiceFailure(
          e.toString(),
        ),
      );
    }
  }

  //--------------------------------------------------
  // Remove Image
  //--------------------------------------------------

  void removeImage(int index) {
    if (index < 0 || index >= images.length) {
      return;
    }

    images.removeAt(index);

    emit(
      const PublishServiceImagesChanged(),
    );
  }

  //--------------------------------------------------
  // Publish Service
  //--------------------------------------------------

  Future<void> publishService({
    required String title,
    required String description,
    required String delivery,
    required String price,
    required bool transportation,
    required bool negotiate,
  }) async {
    try {
      emit(
        const PublishServiceLoading(),
      );

      final List<String> imageUrls =
          await repository.uploadImages(
        images,
      );

      final ServiceModel service = ServiceModel(
        id: '',
        providerId: repository.providerId,
        title: title.trim(),
        description: description.trim(),
        images: imageUrls,
        price: double.parse(price),
        delivery: delivery,
        transportation: transportation,
        negotiate: negotiate,
        active: true,
        createdAt: DateTime.now(),
      );

      await repository.publishService(
        service,
      );

      images.clear();

      emit(
        const PublishServiceSuccess(),
      );
    } catch (e) {
      emit(
        PublishServiceFailure(
          e.toString(),
        ),
      );
    }
  }

  //--------------------------------------------------
  // Clear Images
  //--------------------------------------------------

  void clearImages() {
    images.clear();

    emit(
      const PublishServiceImagesChanged(),
    );
  }
}