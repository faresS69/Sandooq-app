import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandooq/controllers/user_controller.dart';
import 'package:sandooq/screens/home_screen.dart';
import 'package:sandooq/widgets/rosca.dart';

class HomeContent extends StatelessWidget {
  final RxBool _isRefreshing = false.obs;

  HomeContent({super.key});

  Future<void> _refreshData() async {
    _isRefreshing.value = true;
    await Future.delayed(const Duration(seconds: 2)); // Simulate data fetch
    _isRefreshing.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final user = Get.find<CurrentUserController>().user.value;

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Good morning",
                  style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w400, fontSize: 26)),
              Text(user!.fullName.capitalize!,
                  style: GoogleFonts.workSans(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          const SizedBox(height: 16),
          // Rewards balance card
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(colors: [
                const Color.fromARGB(255, 164, 242, 138),
                const Color.fromARGB(255, 151, 220, 245).withOpacity(0.5),
              ], center: Alignment.center, radius: 0.8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                )
              ],
              color: const Color(0xFFDFF6D8),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Rewards balance",
                    style: TextStyle(color: Colors.black54)),
                const SizedBox(height: 8),
                const Text("184.23 DA",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text("The next reward: 0 DA"),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {},
                  child: const Text("Learn more about circlys →",
                      style: TextStyle(color: Colors.green)),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),

          CurrentCircleCard(
            totalMembers: 5,
            userTurn: 3,
            currentRound: 4,
            amountPerRound: 10000,
            nextDate: DateTime(2025, 5, 5),
          ),

          // Stats summary row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatCard(title: "Circles", value: "5 circles"),
              StatCard(title: "Commitment", value: "9 months"),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatCard(title: "To be received", value: "55,000 DA"),
              StatCard(title: "Upcoming payout", value: "55,000 DA"),
            ],
          ),
          Center(
            child: SizedBox(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/Sandooq.png"),
                    const Text("All Rights Reserved"),
                    const Text("Sandooq 2025")
                  ],
                )),
          )
        ],
      ),
    );
  }
}
