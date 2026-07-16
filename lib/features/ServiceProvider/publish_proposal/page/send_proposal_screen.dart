import 'package:expertisemarket/features/ServiceProvider/publish_proposal/cubit/proposal_cubit.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_proposal/widgets/proposal_form.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_proposal/widgets/request_summary_card.dart';
import 'package:expertisemarket/features/ServiceProvider/request/model/request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendProposalScreen extends StatelessWidget {
  const SendProposalScreen({
    super.key,
    required this.request,
  });

  final RequestModel request;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProposalCubit(),
      child: BlocListener<ProposalCubit, ProposalState>(
        listener: (context, state) {
          if (state is ProposalSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Proposal sent successfully",
                ),
              ),
            );

            Navigator.pop(context);
          }

          if (state is ProposalFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xffF8FAFC),

          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
            centerTitle: true,

            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xff001A2C),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            title: const Text(
              "Send Proposal",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xff001A2C),
              ),
            ),

            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 1,
                color: const Color(0xffE2E8F0),
              ),
            ),
          ),

          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RequestSummaryCard(
                    request: request,
                  ),

                  const SizedBox(height: 24),

                  ProposalForm(
                    request: request,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}