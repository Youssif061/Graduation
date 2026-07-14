import 'request_urgency.dart';

class ServiceRequestModel {
  const ServiceRequestModel({
    required this.title,
    required this.description,
    required this.urgency,
    required this.willingToNegotiate,
    this.budget,
  });

  final String title;
  final String description;
  final RequestUrgency urgency;
  final double? budget;
  final bool willingToNegotiate;

  Map<String, dynamic> toFirestore({
    required String id,
    required String userId,
    required List<String> imageUrls,
  }) {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'urgency': urgency.name,
      'budget': budget,
      'willingToNegotiate': willingToNegotiate,
      'imageUrls': imageUrls,
      'status': 'open',
    };
  }
}
