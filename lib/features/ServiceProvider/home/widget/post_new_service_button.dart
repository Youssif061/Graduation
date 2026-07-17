import 'package:expertisemarket/features/ServiceProvider/publish_service/page/publish_service_screen.dart';
import 'package:flutter/material.dart';

class PostNewServiceButton extends StatelessWidget {
  const PostNewServiceButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const PublishServiceScreen(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 18,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFEBF5FF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                size: 20,
                color: Color(0xFF001A2C),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              "Post New Service",
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