import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // ✅ Sign up with email & password
  Future<AuthResponse?> signUp(String email, String password) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      throw e.message;
    }
  }

  // ✅ Login with email & password
  Future<AuthResponse?> signIn(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      throw e.message;
    }
  }

  // ✅ Sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // ✅ Check if user is logged in
  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }
}
