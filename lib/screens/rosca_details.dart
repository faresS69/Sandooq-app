import 'package:flutter/material.dart';

class RoscaDetailsScreen extends StatelessWidget {
  const RoscaDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color mainBlue = const Color(0xFF0D1C60); // Dark blue background
    final Color yellow = const Color(0xFFFFC107);   // Yellow for accents
    final Color lightYellow = const Color(0xFFFFD54F); // Light Yellow

    return Scaffold(
      backgroundColor: mainBlue,
      appBar: AppBar(
        backgroundColor: mainBlue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          '5,750 Cycle',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'TOTAL AMOUNT',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 8),
            const Text(
              '5,750',
              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '575 DA x 10 Months',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 4),
            const Text(
              'Cycle ID: #R30210',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 24),

            // Timeline
            Expanded(
              child: ListView(
                children: [
                  _timelineItem('1', 'Jan 1', 'Fares Slimani', true, mainBlue, yellow),
                  _timelineItem('2', 'Feb 1', 'Amine Said', true, mainBlue, yellow),
                  _timelineItem('3', 'Mar 1', 'Abdou Tito', true, mainBlue, yellow),
                  _timelineItem('4', 'Apr 1', 'Aditya Adam', true, mainBlue, yellow),
                  _timelineItem('5', 'May 1', 'Reyansh Jim', true, mainBlue, yellow),
                  _timelineItem('6', 'Jun 1', 'Ahmed Salem', false, mainBlue, yellow),
                  _timelineItem('7', 'Jul 1', 'Meriem Ismail', false, mainBlue, yellow, isPayButton: true),
                  _timelineItem('8', 'Aug 1', 'Arjun Ray', false, mainBlue, yellow),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _timelineItem(
    String number,
    String date,
    String name,
    bool cashedOut,
    Color mainBlue,
    Color yellow, {
    bool isPayButton = false,
  }) {
    return Row(
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: yellow,
              child: Text(number, style: const TextStyle(color: Colors.black, fontSize: 12)),
            ),
            Container(
              width: 2,
              height: 50,
              color: Colors.white30,
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  child: const Icon(Icons.person, color: Colors.black),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text(date, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
                if (cashedOut)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: yellow,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text('Cashed-out', style: TextStyle(color: Colors.black, fontSize: 12)),
                  ),
                if (isPayButton)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: yellow,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {},
                    child: const Text('Pay'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
