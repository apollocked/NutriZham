class User {
  final String id;
  final String username;
  final String email;
  final int age;
  final String? profileImage;
  final DateTime createdAt;
  final List<String> favorites;
  final List<String> plannedMeals;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.age,
    this.profileImage,
    required this.createdAt,
    this.favorites = const [],
    this.plannedMeals = const [],
    this.updatedAt,
  });
}
