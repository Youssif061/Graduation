import 'package:flutter/material.dart';
import 'custom_text_field.dart';
import 'duration_dropdown.dart';
import 'send_proposal_button.dart';

class ProposalForm extends StatefulWidget {
  const ProposalForm({super.key});

  @override
  State<ProposalForm> createState() => _ProposalFormState();
}

class _ProposalFormState extends State<ProposalForm> {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  String selectedDuration = "Less than 1 week";

  @override
  void initState() {
    super.initState();
    selectedDuration = "Less than 1 week";
  }

  @override
  void dispose() {
    priceController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Proposal',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xff001A2C),
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            "Fixed Price (\$)",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff001A2C),
            ),
          ),

          const SizedBox(height: 10),

          CustomTextField(
            controller: priceController,
            hint: "\$2500",
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 10),

          Text(
            'Client will see the total amount inclusive ofplatform fees.',
            style: TextStyle(fontSize: 16, color: Color(0xff43474DB2)),
          ),

          const SizedBox(height: 20),

          const Text(
            "Estimated Duration",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff001A2C),
            ),
          ),
          const SizedBox(height: 10),

          DurationDropdown(
            value: selectedDuration,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedDuration = value;
                });
              }
            },
          ),
          const SizedBox(height: 20),

          const Text(
            "Proposal Message",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff001A2C),
            ),
          ),
          const SizedBox(height: 10),

          CustomTextField(
            controller: messageController,
            hint:
                "Describe your approach, experience, and why you're the perfect fit for this project...",
            maxLines: 6,
            onChanged: (value) {
              setState(() {});
            },
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Min. 100 characters",
                style: TextStyle(
                  color: Color(0xff43474DB2),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${messageController.text.length} / 5000",
                style: TextStyle(
                  color: Color(0xff43474DB2),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          SendProposalButton(onPressed: () {}),
        ],
      ),
    );
  }
}
