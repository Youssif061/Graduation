import 'package:flutter/material.dart';
import '../data/models/pro_model.dart';
import '../widgets/custom_button.dart';
import 'checkout_screen.dart';

class BookingScreen extends StatefulWidget {
  final ProModel pro;

  const BookingScreen({super.key, required this.pro});
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String selectedTime = "09:00 AM";
  int selectedDay = 8;

  final TextEditingController addressController = TextEditingController();

  final List<String> times = ["09:00 AM", "10:30 AM", "01:00 PM"];

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5FAFF),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 12,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 14,
              backgroundImage: AssetImage("assets/images/2.png"),
            ),
            const SizedBox(width: 8),
            const Text(
              "ExpertiseMarket",
              style: TextStyle(
                color: Color(0xff102A43),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 14),
            child: Icon(
              Icons.notifications_none,
              size: 18,
              color: Color(0xff102A43),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Book Service",
              style: TextStyle(fontSize: 20, color: Color(0xff102A43)),
            ),

            const SizedBox(height: 5),

            Container(height: 2, width: 68, color: const Color(0xff008C4A)),

            const SizedBox(height: 14),

            _dateCard(),

            const SizedBox(height: 14),

            _timeCard(),

            const SizedBox(height: 14),

            _addressCard(),

            const SizedBox(height: 14),

            _serviceCard(),

            const SizedBox(height: 10),

            _totalCard(),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 40),
                      side: const BorderSide(color: Color(0xffD9E1E8)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 11, color: Color(0xff102A43)),
                    ),
                  ),
                ),

                const SizedBox(width: 6),

                Expanded(
                  child: CustomButton(
                    title: "Continue →",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CheckoutScreen(
                            service: widget.pro.category,
                            expert: widget.pro.name,
                            price: widget.pro.price,
                            address: addressController.text,
                            date: selectedDay.toString(),
                            time: selectedTime,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= DATE =================

  Widget _dateCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _TitleRow(
            icon: Icons.calendar_today_outlined,
            title: "Select Date",
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _Day(text: "M"),
              _Day(text: "T"),
              _Day(text: "W"),
              _Day(text: "T"),
              _Day(text: "F"),
              _Day(text: "S"),
              _Day(text: "S"),
            ],
          ),

          const SizedBox(height: 8),

          _calendarRow(["28", "29", "30", "1", "2", "3", "4"]),
          _calendarRow(["5", "6", "7", "8", "9", "10", "11"]),
          _calendarRow(["12", "13", "14", "15", "16", "17", "18"]),
        ],
      ),
    );
  }

  Widget _calendarRow(List<String> days) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: days.map((day) {
        final number = int.tryParse(day);
        final selected = number == selectedDay;

        return GestureDetector(
          onTap: number == null
              ? null
              : () {
                  setState(() {
                    selectedDay = number;
                  });
                },
          child: Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? const Color(0xff008C4A) : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              day,
              style: TextStyle(
                fontSize: 9,
                color: selected ? Colors.white : const Color(0xff102A43),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ================= TIME =================

  Widget _timeCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _TitleRow(icon: Icons.access_time, title: "Select Time"),

          const SizedBox(height: 10),

          Row(
            children: times.map((time) {
              final selected = selectedTime == time;

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTime = time;
                      });
                    },
                    child: Container(
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected
                            ? const Color(0xffE2FBEA)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: selected
                              ? const Color(0xff00A86B)
                              : const Color(0xffE0E6EB),
                        ),
                      ),
                      child: Text(
                        time,
                        style: TextStyle(
                          fontSize: 9,
                          color: selected
                              ? const Color(0xff008C4A)
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ================= ADDRESS =================

  Widget _addressCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              _TitleRow(icon: Icons.location_on_outlined, title: "Address"),
              Spacer(),
              Icon(Icons.my_location, size: 12, color: Color(0xff008C4A)),
              SizedBox(width: 3),
              Text(
                "Use Current Location",
                style: TextStyle(fontSize: 8, color: Color(0xff008C4A)),
              ),
            ],
          ),

          const SizedBox(height: 10),

          const Text(
            "Street Address",
            style: TextStyle(fontSize: 9, color: Color(0xff8A98A6)),
          ),

          const SizedBox(height: 5),

          TextField(
            controller: addressController,
            style: const TextStyle(fontSize: 10),
            decoration: InputDecoration(
              hintText: "e.g. 123 Expertise Way",
              hintStyle: const TextStyle(fontSize: 9, color: Color(0xffC4CDD5)),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 9,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Color(0xffE0E6EB)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= SERVICE =================

  Widget _serviceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xff19344D),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Service Selected",
            style: TextStyle(fontSize: 9, color: Color(0xff8193A4)),
          ),

          SizedBox(height: 5),

          Text(widget.pro.category),

          SizedBox(height: 9),

          Text("🟢  ${widget.pro.name}"),

          Text("      ${widget.pro.job}"),
        ],
      ),
    );
  }

  // ================= TOTAL =================

  Widget _totalCard() {
    return Container(
      width: double.infinity,
      height: 82,
      decoration: BoxDecoration(
        color: const Color(0xff5CF38C),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.payments_outlined, size: 22, color: Color(0xff008C4A)),
          SizedBox(height: 2),
          Text(
            "Estimated Total",
            style: TextStyle(fontSize: 9, color: Color(0xff008C4A)),
          ),
          Text("\$${widget.pro.price}"),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
        ],
      ),
      child: child,
    );
  }
}

class _TitleRow extends StatelessWidget {
  final IconData icon;
  final String title;

  const _TitleRow({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15, color: const Color(0xff008C4A)),
        const SizedBox(width: 5),
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Color(0xff102A43)),
        ),
      ],
    );
  }
}

class _Day extends StatelessWidget {
  final String text;

  const _Day({required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 7, color: Color(0xff7D8792)),
        ),
      ),
    );
  }
}
