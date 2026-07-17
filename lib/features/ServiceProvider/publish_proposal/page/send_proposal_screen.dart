import 'package:expertisemarket/features/ServiceProvider/publish_proposal/widgets/proposal_form.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_proposal/widgets/request_summary_card.dart';
import 'package:flutter/material.dart';

class SendProposalScreen extends StatelessWidget {
  const SendProposalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xff001A2C)),
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
          child: Divider(color: Colors.grey.shade200, height: 1),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              /// Request Summary
              // RequestSummaryCard(),

              SizedBox(height: 24),

              /// Proposal Form
              ProposalForm(),
            ],
          ),
        ),
      ),
    );
  }
}
