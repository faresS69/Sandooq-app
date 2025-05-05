import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrentCircleCard extends StatelessWidget {
  final int totalMembers;
  final int userTurn;
  final int currentRound;
  final int amountPerRound;
  final DateTime nextDate;

  const CurrentCircleCard({
    super.key,
    required this.totalMembers,
    required this.userTurn,
    required this.currentRound,
    required this.amountPerRound,
    required this.nextDate,
  });

  @override
  Widget build(BuildContext context) {
    double progress = currentRound / totalMembers;

    return Card(
      color: const Color(0xFFDFF6D8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Your Current Circle",
                style: TextStyle(color: Colors.black54)),
            const SizedBox(height: 12),

            // Amount
            Text(
              "💰 Amount per round: ${amountPerRound.toString()} DA",
              style: GoogleFonts.workSans(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),

            // Your turn
            Text(
              "📍 Your turn: $userTurn / $totalMembers",
              style: GoogleFonts.workSans(),
            ),

            // Next payout date
            Text(
              "📅 Next circle: ${_formatDate(nextDate)}",
              style: GoogleFonts.workSans(),
            ),

            const SizedBox(height: 12),

            // Progress bar with segments
            Stack(
              children: [
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 14,
                  backgroundColor: Colors.grey[300],
                  color: Colors.green[600],
                  borderRadius: BorderRadius.circular(20),
                ),
                Positioned.fill(
                  child: Row(
                    children: List.generate(
                      totalMembers - 1,
                      (index) => Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 1),
                          color: Colors.transparent,
                          child: const VerticalDivider(
                              color: Colors.white, thickness: 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Optional: current round summary
            Text(
              "Round $currentRound of $totalMembers",
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day} ${_monthName(date.month)} ${date.year}";
  }

  String _monthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month - 1];
  }
}
