import 'package:expertisemarket/features/ServiceProvider/request/cubit/request_cubit.dart';
import 'package:expertisemarket/features/ServiceProvider/request/model/request_model.dart';
import 'package:expertisemarket/features/ServiceProvider/request/page/request_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LatestRequestsListView extends StatelessWidget {
  const LatestRequestsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestCubit, RequestState>(
      builder: (context, state) {
        if (state is RequestLoading) {
          return const Padding(
            padding: EdgeInsets.all(24),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is RequestFailure) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Text(
                state.message,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                ),
              ),
            ),
          );
        }

        if (state is RequestLoaded) {
          final List<RequestModel> requests = state.requests;

          if (requests.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                child: Text(
                  "No Requests Available",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: requests.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final request = requests[index];

              return _RequestCard(request: request);
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    required this.request,
  });

  final RequestModel request;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xffE5E7EB),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xffEBF5FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.design_services,
              color: Color(0xff001A2C),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        request.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff001A2C),
                        ),
                      ),
                    ),

                    if (request.isNew)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffD1FAE5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          "NEW",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xff065F46),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 6),

                Text(
                  "Client: ${request.clientName}",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  request.timeAgo,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RequestScreen(
                    request: request,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff001A2C),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("View Details"),
          ),
        ],
      ),
    );
  }
}