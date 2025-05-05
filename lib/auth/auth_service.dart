import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../controllers/user_controller.dart';
import '../models/user_model.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<AuthResponse> signUp(
      String name, String email, String password) async {
    try {
      // Sign up the user
      final response =
          await _supabase.auth.signUp(email: email, password: password);
      final user = response.user;

      if (user == null) {
        throw Exception('User signup failed. No user object returned.');
      }

      // Insert user details into the database
      await _supabase.from('users').insert({
        'id': user.id,
        'email': email,
        'fullName': name,
        'isVerified': false,
        'joinedRoscaIds': [],
        'profilePicUrl': null,
        'phoneNumber': null,
        'city': null,
      });

      print('User inserted successfully');
      return response;
    } on PostgrestException catch (e) {
      print('Database error: ${e.message}');
      rethrow; // Optionally rethrow the error for higher-level handling
    } on AuthException catch (e) {
      print('Authentication error: ${e.message}');
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  Future<AuthResponse> signIn(String email, String password) async {
    try {
      // Attempt to sign in the user
      final response = await _supabase.auth
          .signInWithPassword(email: email, password: password);

      final user = _supabase.auth.currentUser;
      if (user == null) {
        throw Exception('Sign-in failed. No user object returned.');
      }

      // Fetch user details from the database
      UserModel temp = await fetchUserDetails(user.id);
      
      print('User signed in successfully: ${temp.toMap()}');
      return response;
    } on PostgrestException catch (e) {
      print('Database error: ${e.message}');
      rethrow;
    } on AuthException catch (e) {
      print('Authentication error: ${e.message}');
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    final currentUserController = Get.find<CurrentUserController>();
    currentUserController.clearUser();
    print('User signed out successfully');
  }

  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
  
  fetchUserDetails(String id) async {
    final data =
          await _supabase.from('users').select().eq('id', id).single();
      if (data.isEmpty) {
        throw Exception('Failed to fetch user data: No data returned.');
      }

      // Use the updated UserModel to handle null values
      final userModel = UserModel.fromMap(data);
      final currentUserController = Get.find<CurrentUserController>();
      currentUserController.setUser(userModel);
      return userModel;
  }
}
