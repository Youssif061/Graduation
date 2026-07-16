import 'package:expertisemarket/features/ServiceProvider/request/cubit/request_cubit.dart';
import 'package:expertisemarket/features/ServiceProvider/request/repository/request_repository.dart';
import 'package:expertisemarket/features/ServiceProvider/request/widget/job_requests_header.dart';
import 'package:expertisemarket/features/ServiceProvider/request/widget/requests_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RequestCubit(
        repository: RequestRepository(),
      )..loadRequests(),
      child: const _RequestsView(),
    );
  }
}

class _RequestsView extends StatelessWidget {
  const _RequestsView();

  Future<void> _refresh(
    BuildContext context,
  ) async {
    await context
        .read<RequestCubit>()
        .refreshRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const Text(
          "Job Requests",
          style: TextStyle(
            color: Color(0xff001A2C),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: BlocBuilder<RequestCubit, RequestState>(
        builder: (context, state) {
          //------------------------------------------
          // Loading
          //------------------------------------------

          if (state is RequestLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          //------------------------------------------
          // Failure
          //------------------------------------------

          if (state is RequestFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(
                  24,
                ),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 70,
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    Text(
                      state.message,
                      textAlign:
                          TextAlign.center,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<RequestCubit>()
                            .loadRequests();
                      },
                      child: const Text(
                        "Retry",
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          //------------------------------------------
          // Loaded
          //------------------------------------------

          if (state is RequestLoaded) {
            return RefreshIndicator(
              onRefresh: () =>
                  _refresh(context),
              child: Padding(
                padding:
                    const EdgeInsets.all(20),
                child: Column(
                  children: [
                    JobRequestsHeader(
                      totalRequests:
                          state.requests.length,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Expanded(
                      child:
                          state.requests.isEmpty
                              ? ListView(
                                  children: const [
                                    SizedBox(
                                      height: 180,
                                    ),
                                    Center(
                                      child: Text(
                                        "No Requests Yet",
                                        style:
                                            TextStyle(
                                          fontSize:
                                              18,
                                          color: Colors
                                              .grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : RequestsListView(
                                  requests:
                                      state
                                          .requests,
                                ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}