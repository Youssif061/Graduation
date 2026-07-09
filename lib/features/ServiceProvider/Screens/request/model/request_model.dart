class RequestModel {
  final String title;
  final String summary;

  final String clientName;
  final String clientImage;
  final String reviews;

  final String description;

  final String budget;
  final String timeline;

  final String price;

  final String timeAgo;
  final bool isNew;

  final List<String> problemPhotos;

  const RequestModel({
    required this.title,
    required this.summary,
    required this.clientName,
    required this.clientImage,
    required this.reviews,
    required this.description,
    required this.budget,
    required this.timeline,
    required this.price,
    required this.timeAgo,
    required this.problemPhotos,
    this.isNew = false,
  });
}