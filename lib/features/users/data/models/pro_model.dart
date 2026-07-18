class ProModel {
  final String uid;
  final String name;
  final String job;
  final String image;
  final String category;
  final double rating;
  final int experience;
  final double price;
  final bool isVerified;

  ProModel({
    required this.uid,
    required this.name,
    required this.job,
    required this.image,
    required this.category,
    required this.rating,
    required this.experience,
    required this.price,
    required this.isVerified,
  });

  factory ProModel.fromMap(Map<String, dynamic> map, [String? docId]) {
    return ProModel(
      uid: map['uid'] ?? docId ?? '',
      name: map['name'] ?? '',
      job: map['job'] ?? '',
      image: map['image'] ?? '',
      category: map['category'] ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      isVerified: map['verified'] ?? false,

      // في Firestore انتي مخزنة "10 years"
      experience: int.tryParse(
            map['experience']
                .toString()
                .replaceAll('years', '')
                .trim(),
          ) ??
          0,
    );
  }
}