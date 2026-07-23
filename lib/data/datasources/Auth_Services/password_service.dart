import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class PasswordService {
  final FirebaseAuth _auth;

  PasswordService({required FirebaseAuth auth}) : _auth = auth;

  Future<Map<String, dynamic>> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return {'success': true, 'message': 'Password reset email sent. Please check your inbox.'};
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found with this email';
          break;
        case 'invalid-email':
          message = 'Invalid email address';
          break;
        default:
          message = 'Failed to send reset email: ${e.message}';
      }
      return {'success': false, 'message': message};
    } catch (e) {
      debugPrint('PasswordService.resetPassword: $e');
      return {'success': false, 'message': 'An unexpected error occurred'};
    }
  }

  Future<Map<String, dynamic>> validateCurrentPassword(String password) async {
    try {
      final user = _auth.currentUser;
      if (user == null || user.email == null) {
        return {'success': false, 'message': 'Wrong password'};
      }

      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);

      return {'success': true, 'message': 'Password verified'};
    } on FirebaseAuthException catch (e) {
      debugPrint('PasswordService.validateCurrentPassword: $e');
      return {'success': false, 'message': 'Wrong password'};
    } catch (e) {
      debugPrint('PasswordService.validateCurrentPassword: $e');
      return {'success': false, 'message': 'Wrong password'};
    }
  }

  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null || user.email == null) {
        return {'success': false, 'message': 'No user logged in'};
      }

      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);

      return {'success': true, 'message': 'Password updated successfully'};
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'wrong-password':
          message = 'Current password is incorrect';
          break;
        case 'weak-password':
          message = 'New password is too weak';
          break;
        case 'requires-recent-login':
          message = 'Please log in again to change password';
          break;
        default:
          message = 'Failed to change password: ${e.message}';
      }
      return {'success': false, 'message': message};
    } catch (e) {
      debugPrint('PasswordService.changePassword: $e');
      return {'success': false, 'message': 'An unexpected error occurred'};
    }
  }
}
