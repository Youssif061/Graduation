import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues priceRange = const RangeValues(40, 150);

  String selectedDistance = "Any";
  String selectedRating = "4+";

  final List<String> distances = [
    "Any",
    "Under 5km",
    "Under 10km",
  ];

  final List<String> ratings = [
    "1+",
    "2+",
    "3+",
    "4+",
    "5",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= HANDLE =================
              Center(
                child: Container(
                  width: 35,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xffC6CBD1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ================= TITLE =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Filters",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff102A43),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        priceRange = const RangeValues(40, 150);
                        selectedDistance = "Any";
                        selectedRating = "4+";
                      });
                    },
                    child: const Text(
                      "Reset",
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xff5F6368),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 26),

              // ================= PRICE =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Price Range",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff102A43),
                    ),
                  ),

                  Text(
                    "\$${priceRange.start.round()} - \$${priceRange.end.round()}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff008C4A),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  activeTrackColor: const Color(0xff008C4A),
                  inactiveTrackColor: const Color(0xffDCE5EC),
                  thumbColor: Colors.white,
                  overlayColor: const Color(0xff008C4A).withOpacity(0.15),
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 6,
                  ),
                ),
                child: RangeSlider(
                  values: priceRange,
                  min: 0,
                  max: 300,
                  onChanged: (value) {
                    setState(() {
                      priceRange = value;
                    });
                  },
                ),
              ),

              const SizedBox(height: 18),

              // ================= DISTANCE =================
              const Text(
                "Distance",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff102A43),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: distances.map((distance) {
                  final isSelected =
                      selectedDistance == distance;

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDistance = distance;
                          });
                        },
                        child: Container(
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xff55E889)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xff00A86B)
                                  : const Color(0xffC8D0D8),
                            ),
                          ),
                          child: Text(
                            distance,
                            style: TextStyle(
                              fontSize: 10,
                              color: isSelected
                                  ? const Color(0xff008C4A)
                                  : const Color(0xff59636D),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 22),

              // ================= RATING =================
              const Text(
                "Minimum Rating",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff102A43),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ratings.map((rating) {
                  final isSelected =
                      selectedRating == rating;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRating = rating;
                      });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xff55E889)
                            : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xff00A86B)
                              : const Color(0xffD1D8DE),
                        ),
                      ),
                      child: Text(
                        rating,
                        style: TextStyle(
                          fontSize: 10,
                          color: isSelected
                              ? const Color(0xff008C4A)
                              : const Color(0xff59636D),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}