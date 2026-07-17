import 'package:expertisemarket/features/products/presentation/pages/search_screen.dart';
import 'package:expertisemarket/features/users/screens/booking.dart';
import 'package:expertisemarket/features/users/screens/filter.dart';
import 'package:flutter/material.dart';

import '../data/firebase_service.dart';
import '../data/models/pro_model.dart';
import '../widgets/custom_chip.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/pro_service_card.dart';

class ProsScreen extends StatefulWidget {
  const ProsScreen({super.key});

  @override
  State<ProsScreen> createState() => _ProsScreenState();
}

class _ProsScreenState extends State<ProsScreen> {
  late Future<List<ProModel>> prosFuture;

  @override
  void initState() {
    super.initState();

    prosFuture = FirebaseService.instance.getProfessionals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Professionals",
          style: TextStyle(
            color: Color(0xff0B253B),
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xff0B253B)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
        child: Column(
          children: [
            // ================= SEARCH =================
            Row(
              children: [
                Expanded(
                  child: CustomSearchBar(
                    hint: "Search for experts...",
                    readOnly: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SearchScreen()),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 8),

                // ================= FILTER =================
                InkWell(
                  borderRadius: BorderRadius.circular(11),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) {
                        return const FilterScreen();
                      },
                    );
                  },
                  child: Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(color: const Color(0xffDCE4EB)),
                    ),
                    child: const Icon(
                      Icons.tune,
                      size: 20,
                      color: Color(0xff0B253B),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ================= CHIPS =================
            SizedBox(
              height: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CustomChip(text: "All Services", selected: true),
                  CustomChip(text: "Plumbing"),
                  CustomChip(text: "Electrical"),
                  CustomChip(text: "HVAC"),
                  CustomChip(text: "Cleaning"),
                  CustomChip(text: "Carpentry"),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ================= PROFESSIONALS =================
            Expanded(
              child: FutureBuilder<List<ProModel>>(
                future: prosFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff00A86B),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No professionals found"));
                  }

                  final pros = snapshot.data!;

                  return ListView.builder(
                    itemCount: pros.length,
                    itemBuilder: (context, index) {
                      return ProServiceCard(
                        pro: pros[index],
                        onBook: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BookingScreen(pro: pros[index]),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
