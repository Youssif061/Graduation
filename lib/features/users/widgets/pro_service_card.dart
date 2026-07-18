import 'package:flutter/material.dart';
import '../data/models/pro_model.dart';
import '../screens/pro_details.dart';

class ProServiceCard extends StatelessWidget {
  final ProModel pro;
  final VoidCallback onBook;

  const ProServiceCard({
    super.key,
    required this.pro,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProDetailsScreen(pro: pro),
          ),
        );
      },
      child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/${pro.image}",
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(
                10,
                8,
                10,
                10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          pro.name,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff0B253B),
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffDDF7E8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 11,
                              color: Color(0xff00A86B),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              "${pro.rating}",
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff008C5A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "${pro.job} • ${pro.experience} yrs exp",
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xff66788A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 3),

                  const Text(
                    "Specialized in modern residential installations...",
                    style: TextStyle(
                      fontSize: 9,
                      color: Color(0xff8A98A6),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Maintenance inspection",
                              style: TextStyle(
                                fontSize: 9,
                                color: Color(0xff8A98A6),
                              ),
                            ),

                            const SizedBox(height: 2),

                            Text(
                              "\$${pro.price}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0B253B),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 34,
                        child: ElevatedButton(
                          onPressed: onBook,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xff0B253B),
                            elevation: 0,
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(7),
                            ),
                          ),
                          child: const Text(
                            "Book Service",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
   );
  }
}