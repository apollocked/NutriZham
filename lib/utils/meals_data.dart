class Recipe {
  final String title;
  final String image;
  final int calories;
  final List<String> ingredients;
  final List<String> steps;

  Recipe({
    required this.title,
    required this.image,
    required this.calories,
    required this.ingredients,
    required this.steps,
  });
}

final List<Recipe> recipes = [
  Recipe(
    title: 'Grilled Chicken Bowl',
    image:
        'https://bowlsarethenewplates.com/wp-content/uploads/2021/03/harissa-chicken-1-682x1024.jpg',
    calories: 420,
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
    title: 'Oatmeal with Fruits',
    image: 'https://images.unsplash.com/photo-1517673400267-0251440c45dc',
    calories: 280,
    ingredients: ['Oats', 'Milk or water', 'Banana', 'Berries', 'Honey'],
    steps: [
      'Boil oats with milk or water.',
      'Slice fruits.',
      'Mix fruits into oatmeal.',
      'Add honey if desired.',
    ],
  ),
];
