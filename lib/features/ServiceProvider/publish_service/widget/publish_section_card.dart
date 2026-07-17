import 'package:flutter/material.dart';

class PublishSectionCard extends StatelessWidget {
  const PublishSectionCard({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(
        bottom: 20,
      ),

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(
              .03,
            ),
            blurRadius: 12,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight:
                  FontWeight.bold,
              color:
                  Color(0xff001A2C),
            ),
          ),

          const SizedBox(
            height: 16,
          ),

          child,
        ],
      ),
    );
  }
}