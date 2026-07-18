import 'package:expertisemarket/features/ServiceProvider/request/model/request_model.dart';
import 'package:expertisemarket/features/ServiceProvider/request/widget/request_card.dart';
import 'package:flutter/material.dart';

class RequestsListView
    extends StatelessWidget {
  const RequestsListView({
    super.key,
    required this.requests,
  });

  final List<RequestModel> requests;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics:
          const AlwaysScrollableScrollPhysics(),
      itemCount: requests.length,
      separatorBuilder: (_, __) =>
          const SizedBox(height: 18),
      itemBuilder: (context, index) {
        return RequestCard(
          request: requests[index],
        );
      },
    );
  }
}