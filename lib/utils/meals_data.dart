enum MealCategory {
  breakfast,
  lunch,
  dinner,
  snack,
}

class NutritionalInfo {
  final int calories;
  final double protein;
  final double carbs;
  final double fats;

  NutritionalInfo({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
  });
}

class Recipe {
  final String id;
  final String title;
  final String image;
  final NutritionalInfo nutrition;
  final List<String> ingredients;
  final List<String> steps;
  final MealCategory category;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.nutrition,
    required this.ingredients,
    required this.steps,
    required this.category,
  });
}

final List<Recipe> recipes = [
  Recipe(
    id: '1',
    title: 'Grilled Chicken Bowl',
    image:
        'https://bowlsarethenewplates.com/wp-content/uploads/2021/03/harissa-chicken-1-682x1024.jpg',
    nutrition: NutritionalInfo(
      calories: 420,
      protein: 35,
      carbs: 45,
      fats: 12,
    ),
    category: MealCategory.lunch,
    ingredients: [
      'Chicken breast',
      'Olive oil',
      'Brown rice',
      'Broccoli',
      'Salt & pepper',
    ],
    steps: [
      'Season chicken with salt and pepper.',
      'Grill chicken until fully cooked.',
      'Cook brown rice.',
      'Steam broccoli.',
      'Serve together in a bowl.',
    ],
  ),
  Recipe(
    id: '2',
    title: 'Oatmeal with Fruits',
    image: 'https://images.unsplash.com/photo-1517673400267-0251440c45dc',
    nutrition: NutritionalInfo(
      calories: 280,
      protein: 8,
      carbs: 52,
      fats: 6,
    ),
    category: MealCategory.breakfast,
    ingredients: ['Oats', 'Milk or water', 'Banana', 'Berries', 'Honey'],
    steps: [
      'Boil oats with milk or water.',
      'Slice fruits.',
      'Mix fruits into oatmeal.',
      'Add honey if desired.',
    ],
  ),
  Recipe(
    id: '3',
    title: 'Salmon with Veggies',
    image: 'https://images.unsplash.com/photo-1485921325833-c519f76c4927',
    nutrition: NutritionalInfo(
      calories: 380,
      protein: 32,
      carbs: 18,
      fats: 22,
    ),
    category: MealCategory.dinner,
    ingredients: [
      'Salmon fillet',
      'Asparagus',
      'Cherry tomatoes',
      'Lemon',
      'Garlic',
      'Olive oil',
    ],
    steps: [
      'Preheat oven to 400°F (200°C).',
      'Season salmon with salt, pepper, and garlic.',
      'Place salmon and vegetables on a baking sheet.',
      'Drizzle with olive oil and lemon juice.',
      'Bake for 15-20 minutes.',
    ],
  ),
  Recipe(
    id: '4',
    title: 'Greek Yogurt Parfait',
    image: 'https://images.unsplash.com/photo-1488477181946-6428a0291777',
    nutrition: NutritionalInfo(
      calories: 220,
      protein: 15,
      carbs: 32,
      fats: 4,
    ),
    category: MealCategory.breakfast,
    ingredients: [
      'Greek yogurt',
      'Granola',
      'Mixed berries',
      'Honey',
      'Chia seeds',
    ],
    steps: [
      'Layer Greek yogurt in a glass or bowl.',
      'Add a layer of granola.',
      'Top with mixed berries.',
      'Drizzle with honey and sprinkle chia seeds.',
    ],
  ),
  Recipe(
    id: '5',
    title: 'Protein Smoothie',
    image: 'https://images.unsplash.com/photo-1505252585461-04db1eb84625',
    nutrition: NutritionalInfo(
      calories: 310,
      protein: 25,
      carbs: 38,
      fats: 8,
    ),
    category: MealCategory.snack,
    ingredients: [
      'Protein powder',
      'Banana',
      'Spinach',
      'Almond milk',
      'Peanut butter',
      'Ice',
    ],
    steps: [
      'Add all ingredients to a blender.',
      'Blend until smooth.',
      'Pour into a glass and enjoy.',
    ],
  ),
  Recipe(
    id: '6',
    title: 'Quinoa Buddha Bowl',
    image: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
    nutrition: NutritionalInfo(
      calories: 395,
      protein: 14,
      carbs: 58,
      fats: 13,
    ),
    category: MealCategory.lunch,
    ingredients: [
      'Quinoa',
      'Chickpeas',
      'Sweet potato',
      'Kale',
      'Avocado',
      'Tahini dressing',
    ],
    steps: [
      'Cook quinoa according to package instructions.',
      'Roast sweet potato and chickpeas.',
      'Massage kale with olive oil.',
      'Assemble bowl with all ingredients.',
      'Drizzle with tahini dressing.',
    ],
  ),
  Recipe(
    id: '7',
    title: 'Turkey Lettuce Wraps',
    image: 'https://images.unsplash.com/photo-1590951735308-c0ce1d22e60c',
    nutrition: NutritionalInfo(
      calories: 265,
      protein: 28,
      carbs: 12,
      fats: 12,
    ),
    category: MealCategory.lunch,
    ingredients: [
      'Ground turkey',
      'Lettuce leaves',
      'Bell peppers',
      'Onion',
      'Soy sauce',
      'Ginger',
    ],
    steps: [
      'Cook ground turkey with onions and peppers.',
      'Add soy sauce and ginger.',
      'Wash and dry lettuce leaves.',
      'Spoon turkey mixture into lettuce leaves.',
      'Wrap and enjoy.',
    ],
  ),
  Recipe(
    id: '8',
    title: 'Baked Sweet Potato',
    image: 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90',
    nutrition: NutritionalInfo(
      calories: 180,
      protein: 4,
      carbs: 41,
      fats: 0.3,
    ),
    category: MealCategory.snack,
    ingredients: [
      'Sweet potato',
      'Cinnamon',
      'Optional: Greek yogurt',
    ],
    steps: [
      'Preheat oven to 400°F (200°C).',
      'Pierce sweet potato with a fork.',
      'Bake for 45-60 minutes until tender.',
      'Sprinkle with cinnamon and top with yogurt if desired.',
    ],
  ),
];
