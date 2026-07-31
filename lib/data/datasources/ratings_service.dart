import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class RatingsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? get currentUserId => FirebaseAuth.instance.currentUser?.uid;

  Future<int> getUserRating(String recipeId) async {
    final userId = currentUserId;
    if (userId == null) return 0;
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (!doc.exists) return 0;
      final ratings = doc.data()!['ratings'] as Map<String, dynamic>? ?? {};
      return (ratings[recipeId] as num?)?.toInt() ?? 0;
    } catch (e) {
      debugPrint('RatingsService.getUserRating: $e');
      return 0;
    }
  }

  Future<double> saveRating(String recipeId, int newRating) async {
    final userId = currentUserId;
    if (userId == null) return 0.0;
    try {
      double savedAvg = 0.0;
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final userRef = _firestore.collection('users').doc(userId);
        final recipeRef = _firestore.collection('recipes').doc(recipeId);

        final userSnapshot = await transaction.get(userRef);
        final recipeSnapshot = await transaction.get(recipeRef);

        final currentRatings = Map<String, dynamic>.from(
            (userSnapshot.data()?['ratings'] as Map<String, dynamic>?) ?? {});
        final oldRating = (currentRatings[recipeId] as num?)?.toInt() ?? 0;
        final currentAvg = (recipeSnapshot.data()?['rating'] as num?)?.toDouble() ?? 0.0;
        final currentCount = (recipeSnapshot.data()?['ratingCount'] as num?)?.toInt() ?? 0;

        double newAvg;
        int newCount;

        if (oldRating == 0 && newRating > 0) {
          newCount = currentCount + 1;
          newAvg = currentCount == 0
              ? newRating.toDouble()
              : ((currentAvg * currentCount) + newRating) / newCount;
        } else if (oldRating > 0 && newRating > 0) {
          newCount = currentCount > 0 ? currentCount : 1;
          newAvg = ((currentAvg * newCount) - oldRating + newRating) / newCount;
        } else {
          newCount = currentCount > 0 ? currentCount - 1 : 0;
          newAvg = newCount > 0
              ? ((currentAvg * currentCount) - oldRating) / newCount
              : 0.0;
        }

        currentRatings[recipeId] = newRating;
        transaction.update(userRef, {
          'ratings': currentRatings,
          'updatedAt': DateTime.now().toIso8601String(),
        });
        transaction.set(recipeRef, {
          'rating': newAvg,
          'ratingCount': newCount,
        }, SetOptions(merge: true));

        savedAvg = newAvg;
      });
      return savedAvg;
    } catch (e) {
      debugPrint('RatingsService.saveRating: $e');
      rethrow;
    }
  }
}
