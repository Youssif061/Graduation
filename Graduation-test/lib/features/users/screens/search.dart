import 'package:expertisemarket/features/users/screens/booking.dart';
import 'package:flutter/material.dart';

import '../data/firebase_service.dart';
import '../data/models/pro_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  late Future<List<ProModel>> prosFuture;

  List<ProModel> allPros = [];
  List<ProModel> filteredPros = [];

  List<String> recentSearches = [
    "Master Plumber",
    "Logo Design",
    "Interior Design Consultant",
  ];

  @override
  void initState() {
    super.initState();

    // ================= FIREBASE =================
    prosFuture = FirebaseService.instance.getProfessionals();

    prosFuture.then((value) {
      setState(() {
        allPros = value;
        filteredPros = value;
      });
    });

    searchController.addListener(searchPros);
  }

  void searchPros() {
    final query = searchController.text.toLowerCase();

    setState(() {
      filteredPros = allPros.where((pro) {
        return pro.name.toLowerCase().contains(query) ||
            pro.job.toLowerCase().contains(query) ||
            pro.category.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5FAFF),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(11, 6, 11, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= SEARCH =================
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 42,
                      child: TextField(
                        controller: searchController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "Search for experts...",
                          hintStyle: const TextStyle(
                            fontSize: 11,
                            color: Color(0xff7D8792),
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 18,
                            color: Color(0xff7D8792),
                          ),
                          filled: true,
                          fillColor: const Color(0xffF5FAFF),
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xff18344D),
                              width: 0.8,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xff18344D),
                              width: 0.8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 11, color: Color(0xff102A43)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ================= RECENT SEARCHES =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recent Searches",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff101820),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        recentSearches.clear();
                      });
                    },
                    child: const Text(
                      "Clear all",
                      style: TextStyle(fontSize: 10, color: Color(0xff102A43)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              if (recentSearches.isNotEmpty)
                Column(
                  children: recentSearches.map((search) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.history,
                            size: 17,
                            color: Color(0xffB7C0C9),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              search,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xff263746),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                recentSearches.remove(search);
                              });
                            },
                            child: const Icon(
                              Icons.close,
                              size: 17,
                              color: Color(0xffC1C8CF),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),

              const SizedBox(height: 15),

              // ================= RECOMMENDED =================
              const Text(
                "Recommended for You",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff101820),
                ),
              ),

              const SizedBox(height: 12),

              // ================= PROS =================
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

                    if (filteredPros.isEmpty) {
                      return const Center(
                        child: Text("No professionals found"),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: filteredPros.length,
                      itemBuilder: (context, index) {
                        return SearchProCard(
                          pro: filteredPros[index],
                          onBook: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    BookingScreen(pro: filteredPros[index]),
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
      ),
    );
  }
}

// ============================================================
// SEARCH PRO CARD
// ============================================================

class SearchProCard extends StatelessWidget {
  final ProModel pro;
  final VoidCallback onBook;

  const SearchProCard({super.key, required this.pro, required this.onBook});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffE7EDF2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= IMAGE =================
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  "assets/images/${pro.image}",
                  width: 47,
                  height: 47,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 10),

              // ================= INFO =================
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pro.name,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff101820),
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      pro.job.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 7,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff777F87),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 13,
                          color: Color(0xff008C4A),
                        ),

                        const SizedBox(width: 3),

                        Text(
                          "${pro.rating}",
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xff263746),
                          ),
                        ),

                        const SizedBox(width: 3),

                        const Text(
                          "(124)",
                          style: TextStyle(
                            fontSize: 9,
                            color: Color(0xff8A929A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          const Divider(height: 1, color: Color(0xffEDF1F4)),

          const SizedBox(height: 8),

          Text(
            "\$${pro.price}",
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Color(0xff102A43),
            ),
          ),
        ],
      ),
    );
  }
}
