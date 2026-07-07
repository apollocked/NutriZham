import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    } catch (_) {
      return 0;
    }
  }

  Future<void> saveRating(String recipeId, int newRating) async {
    final userId = currentUserId;
    if (userId == null) return;
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final userRef = _firestore.collection('users').doc(userId);
        final recipeRef = _firestore.collection('recipes').doc(recipeId);

        final userSnapshot = await transaction.get(userRef);
        final recipeSnapshot = await transaction.get(recipeRef);

        final currentRatings = Map<String, dynamic>.from(
            (userSnapshot.data()?['ratings'] as Map<String, dynamic>?) ?? {});
        final oldRating = (currentRatings[recipeId] as num?)?.toInt() ?? 0;
        final currentAvg = (recipeSnapshot.data()?['rating'] as num?)?.toDouble() ?? 0.0;
        final currentCount = (recipeSnapshot.data()?['ratingCount'] as int?) ?? 0;

        double newAvg;
        int newCount;

        if (oldRating == 0 && newRating > 0) {
          newCount = currentCount + 1;
          newAvg = ((currentAvg * currentCount) + newRating) / newCount;
        } else if (oldRating > 0 && newRating > 0) {
          newCount = currentCount;
          newAvg = ((currentAvg * currentCount) - oldRating + newRating) / newCount;
        } else {
          newCount = currentCount > 0 ? currentCount - 1 : 0;
          newAvg = newCount > 0 ? ((currentAvg * (currentCount + 1)) - oldRating) / newCount : 0.0;
        }

        currentRatings[recipeId] = newRating;
        transaction.update(userRef, {
          'ratings': currentRatings,
          'updatedAt': DateTime.now().toIso8601String(),
        });
        transaction.update(recipeRef, {
          'rating': newAvg,
          'ratingCount': newCount,
        });
      });
    } catch (_) {
      rethrow;
    }
  }
}
