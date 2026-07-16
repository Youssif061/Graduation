class HomeStatsModel {
  final int totalJobs;
  final double rating;
  final int reviews;

  const HomeStatsModel({
    required this.totalJobs,
    required this.rating,
    required this.reviews,
  });

  factory HomeStatsModel.empty() {
    return const HomeStatsModel(
      totalJobs: 0,
      rating: 0,
      reviews: 0,
    );
  }

  factory HomeStatsModel.fromMap(Map<String, dynamic> map) {
    return HomeStatsModel(
      totalJobs: (map['totalJobs'] ?? 0) as int,
      rating: (map['rating'] ?? 0).toDouble(),
      reviews: (map['reviews'] ?? 0) as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalJobs': totalJobs,
      'rating': rating,
      'reviews': reviews,
    };
  }

  HomeStatsModel copyWith({
    int? totalJobs,
    double? rating,
    int? reviews,
  }) {
    return HomeStatsModel(
      totalJobs: totalJobs ?? this.totalJobs,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
    );
  }
}