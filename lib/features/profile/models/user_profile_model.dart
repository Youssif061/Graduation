import 'package:equatable/equatable.dart';

class UserProfileModel extends Equatable {
  const UserProfileModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.photoUrl,
    required this.photoStoragePath,
  });

  final String uid;
  final String fullName;
  final String email;
  final String photoUrl;
  final String photoStoragePath;

  bool get hasPhoto => photoUrl.trim().isNotEmpty;

  factory UserProfileModel.fromMap({
    required String uid,
    required Map<String, dynamic> data,
    required String fallbackFullName,
    required String fallbackEmail,
    required String fallbackPhotoUrl,
  }) {
    return UserProfileModel(
      uid: uid,
      fullName: _valueOrFallback(data['fullName'], fallbackFullName),
      email: _valueOrFallback(data['email'], fallbackEmail),
      photoUrl: _valueOrFallback(data['photoUrl'], fallbackPhotoUrl),
      photoStoragePath: _valueOrFallback(data['photoStoragePath'], ''),
    );
  }

  UserProfileModel copyWith({
    String? fullName,
    String? email,
    String? photoUrl,
    String? photoStoragePath,
  }) {
    return UserProfileModel(
      uid: uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      photoStoragePath: photoStoragePath ?? this.photoStoragePath,
    );
  }

  static String _valueOrFallback(dynamic value, String fallback) {
    final parsedValue = value?.toString().trim() ?? '';

    return parsedValue.isEmpty ? fallback : parsedValue;
  }

  @override
  List<Object?> get props => [uid, fullName, email, photoUrl, photoStoragePath];
}
