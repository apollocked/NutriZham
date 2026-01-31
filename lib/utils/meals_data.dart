enum MealCategory {
  breakfast,
  lunch,
  dinner,
  snack,
  bulking,
  cutting,
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

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
    };
  }

  factory NutritionalInfo.fromJson(Map<String, dynamic> json) {
    return NutritionalInfo(
      calories: json['calories'] as int,
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
    );
  }
}

class Recipe {
  final String id;
  final Map<String, String> title;
  final String image;
  final NutritionalInfo nutrition;
  final Map<String, List<String>> ingredients;
  final Map<String, List<String>> steps;
  final MealCategory category;
  double rating; // Average rating
  int ratingCount; // Number of ratings

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.nutrition,
    required this.ingredients,
    required this.steps,
    required this.category,
    this.rating = 0.0,
    this.ratingCount = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'nutrition': nutrition.toJson(),
      'ingredients': ingredients,
      'steps': steps,
      'category': category.toString(),
      'rating': rating,
      'ratingCount': ratingCount,
    };
  }
}

final List<Recipe> recipes = [
  Recipe(
    id: '1',
    title: {
      'en': 'Grilled Chicken Bowl',
      'ku': 'مرگی برژاو لەگەڵ برنج',
    },
    image: 'https://bowlsarethenewplates.com/wp-content/uploads/2021/03/harissa-chicken-1-682x1024.jpg',
    nutrition: NutritionalInfo(calories: 420, protein: 35, carbs: 45, fats: 12),
    category: MealCategory.bulking,
    rating: 4.5,
    ratingCount: 128,
    ingredients: {
      'en': ['Chicken breast', 'Olive oil', 'Brown rice', 'Broccoli', 'Salt & pepper'],
      'ku': ['سنگی مرغ', 'ڕۆنی زەیتوون', 'برنجی قاوەیی', 'بڕۆکلی', 'خوێ و بیبەر'],
    },
    steps: {
      'en': [
        'Season chicken with salt and pepper.',
        'Grill chicken until fully cooked.',
        'Cook brown rice.',
        'Steam broccoli.',
        'Serve together in a bowl.',
      ],
      'ku': [
        'مرغەکە بە خوێ و بیبەر تام بکە.',
        'مرغەکە برژێنە تا تەواو پووخت ببێت.',
        'برنجە قاوەییەکە لێبنێ.',
        'بڕۆکلی بە هەڵم لێبنێ.',
        'هەموویان پێکەوە لە قاپێکدا دابنێ.',
      ],
    },
  ),
  Recipe(
    id: '2',
    title: {
      'en': 'Oatmeal with Fruits',
      'ku': 'جۆ دۆشاو لەگەڵ میوە',
    },
    image: 'https://images.unsplash.com/photo-1517673400267-0251440c45dc',
    nutrition: NutritionalInfo(calories: 280, protein: 8, carbs: 52, fats: 6),
    category: MealCategory.breakfast,
    rating: 4.2,
    ratingCount: 95,
    ingredients: {
      'en': ['Oats', 'Milk or water', 'Banana', 'Berries', 'Honey'],
      'ku': ['جۆی دۆشاو', 'شیر یان ئاو', 'مۆز', 'توومیوە', 'هەنگوین'],
    },
    steps: {
      'en': [
        'Boil oats with milk or water.',
        'Slice fruits.',
        'Mix fruits into oatmeal.',
        'Add honey if desired.',
      ],
      'ku': [
        'جۆدۆشاوەکە لەگەڵ شیر یان ئاو بکوڵێنە.',
        'میوەکان پارچە پارچە بکە.',
        'میوەکان لەگەڵ جۆدۆشاوەکە تێکەڵ بکە.',
        'هەنگوین زیاد بکە بە پێی ئارەزوو.',
      ],
    },
  ),
  Recipe(
    id: '3',
    title: {
      'en': 'Salmon with Veggies',
      'ku': 'ماسی سەلمۆن لەگەڵ سەوزە',
    },
    image: 'https://images.unsplash.com/photo-1485921325833-c519f76c4927',
    nutrition: NutritionalInfo(calories: 380, protein: 32, carbs: 18, fats: 22),
    category: MealCategory.dinner,
    rating: 4.7,
    ratingCount: 156,
    ingredients: {
      'en': ['Salmon fillet', 'Asparagus', 'Cherry tomatoes', 'Lemon', 'Garlic', 'Olive oil'],
      'ku': ['پارچە ماسی سەلمۆن', 'مارچووبە', 'تەماتەی گێلاسی', 'لیمۆ', 'سیر', 'ڕۆنی زەیتوون'],
    },
    steps: {
      'en': [
        'Preheat oven to 400°F (200°C).',
        'Season salmon with salt, pepper, and garlic.',
        'Place salmon and vegetables on a baking sheet.',
        'Drizzle with olive oil and lemon juice.',
        'Bake for 15-20 minutes.',
      ],
      'ku': [
        'تەنوور گەرم بکەرەوە بۆ ٢٠٠ پلەی سەدی.',
        'ماسیەکە بە خوێ و بیبەر و سیر تام بکە.',
        'ماسی و سەوزەکان لەسەر تاسی نانەوا دابنێ.',
        'ڕۆنی زەیتوون و ئاوی لیمۆی بەسەردا بڕێژە.',
        'بۆ ماوەی ١٥-٢٠ خولەک بیبرژێنە.',
      ],
    },
  ),
  Recipe(
    id: '4',
    title: {
      'en': 'Greek Yogurt Parfait',
      'ku': 'ماستی یۆنانی لەگەڵ گرانۆلا',
    },
    image: 'https://images.unsplash.com/photo-1488477181946-6428a0291777',
    nutrition: NutritionalInfo(calories: 220, protein: 15, carbs: 32, fats: 4),
    category: MealCategory.breakfast,
    rating: 4.3,
    ratingCount: 87,
    ingredients: {
      'en': ['Greek yogurt', 'Granola', 'Mixed berries', 'Honey', 'Chia seeds'],
      'ku': ['ماستی یۆنانی', 'گرانۆلا', 'توومیوەی جۆراوجۆر', 'هەنگوین', 'تۆوی چیا'],
    },
    steps: {
      'en': [
        'Layer Greek yogurt in a glass or bowl.',
        'Add a layer of granola.',
        'Top with mixed berries.',
        'Drizzle with honey and sprinkle chia seeds.',
      ],
      'ku': [
        'ماستی یۆنانی لە گڵاسێک یان قاپێکدا چینێک دروست بکە.',
        'چینێک گرانۆلا زیاد بکە.',
        'توومیوەکانی بەسەرەوە دابنێ.',
        'هەنگوین و تۆوی چیای بەسەردا بڕێژە.',
      ],
    },
  ),
  Recipe(
    id: '5',
    title: {
      'en': 'Protein Smoothie',
      'ku': 'خواردنەوەی پڕۆتین',
    },
    image: 'https://images.unsplash.com/photo-1505252585461-04db1eb84625',
    nutrition: NutritionalInfo(calories: 310, protein: 25, carbs: 38, fats: 8),
    category: MealCategory.bulking,
    rating: 4.6,
    ratingCount: 142,
    ingredients: {
      'en': ['Protein powder', 'Banana', 'Spinach', 'Almond milk', 'Peanut butter', 'Ice'],
      'ku': ['تۆزی پڕۆتین', 'مۆز', 'سپێناخ', 'شیری بادەم', 'کەرەی کاکوێلە', 'سەهۆڵ'],
    },
    steps: {
      'en': [
        'Add all ingredients to a blender.',
        'Blend until smooth.',
        'Pour into a glass and enjoy.',
      ],
      'ku': [
        'هەموو پێکهاتەکان بخەرە ناو مکسەرەوە.',
        'باش تێکەڵیان بکە تا نەرم ببێت.',
        'بیکەرە ناو گڵاسێکەوە و چێژ لێوەربگرە.',
      ],
    },
  ),
  Recipe(
    id: '6',
    title: {
      'en': 'Quinoa Buddha Bowl',
      'ku': 'قاپی کینۆا',
    },
    image: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
    nutrition: NutritionalInfo(calories: 395, protein: 14, carbs: 58, fats: 13),
    category: MealCategory.lunch,
    rating: 4.4,
    ratingCount: 103,
    ingredients: {
      'en': ['Quinoa', 'Chickpeas', 'Sweet potato', 'Kale', 'Avocado', 'Tahini dressing'],
      'ku': ['کینۆا', 'نۆک', 'پەتاتەی شیرین', 'کەڵەرم', 'ئەڤۆکادۆ', 'سۆسی تەحینی'],
    },
    steps: {
      'en': [
        'Cook quinoa according to package instructions.',
        'Roast sweet potato and chickpeas.',
        'Massage kale with olive oil.',
        'Assemble bowl with all ingredients.',
        'Drizzle with tahini dressing.',
      ],
      'ku': [
        'کینۆاکە بە پێی ڕێنماییەکان لێبنێ.',
        'پەتاتەی شیرین و نۆکەکە برژێنە.',
        'کەڵەرمەکە بە ڕۆنی زەیتوون مالش بدە.',
        'قاپەکە لەگەڵ هەموو پێکهاتەکان ئامادە بکە.',
        'سۆسی تەحینی بەسەردا بڕێژە.',
      ],
    },
  ),
  Recipe(
    id: '7',
    title: {
      'en': 'Turkey Lettuce Wraps',
      'ku': 'بوقچەی بووقەڵەموون و تووک',
    },
    image: 'https://images.unsplash.com/photo-1590951735308-c0ce1d22e60c',
    nutrition: NutritionalInfo(calories: 265, protein: 28, carbs: 12, fats: 12),
    category: MealCategory.cutting,
    rating: 4.1,
    ratingCount: 76,
    ingredients: {
      'en': ['Ground turkey', 'Lettuce leaves', 'Bell peppers', 'Onion', 'Soy sauce', 'Ginger'],
      'ku': ['گۆشتی تووکی هاڕاو', 'گەڵای بوقەڵەموون', 'دڵۆپی رەنگاوڕەنگ', 'پیاز', 'سۆسی سۆیا', 'زەنجەفیل'],
    },
    steps: {
      'en': [
        'Cook ground turkey with onions and peppers.',
        'Add soy sauce and ginger.',
        'Wash and dry lettuce leaves.',
        'Spoon turkey mixture into lettuce leaves.',
        'Wrap and enjoy.',
      ],
      'ku': [
        'گۆشتی تووک لەگەڵ پیاز و دڵۆپ برژێنە.',
        'سۆسی سۆیا و زەنجەفیل زیاد بکە.',
        'گەڵای بوقەڵەموون بشۆرەوە و وشکی بکەرەوە.',
        'تێکەڵی تووکەکە بخەرە ناو گەڵاکانەوە.',
        'بیپێچەوە و چێژ لێوەربگرە.',
      ],
    },
  ),
  Recipe(
    id: '8',
    title: {
      'en': 'Baked Sweet Potato',
      'ku': 'پەتاتەی شیرینی برژاو',
    },
    image: 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90',
    nutrition: NutritionalInfo(calories: 180, protein: 4, carbs: 41, fats: 0.3),
    category: MealCategory.snack,
    rating: 4.0,
    ratingCount: 64,
    ingredients: {
      'en': ['Sweet potato', 'Cinnamon', 'Optional: Greek yogurt'],
      'ku': ['پەتاتەی شیرین', 'دارچین', 'دڵخواز: ماستی یۆنانی'],
    },
    steps: {
      'en': [
        'Preheat oven to 400°F (200°C).',
        'Pierce sweet potato with a fork.',
        'Bake for 45-60 minutes until tender.',
        'Sprinkle with cinnamon and top with yogurt if desired.',
      ],
      'ku': [
        'تەنوور گەرم بکەرەوە بۆ ٢٠٠ پلەی سەدی.',
        'پەتاتەکە بە چەنگاڵێک کون بکە.',
        'بۆ ٤٥-٦٠ خولەک برژێنە تا نەرم ببێت.',
        'دارچین بەسەردا بڕێژە و ماستیش زیاد بکە بە پێی ئارەزوو.',
      ],
    },
  ),
  Recipe(
    id: '9',
    title: {
      'en': 'Egg White Omelette',
      'ku': 'ئۆملێتی سپێڵکی هێلکە',
    },
    image: 'https://images.unsplash.com/photo-1608039829572-78524f79c4c7',
    nutrition: NutritionalInfo(calories: 180, protein: 22, carbs: 8, fats: 6),
    category: MealCategory.cutting,
    rating: 4.3,
    ratingCount: 91,
    ingredients: {
      'en': ['Egg whites', 'Spinach', 'Mushrooms', 'Tomatoes', 'Low-fat cheese'],
      'ku': ['سپێڵکی هێلکە', 'سپێناخ', 'تڵۆپەڵۆ', 'تەماتە', 'پەنیری کەم چەوری'],
    },
    steps: {
      'en': [
        'Beat egg whites in a bowl.',
        'Sauté vegetables in a pan.',
        'Pour egg whites over vegetables.',
        'Cook until set, add cheese.',
        'Fold and serve.',
      ],
      'ku': [
        'سپێڵکەکان لە قاپێکدا لێبدە.',
        'سەوزەکان لە تاوەیەکدا برژێنە.',
        'سپێڵکەکان بەسەر سەوزەکاندا بڕێژە.',
        'لێبنێ تا قایم ببێت، پەنیر زیاد بکە.',
        'بیپێچەوە و دایبڕێژە.',
      ],
    },
  ),
  Recipe(
    id: '10',
    title: {
      'en': 'Mass Gainer Shake',
      'ku': 'شەیکی زیادکردنی قەبارە',
    },
    image: 'https://images.unsplash.com/photo-1622484211979-7d6ac035e1dd',
    nutrition: NutritionalInfo(calories: 650, protein: 40, carbs: 85, fats: 18),
    category: MealCategory.bulking,
    rating: 4.8,
    ratingCount: 187,
    ingredients: {
      'en': ['Protein powder', 'Oats', 'Banana', 'Peanut butter', 'Whole milk', 'Honey'],
      'ku': ['تۆزی پڕۆتین', 'جۆی دۆشاو', 'مۆز', 'کەرەی کاکوێلە', 'شیری تەواو', 'هەنگوین'],
    },
    steps: {
      'en': [
        'Add all ingredients to blender.',
        'Blend on high for 1-2 minutes.',
        'Add ice if desired.',
        'Drink immediately post-workout.',
      ],
      'ku': [
        'هەموو پێکهاتەکان بخەرە ناو مکسەرەوە.',
        'بۆ ١-٢ خولەک بە خێرایی تێکەڵیان بکە.',
        'سەهۆڵ زیاد بکە بە پێی ئارەزوو.',
        'دوای ڕاهێنان یەکسەر بیخۆرەوە.',
      ],
    },
  ),
];
