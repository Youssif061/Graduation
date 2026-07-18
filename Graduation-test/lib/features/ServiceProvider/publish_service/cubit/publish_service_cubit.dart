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

  //----------------------------------------------------------
  // Images
  //----------------------------------------------------------

  final List<File> images = [];

  final List<String> existingImages = [];

  ServiceModel? currentService;

  //----------------------------------------------------------
  // Pick Images
  //----------------------------------------------------------

  Future<void> pickImages() async {
    try {
      final pickedImages = await _picker.pickMultiImage(
        imageQuality: 80,
      );

      if (pickedImages.isEmpty) return;

      images.addAll(
        pickedImages.map(
          (e) => File(e.path),
        ),
      );

      emit(
        PublishServiceImagesChanged(
          images: List.from(images),
          existingImages: List.from(existingImages),
        ),
      );
    } catch (e) {
      emit(
        PublishServiceFailure(
          e.toString(),
        ),
      );
    }
  }

  //----------------------------------------------------------
  // Load Service
  //----------------------------------------------------------

  void loadService(
    ServiceModel service,
  ) {
    currentService = service;

    images.clear();

    existingImages
      ..clear()
      ..addAll(service.images);

    emit(
      PublishServiceImagesChanged(
        images: List.from(images),
        existingImages: List.from(existingImages),
      ),
    );
  }

  //----------------------------------------------------------
  // Remove New Image
  //----------------------------------------------------------

  void removeImage(
    int index,
  ) {
    images.removeAt(index);

    emit(
      PublishServiceImagesChanged(
        images: List.from(images),
        existingImages: List.from(existingImages),
      ),
    );
  }

  //----------------------------------------------------------
  // Remove Old Image
  //----------------------------------------------------------

  void removeExistingImage(
    int index,
  ) {
    existingImages.removeAt(index);

    emit(
      PublishServiceImagesChanged(
        images: List.from(images),
        existingImages: List.from(existingImages),
      ),
    );
  }

  //----------------------------------------------------------
  // Publish Service
  //----------------------------------------------------------

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

      final uploadedImages =
          await repository.uploadImages(
        images,
      );

      final service = ServiceModel(
        id: "",
        providerId: repository.providerId,
        title: title.trim(),
        description: description.trim(),
        images: uploadedImages,
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

      clear();

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

  //----------------------------------------------------------
  // Update Service
  //----------------------------------------------------------

  Future<void> updateService({
    required String title,
    required String description,
    required String delivery,
    required String price,
    required bool transportation,
    required bool negotiate,
  }) async {
    if (currentService == null) return;

    try {
      emit(
        const PublishServiceLoading(),
      );

      List<String> imageUrls =
          List.from(existingImages);

      if (images.isNotEmpty) {
        final uploaded =
            await repository.uploadImages(
          images,
        );

        imageUrls.addAll(uploaded);
      }

      final service =
          currentService!.copyWith(
        title: title.trim(),
        description: description.trim(),
        images: imageUrls,
        price: double.parse(price),
        delivery: delivery,
        transportation: transportation,
        negotiate: negotiate,
      );

      await repository.updateService(
        service,
      );

      emit(
        const PublishServiceUpdated(),
      );
    } catch (e) {
      emit(
        PublishServiceFailure(
          e.toString(),
        ),
      );
    }
  }

  //----------------------------------------------------------
  // Delete Service
  //----------------------------------------------------------

  Future<void> deleteService() async {
    if (currentService == null) return;

    try {
      emit(
        const PublishServiceLoading(),
      );

      await repository.deleteService(
        currentService!.id,
      );

      clear();

      emit(
        const PublishServiceDeleted(),
      );
    } catch (e) {
      emit(
        PublishServiceFailure(
          e.toString(),
        ),
      );
    }
  }

  //----------------------------------------------------------
  // Clear
  //----------------------------------------------------------

  void clear() {
    currentService = null;

    images.clear();

    existingImages.clear();

    emit(
      PublishServiceImagesChanged(
        images: List.from(images),
        existingImages: List.from(existingImages),
      ),
    );
  }
}