class MealPlanEntry {
  final String recipeId;
  final String slot;
  final int order;

  const MealPlanEntry({
    required this.recipeId,
    required this.slot,
    this.order = 0,
  });

  Map<String, dynamic> toJson() => {
        'recipeId': recipeId,
        'slot': slot,
        'order': order,
      };

  factory MealPlanEntry.fromJson(Map<String, dynamic> json) => MealPlanEntry(
        recipeId: json['recipeId'] as String? ?? '',
        slot: json['slot'] as String? ?? 'breakfast',
        order: (json['order'] as num?)?.toInt() ?? 0,
      );
}
