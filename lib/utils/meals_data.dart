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

// ... (Keep enum and class definitions as they are)

final List<Recipe> recipes = [
  Recipe(
    id: '1',
    title: {
      'en': 'Grilled Chicken Bowl',
      'ku': 'مرگی برژاو لەگەڵ برنج',
    },
    icon: '🍗',
    nutrition: NutritionalInfo(calories: 420, protein: 35, carbs: 45, fats: 12),
    category: MealCategory.bulking,
    rating: 4.5,
    ratingCount: 128,
    ingredients: {
      'en': [
        'Chicken breast',
        'Olive oil',
        'Brown rice',
        'Broccoli',
        'Salt & pepper'
      ],
      'ku': [
        'سنگی مریشک',
        'ڕۆنی زەیتوون',
        'برنجی قاوەیی',
        'بڕۆکلی',
        'خوێ و بیبەر'
      ],
    },
    steps: {
      'en': [
        'Clean chicken breast and season with olive oil, salt, and black pepper.',
        'Heat a grill or pan and cook chicken for 6-8 minutes per side until golden.',
        'Boil brown rice in a 2:1 water-to-rice ratio until fully absorbed.',
        'Steam broccoli for 5 minutes until tender-crisp to retain nutrients.',
        'Slice the chicken and serve over a bed of rice with broccoli on the side.',
      ],
      'ku': [
        'سنگی مریشکەکە پاک بکەرەوە و بە ڕۆنی زەیتوون، خوێ، و بیبەری ڕەش تامبکە.',
        'تاوەیەک یان برژێنەرێک گەرم بکە و بۆ ٦-٨ خولەک بۆ هەر لایەک بیبرژێنە.',
        'برنجە قاوەییەکە لێبنێ تا ئاوەکەی هەڵدەمژێت.',
        'بڕۆکلییەکە بۆ ٥ خولەک بە هەڵم بکوڵێنە تا ڕەنگی سەوز دەمێنێتەوە.',
        'مریشکەکە پارچە پارچە بکە و لەگەڵ برنج و بڕۆکلییەکە دایبنێ.',
      ],
    },
  ),
  Recipe(
    id: '11',
    title: {
      'en': 'Kurdish Dolma',
      'ku': 'دۆڵمە',
    },
    icon: '🍇',
    nutrition: NutritionalInfo(calories: 550, protein: 18, carbs: 75, fats: 22),
    category: MealCategory.dinner,
    rating: 4.9,
    ratingCount: 210,
    ingredients: {
      'en': [
        'Grape leaves',
        'Onions',
        'Eggplant',
        'Rice',
        'Ground lamb',
        'Tomato paste',
        'Lemon juice',
        'Sumac'
      ],
      'ku': [
        'گەڵامێو',
        'پیاز',
        'باینجان',
        'برنج',
        'گۆشتی بەرخی هاڕاو',
        'دۆشاوی تەماتە',
        'ئاوی لیمۆ',
        'سماق'
      ],
    },
    steps: {
      'en': [
        'Wash rice and mix with ground lamb, tomato paste, chopped onion centers, and spices.',
        'Hollow out the eggplants and zucchinis; peel onions and boil slightly to separate layers.',
        'Stuff the vegetables loosely (rice expands) and wrap the grape leaves tightly.',
        'Place lamb ribs at the bottom of a large pot, then layer stuffed veggies, then grape leaves on top.',
        'Mix water with tomato paste, lemon juice, and sumac; pour over the pot.',
        'Cover with a heavy plate to hold them down; cook on medium for 15 mins, then low for 1 hour.',
      ],
      'ku': [
        'برنجەکە بشۆرەوە و تێکەڵی بکە لەگەڵ گۆشتی هاڕاو، دۆشاو، ناوکی پیازە وردکراوەکان و بەهارات.',
        'ناوکی باینجان و کولەکەکان دەربهێنە؛ پیازەکان پاک بکە و کەمێک بیانوڵێنە تا توێژاڵەکانی لێک جیا دەبنەوە.',
        'ناو سەوزەکان پڕ بکە (بە شلی چونکە برنجەکە گەورە دەبێت) و گەڵامێوەکان بە توندی بپێچەوە.',
        'پەڕەی بەراوی مەڕ بخە بنکی مەنجەڵەکە، پاشان سەوزە پڕکراوەکان و پاشان گەڵامێوەکان ڕیز بکە.',
        'ئاو و دۆشاوی تەماتە و ئاوی لیمۆ و سماق تێکەڵ بکە و بیڕێژە بەسەریدا.',
        'قاپێکی قورس بخە سەر دۆڵمەکان؛ بۆ ١٥ خولەک لەسەر ئاگری مامناوەند و پاشان بۆ ١ کاتژمێر لەسەر ئاگری هێواش لێیبنێ.',
      ],
    },
  ),
  Recipe(
    id: '12',
    title: {
      'en': 'Kurdish Kofta',
      'ku': 'کفتە',
    },
    icon: '🥘',
    nutrition: NutritionalInfo(calories: 480, protein: 25, carbs: 55, fats: 18),
    category: MealCategory.lunch,
    rating: 4.7,
    ratingCount: 145,
    ingredients: {
      'en': [
        'Fine bulgur',
        'Rice flour',
        'Ground beef',
        'Onions',
        'Celery',
        'Split peas'
      ],
      'ku': [
        'بڕوێشی ورد',
        'ئاردی برنج',
        'گۆشتی هاڕاو',
        'پیاز',
        'کەرەوز',
        'لەپە'
      ],
    },
    steps: {
      'en': [
        'Mix bulgur, rice flour, and water to create a firm, non-sticky dough. Let it rest.',
        'Prepare filling: Sauté ground beef with onions, celery, and Kurdish spices until dry.',
        'Take a small piece of dough, flatten it in your palm, add filling, and seal into a ball.',
        'Prepare a soup base with water, tomato paste, and pre-boiled split peas.',
        'Gently drop the koftas into the boiling soup. Cook until they float to the surface.',
      ],
      'ku': [
        'بڕوێش و ئاردی برنج و ئاو تێکەڵ بکە تا دەبێتە هەویرێکی توند. لێی بگەڕێ تا دەحەوێتەوە.',
        'ناوەڕۆکەکەی ئامادە بکە: گۆشتەکە لەگەڵ پیاز و کەرەوز و بەهاراتی کوردی سوور بکەرەوە تا وشک دەبێتەوە.',
        'گونکێکی بچووک لە هەویرەکە ببڕە، لە ناو دەستت تەختی بکە، ناوەکەی تێبکە و بە شێوەی تۆپ دایبخەوە.',
        'شۆربایەک ئامادە بکە بە ئاو و دۆشاو و لەپەی کوڵاو.',
        'کفتەکان بە هێواشی بخە ناو شۆربا کوڵاوەکە. لێی بگەڕێ تا دێنە سەر ئاوەکە، ئەوە نیشانەی کوڵانە.',
      ],
    },
  ),
  Recipe(
    id: '14',
    title: {
      'en': 'Sar w Pe (Pacha)',
      'ku': 'سەر و پێ',
    },
    icon: '🍲',
    nutrition: NutritionalInfo(calories: 750, protein: 55, carbs: 10, fats: 52),
    category: MealCategory.bulking,
    rating: 4.8,
    ratingCount: 98,
    ingredients: {
      'en': [
        'Sheep head and trotters',
        'Lamb stomach (stuffed)',
        'Garlic',
        'Lemon',
        'Bread'
      ],
      'ku': ['سەری مەڕ و پێکان', 'ورگ و ڕیخۆڵە (پڕکراو)', 'سیر', 'لیمۆ', 'نان'],
    },
    steps: {
      'en': [
        'Burn off any remaining hair on the head/trotters and scrub thoroughly with salt and flour.',
        'Place cleaned meat in a large pot, cover with water, and boil. Skim off the foam.',
        'Add whole garlic cloves and spices. Simmer for 4-6 hours until meat is tender.',
        'Stuff the stomach/tripe with rice and meat mixture and sew shut; add to the pot for the last 2 hours.',
        'Serve by shredding bread in a bowl (Tirit), soaking it with broth, and placing meat on top.',
      ],
      'ku': [
        'مووی زیادەی سەر و پێیەکان بسوتێنە و بە خوێ و ئارد بە باشی بیشۆ و پاکی بکەرەوە.',
        'گۆشتە پاککراوەکە بخە مەنجەڵێکی گەورە، ئاوی تێبکە و بکوڵێنە. کەفەکەی سەر ئاوەکە لادە.',
        'سیر و بەهاراتی تێبکە. بۆ ٤-٦ کاتژمێر لەسەر ئاگرێکی هێواش لێیبنێ تا گۆشتەکە نەرم دەبێت.',
        'ورگ و ڕیخۆڵەکان بە تێکەڵەی برنج و گۆشت پڕ بکە و بیدورەوە؛ لە ٢ کاتژمێری کۆتایی زیادی بکە بۆ مەنجەڵەکە.',
        'بۆ پێشکەشکردن، نان لەناو قاپێکدا ورد بکە (تیریت)، ئاوەکەی بکە بەسەردا و گۆشتەکەی بخە سەر.',
      ],
    },
  ),
  Recipe(
    id: '21',
    title: {
      'en': 'Kurdish Biryani',
      'ku': 'بریانی',
    },
    icon: '🍛',
    nutrition: NutritionalInfo(calories: 620, protein: 25, carbs: 80, fats: 22),
    category: MealCategory.bulking,
    rating: 4.9,
    ratingCount: 250,
    ingredients: {
      'en': [
        'Basmati rice',
        'Chicken',
        'Potatoes',
        'Vermicelli (Sha\'riya)',
        'Biryani spice',
        'Almonds & Raisins'
      ],
      'ku': [
        'برنجی بەسمەتی',
        'مریشک',
        'پەتاتە',
        'شەعریە',
        'بەهاراتی بریانی',
        'بادەم و مێوژ'
      ],
    },
    steps: {
      'en': [
        'Boil chicken with aromatics, then fry or grill until golden. Keep the broth.',
        'Dice potatoes and fry until crispy. Fry vermicelli until dark brown and cook with a little broth.',
        'Cook rice in the chicken broth with heavy Biryani spices and salt.',
        'Lightly fry raisins and almonds until they swell/turn golden.',
        'Once rice is done, mix in the fried potatoes, vermicelli, and nuts. Serve with the chicken on top.',
      ],
      'ku': [
        'مریشکەکە بکوڵێنە، پاشان سووری بکەرەوە یان بیبرژێنە. ئاوەکەی مەڕێژە.',
        'پەتاتەکان بە چوارگۆشەیی ورد بکە و سووریان بکەرەوە. شەعریەکە سوور بکەرەوە و بە کەمێک ئاوی مریشک بیپێژە.',
        'برنجەکە لەناو ئاوی مریشکەکەدا لێبنێ لەگەڵ بەهاراتی بریانی و خوێ.',
        'مێوژ و بادەمەکان کەمێک لەناو ڕۆندا سوور بکەرەوە.',
        'کاتێک برنجەکە ئامادە بوو، پەتاتە و شەعریە و مێوژ و بادەمەکەی تێکەڵ بکە. مریشکەکە بخە سەر برنجەکە.',
      ],
    },
  ),
  Recipe(
    id: '24',
    title: {
      'en': 'Qaymax and Honey',
      'ku': 'قەیماغ و هەنگوین',
    },
    icon: '🍯',
    nutrition: NutritionalInfo(calories: 520, protein: 6, carbs: 42, fats: 38),
    category: MealCategory.bulking,
    rating: 4.9,
    ratingCount: 156,
    ingredients: {
      'en': ['Clotted cream (Qaymax)', 'Natural honey', 'Fresh Samoon or Naan'],
      'ku': ['قەیماغ', 'هەنگوینی سروشتی', 'سەموون یان نانی گەرم'],
    },
    steps: {
      'en': [
        'Use fresh heavy cream (traditional Qaymax) and spread it flat on a breakfast plate.',
        'Drizzle high-quality natural honey in a zigzag pattern over the cream.',
        'Do not over-mix; allow the honey to sit on top of the cream.',
        'Serve immediately with warm Kurdish tea and freshly baked samoon bread.',
      ],
      'ku': [
        'قەیماغی تازە بەکاربهێنە و بە ڕێکی لەناو قاپێکی نانی بەیانیدا بڵاوی بکەرەوە.',
        'هەنگوینی سروشتی بە شێوەی زیکزاک بەسەر قەیماغەکەدا بڕێژە.',
        'زۆر تێکی مەدە؛ با هەنگوینەکە لەسەر قەیماغەکە بمێنێتەوە.',
        'یەکسەر لەگەڵ چای گەرم و نانی تازە یان سەموونی گەرم پێشکەشی بکە.',
      ],
    },
  ),
  // ... (Include other recipes like Nesk, Kabab, and Mandi with similar detail)
];
