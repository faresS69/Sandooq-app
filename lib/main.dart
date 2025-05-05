import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandooq/auth/auth_gate.dart';
import 'package:sandooq/themes/themes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth/auth_service.dart';
import 'controllers/user_controller.dart';

void main() async {
  await Supabase.initialize(
      url: "Nah man i won't share this",
      anonKey:
          "Same XD");
  Get.put(CurrentUserController());
  //set current user
  final user = Supabase.instance.client.auth.currentUser;
  final AuthService authService = AuthService();
  if (user != null) {
    await authService.fetchUserDetails(user.id);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sandooq',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      home: AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}
