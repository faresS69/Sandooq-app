import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandooq/auth/auth_service.dart';
import 'package:sandooq/controllers/user_controller.dart';

import 'login/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final authService = AuthService();
  var showReminder = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit, color: Colors.black),
          ),
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              _buildProfileHeader(),
              const SizedBox(height: 20),
              _buildReminderCard(),
              const SizedBox(height: 20),
              _buildUserDetails(),
              const SizedBox(height: 40),
              _buildLogoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    final user = Get.find<CurrentUserController>().user.value;
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            user?.profilePicUrl ??
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQL1WqGdweFYA8Kozyxhxr7cL3dWyJqUbXSIQ&s",
          ),
          radius: 60,
        ),
        const SizedBox(height: 16),
        Text(
          user?.fullName.capitalize ?? "Guest User",
          style: GoogleFonts.workSans(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildReminderCard() {
    return Obx(() {
      if (!showReminder.value) return SizedBox.shrink();
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.black54),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Complete your profile for a better experience.",
                style: GoogleFonts.workSans(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.close, size: 20, color: Colors.black54),
              onPressed: () => showReminder.value = false,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildUserDetails() {
    final user = Get.find<CurrentUserController>().user.value;
    return Column(
      children: [
        _buildDetailRow("Phone Number", user?.phoneNumber ?? "N/A"),
        const SizedBox(height: 10),
        _buildDetailRow("Email", user?.email ?? "N/A"),
        const SizedBox(height: 10),
        _buildDetailRow("Wilaya", user?.city ?? "N/A"),
        const SizedBox(height: 10),
        _buildDetailRow(
          "Verification Status",
          user?.isVerified == true ? "Verified" : "Not Verified",
          color: user?.isVerified == true ? Colors.green : Colors.red,
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label:",
          style: GoogleFonts.workSans(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white70
                : Colors.black87,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.workSans(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).brightness == Brightness.dark
                ? color ?? Colors.white70
                : color ?? Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: _showLogoutDialog,
      child: Text(
        "Logout",
        style: GoogleFonts.workSans(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await authService.signOut();
                Get.offAll(() => LoginScreen());
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}
