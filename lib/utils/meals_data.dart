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
    required this.icon,
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
    title: {'en': 'Grilled Chicken', 'ku': 'مریشکی برژاو', 'ar': 'دجاج مشوي'},
    icon: '🍗',
    nutrition: NutritionalInfo(calories: 450, protein: 40, carbs: 5, fats: 25),
    category: MealCategory.bulking,
    rating: 4.8,
    ratingCount: 210,
    ingredients: {
      'en': [
        '1 whole chicken (cut into pieces)',
        '½ cup lemon juice',
        '6 cloves garlic (minced)',
        '1 cup plain yogurt',
        '3 tbsp olive oil',
        '2 tbsp Kurdish spice mix',
        '1 tsp salt',
        '½ tsp black pepper'
      ],
      'ku': [
        '١ مریشک (بڕێ بۆ پارچە)',
        '١/٢ پەرداخ ئاوی لیمۆ',
        '٦ خاو سیر (وردکراوە)',
        '١ پەرداخ ماست',
        '٣ قاشق خواردن ڕۆنی زەیتوون',
        '٢ قاشق خواردن بەهاراتی کوردی',
        '١ مڵاک چای خوێ',
        '١/٢ مڵاک چای بیبەری ڕەش'
      ],
      'ar': [
        '١ دجاجة كاملة (مقطعة إلى قطع)',
        '½ كوب عصير ليمون',
        '٦ فصوص ثوم (مفرومة)',
        '١ كوب زبادي عادي',
        '٣ ملعقة كبيرة زيت زيتون',
        '٢ ملعقة كبيرة خلطة بهارات كردية',
        '١ ملعقة صغيرة ملح',
        '½ ملعقة صغيرة فلفل أسود'
      ],
    },
    steps: {
      'en': [
        '1. Clean the chicken pieces and pat them dry with paper towels.',
        '2. In a large bowl, mix yogurt, lemon juice, minced garlic, olive oil, and all spices.',
        '3. Add chicken pieces to the marinade and coat well. Cover and refrigerate for at least 4 hours (overnight is best).',
        '4. Preheat grill to medium-high heat. Remove chicken from marinade, letting excess drip off.',
        '5. Grill chicken for 8-10 minutes per side, until internal temperature reaches 165°F (74°C).',
        '6. Let chicken rest for 5 minutes before serving with fresh vegetables or rice.'
      ],
      'ku': [
        '١. پارچە مریشکەکان پاک بکەرەوە و بە کلینکس وشکیان بکە.',
        '٢. لە قاپێکی گەورەدا، ماست و ئاوی لیمۆ و سیر و ڕۆن و بەهاراتەکان تێکەڵ بکە.',
        '٣. پارچە مریشکەکان بخەرە ناوی و باش بەم تێکەڵە بپۆشێنە. دایبخە و بۆ کەمترین ٤ کاتژمێر لە سەلادەر بخۆشێنەرەوە.',
        '٤. برژێنەرەکە گەرم بکە. مریشکەکان لە تێکەڵەکە دەربکە و ئەوەی زیادەیە بی لابە.',
        '٥. مریشکەکان بۆ ٨-١٠ خولەک لە هەر لایەک ببرژێنە تا ناوەوەی گەرمی بگاتە ٧٤ پلەی سیلیزی.',
        '٦. بۆ ٥ خولەک پێش خواردن ڕایان بگەڕێنە و لەگەڵ سەوزە یان برنج پێشکەشی بکە.'
      ],
      'ar': [
        '١. نظّف قطع الدجاج وجففها بورق المطبخ.',
        '٢. في وعاء كبير، اخلط الزبادي وعصير الليمون والثوم المفروم وزيت الزيتون وجميع التوابل.',
        '٣. أضف قطع الدجاج إلى التتبيلة وغطها جيداً. غطِّها واتركها في الثلاجة لمدة لا تقل عن ٤ ساعات (الأفضل طوال الليل).',
        '٤. سخّن الشواية على حرارة متوسطة عالية. أزل الدجاج من التتبيلة واترك الزائد يتقطر.',
        '٥. اشوِ الدجاج لمدة ٨-١٠ دقائق من كل جانب، حتى تصل درجة الحرارة الداخلية إلى ٧٤ درجة مئوية.',
        '٦. دع الدجاج يرتاح لمدة ٥ دقائق قبل التقديم مع الخضروات الطازجة أو الأرز.'
      ],
    },
  ),
];
