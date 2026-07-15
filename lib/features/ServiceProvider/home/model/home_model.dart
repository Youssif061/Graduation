class HomeStatsModel {
  final int totalJobs;
  final double rating;
  final int reviews;

  const HomeStatsModel({
    required this.totalJobs,
    required this.rating,
    required this.reviews,
  });

  factory HomeStatsModel.fromJson(Map<String, dynamic> json) {
    return HomeStatsModel(
      totalJobs: (json['totalJobs'] ?? 0) as int,
      rating: (json['rating'] ?? 0).toDouble(),
      reviews: (json['reviews'] ?? 0) as int,
    );
  }

  Map<String, dynamic> toJson() {
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