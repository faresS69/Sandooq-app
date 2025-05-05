import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandooq/screens/profile_screen.dart';

import '../controllers/user_controller.dart';
import '../screens/home_screen.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final user = Get.find<CurrentUserController>().user.value;

  @override
  Widget build(BuildContext context) {
    return Container(
    width: 200,
    color: // depends on the theme
        Theme.of(context).brightness == Brightness.light
            ? const Color(0xFFF5F5F5)
            : const Color(0xFF1F1F1F),
    child: Column(
      children: [
        const SizedBox(height: 50),
        CircleAvatar(
          backgroundImage: NetworkImage(user!.profilePicUrl ??
              "https://images.squarespace-cdn.com/content/v1/590beb9b893fc0ef1a3523e3/1658676592432-NRVI5VLXVLV7PRS1VRQM/WG"),
          minRadius: 60,
        ),
        const SizedBox(height: 20),
        Text(
          user!.fullName.capitalize!,
          style: GoogleFonts.workSans(
              fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 40),
        ListTile(
          title: Text("Home"),
          onTap: () {
            Get.off(
              () => HomeScreen(),
              transition: Transition.rightToLeft,
              duration: const Duration(milliseconds: 300),
            );
          },
        ),
        ListTile(
          title: Text("Profile"),
          onTap: () {
            Navigator.pop(context);
            Get.to(() =>ProfileScreen(),
              transition: Transition.cupertino,
              duration: const Duration(milliseconds: 700),
            );
          },
        ),
      ],
    ),
  
);
}
}
