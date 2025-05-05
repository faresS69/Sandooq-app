import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'rosca_details.dart';

class ExploreScreen extends StatelessWidget {
  final RxString _searchQuery = ''.obs;
  final RxBool _isRefreshing = false.obs;

  ExploreScreen({super.key});

  Future<void> _refreshData() async {
    _isRefreshing.value = true;
    await Future.delayed(const Duration(seconds: 2)); // Simulate data fetch
    _isRefreshing.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _buildSearchBar(context),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshData,
                child: Obx(() {
                  return ListView(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    children: [
                      if (_searchQuery.value.isEmpty) ...[
                        _buildRoscaCard(
                          context: context,
                          title: "Monthly ROSCA",
                          description: "Created by John Doe",
                          payoutDate: "Payout: May 15, 2025",
                          wilaya: "Algiers",
                        ),
                        const SizedBox(height: 16),
                        _buildRoscaCard(
                          context: context,
                          title: "Weekly ROSCA",
                          description: "Created by Jane Smith",
                          payoutDate: "Payout: April 30, 2025",
                          wilaya: "Oran",
                        ),
                      ] else ...[
                        _buildRoscaCard(
                          context: context,
                          title: "Filtered ROSCA",
                          description: "Search result for '${_searchQuery.value}'",
                          payoutDate: "Payout: May 20, 2025",
                          wilaya: "Constantine",
                        ),
                      ],
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            onChanged: (value) => _searchQuery.value = value,
            decoration: InputDecoration(
              hintText: "Search ROSCAs...",
              hintStyle: GoogleFonts.workSans(color: Colors.grey),
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFilterButton(context, "Date"),
                _buildFilterButton(context, "Wilaya"),
                _buildFilterButton(context, "Owner"),
                _buildFilterButton(context, "Amount"),
              ],
            ),
          ),
          Divider(
            height: 16,
            thickness: 1,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context, String label) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(Icons.filter_list, size: 16),
      label: Text(label, style: GoogleFonts.workSans(fontSize: 14)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.grey[800],
        foregroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.black87
            : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _buildRoscaCard({
    required BuildContext context,
    required String title,
    required String description,
    required String payoutDate,
    required String wilaya,
  }) {
    return GestureDetector(
      onTap: () {
        // Handle card tap
        Get.to(RoscaDetailsScreen());
      },
      child: Card(
        
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),side: BorderSide(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.grey[300]!
              : Colors.grey[700]!,
          width: 1,
        )),
        
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.grey[800],
        shadowColor: Theme.of(context).brightness == Brightness.light
            ? Colors.black12
            : Colors.black54,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.workSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black87
                      : Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: GoogleFonts.workSans(
                  fontSize: 14,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black54
                      : Colors.white70,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                payoutDate,
                style: GoogleFonts.workSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Wilaya: $wilaya",
                style: GoogleFonts.workSans(
                  fontSize: 14,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black54
                      : Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
