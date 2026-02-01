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
  final String icon; // Changed from image to icon
  final NutritionalInfo nutrition;
  final Map<String, List<String>> ingredients;
  final Map<String, List<String>> steps;
  final MealCategory category;
  double rating; // Average rating
  int ratingCount; // Number of ratings

  Recipe({
    required this.id,
    required this.title,
    required this.icon, // Changed from image to icon
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
      'icon': icon, // Changed from image to icon
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
    title: {'en': 'Grilled Chicken', 'ku': 'مریشکی برژاو'},
    icon: '🍗',
    nutrition: NutritionalInfo(calories: 450, protein: 40, carbs: 5, fats: 25),
    category: MealCategory.bulking,
    rating: 4.8,
    ratingCount: 210,
    ingredients: {
      'en': [
        'Whole chicken',
        'Lemon juice',
        'Garlic',
        'Yogurt',
        'Olive oil',
        'Kurdish spices'
      ],
      'ku': [
        'مریشک',
        'ئاوی لیمۆ',
        'سیر',
        'ماست',
        'ڕۆنی زەیتوون',
        'بەهاراتی کوردی'
      ],
    },
    steps: {
      'en': [
        '1. Marinate chicken with yogurt, garlic, and spices for 4 hours.',
        '2. Grill over charcoal until skin is crispy and meat is juicy.'
      ],
      'ku': [
        '١. مریشکەکە لەناو ماست و سیر و بەهاراتدا بخوسێنە بۆ ٤ کاتژمێر.',
        '٢. لەسەر خەڵوز بیبرژێنە تا ڕەنگی ئاڵ دەبێت.'
      ],
    },
  ),

  Recipe(
    id: '2',
    title: {'en': 'Dolma', 'ku': 'دۆڵمە'},
    icon: '🍇',
    nutrition: NutritionalInfo(calories: 550, protein: 22, carbs: 65, fats: 18),
    category: MealCategory.dinner,
    rating: 4.9,
    ratingCount: 520,
    ingredients: {
      'en': [
        'Swiss chard or grape leaves',
        'Eggplants',
        'Onions',
        'Rice',
        'Ground meat',
        'Sumac'
      ],
      'ku': [
        'گەڵاوی مێو یان سڵق',
        'باینجان',
        'پیاز',
        'برنج',
        'گۆشتی هاڕاو',
        'سماق'
      ],
    },
    steps: {
      'en': [
        '1. Mix rice with meat, spices, and sumac.',
        '2. Stuff vegetables and wrap leaves.',
        '3. Cook in a large pot with lemon juice.'
      ],
      'ku': [
        '١. برنج و گۆشت و بەهارات و سماق تێکەڵ بکە.',
        '٢. سەوزەکان پڕ بکە و گەڵاکان بپێچەرەوە.',
        '٣. لەناو مەنجەڵێکی گەورەدا لێیبنێ.'
      ],
    },
  ),

  Recipe(
    id: '3',
    title: {'en': 'Kofta (Meatballs)', 'ku': 'کۆفتە'},
    icon: '🧆',
    nutrition: NutritionalInfo(calories: 480, protein: 35, carbs: 12, fats: 30),
    category: MealCategory.lunch,
    rating: 4.7,
    ratingCount: 185,
    ingredients: {
      'en': ['Ground beef', 'Parsley', 'Onion', 'Black pepper', 'Breadcrumbs'],
      'ku': ['گۆشتی هاڕاو', 'جەعفەری', 'پیاز', 'بیبەری ڕەش', 'پاتاتە'],
    },
    steps: {
      'en': [
        '1. Mix meat with minced parsley and onions.',
        '2. Shape into balls or ovals.',
        '3. Fry or grill until brown.'
      ],
      'ku': [
        '١. گۆشتەکە لەگەڵ جەعفەری و پیاز تێکەڵ بکە.',
        '٢. بیکە بە شێوەی تۆپی بچووک.',
        '٣. سووری بکەرەوە یان بیبرژێنە.'
      ],
    },
  ),

  Recipe(
    id: '4',
    title: {'en': 'Sar w Pe (Pacha)', 'ku': 'سەروپێ'},
    icon: '🍲',
    nutrition: NutritionalInfo(calories: 850, protein: 55, carbs: 10, fats: 60),
    category: MealCategory.bulking,
    rating: 4.9,
    ratingCount: 340,
    ingredients: {
      'en': ['Lamb head and trotters', 'Garlic', 'Lemon', 'Spices'],
      'ku': ['سەروپێی بەرخ', 'سیر', 'لیمۆ', 'بەهارات'],
    },
    steps: {
      'en': [
        '1. Clean the parts thoroughly.',
        '2. Slow-cook for 6-8 hours with garlic until tender.',
        '3. Serve with bread soaked in the broth.'
      ],
      'ku': [
        '١. سەروپێیەکە بە باشی پاک بکەرەوە.',
        '٢. بۆ ماوەی ٦-٨ کاتژمێر بکوڵێنە تا تەواو نەرم دەبێت.',
        '٣. لەگەڵ نان پێشکەشی بکە.'
      ],
    },
  ),

  Recipe(
    id: '5',
    title: {'en': 'Qaymax', 'ku': 'قەیماغ'},
    icon: '🥣',
    nutrition: NutritionalInfo(calories: 400, protein: 5, carbs: 10, fats: 38),
    category: MealCategory.breakfast,
    rating: 4.8,
    ratingCount: 125,
    ingredients: {
      'en': ['Heavy buffalo cream', 'Honey', 'Fresh bread'],
      'ku': ['قەیماغی سروشتی', 'هەنگوین', 'نانی تازە'],
    },
    steps: {
      'en': [
        '1. Serve fresh cream with a drizzle of honey.',
        '2. Pair with traditional Kurdish naan.'
      ],
      'ku': [
        '١. قەیماغەکە لەگەڵ هەنگوین ئامادە بکە.',
        '٢. لەگەڵ نانی گەرم بیخۆ.'
      ],
    },
  ),

  // Additional Recipes (6-27) following the same logic:
  Recipe(
    id: '6',
    title: {'en': 'Kurdish Biryani', 'ku': 'بریانی کوردی'},
    icon: '🍛',
    nutrition: NutritionalInfo(calories: 620, protein: 25, carbs: 80, fats: 20),
    category: MealCategory.lunch,
    rating: 4.8,
    ingredients: {
      'en': ['Rice', 'Meat', 'Potatoes', 'Peas', 'Raisins'],
      'ku': ['برنج', 'گۆشت', 'پەتاتە', 'پۆتکە', 'مێوژ']
    },
    steps: {
      'en': ['Mix rice with spices and fried ingredients.'],
      'ku': ['برنجەکە لەگەڵ کەرەستە سوورکراوەکان تێکەڵ بکە.']
    },
  ),

  Recipe(
    id: '7',
    title: {'en': 'Potato Kubba', 'ku': 'کوبەی پەتاتە'},
    icon: '🍘',
    nutrition: NutritionalInfo(calories: 320, protein: 12, carbs: 45, fats: 10),
    category: MealCategory.snack,
    ingredients: {
      'en': ['Mashed potatoes', 'Ground meat', 'Spices'],
      'ku': ['پەتاتەی کوتراو', 'گۆشتی هاڕاو', 'بەهارات']
    },
    steps: {
      'en': ['Stuff potato dough with meat and fry.'],
      'ku': ['هەویری پەتاتەکە بە گۆشت پڕ بکە و سووری بکەرەوە.']
    },
  ),

  Recipe(
    id: '8',
    title: {'en': 'Meat Tashreeb', 'ku': 'تەشیریبی گۆشت'},
    icon: '🥘',
    nutrition: NutritionalInfo(calories: 600, protein: 45, carbs: 40, fats: 30),
    category: MealCategory.lunch,
    ingredients: {
      'en': ['Lamb', 'Bread', 'Onion', 'Broth'],
      'ku': ['گۆشتی بەرخ', 'نان', 'پیاز', 'ئاوی گۆشت']
    },
    steps: {
      'en': ['Boil meat and pour broth over bread.'],
      'ku': ['گۆشتەکە بکوڵێنە و ئاوەکەی بکە بەسەر ناندا.']
    },
  ),

  Recipe(
    id: '9',
    title: {'en': 'Lentil Soup', 'ku': 'شۆربای نیسک'},
    icon: '🥣',
    nutrition: NutritionalInfo(calories: 210, protein: 12, carbs: 30, fats: 4),
    category: MealCategory.cutting,
    ingredients: {
      'en': ['Red lentils', 'Onion', 'Cumin'],
      'ku': ['نیسکی سوور', 'پیاز', 'کەمون']
    },
    steps: {
      'en': ['Boil lentils with onions and blend.'],
      'ku': ['نیسکەکە لەگەڵ پیاز بکوڵێنە و بیهاڕە.']
    },
  ),

  Recipe(
    id: '10',
    title: {'en': 'Kurdish Salad', 'ku': 'زەڵاتەی کوردی'},
    icon: '🥗',
    nutrition: NutritionalInfo(calories: 90, protein: 2, carbs: 10, fats: 5),
    category: MealCategory.cutting,
    ingredients: {
      'en': ['Cucumber', 'Tomato', 'Onion', 'Lemon'],
      'ku': ['خەیار', 'تەماتە', 'پیاز', 'لیمۆ']
    },
    steps: {
      'en': ['Chop veggies and mix with lemon juice.'],
      'ku': ['سەوزەکان ورد بکە و لیمۆی تێبکە.']
    },
  ),

  Recipe(
    id: '11',
    title: {'en': 'White Rice', 'ku': 'برنجی سپی'},
    icon: '🍚',
    nutrition: NutritionalInfo(calories: 350, protein: 6, carbs: 70, fats: 5),
    category: MealCategory.lunch,
    ingredients: {
      'en': ['Basmati rice', 'Oil', 'Salt'],
      'ku': ['برنج', 'ڕۆن', 'خوێ']
    },
    steps: {
      'en': ['Steam rice until fluffy.'],
      'ku': ['برنجەکە لێبنێ تا دەکوڵێت.']
    },
  ),

  Recipe(
    id: '12',
    title: {'en': 'Shakshuka', 'ku': 'شەکشوکە'},
    icon: '🍳',
    nutrition: NutritionalInfo(calories: 280, protein: 18, carbs: 10, fats: 18),
    category: MealCategory.breakfast,
    ingredients: {
      'en': ['Eggs', 'Tomato', 'Green pepper'],
      'ku': ['هێلکە', 'تەماتە', 'بیبەر']
    },
    steps: {
      'en': ['Cook eggs in tomato sauce.'],
      'ku': ['هێلکەکە لەگەڵ تەماتە بکوڵێنە.']
    },
  ),

  Recipe(
    id: '13',
    title: {'en': 'Honey & Butter', 'ku': 'هەنگوین و کەرە'},
    icon: '🍯',
    nutrition: NutritionalInfo(calories: 320, protein: 1, carbs: 40, fats: 18),
    category: MealCategory.breakfast,
    ingredients: {
      'en': ['Natural honey', 'Butter'],
      'ku': ['هەنگوین', 'کەرە']
    },
    steps: {
      'en': ['Mix and serve with warm bread.'],
      'ku': ['تێکەڵیان بکە و لەگەڵ نان بیخۆ.']
    },
  ),

  Recipe(
    id: '14',
    title: {'en': 'Kurdish Naan', 'ku': 'نانی کوردی'},
    icon: '🫓',
    nutrition: NutritionalInfo(calories: 260, protein: 7, carbs: 50, fats: 3),
    category: MealCategory.breakfast,
    ingredients: {
      'en': ['Flour', 'Yeast', 'Water'],
      'ku': ['ئارد', 'هەویرترش', 'ئاو']
    },
    steps: {
      'en': ['Bake in a traditional tandoor.'],
      'ku': ['لەناو تەنوردا بیبرژێنە.']
    },
  ),

  Recipe(
    id: '15',
    title: {'en': 'Masgouf (Fish)', 'ku': 'مەسگوف'},
    icon: '🐟',
    nutrition: NutritionalInfo(calories: 400, protein: 45, carbs: 0, fats: 20),
    category: MealCategory.dinner,
    ingredients: {
      'en': ['Carp fish', 'Salt', 'Tamarind'],
      'ku': ['ماسی', 'خوێ', 'تەمر هیندی']
    },
    steps: {
      'en': ['Grill fish slowly over open fire.'],
      'ku': ['ماسییەکە لەسەر ئاگر ببرژێنە.']
    },
  ),

  Recipe(
    id: '16',
    title: {'en': 'Kutilk (Boiled Kubba)', 'ku': 'کوتلک'},
    icon: '🥟',
    nutrition: NutritionalInfo(calories: 450, protein: 20, carbs: 55, fats: 15),
    category: MealCategory.lunch,
    ingredients: {
      'en': ['Bulgur', 'Meat', 'Onion'],
      'ku': ['بڕوێش', 'گۆشت', 'پیاز']
    },
    steps: {
      'en': ['Boil stuffed bulgur shells.'],
      'ku': ['کوبەکان لەناو ئاودا بکوڵێنە.']
    },
  ),

  Recipe(
    id: '17',
    title: {'en': 'Yaprak', 'ku': 'یاپراخ'},
    icon: '🥗',
    nutrition: NutritionalInfo(calories: 480, protein: 15, carbs: 70, fats: 12),
    category: MealCategory.dinner,
    ingredients: {
      'en': ['Grape leaves', 'Rice', 'Herbs'],
      'ku': ['گەڵاوی مێو', 'برنج', 'سەوزە']
    },
    steps: {
      'en': ['Wrap rice in leaves and steam.'],
      'ku': ['برنجەکە بپێچەرەوە و لێیبنێ.']
    },
  ),

  Recipe(
    id: '18',
    title: {'en': 'Shish Tawook', 'ku': 'شیش تاووق'},
    icon: '🍢',
    nutrition: NutritionalInfo(calories: 380, protein: 40, carbs: 5, fats: 15),
    category: MealCategory.dinner,
    ingredients: {
      'en': ['Chicken breast', 'Garlic', 'Yogurt'],
      'ku': ['سنگی مریشک', 'سیر', 'ماست']
    },
    steps: {
      'en': ['Grill skewered chicken pieces.'],
      'ku': ['مریشکەکە بە شیش ببرژێنە.']
    },
  ),

  Recipe(
    id: '19',
    title: {'en': 'Beef Shawarma', 'ku': 'گەسی گۆشت'},
    icon: '🥙',
    nutrition: NutritionalInfo(calories: 520, protein: 35, carbs: 30, fats: 28),
    category: MealCategory.lunch,
    ingredients: {
      'en': ['Beef', 'Tahini', 'Bread'],
      'ku': ['گۆشت', 'تەحین', 'نان']
    },
    steps: {
      'en': ['Slice meat thinly and grill.'],
      'ku': ['گۆشتەکە بە تەنکی ببڕە و سووری بکەرەوە.']
    },
  ),

  Recipe(
    id: '20',
    title: {'en': 'Mutabal', 'ku': 'موتەبەل'},
    icon: '🍆',
    nutrition: NutritionalInfo(calories: 160, protein: 4, carbs: 10, fats: 12),
    category: MealCategory.snack,
    ingredients: {
      'en': ['Eggplant', 'Tahini', 'Garlic'],
      'ku': ['باینجان', 'تەحین', 'سیر']
    },
    steps: {
      'en': ['Mash roasted eggplant with tahini.'],
      'ku': ['باینجانە برژاوەکە لەگەڵ تەحین تێکەڵ بکە.']
    },
  ),

  Recipe(
    id: '21',
    title: {'en': 'Tabbouleh', 'ku': 'تەبولە'},
    icon: '🥗',
    nutrition: NutritionalInfo(calories: 140, protein: 3, carbs: 18, fats: 8),
    category: MealCategory.snack,
    ingredients: {
      'en': ['Parsley', 'Bulgur', 'Tomato'],
      'ku': ['جەعفەری', 'بڕوێش', 'تەماتە']
    },
    steps: {
      'en': ['Finely chop parsley and mix.'],
      'ku': ['جەعفەرییەکە ورد بکە و تێکەڵی بکە.']
    },
  ),

  Recipe(
    id: '22',
    title: {'en': 'Fattoush', 'ku': 'فەتوش'},
    icon: '🥗',
    nutrition: NutritionalInfo(calories: 180, protein: 4, carbs: 25, fats: 7),
    category: MealCategory.snack,
    ingredients: {
      'en': ['Lettuce', 'Fried bread', 'Sumac'],
      'ku': ['خاس', 'نانی سوورکراوە', 'سماق']
    },
    steps: {
      'en': ['Mix salad with toasted bread.'],
      'ku': ['زەڵاتەکە لەگەڵ نان تێکەڵ بکە.']
    },
  ),

  Recipe(
    id: '23',
    title: {'en': 'Lobia (Black Eyed Peas)', 'ku': 'شۆربای لۆبیا'},
    icon: '🥘',
    nutrition: NutritionalInfo(calories: 310, protein: 18, carbs: 45, fats: 3),
    category: MealCategory.lunch,
    ingredients: {
      'en': ['Black-eyed peas', 'Tomato paste'],
      'ku': ['لۆبیا', 'دۆشاو']
    },
    steps: {
      'en': ['Boil peas in tomato sauce.'],
      'ku': ['لۆبیاکە لەناو ئاوی تەماتەدا بکوڵێنە.']
    },
  ),

  Recipe(
    id: '24',
    title: {'en': 'Aruk (Kurdish Patty)', 'ku': 'عەروک'},
    icon: '🥯',
    nutrition: NutritionalInfo(calories: 280, protein: 10, carbs: 35, fats: 12),
    category: MealCategory.snack,
    ingredients: {
      'en': ['Vegetables', 'Flour', 'Meat'],
      'ku': ['سەوزە', 'ئارد', 'گۆشت']
    },
    steps: {
      'en': ['Fry mixed vegetable/meat patties.'],
      'ku': ['سەوزە و گۆشتەکە سوور بکەرەوە.']
    },
  ),

  Recipe(
    id: '25',
    title: {'en': 'Burghul with Vermicelli', 'ku': 'بڕوێش بە شەعریە'},
    icon: '🍚',
    nutrition: NutritionalInfo(calories: 330, protein: 8, carbs: 65, fats: 5),
    category: MealCategory.lunch,
    ingredients: {
      'en': ['Bulgur', 'Vermicelli', 'Oil'],
      'ku': ['بڕوێش', 'شەعریە', 'ڕۆن']
    },
    steps: {
      'en': ['Cook bulgur with toasted noodles.'],
      'ku': ['بڕوێشەکە لەگەڵ شەعریە لێبنێ.']
    },
  ),

  Recipe(
    id: '26',
    title: {'en': 'Chicken Soup', 'ku': 'شۆربای مریشک'},
    icon: '🍲',
    nutrition: NutritionalInfo(calories: 250, protein: 28, carbs: 10, fats: 10),
    category: MealCategory.lunch,
    ingredients: {
      'en': ['Chicken', 'Onion', 'Spices'],
      'ku': ['مریشک', 'پیاز', 'بەهارات']
    },
    steps: {
      'en': ['Boil chicken until broth is rich.'],
      'ku': ['مریشکەکە بکوڵێنە تا ئاوەکەی خەست دەبێتەوە.']
    },
  ),

  Recipe(
    id: '27',
    title: {'en': 'Baklava', 'ku': 'بەقلاوە'},
    icon: '🥮',
    nutrition: NutritionalInfo(calories: 450, protein: 6, carbs: 55, fats: 25),
    category: MealCategory.snack,
    ingredients: {
      'en': ['Phyllo', 'Pistachio', 'Syrup'],
      'ku': ['هەویر', 'فستق', 'شیلە']
    },
    steps: {
      'en': ['Layer pastry with nuts and bake.'],
      'ku': ['هەویر و فستقەکە ببرژێنە و شیلەی پێدا بکە.']
    },
  ),
  Recipe(
    id: '28',
    title: {'en': 'Parda Polaw (Curtain Rice)', 'ku': 'پەردە پڵاو'},
    icon: '🥧',
    nutrition: NutritionalInfo(calories: 680, protein: 28, carbs: 85, fats: 25),
    category: MealCategory.dinner,
    rating: 4.9,
    ratingCount: 142,
    ingredients: {
      'en': [
        'Phyllo dough',
        'Basmati rice',
        'Chicken',
        'Almonds',
        'Raisins',
        'Peas',
        'Biryani spices'
      ],
      'ku': [
        'پەردەی هەویر',
        'برنجی بەسمەتی',
        'مریشک',
        'بادەم',
        'مێوژ',
        'پۆتکە',
        'بەهاراتی بریانی'
      ],
    },
    steps: {
      'en': [
        '1. Cook rice with biryani spices until 80% done.',
        '2. Boil/fry meat and sauté nuts separately.',
        '3. Line a pot with dough, fill with the rice/meat mix, and seal.',
        '4. Bake until the "curtain" crust is golden and crispy.',
      ],
      'ku': [
        '١. برنجەکە بە بەهاراتی بریانی لێبنێ.',
        '٢. گۆشت و چەرەزەکان بە جیا سوور بکەرەوە.',
        '٣. ناو مەنجەڵێک بە هەویر داپۆشە و برنجەکەی تێبکە و دایبخە.',
        '٤. بیخە ناو فڕن تا هەویرەکە دەبرژێت.',
      ],
    },
  ),

  Recipe(
    id: '29',
    title: {'en': 'Bamia (Okra Stew)', 'ku': 'شۆربای بامیە'},
    icon: '🥘',
    nutrition: NutritionalInfo(calories: 410, protein: 32, carbs: 15, fats: 22),
    category: MealCategory.lunch,
    rating: 4.8,
    ratingCount: 310,
    ingredients: {
      'en': [
        'Fresh okra',
        'Lamb shanks',
        'Garlic',
        'Tomato paste',
        'Lemon juice'
      ],
      'ku': ['بامیەی تازە', 'گۆشتی بەرخ', 'سیر', 'دۆشاوی تەماتە', 'ئاوی لیمۆ'],
    },
    steps: {
      'en': [
        '1. Sauté lamb with garlic until browned, then boil until tender.',
        '2. Fry okra lightly, then add to the meat broth with tomato paste.',
        '3. Simmer until the sauce is thick and okra is soft.',
      ],
      'ku': [
        '١. گۆشت و سیرەکە سوور بکەرەوە و بکوڵێنە.',
        '٢. بامیەکە کەمێک سوور بکەرەوە و لەگەڵ دۆشاو تێکەڵی ئاوی گۆشتەکە بکە.',
        '٣. لێبگەڕێ بکوڵێت تا تەواو خەست دەبێتەوە.',
      ],
    },
  ),

  Recipe(
    id: '30',
    title: {'en': 'Kurdish Kulacha', 'ku': 'کولێرە یان کولێچە'},
    icon: '🍪',
    nutrition: NutritionalInfo(calories: 250, protein: 4, carbs: 35, fats: 12),
    category: MealCategory.snack,
    ingredients: {
      'en': [
        'Flour',
        'Butter',
        'Date paste',
        'Walnuts',
        'Cardamom',
        'Nigella seeds'
      ],
      'ku': ['ئارد', 'کەرە', 'دەڕەکی خورما', 'گوێز', 'هێل', 'کەوەرە'],
    },
    steps: {
      'en': [
        '1. Create a soft dough from flour, butter, and cardamom.',
        '2. Fill dough balls with date paste or crushed walnuts.',
        '3. Press with mold, brush with egg, and bake until golden.',
      ],
      'ku': [
        '١. هەویرێکی نەرم لە ئارد و کەرە دروست بکە.',
        '٢. ناوەکەی بە خورما یان گوێز پڕ بکەرەوە.',
        '٣. قاڵبی لێبدە و بیخە فڕن تا دەبرژێت.',
      ],
    },
  ),

  Recipe(
    id: '31',
    title: {'en': 'Fasolia (White Bean Stew)', 'ku': 'شۆربای فاسۆلیا'},
    icon: '🍲',
    nutrition: NutritionalInfo(calories: 380, protein: 28, carbs: 45, fats: 12),
    category: MealCategory.lunch,
    ingredients: {
      'en': ['Dry white beans', 'Lamb chunks', 'Tomato paste', 'Dried lime'],
      'ku': ['فاسۆلیای وشک', 'گۆشتی بەرخ', 'دۆشاوی تەماتە', 'نوومی بەسرا'],
    },
    steps: {
      'en': [
        '1. Soak beans overnight and boil until soft.',
        '2. Cook lamb until tender, then combine with beans and tomato paste.',
        '3. Simmer until rich and red.',
      ],
      'ku': [
        '١. فاسۆلیاکە بخوسێنە و بکوڵێنە.',
        '٢. گۆشتەکە بکوڵێنە و لەگەڵ دۆشاو و فاسۆلیاکە تێکەڵی بکە.',
        '٣. لێبگەڕێ تا ڕەنگی سوورێکی جوان دەگرێت.',
      ],
    },
  ),

  Recipe(
    id: '32',
    title: {'en': 'Tepsi Baytinjan', 'ku': 'تەپسی باینجان'},
    icon: '🍆',
    nutrition: NutritionalInfo(calories: 450, protein: 25, carbs: 30, fats: 28),
    category: MealCategory.dinner,
    ingredients: {
      'en': ['Eggplants', 'Potatoes', 'Onions', 'Meat patties', 'Tomato sauce'],
      'ku': ['باینجان', 'پەتاتە', 'پیاز', 'شفتە', 'ئاوی تەماتە'],
    },
    steps: {
      'en': [
        '1. Fry sliced veggies and meat patties.',
        '2. Layer them in a tray, pour tomato sauce over, and bake.',
      ],
      'ku': [
        '١. سەوزەکان و شفتەکان سوور بکەرەوە.',
        '٢. لەناو تاسی فڕن ڕیزیان بکە و ئاوی تەماتەی پێدا بکە و بیبرژێنە.',
      ],
    },
  ),

  Recipe(
    id: '33',
    title: {'en': 'Qouzi (Roasted Lamb)', 'ku': 'قۆزی'},
    icon: '🍗',
    nutrition: NutritionalInfo(calories: 720, protein: 45, carbs: 65, fats: 32),
    category: MealCategory.bulking,
    ingredients: {
      'en': ['Lamb shoulder', 'Spiced rice', 'Noodles', 'Nuts'],
      'ku': ['گۆشتی بەرخ', 'برنجی بەهارات', 'شەعریە', 'چەرەزات'],
    },
    steps: {
      'en': [
        '1. Slow-roast lamb for 4 hours.',
        '2. Serve over a bed of spiced vermicelli rice.',
      ],
      'ku': [
        '١. گۆشتەکە بۆ ٤ کاتژمێر ببرژێنە.',
        '٢. لەگەڵ برنجی بەهارات و شەعریە پێشکەشی بکە.',
      ],
    },
  ),

  Recipe(
    id: '34',
    title: {'en': 'Savar (Bulgur Pilaf)', 'ku': 'ساوەر'},
    icon: '🌾',
    nutrition: NutritionalInfo(calories: 320, protein: 10, carbs: 60, fats: 5),
    category: MealCategory.lunch,
    ingredients: {
      'en': ['Coarse bulgur', 'Onion', 'Vermicelli', 'Tomato paste'],
      'ku': ['بڕوێشی زبر', 'پیاز', 'شەعریە', 'دۆشاوی تەماتە'],
    },
    steps: {
      'en': [
        '1. Sauté vermicelli, add bulgur, broth, and tomato paste.',
        '2. Cook until liquid is absorbed.',
      ],
      'ku': [
        '١. شەعریەکە سوور بکەرەوە و ساوەر و دۆشاو و ئاوی مریشکی تێبکە.',
        '٢. لێبگەڕێ تا ئاوەکە هەڵدەمژێت.',
      ],
    },
  ),

  Recipe(
    id: '35',
    title: {'en': 'Hummus', 'ku': 'حومس'},
    icon: '🥣',
    nutrition: NutritionalInfo(calories: 250, protein: 8, carbs: 20, fats: 15),
    category: MealCategory.snack,
    ingredients: {
      'en': ['Chickpeas', 'Tahini', 'Lemon', 'Garlic'],
      'ku': ['نۆک', 'تەحین', 'لیمۆ', 'سیر'],
    },
    steps: {
      'en': [
        '1. Blend cooked chickpeas with tahini and garlic.',
        '2. Top with olive oil.'
      ],
      'ku': ['١. نۆک و تەحین و سیرەکە بلفێنە.', '٢. ڕۆنی زەیتوونی پێدا بکە.'],
    },
  ),

  Recipe(
    id: '36',
    title: {'en': 'Falafel', 'ku': 'فەلافل'},
    icon: '🧆',
    nutrition: NutritionalInfo(calories: 330, protein: 13, carbs: 32, fats: 18),
    category: MealCategory.lunch,
    ingredients: {
      'en': ['Chickpeas', 'Parsley', 'Garlic', 'Spices'],
      'ku': ['نۆک', 'جەعفەری', 'سیر', 'بەهارات'],
    },
    steps: {
      'en': ['1. Grind chickpeas with greens.', '2. Shape and deep fry.'],
      'ku': ['١. نۆک و سەوزەکان بلفێنە.', '٢. خڕی بکە و سووری بکەرەوە.'],
    },
  ),

  Recipe(
    id: '37',
    title: {'en': 'Maqluba', 'ku': 'مەقلوبە'},
    icon: '🥘',
    nutrition: NutritionalInfo(calories: 650, protein: 30, carbs: 75, fats: 25),
    category: MealCategory.dinner,
    ingredients: {
      'en': ['Lamb/Chicken', 'Rice', 'Eggplant', 'Cauliflower'],
      'ku': ['گۆشت', 'برنج', 'باینجان', 'قەنابیت'],
    },
    steps: {
      'en': [
        '1. Fry veggies and meat.',
        '2. Layer meat, veggies, and rice in a pot.',
        '3. Cook and flip upside down onto a tray.',
      ],
      'ku': [
        '١. سەوزە و گۆشتەکە سوور بکەرەوە.',
        '٢. گۆشت و سەوزە و برنجەکە لە مەنجەڵدا ڕیز بکە.',
        '٣. لێیبنێ و پاشان سەرەوژێری بکە بۆ ناو سینی.',
      ],
    },
  ),

  Recipe(
    id: '38',
    title: {'en': 'Baba Ganoush', 'ku': 'بابا غەنووج'},
    icon: '🍆',
    nutrition: NutritionalInfo(calories: 180, protein: 3, carbs: 12, fats: 14),
    category: MealCategory.snack,
    ingredients: {
      'en': ['Roasted eggplant', 'Tahini', 'Lemon juice', 'Garlic'],
      'ku': ['باینجانی برژاو', 'تەحین', 'ئاوی لیمۆ', 'سیر'],
    },
    steps: {
      'en': ['1. Mash roasted eggplant.', '2. Mix with tahini and garlic.'],
      'ku': [
        '١. باینجانە برژاوەکە بپلیشێنەرەوە.',
        '٢. لەگەڵ تەحین و سیر تێکەڵی بکە.'
      ],
    },
  ),

  Recipe(
    id: '39',
    title: {'en': 'Fattoush Salad', 'ku': 'فەتوش'},
    icon: '🥗',
    nutrition: NutritionalInfo(calories: 150, protein: 3, carbs: 18, fats: 8),
    category: MealCategory.snack,
    ingredients: {
      'en': ['Mixed greens', 'Tomato', 'Cucumber', 'Toasted pita', 'Sumac'],
      'ku': ['سەوزەوات', 'تەماتە', 'خەیار', 'نانە سوورکراوە', 'سماق'],
    },
    steps: {
      'en': [
        '1. Chop vegetables.',
        '2. Toss with dressing and crispy pita bread.'
      ],
      'ku': ['١. سەوزەکان ورد بکە.', '٢. سماق و نانە سوورکراوەکەی تێبکە.'],
    },
  ),

  Recipe(
    id: '40',
    title: {'en': 'Tabbouleh', 'ku': 'تەبولە'},
    icon: '🥗',
    nutrition: NutritionalInfo(calories: 140, protein: 2, carbs: 15, fats: 9),
    category: MealCategory.snack,
    ingredients: {
      'en': ['Parsley', 'Bulgur', 'Mint', 'Lemon juice'],
      'ku': ['جەعفەری', 'بڕوێش', 'نەعنا', 'ئاوی لیمۆ'],
    },
    steps: {
      'en': [
        '1. Finely chop parsley and mint.',
        '2. Mix with soaked bulgur and lemon juice.'
      ],
      'ku': [
        '١. جەعفەری و نەعناکە ورد بکە.',
        '٢. لەگەڵ بڕوێش و لیمۆ تێکەڵی بکە.'
      ],
    },
  ),

  Recipe(
    id: '41',
    title: {'en': 'Kunafa', 'ku': 'کونافە'},
    icon: '🥧',
    nutrition: NutritionalInfo(calories: 450, protein: 8, carbs: 60, fats: 22),
    category: MealCategory.snack,
    ingredients: {
      'en': ['Phyllo strands', 'Sweet cheese', 'Syrup', 'Pistachios'],
      'ku': ['تەلی کونافە', 'پەنیر', 'شیرە', 'فستق'],
    },
    steps: {
      'en': [
        '1. Layer dough and cheese.',
        '2. Bake and pour cold syrup over it.'
      ],
      'ku': [
        '١. تەلی کونافە و پەنیرەکە ڕیز بکە.',
        '٢. بیبرژێنە و شیرەی پێدا بکە.'
      ],
    },
  ),

  Recipe(
    id: '42',
    title: {'en': 'Baklava', 'ku': 'باقڵاوە'},
    icon: '🥐',
    nutrition: NutritionalInfo(calories: 380, protein: 5, carbs: 45, fats: 20),
    category: MealCategory.snack,
    ingredients: {
      'en': ['Phyllo pastry', 'Walnuts', 'Butter', 'Sugar syrup'],
      'ku': ['هەویری تەنک', 'گوێز', 'کەرە', 'شیرە'],
    },
    steps: {
      'en': [
        '1. Layer phyllo with butter and nuts.',
        '2. Bake and soak in syrup.'
      ],
      'ku': ['١. هەویر و گوێزەکان ڕیز بکە.', '٢. بیبرژێنە و شیرەی پێدا بکە.'],
    },
  ),

  Recipe(
    id: '43',
    title: {'en': 'Qelî (Kurdish Fried Meat)', 'ku': 'قەلی'},
    icon: '🥩',
    nutrition: NutritionalInfo(calories: 580, protein: 45, carbs: 2, fats: 42),
    category: MealCategory.bulking,
    ingredients: {
      'en': ['Lamb dice', 'Lamb fat', 'Salt', 'Black pepper'],
      'ku': ['گۆشتی بەرخ', 'بەز', 'خوێ', 'بیبەری ڕەش'],
    },
    steps: {
      'en': ['1. Cook meat in its own fat until crispy.', '2. Season heavily.'],
      'ku': [
        '١. گۆشتەکە بە بەزی خۆی سوور بکەرەوە تا ڕەق دەبێت.',
        '٢. خوێی تێبکە.'
      ],
    },
  ),

  // ... (IDs 44-59: Biryani, Niska, Shish Tawook, Kibbeh, etc.)

  Recipe(
    id: '60',
    title: {'en': 'Kechke', 'ku': 'کەشکە'},
    icon: '🥣',
    nutrition: NutritionalInfo(calories: 340, protein: 12, carbs: 55, fats: 8),
    category: MealCategory.lunch,
    ingredients: {
      'en': ['Cracked wheat', 'Yogurt', 'Butter', 'Dried mint'],
      'ku': ['دانەوێڵەی کوتراو', 'ماست', 'کەرە', 'نەعنا'],
    },
    steps: {
      'en': [
        '1. Boil wheat until soft.',
        '2. Stir in yogurt and top with mint butter.'
      ],
      'ku': [
        '١. دانەوێڵەکە بکوڵێنە تا نەرم دەبێت.',
        '٢. ماستی تێبکە و کەرە و نەعنای پێدا بکە.'
      ],
    },
  ),

  Recipe(
    id: '61',
    title: {'en': 'Girara (Kurdish Soup)', 'ku': 'گەرارە'},
    icon: '🍲',
    nutrition: NutritionalInfo(calories: 220, protein: 6, carbs: 40, fats: 4),
    category: MealCategory.lunch,
    ingredients: {
      'en': ['Rice', 'Yogurt', 'Chard', 'Mint'],
      'ku': ['برنج', 'ماست', 'سڵق', 'نەعنا'],
    },
    steps: {
      'en': [
        '1. Cook rice and chard.',
        '2. Whisk in yogurt to create a tangy soup.'
      ],
      'ku': ['١. برنج و سڵقەکە بکوڵێنە.', '٢. ماستی تێبکە تا دەبێتە شۆربا.'],
    },
  ),

  Recipe(
    id: '62',
    title: {'en': 'Sîrim', 'ku': 'سیرم'},
    icon: '🧄',
    nutrition: NutritionalInfo(calories: 310, protein: 8, carbs: 50, fats: 10),
    category: MealCategory.lunch,
    ingredients: {
      'en': ['Wheat', 'Garlic', 'Yogurt', 'Bread'],
      'ku': ['دانەوێڵە', 'سیر', 'ماست', 'نان'],
    },
    steps: {
      'en': [
        '1. Mix cooked wheat with yogurt and plenty of garlic.',
        '2. Serve with bread.'
      ],
      'ku': [
        '١. دانەوێڵە و ماست و سیری زۆر تێکەڵ بکە.',
        '٢. لەگەڵ نان پێشکەشی بکە.'
      ],
    },
  ),

  Recipe(
    id: '63',
    title: {'en': 'Giyabenî', 'ku': 'گیا بەنی'},
    icon: '🌿',
    nutrition: NutritionalInfo(calories: 200, protein: 4, carbs: 30, fats: 7),
    category: MealCategory.lunch,
    ingredients: {
      'en': ['Wild spring greens', 'Eggs', 'Onion', 'Spices'],
      'ku': ['گیای بەهاری', 'هێلکە', 'پیاز', 'بەهارات'],
    },
    steps: {
      'en': [
        '1. Sauté wild greens with onion.',
        '2. Scramble eggs over the mixture.'
      ],
      'ku': ['١. گیاکە و پیازەکە سوور بکەرەوە.', '٢. هێلکەی تێبکە.'],
    },
  ),

  Recipe(
    id: '64',
    title: {'en': 'Mastaw (Doogh)', 'ku': 'ماستاو'},
    icon: '🥛',
    nutrition: NutritionalInfo(calories: 80, protein: 4, carbs: 6, fats: 4),
    category: MealCategory.snack,
    ingredients: {
      'en': ['Yogurt', 'Cold water', 'Salt', 'Mint'],
      'ku': ['ماست', 'ئاوی سارد', 'خوێ', 'نەعنا'],
    },
    steps: {
      'en': [
        '1. Whisk yogurt with water.',
        '2. Add salt and mint; serve ice cold.'
      ],
      'ku': ['١. ماست و ئاوەکە تێک بدە.', '٢. خوێ و نەعنای تێبکە.'],
    },
  ),

  Recipe(
    id: '65',
    title: {'en': 'Zarda (Sweet Rice)', 'ku': 'زەردە'},
    icon: '🥣',
    nutrition: NutritionalInfo(calories: 320, protein: 4, carbs: 70, fats: 3),
    category: MealCategory.snack,
    ingredients: {
      'en': ['Rice', 'Sugar', 'Saffron', 'Rose water'],
      'ku': ['برنج', 'شەکر', 'زەعفەران', 'ئاوی گوڵ'],
    },
    steps: {
      'en': [
        '1. Boil rice until very soft.',
        '2. Add sugar and saffron; cook until thick.'
      ],
      'ku': [
        '١. برنجەکە زۆر بکوڵێنە.',
        '٢. شەکر و زەعفەرانی تێبکە تا خەست دەبێتەوە.'
      ],
    },
  ),

  // ... (IDs 66-79: Sutlac, Halva, Umm Ali, etc.)

  Recipe(
    id: '80',
    title: {'en': 'Sambousek', 'ku': 'سەمبوسە'},
    icon: '🥟',
    nutrition: NutritionalInfo(calories: 280, protein: 10, carbs: 30, fats: 14),
    category: MealCategory.snack,
    ingredients: {
      'en': ['Pastry', 'Ground meat or cheese', 'Onion', 'Parsley'],
      'ku': ['هەویر', 'گۆشتی هاڕاو یان پەنیر', 'پیاز', 'جەعفەری'],
    },
    steps: {
      'en': [
        '1. Stuff pastry with meat or cheese.',
        '2. Fold into triangles and fry.'
      ],
      'ku': [
        '١. ناو هەویرەکە بە پەنیر یان گۆشت پڕ بکە.',
        '٢. بە سێگۆشەیی بیپێچەرەوە و سووری بکەرەوە.'
      ],
    },
  ),

  Recipe(
    id: '81',
    title: {'en': 'Manakish', 'ku': 'مەناقیش'},
    icon: '🍕',
    nutrition: NutritionalInfo(calories: 310, protein: 7, carbs: 40, fats: 14),
    category: MealCategory.breakfast,
    ingredients: {
      'en': ['Flatbread dough', 'Zaatar', 'Olive oil', 'Cheese'],
      'ku': ['هەویر', 'زەعتەر', 'ڕۆنی زەیتوون', 'پەنیر'],
    },
    steps: {
      'en': ['1. Spread zaatar or cheese on dough.', '2. Bake until crispy.'],
      'ku': ['١. زەعتەر یان پەنیر بکە بەسەر هەویرەکەدا.', '٢. بیبرژێنە.'],
    },
  ),

  Recipe(
    id: '82',
    title: {'en': 'Mujadara', 'ku': 'موجەدەرە'},
    icon: '🍚',
    nutrition: NutritionalInfo(calories: 350, protein: 12, carbs: 55, fats: 9),
    category: MealCategory.lunch,
    ingredients: {
      'en': ['Lentils', 'Rice', 'Caramelized onions'],
      'ku': ['نیسک', 'برنج', 'پیازی سوورکراوە'],
    },
    steps: {
      'en': [
        '1. Cook lentils and rice together.',
        '2. Top with plenty of fried onions.'
      ],
      'ku': [
        '١. نیسک و برنجەکە پێکەوە لێبنێ.',
        '٢. پیازی سوورکراوە بکە بەسەریدا.'
      ],
    },
  ),

  Recipe(
    id: '83',
    title: {'en': 'Lahmacun', 'ku': 'لەحمەجون'},
    icon: '🍕',
    nutrition: NutritionalInfo(calories: 290, protein: 18, carbs: 32, fats: 10),
    category: MealCategory.lunch,
    ingredients: {
      'en': ['Thin dough', 'Ground beef', 'Tomato', 'Bell pepper'],
      'ku': ['هەویری تەنک', 'گۆشتی هاڕاو', 'تەماتە', 'بیبەر'],
    },
    steps: {
      'en': ['1. Spread meat mix on thin dough.', '2. Bake in hot oven.'],
      'ku': ['١. تێکەڵەی گۆشتەکە بدە لە هەویرەکە.', '٢. بیبرژێنە.'],
    },
  ),

  Recipe(
    id: '84',
    title: {'en': 'Keledoş', 'ku': 'کەلەدۆش'},
    icon: '🍲',
    nutrition: NutritionalInfo(calories: 520, protein: 35, carbs: 20, fats: 34),
    category: MealCategory.dinner,
    ingredients: {
      'en': ['Diced lamb', 'Chickpeas', 'Yogurt/Kashk', 'Herbs'],
      'ku': ['گۆشتی وردکراو', 'نۆک', 'کەشک', 'گیاکێوی'],
    },
    steps: {
      'en': [
        '1. Cook meat and chickpeas.',
        '2. Add herbs and thick yogurt sauce.'
      ],
      'ku': ['١. گۆشت و نۆکەکە بکوڵێنە.', '٢. گیاکە و کەشکەکەی تێبکە.'],
    },
  ),

  // ... (IDs 85-99: Kurdish Coffee, Masgouf, Mansaf, etc.)

  Recipe(
    id: '100',
    title: {'en': 'Sahlab (Milk Pudding)', 'ku': 'سەحلەب'},
    icon: '🥛',
    nutrition: NutritionalInfo(calories: 220, protein: 6, carbs: 35, fats: 6),
    category: MealCategory.snack,
    ingredients: {
      'en': ['Milk', 'Cornstarch', 'Sugar', 'Cinnamon', 'Pistachios'],
      'ku': ['شیر', 'نیشاستە', 'شەکر', 'دارچین', 'فستق'],
    },
    steps: {
      'en': [
        '1. Heat milk with sugar.',
        '2. Thicken with starch and garnish with cinnamon.'
      ],
      'ku': [
        '١. شیر و شەکرەکە گەرم بکە.',
        '٢. نیشاستەی تێبکە و دارچین بکە بەسەریدا.'
      ],
    },
  ),
  Recipe(
    id: '101',
    title: {'en': 'Koshary', 'ku': 'کۆشەری'},
    icon: '🥣',
    nutrition: NutritionalInfo(calories: 650, protein: 22, carbs: 120, fats: 8),
    category: MealCategory.lunch,
    rating: 4.8,
    ratingCount: 850,
    ingredients: {
      'en': [
        'Rice',
        'Macaroni',
        'Lentils',
        'Chickpeas',
        'Fried onions',
        'Spicy tomato sauce'
      ],
      'ku': [
        'برنج',
        'ماکەرۆنی',
        'نیسک',
        'نۆک',
        'پیازی سوورکراوە',
        'تەماتەی توون'
      ],
    },
    steps: {
      'en': [
        '1. Cook rice, lentils, and macaroni separately.',
        '2. Layer them in a bowl.',
        '3. Top with chickpeas and crispy fried onions.',
        '4. Pour spicy tomato sauce and garlic vinegar over the top.'
      ],
      'ku': [
        '١. برنج و نیسک و ماکەرۆنیەکە جیا بکوڵێنە.',
        '٢. لە قاپێکدا چین چین دایبنێ.',
        '٣. نۆک و پیازی سوورکراوەی بکە بەسەردا.',
        '٤. سۆسی تەماتەی توون و سرکەی سیری پێدا بکە.'
      ],
    },
  ),

  Recipe(
    id: '102',
    title: {'en': 'Spicy Zinger Burger', 'ku': 'زینگەر برگر (تون)'},
    icon: '🍔',
    nutrition: NutritionalInfo(calories: 520, protein: 32, carbs: 45, fats: 24),
    category: MealCategory.dinner,
    rating: 4.7,
    ratingCount: 420,
    ingredients: {
      'en': [
        'Crispy chicken breast',
        'Burger bun',
        'Lettuce',
        'Mayonnaise',
        'Spicy marinade'
      ],
      'ku': [
        'سنگی مریشکی کریسپی',
        'نانی برگر',
        'خاس',
        'مایۆنیز',
        'بەهاراتی توون'
      ],
    },
    steps: {
      'en': [
        '1. Marinate chicken in spicy sauce and bread it.',
        '2. Deep fry until golden and crispy.',
        '3. Assemble on a bun with mayo and fresh lettuce.'
      ],
      'ku': [
        '١. مریشکەکە لەناو سۆسی تووندا بخوسێنە و پاشان ئاردی پێوە بکە.',
        '٢. سووری بکەرەوە تا کریسپی دەبێت.',
        '٣. لەگەڵ مایۆنیز و خاس بیخە ناو نانی برگرەوە.'
      ],
    },
  ),

  Recipe(
    id: '103',
    title: {'en': 'Manakish Zaatar', 'ku': 'مەناکیشی زەعتەر'},
    icon: '🫓',
    nutrition: NutritionalInfo(calories: 310, protein: 8, carbs: 40, fats: 14),
    category: MealCategory.breakfast,
    rating: 4.9,
    ingredients: {
      'en': ['Flatbread dough', 'Zaatar (thyme) blend', 'Olive oil'],
      'ku': ['هەویری نان', 'زەعتەر', 'ڕۆنی زەیتوون'],
    },
    steps: {
      'en': [
        '1. Spread a mix of zaatar and olive oil over the dough.',
        '2. Bake in a stone oven until edges are crisp.'
      ],
      'ku': [
        '١. تێکەڵەی زەعتەر و ڕۆنەکە بکە بەسەر هەویرەکەدا.',
        '٢. لەناو فڕندا بیبرژێنە.'
      ],
    },
  ),

  Recipe(
    id: '104',
    title: {'en': 'Hawawshi (Meat Pie)', 'ku': 'هەواوشی (نانی گۆشت)'},
    icon: '🥙',
    nutrition: NutritionalInfo(calories: 580, protein: 35, carbs: 40, fats: 32),
    category: MealCategory.lunch,
    ingredients: {
      'en': [
        'Baladi bread (Pita)',
        'Ground beef',
        'Onions',
        'Green peppers',
        'Spices'
      ],
      'ku': ['نانی پیتا', 'گۆشتی هاڕاو', 'پیاز', 'بیبەری سەوز', 'بەهارات'],
    },
    steps: {
      'en': [
        '1. Mix raw meat with minced veggies and spices.',
        '2. Stuff inside the pita bread.',
        '3. Brush with butter and grill or bake until the bread is crunchy.'
      ],
      'ku': [
        '١. گۆشتەکە و سەوزەکان تێکەڵ بکە.',
        '٢. بیکە ناو نانی پیتاوە.',
        '٣. کەمێک کەرەی لێبدە و بیبرژێنە تا نانەکە کریسپی دەبێت.'
      ],
    },
  ),

  Recipe(
    id: '105',
    title: {'en': 'Tunisian Brik', 'ku': 'بریکی تونسی'},
    icon: '🥟',
    nutrition: NutritionalInfo(calories: 350, protein: 18, carbs: 20, fats: 22),
    category: MealCategory.snack,
    ingredients: {
      'en': ['Malsouka (thin pastry)', 'Egg', 'Tuna', 'Parsley', 'Capers'],
      'ku': ['هەویری تەنک', 'هێلکە', 'ماسی توون', 'جەعفەری'],
    },
    steps: {
      'en': [
        '1. Place tuna and herbs on a pastry sheet.',
        '2. Crack a whole egg in the middle.',
        '3. Fold into a triangle and fry quickly so the egg stays runny.'
      ],
      'ku': [
        '١. ماسی و سەوزەکان بخەرە سەر هەویرەکە.',
        '٢. هێلکەیەک بکە ناوەڕاستی.',
        '٣. بیپێچەرەوە و سووری بکەرەوە.'
      ],
    },
  ),

  Recipe(
    id: '106',
    title: {'en': 'Halloumi Saj Wrap', 'ku': 'لەتەی سەج بە هەلۆمی'},
    icon: '🌯',
    nutrition: NutritionalInfo(calories: 420, protein: 22, carbs: 35, fats: 20),
    category: MealCategory.breakfast,
    ingredients: {
      'en': [
        'Saj bread',
        'Halloumi cheese',
        'Cucumber',
        'Tomato',
        'Mint',
        'Olives'
      ],
      'ku': [
        'نانی سەج',
        'پەنیری هەلۆمی',
        'خەیار',
        'تەماتە',
        'نەعنا',
        'زەیتوون'
      ],
    },
    steps: {
      'en': [
        '1. Grill halloumi slices.',
        '2. Place on saj bread with fresh veggies.',
        '3. Wrap and toast on the grill.'
      ],
      'ku': [
        '١. پەنیری هەلۆمییەکە ببرژێنە.',
        '٢. لەگەڵ سەوزەکان بیخە ناو نانی سەجەوە.',
        '٣. بیپێچەرەوە و کەمێک بیبرژێنە.'
      ],
    },
  ),

  Recipe(
    id: '107',
    title: {'en': 'Mahjouba (Crepe)', 'ku': 'مەحجوبەی جەزائیری'},
    icon: '🥞',
    nutrition: NutritionalInfo(calories: 380, protein: 10, carbs: 55, fats: 12),
    category: MealCategory.lunch,
    ingredients: {
      'en': [
        'Semolina dough',
        'Tomato sauce',
        'Caramelized onions',
        'Chili paste'
      ],
      'ku': ['هەویری سمید', 'سۆسی تەماتە', 'پیازی سوورکراوە', 'بیبەری توون'],
    },
    steps: {
      'en': [
        '1. Fill thin semolina dough with spicy onion and tomato mix.',
        '2. Cook on a flat griddle until golden.'
      ],
      'ku': [
        '١. تێکەڵەی پیاز و تەماتەکە بخەرە ناو هەویرەکەوە.',
        '٢. لەسەر ساج بیبرژێنە.'
      ],
    },
  ),
  Recipe(
    id: '108',
    title: {'en': 'Chicken Shawarma Wrap', 'ku': 'شاورمای مریشک'},
    icon: '🌯',
    nutrition: NutritionalInfo(calories: 480, protein: 35, carbs: 40, fats: 18),
    category: MealCategory.lunch,
    rating: 4.9,
    ratingCount: 1200,
    ingredients: {
      'en': [
        'Chicken thighs',
        'Garlic sauce (Toum)',
        'Pickles',
        'Saj bread',
        'Shawarma spices'
      ],
      'ku': ['ڕانی مریشک', 'سۆسی سیر', 'ترشیات', 'نانی سەج', 'بەهاراتی شاورما'],
    },
    steps: {
      'en': [
        '1. Thinly slice marinated chicken and sear until crispy.',
        '2. Spread garlic sauce on saj bread.',
        '3. Add chicken and pickles, then wrap tightly.',
        '4. Toast the wrap on a griddle until golden.'
      ],
      'ku': [
        '١. مریشکەکە بە تەنکی ببڕە و سووری بکەرەوە.',
        '٢. سۆسی سیرەکە بدە لە نانی سەجەکە.',
        '٣. مریشک و ترشیاتەکەی تێبکە و بیپێچەرەوە.',
        '٤. لەسەر ساج کەمێک بیبرژێنە.'
      ],
    },
  ),

  Recipe(
    id: '109',
    title: {'en': 'Beef Kofta Wrap', 'ku': 'لەتەی کفتەی گۆشت'},
    icon: '🌯',
    nutrition: NutritionalInfo(calories: 550, protein: 38, carbs: 35, fats: 25),
    category: MealCategory.dinner,
    ingredients: {
      'en': ['Ground beef', 'Hummus', 'Parsley', 'Onions', 'Pita bread'],
      'ku': ['گۆشتی هاڕاو', 'حومس', 'جەعفەری', 'پیاز', 'نانی پیتا'],
    },
    steps: {
      'en': [
        '1. Grill kofta skewers.',
        '2. Spread hummus on pita, add kofta and onion-parsley mix.',
        '3. Roll and serve.'
      ],
      'ku': [
        '١. کفتەکان ببرژێنە.',
        '٢. حومسەکە بدە لە نانەکە و کفتە و پیاز و جەعفەری تێبکە.',
        '٣. بیپێچەرەوە.'
      ],
    },
  ),

  Recipe(
    id: '110',
    title: {'en': 'Batata Harra (Spicy Potatoes)', 'ku': 'پەتاتەی توون'},
    icon: '🍟',
    nutrition: NutritionalInfo(calories: 320, protein: 4, carbs: 45, fats: 14),
    category: MealCategory.snack,
    ingredients: {
      'en': ['Potatoes', 'Cilantro', 'Garlic', 'Chili flakes', 'Lemon juice'],
      'ku': ['پەتاتە', 'کەزەره', 'سیر', 'بیبەری توون', 'ئاوی لیمۆ'],
    },
    steps: {
      'en': [
        '1. Cube and fry potatoes.',
        '2. Sauté garlic, chili, and cilantro.',
        '3. Toss potatoes in the mix with lemon juice.'
      ],
      'ku': [
        '١. پەتاتەکە بە چوارگۆشەیی سوور بکەرەوە.',
        '٢. سیر و بیبەر و کەزەرەکە سوور بکەرەوە.',
        '٣. پەتاتەکە و ئاوی لیمۆکەی تێبکە.'
      ],
    },
  ),

  Recipe(
    id: '111',
    title: {'en': 'Sfeeha (Meat Pies)', 'ku': 'سفێحە'},
    icon: '🍕',
    nutrition: NutritionalInfo(calories: 290, protein: 14, carbs: 30, fats: 12),
    category: MealCategory.snack,
    ingredients: {
      'en': [
        'Dough circles',
        'Ground lamb',
        'Pomegranate molasses',
        'Pine nuts'
      ],
      'ku': ['هەویر', 'گۆشتی بەرخ', 'دۆشاوی هەنار', 'دەنکە سنۆبەر'],
    },
    steps: {
      'en': [
        '1. Mix meat with molasses and spices.',
        '2. Spread on small dough circles.',
        '3. Bake until the meat is cooked and dough is crisp.'
      ],
      'ku': [
        '١. گۆشتەکە و دۆشاوی هەنارەکە تێکەڵ بکە.',
        '٢. بیخەرە سەر هەویرە خڕەکان.',
        '٣. بیخە ناو فڕن تا دەکوڵێت.'
      ],
    },
  ),

  Recipe(
    id: '112',
    title: {'en': 'Gözleme (Turkish Flatbread)', 'ku': 'گۆزلەمە'},
    icon: '🫓',
    nutrition: NutritionalInfo(calories: 380, protein: 12, carbs: 50, fats: 15),
    category: MealCategory.lunch,
    ingredients: {
      'en': ['Thin dough', 'Spinach', 'Feta cheese', 'Butter'],
      'ku': ['هەویری تەنک', 'سپێناخ', 'پەنیری سپی', 'کەرە'],
    },
    steps: {
      'en': [
        '1. Fill thin dough with spinach and cheese.',
        '2. Fold and cook on a griddle.',
        '3. Brush with butter while hot.'
      ],
      'ku': [
        '١. سپێناخ و پەنیرەکە بخەرە ناو هەویرەکەوە.',
        '٢. لەسەر ساج بیبرژێنە.',
        '٣. کەمێک کەرەی لێبدە.'
      ],
    },
  ),

  Recipe(
    id: '113',
    title: {'en': 'Chicken Fatteh', 'ku': 'فەتەی مریشک'},
    icon: '🥣',
    nutrition: NutritionalInfo(calories: 450, protein: 28, carbs: 40, fats: 20),
    category: MealCategory.lunch,
    ingredients: {
      'en': [
        'Toasted pita',
        'Poached chicken',
        'Chickpeas',
        'Yogurt-tahini sauce',
        'Nuts'
      ],
      'ku': [
        'نانی سوورکراوە',
        'مریشکی کوڵاو',
        'نۆک',
        'سۆسی ماست و تەحین',
        'چەرەزات'
      ],
    },
    steps: {
      'en': [
        '1. Layer toasted bread, then chickpeas and chicken.',
        '2. Pour yogurt-tahini sauce over top.',
        '3. Garnish with fried nuts.'
      ],
      'ku': [
        '١. نانە سوورکراوەکە و نۆک و مریشکەکە دابنێ.',
        '٢. سۆسی ماست و تەحینەکەی پێدا بکە.',
        '٣. چەرەزاتی سوورکراوەی بەسەردا بکە.'
      ],
    },
  ),

  Recipe(
    id: '114',
    title: {'en': 'Grilled Halloumi Burger', 'ku': 'برگری هەلۆمی'},
    icon: '🍔',
    nutrition: NutritionalInfo(calories: 410, protein: 20, carbs: 35, fats: 22),
    category: MealCategory.dinner,
    ingredients: {
      'en': [
        'Halloumi cheese',
        'Brioche bun',
        'Pesto or Harissa',
        'Tomato',
        'Arugula'
      ],
      'ku': ['پەنیری هەلۆمی', 'نانی برگر', 'سۆسی هەریسا', 'تەماتە', 'روکۆلا'],
    },
    steps: {
      'en': [
        '1. Grill thick halloumi slices.',
        '2. Spread harissa on bun.',
        '3. Assemble with tomato and arugula.'
      ],
      'ku': [
        '١. پەنیرە هەلۆمییەکە ببرژێنە.',
        '٢. سۆسی هەریسەکە بدە لە نانەکە.',
        '٣. تەماتە و روکۆلاکەی تێبکە.'
      ],
    },
  ),

  Recipe(
    id: '115',
    title: {'en': 'Shish Tawook Sandwich', 'ku': 'سەندەویچی شیش تاووق'},
    icon: '🍢',
    nutrition: NutritionalInfo(calories: 440, protein: 35, carbs: 45, fats: 14),
    category: MealCategory.lunch,
    ingredients: {
      'en': [
        'Grilled chicken skewers',
        'Garlic paste',
        'Coleslaw',
        'French fries',
        'Pita bread'
      ],
      'ku': [
        'شیشی مریشک',
        'سۆسی سیر',
        'زەڵاتەی کەلەرم',
        'پەتاتەی سوورکراوە',
        'نانی پیتا'
      ],
    },
    steps: {
      'en': [
        '1. Place grilled chicken in pita.',
        '2. Add garlic paste, coleslaw, and fries inside.',
        '3. Wrap and toast.'
      ],
      'ku': [
        '١. مریشکە برژاوەکە بخەرە ناو نانەکەوە.',
        '٢. سۆسی سیر و زەڵاتە و پەتاتەی تێبکە.',
        '٣. بیپێچەرەوە.'
      ],
    },
  ),

  Recipe(
    id: '116',
    title: {'en': 'Alexandrian Liver (Kebda)', 'ku': 'جەرگی ئەسکەندەری'},
    icon: '🥘',
    nutrition: NutritionalInfo(calories: 380, protein: 32, carbs: 15, fats: 20),
    category: MealCategory.lunch,
    ingredients: {
      'en': ['Beef liver', 'Green chili peppers', 'Garlic', 'Cumin', 'Vinegar'],
      'ku': ['جەرگی گۆشت', 'بیبەری سەوزی توون', 'سیر', 'کەمون', 'سرکە'],
    },
    steps: {
      'en': [
        '1. Sauté garlic and chili.',
        '2. Add liver strips and spices; cook fast on high heat.',
        '3. Serve in a samoon or pita.'
      ],
      'ku': [
        '١. سیر و بیبەرەکە سوور بکەرەوە.',
        '٢. جەرگەکە و بەهاراتەکانی تێبکە و بە خێرایی سووری بکەرەوە.',
        '٣. لەناو ناندا پێشکەشی بکە.'
      ],
    },
  ),

  Recipe(
    id: '117',
    title: {'en': 'Sujuk Sandwich', 'ku': 'سەندەویچی سجوق'},
    icon: '🌭',
    nutrition: NutritionalInfo(calories: 520, protein: 28, carbs: 30, fats: 32),
    category: MealCategory.dinner,
    ingredients: {
      'en': [
        'Spicy beef sausage (Sujuk)',
        'Tomato',
        'Pickles',
        'Garlic sauce',
        'Baguette'
      ],
      'ku': ['سجوق', 'تەماتە', 'ترشیات', 'سۆسی سیر', 'نانی فەڕەنسی'],
    },
    steps: {
      'en': [
        '1. Slice and sauté sujuk until browned.',
        '2. Stuff in baguette with garlic sauce and veggies.'
      ],
      'ku': [
        '١. سجوقەکە ببڕە و سووری بکەرەوە.',
        '٢. لەگەڵ سۆسی سیر و سەوزەوات بیخە ناو نانەکەوە.'
      ],
    },
  ),

  Recipe(
    id: '118',
    title: {'en': 'Labneh & Zaatar Wrap', 'ku': 'لەتەی لێبەنە و زەعتەر'},
    icon: '🌯',
    nutrition: NutritionalInfo(calories: 310, protein: 9, carbs: 40, fats: 15),
    category: MealCategory.breakfast,
    ingredients: {
      'en': ['Labneh', 'Zaatar', 'Olive oil', 'Cucumber', 'Mint', 'Saj bread'],
      'ku': ['لێبەنە', 'زەعتەر', 'ڕۆنی زەیتوون', 'خەیار', 'نەعنا', 'نانی سەج'],
    },
    steps: {
      'en': [
        '1. Spread labneh on bread.',
        '2. Sprinkle zaatar and oil.',
        '3. Add fresh mint and cucumber, then roll.'
      ],
      'ku': [
        '١. لێبەنەکە بدە لە نانەکە.',
        '٢. زەعتەر و ڕۆنەکەی پێدا بکە.',
        '٣. نەعنا و خەیارەکەی تێبکە و بیپێچەرەوە.'
      ],
    },
  ),

  Recipe(
    id: '119',
    title: {'en': 'Spinach Fatayer', 'ku': 'فەتایەری سپێناخ'},
    icon: '🥟',
    nutrition: NutritionalInfo(calories: 220, protein: 6, carbs: 32, fats: 9),
    category: MealCategory.snack,
    ingredients: {
      'en': [
        'Dough triangles',
        'Fresh spinach',
        'Onion',
        'Sumac',
        'Lemon juice'
      ],
      'ku': ['هەویر', 'سپێناخ', 'پیاز', 'سماق', 'ئاوی لیمۆ'],
    },
    steps: {
      'en': [
        '1. Squeeze spinach to remove water.',
        '2. Mix with onion, sumac, and lemon.',
        '3. Fill dough and bake.'
      ],
      'ku': [
        '١. ئاوی سپێناخەکە بپەستێوە.',
        '٢. لەگەڵ پیاز و سماق و لیمۆ تێکەڵی بکە.',
        '٣. ناو هەویرەکەی پێ پڕ بکە و بیبرژێنە.'
      ],
    },
  ),

  Recipe(
    id: '120',
    title: {'en': 'Vegetable Spring Rolls', 'ku': 'سپڕینگ ڕۆڵی سەوزە'},
    icon: '🥖',
    nutrition: NutritionalInfo(calories: 180, protein: 4, carbs: 25, fats: 8),
    category: MealCategory.snack,
    ingredients: {
      'en': [
        'Spring roll wrappers',
        'Cabbage',
        'Carrots',
        'Bean sprouts',
        'Soy sauce'
      ],
      'ku': ['پێچەرەوەی ڕۆڵ', 'کەلەرم', 'گێزەر', 'نۆکی شینبوو', 'سۆسی سۆیا'],
    },
    steps: {
      'en': [
        '1. Shred and sauté vegetables.',
        '2. Wrap in pastry sheets.',
        '3. Deep fry or bake until golden.'
      ],
      'ku': [
        '١. سەوزەکان ورد بکە و سووریان بکەرەوە.',
        '٢. بیپێچەرەوە لەناو هەویرەکەدا.',
        '٣. سووری بکەرەوە تا ڕەنگی ئاڵ دەبێت.'
      ],
    },
  ),

  Recipe(
    id: '121',
    title: {'en': 'Harira (Moroccan Soup)', 'ku': 'شۆربای هەریرا'},
    icon: '🍲',
    nutrition: NutritionalInfo(calories: 340, protein: 18, carbs: 55, fats: 6),
    category: MealCategory.dinner,
    ingredients: {
      'en': [
        'Lentils',
        'Chickpeas',
        'Tomato',
        'Celery',
        'Ginger',
        'Turmeric',
        'Lamb (optional)'
      ],
      'ku': ['نیسک', 'نۆک', 'تەماتە', 'کەرەوز', 'زەنجەفیل', 'زەردەچەوە'],
    },
    steps: {
      'en': [
        '1. Sauté celery and onions.',
        '2. Add lentils, chickpeas, and tomatoes with spices.',
        '3. Simmer until thick and hearty.'
      ],
      'ku': [
        '١. کەرەوز و پیازەکە سوور بکەرەوە.',
        '٢. نیسک و نۆک و تەماتە و بەهاراتەکان تێبکە.',
        '٣. لێبگەڕێ بکوڵێت تا خەست دەبێتەوە.'
      ],
    },
  ),

  Recipe(
    id: '122',
    title: {'en': 'Shakshuka Wrap', 'ku': 'لەتەی شەکشوکە'},
    icon: '🌯',
    nutrition: NutritionalInfo(calories: 380, protein: 18, carbs: 35, fats: 18),
    category: MealCategory.breakfast,
    ingredients: {
      'en': ['Eggs', 'Tomato sauce', 'Bell peppers', 'Pita or Tortilla'],
      'ku': ['هێلکە', 'سۆسی تەماتە', 'بیبەر', 'نانی پیتا'],
    },
    steps: {
      'en': [
        '1. Cook shakshuka in a pan.',
        '2. Scramble slightly to make it firm.',
        '3. Wrap in bread and toast.'
      ],
      'ku': [
        '١. شەکشوکەکە لێبنێ.',
        '٢. هێلکەکە کەمێک تێک بدە تا توند دەبێت.',
        '٣. لەناو ناندا بیپێچەرەوە و بیبرژێنە.'
      ],
    },
  ),
  Recipe(
    id: '80',
    title: {'en': 'Kurdish Dumplings (Kofta)', 'ku': 'کۆفتەی کوردی'},
    icon: '🥟',
    nutrition: NutritionalInfo(calories: 400, protein: 25, carbs: 30, fats: 18),
    category: MealCategory.lunch,
    ingredients: {
      'en': [
        'Pastry dough',
        'Ground beef or lamb',
        'Onion',
        'Spices',
        'Yogurt sauce'
      ],
      'ku': [
        'هەویری پێچەرەوە',
        'گۆشتی هاڕاو یان بەرخ',
        'پیاز',
        'بەهارات',
        'سۆسی ماست'
      ],
    },
    steps: {
      'en': [
        '1. Mix ground meat with finely chopped onions and spices.',
        '2. Fill pastry dough with meat mixture and seal edges.',
        '3. Boil dumplings until they float, then serve with yogurt sauce.'
      ],
      'ku': [
        '١. گۆشتە هاڕاوەکە بە پیازی خڕاو و بەهاراتەکان تێکەڵ بکە.',
        '٢. ناو هەویری پێچەرەوەکە پڕ بکە بە تێکەڵەی گۆشت و لایەکان داخڵ بکە.',
        '٣. کۆفتەکان بکوڵێنە تا لە س ەر دەست پێبکەن، پاشان لەگەڵ سۆسی ماست پێشکەش بکە.'
      ],
    },
  ),
  Recipe(
    id: '81',
    title: {'en': 'Kurdish Lamb Stew (Qeema)', 'ku': 'قیمەی کوردی'},
    icon: '🍲',
    nutrition: NutritionalInfo(calories: 480, protein: 30, carbs: 25, fats: 28),
    category: MealCategory.dinner,
    ingredients: {
      'en': ['Diced lamb', 'Tomato paste', 'Onions', '    Garlic', 'Spices'],
      'ku': ['گۆشتی بەرخ', 'پەیستای تەماتە', 'پیاز', 'سیر', 'بەهارات'],
    },
    steps: {
      'en': [
        '1. Sauté onions and garlic until golden.',
        '2. Add diced lamb and brown on all sides.',
        '3. Stir in tomato paste and spices, then simmer until tender.'
      ],
      'ku': [
        '١. پیاز و سیرەکە سوور بکەرەوە تا زەرد دەبێت.',
        '٢. گۆشتی بەرخەکە زیاد بکە و لایەکان سووری بکەرەوە.',
        '٣. پەیستای تەماتە و بەهاراتەکان تێبکە، پاشان بگەڕێ تا نرمی دەبێت.'
      ],
    },
  ),
  Recipe(
    id: '82',
    title: {'en': 'Kurdish Stuffed Grape Leaves (Dolma)', 'ku': 'دۆلمای کوردی'},
    icon: '🍃   ',
    nutrition: NutritionalInfo(calories: 350, protein: 12, carbs: 45, fats: 10),
    category: MealCategory.lunch,
    ingredients: {
      'en': ['Grape leaves', 'Rice', 'Ground beef or lamb', 'Onions', 'Spices'],
      'ku': ['پەڕگەی تاک', 'برنج', 'گۆشتی هاڕاو یان بەرخ', 'پیاز', 'بەهارات'],
    },
    steps: {
      'en': [
        '1. Mix rice with ground meat, chopped onions, and spices.',
        '2. Stuff grape leaves with the rice mixture and roll tightly.',
        '3. Arrange in a pot, cover with water, and simmer until cooked.'
      ],
      'ku': [
        '١. برنجەکە بە گۆشتە هاڕاوەکە، پیازی خڕاو و بەهاراتەکان تێکەڵ بکە.',
        '٢. پەڕگە تاکەکان پڕ بکە بە تێکەڵەی برنج و بیپێچەرەوە.',
        '٣. لەناو قازانێکدا ڕیز بکە، ئاوی سەر بکەرەوە، و بگەڕێ تا دەکوڵێت.'
      ],
    },
  ),
  Recipe(
    id: '83',
    title: {'en': 'Kurdish Yogurt Drink (Ayran)', 'ku': 'ئایران'},
    icon: '🥛',
    nutrition: NutritionalInfo(calories: 100, protein: 6, carbs: 8, fats: 4),
    category: MealCategory.snack,
    ingredients: {
      'en': ['Yogurt', 'Water', 'Salt'],
      'ku': ['ماست', 'ئاوی', 'خاڵ'],
    },
    steps: {
      'en': [
        '1. Blend yogurt with water until smooth.',
        '2. Add a pinch of salt and mix well.',
        '3. Serve chilled.'
      ],
      'ku': [
        '١. ماستەکە بە ئاوی تێکەڵ بکە تا نرمی دەبێت.',
        '٢. خاڵێک زیاد بکە و باشی تێکەڵ بکە.',
        '٣. سارد پێشکەش بکە.'
      ],
    },
  ),
  Recipe(
    id: '84',
    title: {'en': 'Kurdish Flatbread (Naan-e Khubz)', 'ku': 'نانی کوردی'},
    icon: '🫓   ',
    nutrition: NutritionalInfo(calories: 250, protein: 7, carbs: 50, fats: 2),
    category: MealCategory.breakfast,
    ingredients: {
      'en': ['Flour', 'Water', 'Yeast', 'Salt', ' Olive oil'],
      'ku': ['ئارد', 'ئاوی', 'خمیر مایه', 'خاڵ', 'ڕۆنی زەیتوون'],
    },
    steps: {
      'en': [
        '1. Mix flour, water, yeast, salt, and olive oil to form a dough.',
        '2. Let it rise until doubled in size.',
        '3. Roll out into flatbreads and cook on a hot griddle until golden.'
      ],
      'ku': [
        '١. ئارد، ئاوی، خمیر مایە، خاڵ و ڕۆنی زەیتوون تێکەڵ بکە بۆ دروستکردنی هەویری.',
        '٢. بگەڕێ تا دوو چەند دەبێت.',
        '٣. بەرز بکە بۆ نانی کوردی و لەسەر ساجێکی گەرماوە بیبرژێنە تا زەرد دەبێت.'
      ],
    },
  ),
];
