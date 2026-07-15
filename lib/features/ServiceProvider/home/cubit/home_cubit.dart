import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/home_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> loadHomeData({
    required String providerId,
  }) async {
    try {
      emit(const HomeLoading());

      final provider = await _firestore
          .collection('serviceProviders')
          .doc(providerId)
          .get();

      /// إذا لم يوجد مقدم الخدمة بعد
      /// اعرض الصفحة بالقيم الافتراضية
      if (!provider.exists) {
        emit(
          HomeLoaded(
            HomeStatsModel(
              totalJobs: 0,
              rating: 0,
              reviews: 0,
            ),
          ),
        );
        return;
      }

      final data = provider.data();

      if (data == null) {
        emit(
          HomeLoaded(
            HomeStatsModel(
              totalJobs: 0,
              rating: 0,
              reviews: 0,
            ),
          ),
        );
        return;
      }

      final stats = HomeStatsModel.fromJson(data);

      emit(HomeLoaded(stats));
    } on FirebaseException {
      /// في حالة حدوث أي خطأ في Firebase
      /// لا تجعل الصفحة فارغة
      emit(
        HomeLoaded(
          HomeStatsModel(
            totalJobs: 0,
            rating: 0,
            reviews: 0,
          ),
        ),
      );
    } catch (_) {
      emit(
        HomeLoaded(
          HomeStatsModel(
            totalJobs: 0,
            rating: 0,
            reviews: 0,
          ),
        ),
      );
    }
  }

  Future<void> refresh(String providerId) async {
    await loadHomeData(
      providerId: providerId,
    );
  }
}