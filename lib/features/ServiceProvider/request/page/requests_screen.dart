import 'package:expertisemarket/features/ServiceProvider/request/cubit/request_cubit.dart';
import 'package:expertisemarket/features/ServiceProvider/request/widget/job_requests_header.dart';
import 'package:expertisemarket/features/ServiceProvider/request/widget/requests_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<RequestCubit>().loadRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          "Job Requests",
          style: TextStyle(
            color: Color(0xff001A2C),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const JobRequestsHeader(),

            const SizedBox(height: 20),

            Expanded(
              child: BlocBuilder<RequestCubit, RequestState>(
                builder: (context, state) {
                  if (state is RequestLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is RequestFailure) {
                    return Center(
                      child: Text(state.message),
                    );
                  }

                  if (state is RequestLoaded) {
                    if (state.requests.isEmpty) {
                      return const Center(
                        child: Text(
                          "No Requests Yet",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }

                    return RequestsListView(
                      requests: state.requests,
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}