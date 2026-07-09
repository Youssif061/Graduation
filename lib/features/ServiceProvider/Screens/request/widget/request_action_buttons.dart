import 'package:craftmarket/features/ServiceProvider/Screens/publish_proposal/page/send_proposal_screen.dart';
import 'package:flutter/material.dart';

class RequestActionButtons extends StatelessWidget {
  const RequestActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Reject
        SizedBox(
          height: 54,
          child: OutlinedButton.icon(
            onPressed: () {
              _showRejectDialog(context);
            },
            icon: const Icon(
              Icons.close_rounded,
              size: 18,
              color: Color(0xff001A2C),
            ),
            label: const Text(
              "Reject",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color(0xff001A2C),
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(
                color: Color(0xffCBD5E1),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        /// Send Proposal
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 54,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SendProposalScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 18,
              ),
              label: const Text(
                "Send Proposal",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0C8A43),
                foregroundColor: Colors.white,
                elevation: 2,
                shadowColor: const Color(0xff0C8A43),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static void _showRejectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Reject Request",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Are you sure you want to reject this request?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff001A2C),
              ),
              onPressed: () {
                Navigator.pop(context);

                // TODO: Reject Request
              },
              child: const Text(
                "Reject",
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