import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrizham/data/models/meals_data.dart';

class RecipeDatasource {
  static Future<List<Recipe>> getRecipes({
    String? lastRecipeTitle,
    int limit = 25,
  }) async {
    Query query = FirebaseFirestore.instance
        .collection('recipes')
        .orderBy('title')
        .limit(limit);
    if (lastRecipeTitle != null) {
      query = query.startAfter([lastRecipeTitle]);
    }
    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => Recipe.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  static Future<List<Recipe>> getAllRecipes() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('recipes').get();
    return snapshot.docs.map((doc) => Recipe.fromJson(doc.data())).toList();
  }

  static Future<List<Recipe>> searchRecipes(String query) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('recipes')
        .orderBy('title')
        .startAt([query]).endAt(['$query\uf8ff']).get();
    return snapshot.docs.map((doc) => Recipe.fromJson(doc.data())).toList();
  }

  static Future<List<Recipe>> getRecipesByCategory(
      MealCategory category) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('recipes')
        .where('category', isEqualTo: category.name)
        .get();
    return snapshot.docs.map((doc) => Recipe.fromJson(doc.data())).toList();
  }

  static Future<Recipe?> getRecipeById(String id) async {
    final doc =
        await FirebaseFirestore.instance.collection('recipes').doc(id).get();
    if (!doc.exists) return null;
    return Recipe.fromJson(doc.data() as Map<String, dynamic>);
  }

  static Stream<List<Recipe>> streamRecipesByIds(List<String> ids) {
    if (ids.isEmpty) return Stream.value([]);
    return FirebaseFirestore.instance
        .collection('recipes')
        .where(FieldPath.documentId, whereIn: ids)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Recipe.fromJson(doc.data())).toList());
  }
}
