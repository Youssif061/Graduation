import 'package:expertisemarket/features/ServiceProvider/publish_proposal/cubit/proposal_cubit.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_proposal/widgets/custom_text_field.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_proposal/widgets/duration_dropdown.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_proposal/widgets/send_proposal_button.dart';
import 'package:expertisemarket/features/ServiceProvider/request/model/request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProposalForm extends StatefulWidget {
  const ProposalForm({
    super.key,
    required this.request,
  });

  final RequestModel request;

  @override
  State<ProposalForm> createState() =>
      _ProposalFormState();
}

class _ProposalFormState
    extends State<ProposalForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController
      priceController =
      TextEditingController();

  final TextEditingController
      messageController =
      TextEditingController();

  String selectedDuration =
      "Less than 1 week";

  @override
  void dispose() {
    priceController.dispose();
    messageController.dispose();
    super.dispose();
  }

  void _sendProposal() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<ProposalCubit>().sendProposal(
          requestId: widget.request.id,
          price: priceController.text.trim(),
          duration: selectedDuration,
          message:
              messageController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
        ProposalCubit,
        ProposalState>(
      builder: (context, state) {
        final isLoading =
            state is ProposalLoading;

        return Form(
          key: _formKey,
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(.04),
                  blurRadius: 10,
                  offset:
                      const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your Proposal",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color(0xff001A2C),
                  ),
                ),

                const SizedBox(
                    height: 24),

                const Text(
                  "Fixed Price (\$)",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                    height: 10),

                CustomTextField(
                  controller:
                      priceController,
                  hint: "\$2500",
                  keyboardType:
                      TextInputType.number,
                ),

                const SizedBox(
                    height: 12),

                const Text(
                  "Client will see the total amount inclusive of platform fees.",
                  style: TextStyle(
                    color:
                        Color(0xff64748B),
                  ),
                ),

                const SizedBox(
                    height: 24),

                const Text(
                  "Estimated Duration",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                    height: 10),

                DurationDropdown(
                  value:
                      selectedDuration,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }

                    setState(() {
                      selectedDuration =
                          value;
                    });
                  },
                ),

                const SizedBox(
                    height: 24),

                const Text(
                  "Proposal Message",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                    height: 10),

                CustomTextField(
                  controller:
                      messageController,
                  hint:
                      "Describe your approach, experience, and why you're the perfect fit for this project...",
                  maxLines: 6,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),

                const SizedBox(
                    height: 8),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                  children: [
                    const Text(
                      "Minimum 100 characters",
                    ),
                    Text(
                      "${messageController.text.length}/5000",
                    ),
                  ],
                ),

                const SizedBox(
                    height: 30),

                SendProposalButton(
                  isLoading:
                      isLoading,
                  onPressed:
                      _sendProposal,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}