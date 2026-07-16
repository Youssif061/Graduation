import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_proposal/page/send_proposal_screen.dart';
import 'package:expertisemarket/features/ServiceProvider/request/cubit/request_cubit.dart';
import 'package:expertisemarket/features/ServiceProvider/request/model/request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestActionButtons extends StatelessWidget {
  const RequestActionButtons({
    super.key,
    required this.request,
  });

  final RequestModel request;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestCubit, RequestState>(
      listener: (context, state) {
        if (state is RequestFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        final bool loading =
            state is RequestUpdating;

        return Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 54,
                child: OutlinedButton.icon(
                  onPressed: loading
                      ? null
                      : () => _showRejectDialog(
                            context,
                          ),
                  icon: const Icon(
                    Icons.close,
                    color: Color(0xff001A2C),
                  ),
                  label: const Text(
                    'Reject',
                    style: TextStyle(
                      color: Color(0xff001A2C),
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                  style:
                      OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xffCBD5E1),
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              flex: 2,
              child: SizedBox(
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: loading
                      ? null
                      : () async {
                          await context
                              .read<
                                  RequestCubit>()
                              .acceptRequest(
                                request.id,
                              );

                          if (!context
                              .mounted) {
                            return;
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  SendProposalScreen(
                                request:
                                    request,
                              ),
                            ),
                          );
                        },
                  icon: loading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(
                          Icons.send,
                        ),
                  label: Text(
                    loading
                        ? 'Loading...'
                        : 'Send Proposal',
                  ),
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors
                            .primaryColor,
                    foregroundColor:
                        Colors.white,
                    elevation: 0,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  //--------------------------------------------------
  // Reject Dialog
  //--------------------------------------------------

  void _showRejectDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Reject Request',
          ),
          content: const Text(
            'Are you sure you want to reject this request?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
              ),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.red,
              ),
              onPressed: () async {
                Navigator.pop(context);

                await context
                    .read<RequestCubit>()
                    .rejectRequest(
                      request.id,
                    );

                if (!context.mounted) {
                  return;
                }

                Navigator.pop(context);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Request rejected successfully',
                    ),
                  ),
                );
              },
              child: const Text(
                'Reject',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}