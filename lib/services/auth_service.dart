import 'package:flutter/foundation.dart';

class AuthService {
  Future<bool> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      // Mock successful signup
      return true;
    } catch (e) {
      debugPrint('Error signing up: $e');
      return false;
    }
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Mock successful login
      return true;
    } catch (e) {
      debugPrint('Error signing in: $e');
      return false;
    }
  }

  Future<void> signOut() async {
    // Mock sign out
  }
}
