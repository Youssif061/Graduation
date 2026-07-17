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
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is RequestFailure) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Text(
                state.message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                ),
              ),
            ),
          );
        }

        if (state is! RequestLoaded) {
          return const SizedBox.shrink();
        }

        final requests = state.requests;

        if (requests.isEmpty) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 40,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Center(
              child: Text(
                "No Requests Available",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        }

        final latest =
            requests.length > 3 ? requests.take(3).toList() : requests;

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: latest.length,
          separatorBuilder: (_, __) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            return _LatestRequestCard(
              request: latest[index],
            );
          },
        );
      },
    );
  }
}

class _LatestRequestCard extends StatelessWidget {
  const _LatestRequestCard({
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
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xffEBF5FF),
              borderRadius: BorderRadius.circular(14),
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
                Text(
                  request.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xff001A2C),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  request.clientName,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  request.timeAgo,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff001A2C),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
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
            child: const Text("View"),
          ),
        ],
      ),
    );
  }
}