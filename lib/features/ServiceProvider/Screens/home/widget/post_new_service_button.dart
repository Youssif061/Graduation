import 'package:craftmarket/core/functions/navigations.dart';
import 'package:craftmarket/features/ServiceProvider/Screens/publish_service/page/publish_service_screen.dart';
import 'package:flutter/material.dart';

class PostNewServiceButton extends StatelessWidget {
  const PostNewServiceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(
        //   context,
        // ).push(MaterialPageRoute(builder: (_) => const PublishServiceScreen()));
        // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => RequestScreen(
                  //       request: item,
                  //     ),
                  //   ),
                  // );
                  naviagationPush(context, PublishServiceScreen());
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          color: const Color(0xFFEBF5FF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Color(0xFF001A2C), size: 20),
            ),
            const SizedBox(width: 12),
            const Text(
              'Post New Service',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF001A2C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
