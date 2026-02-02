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
    title: {'en': 'Grilled Chicken', 'ku': 'مریشکی برژاو'},
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
        '١ قاشقە چای خوێ',
        '١/٢ قاشقە چای بیبەری ڕەش'
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
        '30-40 grape leaves (fresh or jarred)',
        '4 small eggplants',
        '4 zucchinis',
        '2 cups basmati rice',
        '500g ground lamb or beef',
        '1 large onion (finely chopped)',
        '¼ cup sumac',
        '2 tbsp tomato paste',
        '1 tsp allspice',
        '½ cup olive oil',
        'Juice of 2 lemons',
        'Salt and pepper to taste'
      ],
      'ku': [
        '٣٠-٤٠ گەڵاوی مێو',
        '٤ باینجانی بچووک',
        '٤ کوسە',
        '٢ پەرداخ برنج',
        '٥٠٠ گرام گۆشتی بەرخ یان مانگای هاڕاو',
        '١ پیازی گەورە (وردکراوە)',
        '١/٤ پەرداخ سماق',
        '٢ قاشق خواردن دۆشاوی تەماتە',
        '١ قاشقە چای بەهاراتی هەموو جۆرە',
        '١/٢ پەرداخ ڕۆنی زەیتوون',
        'ئاوی ٢ لیمۆ',
        'خوێ و بیبەر بەپێی دڵخوازی'
      ],
    },
    steps: {
      'en': [
        '1. If using jarred grape leaves, rinse well to remove brine. Blanch fresh leaves in boiling water for 2 minutes.',
        '2. Cut tops off eggplants and zucchinis, hollow out centers carefully.',
        '3. In a bowl, mix rice, ground meat, chopped onion, sumac, tomato paste, and spices.',
        '4. Stuff vegetables and grape leaves with the mixture, folding leaves like envelopes.',
        '5. Layer stuffed vegetables and dolmas in a large pot, placing heavier items at the bottom.',
        '6. Add enough water to cover, olive oil, and lemon juice. Place a plate on top to keep dolmas submerged.',
        '7. Bring to boil, then reduce heat and simmer for 45-60 minutes until rice is cooked.',
        '8. Let cool for 15 minutes before serving with yogurt.'
      ],
      'ku': [
        '١. ئەگەر گەڵاوی قووتاو بەکاردێنیت، باش بشۆ بۆ لابردنی خوێیەکە. گەڵاوی تازە بۆ ٢ خولەک لە ئاوی کوڵاندابکە.',
        '٢. سەری باینجان و کوسەکان ببڕە و ناوەکیان بە وردبینی بەتاڵ بکە.',
        '٣. لە قاپێکدا، برنج و گۆشت و پیاز و سماق و دۆشاو و بەهاراتەکان تێکەڵ بکە.',
        '٤. سەوزەکان و گەڵاکان پڕ بکە بەم تێکەڵە و گەڵاکان بپێچەرەوە وەک پاکەت.',
        '٥. سەوزە پڕکراوەکان و دۆڵمەکان لە مەنجەڵێکی گەورەدا ڕیز بکە، قورسەکان لە خوارەوە بنێ.',
        '٦. ئاو بە قەبارەی داپۆشینی زیاد بکە، ڕۆنی زەیتوون و ئاوی لیمۆش زیاد بکە. قاپێک لەسەریان بێنە بۆ ئەوەی ناو ئاو بمێننەوە.',
        '٧. بگەڕێنەوە بۆ کوڵان، پاشان گەرمی کەم بکە و بۆ ٤٥-٦٠ خولەک بگەڕێ تا برنجەکە بپوختێت.',
        '٨. بۆ ١٥ خولەک پێش خواردن ڕایان بگەڕێنە و لەگەڵ ماست پێشکەشی بکە.'
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
      'en': [
        '500g ground beef (80/20 fat ratio)',
        '1 large onion (grated)',
        '1 bunch fresh parsley (finely chopped)',
        '½ cup breadcrumbs',
        '1 egg',
        '2 tsp salt',
        '1 tsp black pepper',
        '1 tsp paprika',
        '½ tsp cumin',
        '2 tbsp vegetable oil for frying'
      ],
      'ku': [
        '٥٠٠ گرام گۆشتی مانگای هاڕاو',
        '١ پیازی گەورە (هەڕەکراوە)',
        '١ کۆپی جەعفەری تازە (وردکراوە)',
        '١/٢ پەرداخ پاتاتە',
        '١ هێلکە',
        '٢ قاشقە چای خوێ',
        '١ قاشقە چای بیبەری ڕەش',
        '١ قاشقە چای بیبەری سوور',
        '١/٢ قاشقە چای کەمون',
        '٢ قاشق خواردن ڕۆنی ڕوەک بۆ سوورکردنەوە'
      ],
    },
    steps: {
      'en': [
        '1. In a large bowl, combine ground beef, grated onion, parsley, and breadcrumbs.',
        '2. Add egg, salt, pepper, paprika, and cumin. Mix well with hands until combined.',
        '3. Cover mixture and refrigerate for 30 minutes to firm up.',
        '4. Wet hands with water to prevent sticking, shape mixture into oval patties or meatballs.',
        '5. Heat oil in a large skillet over medium-high heat.',
        '6. Cook kofta for 4-5 minutes per side until browned and cooked through (internal temp 160°F/71°C).',
        '7. Drain on paper towels and serve with rice, salad, and tahini sauce.'
      ],
      'ku': [
        '١. لە قاپێکی گەورەدا، گۆشتی هاڕاو و پیازی هەڕاو و جەعفەری و پاتاتە تێکەڵ بکە.',
        '٢. هێلکە و خوێ و بیبەرەکان زیاد بکە. بە دەست باش تێکەڵ بکە تا یەک ببن.',
        '٣. تێکەڵەکە دایبخە و بۆ ٣٠ خولەک لە سەلادەر بخۆشێنەرەوە تا ڕەق ببێت.',
        '٤. دەستەکانت بە ئاو شڵەق بکە بۆ ڕێگری لە هاتنە پێشیان، تێکەڵەکە بکە بە شێوەی سەرە و خڕی گۆشت.',
        '٥. ڕۆن لە تاوێکدا گەرم بکە بە گەرمی ناوەڕاست.',
        '٦. کۆفتەکان بۆ ٤-٥ خولەک لە هەر لایەک بکوڵێنە تا سوور بن و بپوختن.',
        '٧. بە کلینکس وشکیان بکە و لەگەڵ برنج و زەڵاتە و سۆسی تەحین پێشکەشی بکە.'
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
      'en': [
        '1 lamb head (cleaned and split)',
        '4 lamb trotters (cleaned)',
        '2 lamb brains (optional)',
        '1 lamb tongue',
        '2 onions (quartered)',
        '10 cloves garlic',
        '2 tbsp turmeric',
        '1 tbsp black pepper',
        '2 tsp salt',
        '2 bay leaves',
        '1 cinnamon stick',
        'Fresh bread for serving'
      ],
      'ku': [
        '١ سەری بەرخ (پاککراوە و بڕدراوە)',
        '٤ پێی بەرخ (پاککراوە)',
        '٢ مێشکی بەرخ (ئارەزوویانە)',
        '١ زمانێکی بەرخ',
        '٢ پیاز (چوارپارچەکراوە)',
        '١٠ خاو سیر',
        '٢ قاشق خواردن زەردەچەوە',
        '١ قاشق خواردن بیبەری ڕەش',
        '٢ قاشقە چای خوێ',
        '٢ گەڵای ڕازە',
        '١ قەلیبی دارچین',
        'نانی تازە بۆ پێشکەشکردن'
      ],
    },
    steps: {
      'en': [
        '1. Thoroughly clean all lamb parts under running water, scrubbing trotters well.',
        '2. Place all meat in a large stockpot and cover with cold water.',
        '3. Bring to a boil, then reduce heat to low and skim off foam that rises to the surface.',
        '4. Add onions, garlic, turmeric, pepper, salt, bay leaves, and cinnamon stick.',
        '5. Simmer gently for 6-8 hours until meat is falling off the bone and trotters are gelatinous.',
        '6. Remove meat from bones and chop into bite-sized pieces.',
        '7. Strain broth through a fine mesh sieve and return meat to broth.',
        '8. Serve hot in bowls with bread for dipping into the rich broth.'
      ],
      'ku': [
        '١. هەموو پارچەکانی بەرخ بە باشی لە ژێر ئاوی ڕابەردا بشۆ، پێکان باش بسقێنە.',
        '٢. هەموو گۆشتەکان بخەرە ناو مەنجەڵێکی گەورە و بە ئاوی سارد داپۆشیان بکە.',
        '٣. بگەڕێنەوە بۆ کوڵان، پاشان گەرمی کەم بکە و کەفەکە لەسەر ڕوو کەڵەکەوە بسڕەوە.',
        '٤. پیاز و سیر و زەردەچەوە و بیبەر و خوێ و گەڵای ڕازە و قەلیبی دارچین زیاد بکە.',
        '٥. بە نەرمی بۆ ٦-٨ کاتژمێر بگەڕێ تا گۆشت لە ئێسک دەڕوات و پێکان ژەلەتین دەبن.',
        '٦. گۆشتەکان لە ئێسکەوە بسڕەوە و ببڕە بە قەبارەی گازن.',
        '٧. ئاوەکە بە گۆزێکی ورد بیپاڵێوە و گۆشتەکان بگەڕێنەوە ناوی.',
        '٨. گەرم لە قاپەکاندا پێشکەشی بکە لەگەڵ نان بۆ نوقمکردن لە ئاوە دەوڵەمەندەکە.'
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
      'en': [
        '2 cups fresh buffalo cream (qaymax)',
        '¼ cup pure honey',
        '¼ cup chopped walnuts',
        '1 tbsp rose petals (dried, optional)',
        'Fresh Kurdish naan or flatbread',
        'Fresh mint leaves for garnish'
      ],
      'ku': [
        '٢ پەرداخ قەیماغی سروشتی',
        '١/٤ پەرداخ هەنگوینی پاک',
        '١/٤ پەرداخ گوێزی وردکراو',
        '١ قاشق خواردن گوڵەبەڕۆژە (وشککراو، ئارەزوویانە)',
        'نانی کوردی یان نانی پەتپەتی تازە',
        'گەڵای نەعنای تازە بۆ ڕازاندنەوە'
      ],
    },
    steps: {
      'en': [
        '1. Place fresh qaymax in a serving bowl, smoothing the top with a spoon.',
        '2. Drizzle honey evenly over the cream in a circular pattern.',
        '3. Sprinkle chopped walnuts and dried rose petals over the top.',
        '4. Toast naan bread lightly over an open flame or in a hot pan until warm and slightly crisp.',
        '5. Garnish with fresh mint leaves.',
        '6. Serve immediately, using pieces of warm bread to scoop up the cream and honey mixture.'
      ],
      'ku': [
        '١. قەیماغی تازە بخەرە ناو قاپێکی پێشکەشکردن، سەرەکەی بە کەوچکێک ڕێک بخە.',
        '٢. هەنگوین بە یەکسانی بە شێوەی بازنەیی بکە بەسەر قەیماغەکەدا.',
        '٣. گوێزی وردکراو و گوڵەبەڕۆژەی وشککراو بپاش بە سەری.',
        '٤. نانی نان بە نەرمی لەسەر ئاگرێکی کراوە یان لە تاوێکی گەرمدا ببرژێنە تا گەرم بێت و کەمێک ڕەق بێت.',
        '٥. بە گەڵای نەعنای تازە ڕازێنەرەوە.',
        '٦. یەکسەر پێشکەشی بکە، پارچە نانی گەرم بەکاربێنە بۆ هەڵگرتنی تێکەڵەی قەیماغ و هەنگوین.'
      ],
    },
  ),
  Recipe(
    id: '6',
    title: {'en': 'Kurdish Biryani', 'ku': 'بریانی کوردی'},
    icon: '🍛',
    nutrition: NutritionalInfo(calories: 620, protein: 25, carbs: 80, fats: 20),
    category: MealCategory.lunch,
    rating: 4.8,
    ratingCount: 150,
    ingredients: {
      'en': [
        '2 cups basmati rice',
        '500g chicken or lamb (cubed)',
        '2 large potatoes (peeled and cubed)',
        '1 cup green peas (fresh or frozen)',
        '½ cup raisins',
        '½ cup slivered almonds',
        '2 large onions (sliced)',
        '4 cloves garlic (minced)',
        '2 tbsp biryani spice mix',
        '½ cup yogurt',
        '¼ cup ghee or butter',
        '4 cups chicken or vegetable broth',
        'Saffron strands (soaked in 2 tbsp milk)'
      ],
      'ku': [
        '٢ پەرداخ برنجی بەسمەتی',
        '٥٠٠ گرام مریشک یان بەرخ (چوارگۆشەکراوە)',
        '٢ پەتاتەی گەورە (پەستێنراوی و چوارگۆشەکراوە)',
        '١ پەرداخ پۆتکەی سەوز',
        '١/٢ پەرداخ مێوژ',
        '١/٢ پەرداخ بادەمی وردکراو',
        '٢ پیازی گەورە (پەڕەکراوە)',
        '٤ خاو سیر (وردکراوە)',
        '٢ قاشق خواردن بەهاراتی بریانی',
        '١/٢ پەرداخ ماست',
        '١/٤ پەرداخ گی یان کەرە',
        '٤ پەرداخ ئاوی مریشک یان سەوزە',
        'چەند ڕیشاڵەی زەعفەران (خوساوە لە ٢ قاشق خواردن شیردا)'
      ],
    },
    steps: {
      'en': [
        '1. Wash rice and soak in water for 30 minutes, then drain.',
        '2. Marinate meat in yogurt, half the biryani spices, and garlic for 1 hour.',
        '3. Heat ghee in a large pot and fry onions until golden brown. Remove half for garnish.',
        '4. Add marinated meat and cook until browned on all sides.',
        '5. Add potatoes, peas, and remaining spices. Cook for 5 minutes.',
        '6. Layer soaked rice over the meat mixture, then sprinkle raisins and almonds.',
        '7. Pour hot broth over rice, add saffron milk, and bring to a boil.',
        '8. Reduce heat to low, cover tightly, and cook for 20-25 minutes until rice is tender.',
        '9. Let rest for 10 minutes before fluffing with a fork. Garnish with fried onions.'
      ],
      'ku': [
        '١. برنج بشۆ و بۆ ٣٠ خولەک لە ئاو بخۆشێنە، پاشان بیپاڵێوە.',
        '٢. گۆشت بۆ ١ کاتژمێر لە ماست و نیوەی بەهاراتی بریانی و سیر بخۆشێنە.',
        '٣. گی لە مەنجەڵێکی گەورەدا گەرم بکە و پیاز ببرژێنە تا زەردی قاوەیی. نیوەی بکە بۆ ڕازاندنەوە.',
        '٤. گۆشتی خوساوەکە زیاد بکە و بکوڵێنە تا لە هەموو لایەک سوور بێت.',
        '٥. پەتاتە و پۆتکە و بەهاراتی ماوە زیاد بکە. بۆ ٥ خولەک بکوڵێنە.',
        '٦. برنجی خوساوە لەسەر تێکەڵەی گۆشت ڕیز بکە، پاشان مێوژ و بادەم بپاش بە سەری.',
        '٧. ئاوی گەرم بکە بەسەر برنجەکە، شیرە زەعفەرانەکەش زیاد بکە و بگەڕێنەوە بۆ کوڵان.',
        '٨. گەرمی کەم بکە، دایبخە و بۆ ٢٠-٢٥ خولەک بکوڵێنە تا برنج نەرم بێت.',
        '٩. بۆ ١٠ خولەک پێش خواردن ڕای بگەڕێنە و بە کەوچکەوە لێی بدە. بە پیازی سوورکراوە ڕازێنەرەوە.'
      ],
    },
  ),
  Recipe(
    id: '7',
    title: {'en': 'Potato Kubba', 'ku': 'کوبەی پەتاتە'},
    icon: '🍘',
    nutrition: NutritionalInfo(calories: 320, protein: 12, carbs: 45, fats: 10),
    category: MealCategory.snack,
    rating: 4.5,
    ratingCount: 89,
    ingredients: {
      'en': [
        '4 large potatoes (boiled and mashed)',
        '1 cup semolina flour',
        '250g ground beef or lamb',
        '1 onion (finely chopped)',
        '2 tbsp pine nuts',
        '1 tsp allspice',
        '½ tsp cinnamon',
        'Salt and pepper to taste',
        'Vegetable oil for frying'
      ],
      'ku': [
        '٤ پەتاتەی گەورە (کوڵاو و کوتراوە)',
        '١ پەرداخ ئاردی سمید',
        '٢٥٠ گرام گۆشتی مانگای یان بەرخ',
        '١ پیاز (وردکراوە)',
        '٢ قاشق خواردن دەنکە سنۆبەر',
        '١ قاشقە چای بەهاراتی هەموو جۆرە',
        '١/٢ قاشقە چای دارچین',
        'خوێ و بیبەر بەپێی دڵخوازی',
        'ڕۆنی ڕوەک بۆ سوورکردنەوە'
      ],
    },
    steps: {
      'en': [
        '1. Prepare filling: Sauté chopped onion in oil until golden, add ground meat and cook until browned.',
        '2. Add pine nuts and spices to meat mixture, cook for 2 more minutes, then set aside to cool.',
        '3. For dough: Combine mashed potatoes, semolina flour, and salt until smooth dough forms.',
        '4. Take golf-ball sized portions of dough, flatten in palm, place spoonful of filling in center.',
        '5. Carefully fold dough around filling, sealing edges completely to form oval shape.',
        '6. Heat oil to 350°F (175°C) in deep fryer or heavy pot.',
        '7. Fry kubba in batches until golden brown, about 4-5 minutes per batch.',
        '8. Drain on paper towels and serve warm with yogurt or tahini sauce.'
      ],
      'ku': [
        '١. ناوەکە ئامادە بکە: پیازی وردکراو لە ڕۆندا ببرژێنە تا زەرد بێت، گۆشتی هاڕاو زیاد بکە و بکوڵێنە تا سوور بێت.',
        '٢. دەنکە سنۆبەر و بەهاراتەکان زیاد بکە، بۆ ٢ خولەکی زیاتر بکوڵێنە، پاشان دانێ بۆ ساردبوون.',
        '٣. بۆ هەویری: پەتاتەی کوتراو و ئاردی سمید و خوێ تێکەڵ بکە تا هەویریەکی ڕێک دروست بێت.',
        '٤. پارچە بە قەبارەی تۆپی گۆڵف لە هەویرەکە وەربگرە، لە ناوەڕاستی دەستدا پەت بکە، کەوچکێک لە ناوەکە بخەرە ناوەڕاستی.',
        '٥. بە وردبینی هەویرەکە بپێچەرەوە بە دەوری ناوەکە، لایەکان بە تەواوی داخڵ بکە بۆ دروستکردنی شێوەی سەرە.',
        '٦. ڕۆن بۆ ١٧٥ پلەی سیلیزی گەرم بکە لە برژێنەرێکی قوڵ یان مەنجەڵێکی قورسدا.',
        '٧. کوبەکان بە کۆمەڵە ببرژێنە تا زەردی قاوەیی، نزیکەی ٤-٥ خولەک بۆ هەر کۆمەڵەیەک.',
        '٨. بە کلینکس وشکیان بکە و گەرم لەگەڵ ماست یان سۆسی تەحین پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '8',
    title: {'en': 'Meat Tashreeb', 'ku': 'تەشیریبی گۆشت'},
    icon: '🥘',
    nutrition: NutritionalInfo(calories: 600, protein: 45, carbs: 40, fats: 30),
    category: MealCategory.lunch,
    rating: 4.6,
    ratingCount: 112,
    ingredients: {
      'en': [
        '1kg lamb shanks or shoulder',
        '4 pieces Kurdish naan or pita bread',
        '2 onions (chopped)',
        '4 cloves garlic (minced)',
        '1 tbsp tomato paste',
        '1 tsp turmeric',
        '1 tsp paprika',
        '1 cinnamon stick',
        '2 bay leaves',
        'Salt and pepper to taste',
        'Fresh parsley for garnish'
      ],
      'ku': [
        '١ کیلۆگرام ڕانی بەرخ یان شانی',
        '٤ پارچە نانی کوردی یان پیتا',
        '٢ پیاز (وردکراوە)',
        '٤ خاو سیر (وردکراوە)',
        '١ قاشق خواردن دۆشاوی تەماتە',
        '١ قاشقە چای زەردەچەوە',
        '١ قاشقە چای بیبەری سوور',
        '١ قەلیبی دارچین',
        '٢ گەڵای ڕازە',
        'خوێ و بیبەر بەپێی دڵخوازی',
        'جەعفەری تازە بۆ ڕازاندنەوە'
      ],
    },
    steps: {
      'en': [
        '1. Season lamb shanks generously with salt and pepper.',
        '2. Brown lamb in a large pot over medium-high heat on all sides (about 3-4 minutes per side).',
        '3. Remove lamb and set aside. In same pot, sauté onions until translucent.',
        '4. Add garlic, tomato paste, and spices. Cook for 1-2 minutes until fragrant.',
        '5. Return lamb to pot and add enough water to cover (about 8 cups).',
        '6. Add cinnamon stick and bay leaves. Bring to boil, then reduce to simmer.',
        '7. Cover and cook for 2-3 hours until meat is fork-tender.',
        '8. Toast bread pieces until slightly crisp, then place in serving bowls.',
        '9. Pour hot broth and meat over bread. Garnish with fresh parsley.'
      ],
      'ku': [
        '١. ڕانی بەرخ بە دەروونی بە خوێ و بیبەر بەهارات بدە.',
        '٢. بەرخەکە لە مەنجەڵێکی گەورەدا بە گەرمی ناوەڕاست ببرژێنە لە هەموو لایەک (نزیکەی ٣-٤ خولەک بۆ هەر لایەک).',
        '٣. بەرخەکە لابە و دانێ. لە هەمان مەنجەڵدا، پیاز ببرژێنە تا نیمچە ڕووناک بێت.',
        '٤. سیر و دۆشاوی تەماتە و بەهاراتەکان زیاد بکە. بۆ ١-٢ خولەک بکوڵێنە تا بۆنێکی خۆش هەبێت.',
        '٥. بەرخەکە بگەڕێنەوە ناو مەنجەڵ و ئاو بە قەبارەی داپۆشینی زیاد بکە (نزیکەی ٨ پەرداخ).',
        '٦. قەلیبی دارچین و گەڵای ڕازە زیاد بکە. بگەڕێنەوە بۆ کوڵان، پاشان بگەڕێ بۆ نەرمکوڵان.',
        '٧. دایبخە و بۆ ٢-٣ کاتژمێر بکوڵێنە تا گۆشت بە کەوچکەوە نەرم بێت.',
        '٨. پارچە نانەکان ببرژێنە تا کەمێک ڕەق ببن، پاشان بخەرە ناو قاپەکانی پێشکەشکردن.',
        '٩. ئاوی گەرم و گۆشتەکە بکە بەسەر نانەکە. بە جەعفەری تازە ڕازێنەرەوە.'
      ],
    },
  ),
  Recipe(
    id: '9',
    title: {'en': 'Lentil Soup', 'ku': 'شۆربای نیسک'},
    icon: '🥣',
    nutrition: NutritionalInfo(calories: 210, protein: 12, carbs: 30, fats: 4),
    category: MealCategory.cutting,
    rating: 4.4,
    ratingCount: 95,
    ingredients: {
      'en': [
        '1 cup red lentils',
        '1 onion (chopped)',
        '2 carrots (diced)',
        '2 celery stalks (chopped)',
        '3 cloves garlic (minced)',
        '1 tsp cumin',
        '½ tsp turmeric',
        '6 cups vegetable broth',
        '2 tbsp lemon juice',
        'Fresh cilantro for garnish',
        'Salt and pepper to taste'
      ],
      'ku': [
        '١ پەرداخ نیسکی سوور',
        '١ پیاز (وردکراوە)',
        '٢ گێزەر (چوارگۆشەکراوە)',
        '٢ قەدە کەرەوز (وردکراوە)',
        '٣ خاو سیر (وردکراوە)',
        '١ قاشقە چای کەمون',
        '١/٢ قاشقە چای زەردەچەوە',
        '٦ پەرداخ ئاوی سەوزە',
        '٢ قاشق خواردن ئاوی لیمۆ',
        'کەزەره یان جەعفەری تازە بۆ ڕازاندنەوە',
        'خوێ و بیبەر بەپێی دڵخوازی'
      ],
    },
    steps: {
      'en': [
        '1. Rinse lentils thoroughly under cold water until water runs clear.',
        '2. In a large pot, sauté onions, carrots, and celery over medium heat until softened (5-7 minutes).',
        '3. Add garlic, cumin, and turmeric. Cook for 1 minute until fragrant.',
        '4. Add lentils and vegetable broth. Bring to a boil.',
        '5. Reduce heat to low, cover, and simmer for 25-30 minutes until lentils are very soft.',
        '6. Remove from heat and blend soup until smooth using an immersion blender or regular blender.',
        '7. Return to pot if needed, stir in lemon juice, and season with salt and pepper.',
        '8. Simmer for 5 more minutes. Garnish with fresh cilantro before serving.'
      ],
      'ku': [
        '١. نیسکەکە بە باشی لە ژێر ئاوی سارددا بشۆ تا ئاوەکە ڕوون بێت.',
        '٢. لە مەنجەڵێکی گەورەدا، پیاز و گێزەر و کەرەوز لە گەرمی ناوەڕاستدا ببرژێنە تا نەرم ببن (٥-٧ خولەک).',
        '٣. سیر و کەمون و زەردەچەوە زیاد بکە. بۆ ١ خولەک بکوڵێنە تا بۆنێکی خۆش هەبێت.',
        '٤. نیسک و ئاوی سەوزە زیاد بکە. بگەڕێنەوە بۆ کوڵان.',
        '٥. گەرمی کەم بکە، دایبخە و بۆ ٢٥-٣٠ خولەک بگەڕێ تا نیسکەکە زۆر نەرم بێت.',
        '٦. لە گەرمی لابە و شۆرباکە بلفێنە تا ڕێک بێت بە بەکارهێنانی بلێندەر.',
        '٧. ئەگەر پێویست بوو بگەڕێنەوە ناو مەنجەڵ، ئاوی لیمۆ تێکەڵی بکە و بە خوێ و بیبەر بەهارات بدە.',
        '٨. بۆ ٥ خولەکی زیاتر بگەڕێ. بە کەزەره یان جەعفەری تازە ڕازێنەرەوە پێش پێشکەشکردن.'
      ],
    },
  ),
  Recipe(
    id: '10',
    title: {'en': 'Kurdish Salad', 'ku': 'زەڵاتەی کوردی'},
    icon: '🥗',
    nutrition: NutritionalInfo(calories: 90, protein: 2, carbs: 10, fats: 5),
    category: MealCategory.cutting,
    rating: 4.3,
    ratingCount: 78,
    ingredients: {
      'en': [
        '2 large cucumbers (diced)',
        '4 medium tomatoes (diced)',
        '1 red onion (thinly sliced)',
        '1 green bell pepper (diced)',
        '½ bunch fresh parsley (chopped)',
        '½ bunch fresh mint (chopped)',
        '3 tbsp olive oil',
        '2 tbsp lemon juice',
        '1 tbsp sumac',
        'Salt to taste'
      ],
      'ku': [
        '٢ خەیاری گەورە (چوارگۆشەکراوە)',
        '٤ تەماتەی مامناوەند (چوارگۆشەکراوە)',
        '١ پیازی سوور (پەڕەکراوە)',
        '١ بیبەری سەوز (چوارگۆشەکراوە)',
        '١/٢ کۆپی جەعفەری تازە (وردکراوە)',
        '١/٢ کۆپی نەعنای تازە (وردکراوە)',
        '٣ قاشق خواردن ڕۆنی زەیتوون',
        '٢ قاشق خواردن ئاوی لیمۆ',
        '١ قاشق خواردن سماق',
        'خوێ بەپێی دڵخوازی'
      ],
    },
    steps: {
      'en': [
        '1. Wash all vegetables thoroughly under cold running water.',
        '2. Dice cucumbers and tomatoes into ½-inch pieces, ensuring to remove excess seeds from tomatoes.',
        '3. Slice red onion into thin half-moons. Dice green bell pepper.',
        '4. Finely chop fresh parsley and mint leaves.',
        '5. In a large salad bowl, combine all vegetables and herbs.',
        '6. In a small bowl, whisk together olive oil, lemon juice, sumac, and salt.',
        '7. Pour dressing over salad and toss gently to combine.',
        '8. Let salad sit for 10-15 minutes before serving to allow flavors to meld.',
        '9. Adjust seasoning if needed and serve as a refreshing side dish.'
      ],
      'ku': [
        '١. هەموو سەوزەکان بە باشی لە ژێر ئاوی ساردی ڕابەردا بشۆ.',
        '٢. خەیار و تەماتەکان ببڕە بە قەبارەی نیوەی ئینج، دڵنیابە لە سڕینەوەی تۆوی زیادەی تەماتە.',
        '٣. پیازی سوور ببڕە بە تەنکی بە شێوەی نیوەمانگ. بیبەری سەوزیش چوارگۆشە بکە.',
        '٤. جەعفەری تازە و گەڵای نەعنا بە وردی ببڕە.',
        '٥. لە قاپێکی زەڵاتەی گەورەدا، هەموو سەوزەکان و گیاکان تێکەڵ بکە.',
        '٦. لە قاپێکی بچووکدا، ڕۆنی زەیتوون و ئاوی لیمۆ و سماق و خوێ تێکەڵ بکە.',
        '٧. ڕۆنەکە بکە بەسەر زەڵاتەکە و بە نەرمی تێکەڵی بکە.',
        '٨. ڕێگە بە زەڵاتەکە بدە بۆ ١٠-١٥ خولەک بمێنێتەوە پێش خواردن بۆ یەکگرتنی تامەکان.',
        '٩. ئەگەر پێویست بوو بەهاراتەکە دەستکاری بکە و وەک خواردنێکی لاوەکی فێنککەر پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '11',
    title: {'en': 'White Rice', 'ku': 'برنجی سپی'},
    icon: '🍚',
    nutrition: NutritionalInfo(calories: 350, protein: 6, carbs: 70, fats: 5),
    category: MealCategory.lunch,
    rating: 4.2,
    ratingCount: 65,
    ingredients: {
      'en': [
        '2 cups basmati rice',
        '3 cups water',
        '2 tbsp butter or ghee',
        '1 tsp salt',
        '½ tsp cumin seeds (optional)'
      ],
      'ku': [
        '٢ پەرداخ برنجی بەسمەتی',
        '٣ پەرداخ ئاو',
        '٢ قاشق خواردن کەرە یان گی',
        '١ قاشقە چای خوێ',
        '١/٢ قاشقە چای تۆوی کەمون (ئارەزوویانە)'
      ],
    },
    steps: {
      'en': [
        '1. Rinse rice in cold water 3-4 times until water runs almost clear.',
        '2. Soak rice in water for 30 minutes, then drain completely.',
        '3. In a heavy-bottomed pot, melt butter over medium heat.',
        '4. Add cumin seeds if using, and sauté for 30 seconds until fragrant.',
        '5. Add drained rice and salt. Stir gently for 2 minutes to coat rice with butter.',
        '6. Pour in 3 cups of water and bring to a rolling boil.',
        '7. Once boiling, reduce heat to lowest setting, cover tightly with lid.',
        '8. Cook for 15-18 minutes without peeking. Do not stir during cooking.',
        '9. Remove from heat and let stand covered for 5 minutes.',
        '10. Fluff rice gently with fork before serving.'
      ],
      'ku': [
        '١. برنجەکە ٣-٤ جار لە ئاوی سارددا بشۆ تا ئاوەکە نزیکەی ڕوون بێت.',
        '٢. برنجەکە بۆ ٣٠ خولەک لە ئاو بخۆشێنە، پاشان بە تەواوی بیپاڵێوە.',
        '٣. لە مەنجەڵێکی قوڵدا، کەرە لە گەرمی ناوەڕاستدا بوونەوە بێنە.',
        '٤. تۆوی کەمون زیاد بکە ئەگەر بەکاردێنیت، و بۆ ٣٠ چرکە ببرژێنە تا بۆنێکی خۆش هەبێت.',
        '٥. برنجی پاڵێوراو و خوێ زیاد بکە. بە نەرمی بۆ ٢ خولەک تێکەڵی بکە تا برنجەکە بە کەرە بپۆشرێت.',
        '٦. ٣ پەرداخ ئاو زیاد بکە و بگەڕێنەوە بۆ کوڵانی بەهێز.',
        '٧. کاتێک کوڵی، گەرمی کەم بکە بە لەرزترین ڕێژە، داپۆشی بە درزبەندی.',
        '٨. بۆ ١٥-١٨ خولەک بکوڵێنە بەبێ سەیرکردن. لە کاتی کوڵاندادا تێکەڵی مەکە.',
        '٩. لە گەرمی لابە و بۆ ٥ خولەک بە داپۆشراوی بمێنێتەوە.',
        '١٠. پێش خواردن بە کەوچکەوە بە نەرمی برنجەکە لێبدە.'
      ],
    },
  ),
  Recipe(
    id: '12',
    title: {'en': 'Shakshuka', 'ku': 'شەکشوکە'},
    icon: '🍳',
    nutrition: NutritionalInfo(calories: 280, protein: 18, carbs: 10, fats: 18),
    category: MealCategory.breakfast,
    rating: 4.7,
    ratingCount: 210,
    ingredients: {
      'en': [
        '6 eggs',
        '4 ripe tomatoes (diced)',
        '1 bell pepper (diced)',
        '1 onion (chopped)',
        '3 cloves garlic (minced)',
        '2 tbsp tomato paste',
        '1 tsp cumin',
        '1 tsp paprika',
        '½ tsp chili flakes (optional)',
        '3 tbsp olive oil',
        'Fresh parsley for garnish',
        'Salt and pepper to taste'
      ],
      'ku': [
        '٦ هێلکە',
        '٤ تەماتەی گەشکراو (چوارگۆشەکراوە)',
        '١ بیبەر (چوارگۆشەکراوە)',
        '١ پیاز (وردکراوە)',
        '٣ خاو سیر (وردکراوە)',
        '٢ قاشق خواردن دۆشاوی تەماتە',
        '١ قاشقە چای کەمون',
        '١ قاشقە چای بیبەری سوور',
        '١/٢ قاشقە چای پارچە بیبەری توون (ئارەزوویانە)',
        '٣ قاشق خواردن ڕۆنی زەیتوون',
        'جەعفەری تازە بۆ ڕازاندنەوە',
        'خوێ و بیبەر بەپێی دڵخوازی'
      ],
    },
    steps: {
      'en': [
        '1. Heat olive oil in a large skillet or frying pan over medium heat.',
        '2. Add chopped onions and bell pepper. Sauté for 5-7 minutes until softened.',
        '3. Add minced garlic and cook for 1 minute until fragrant.',
        '4. Stir in diced tomatoes, tomato paste, cumin, paprika, and chili flakes.',
        '5. Cook tomato mixture for 10-12 minutes until thickened slightly.',
        '6. Season with salt and pepper to taste.',
        '7. Create 6 small wells in the tomato mixture using a spoon.',
        '8. Crack one egg into each well. Cover pan and cook for 5-8 minutes until egg whites are set but yolks are still runny.',
        '9. Garnish with fresh parsley and serve immediately with crusty bread.'
      ],
      'ku': [
        '١. ڕۆنی زەیتوون لە تاوێکی گەورە یان تاوێکی برژاندندا گەرم بکە لە گەرمی ناوەڕاست.',
        '٢. پیازی وردکراو و بیبەر زیاد بکە. بۆ ٥-٧ خولەک ببرژێنە تا نەرم ببن.',
        '٣. سیر وردکراو زیاد بکە و بۆ ١ خولەک بکوڵێنە تا بۆنێکی خۆش هەبێت.',
        '٤. تەماتەی چوارگۆشەکراو و دۆشاوی تەماتە و کەمون و بیبەری سوور و پارچە بیبەری توون تێکەڵی بکە.',
        '٥. تێکەڵەی تەماتە بۆ ١٠-١٢ خولەک بکوڵێنە تا کەمێک خەست ببێتەوە.',
        '٦. بە خوێ و بیبەر بەپێی دڵخوازی بەهارات بدە.',
        '٧. ٦ چاڵی بچووک لە تێکەڵەی تەماتە دروست بکە بە بەکارهێنانی کەوچک.',
        '٨. هێلکەیەک بخەرە ناو هەر چاڵێک. تاوەکە دایبخە و بۆ ٥-٨ خولەک بکوڵێنە تا سپی هێلکەکان ڕەق ببن بەڵام زەردەکەیان هێشتا شل بێت.',
        '٩. بە جەعفەری تازە ڕازێنەرەوە و یەکسەر لەگەڵ نانی ڕەق پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '13',
    title: {'en': 'Honey & Butter', 'ku': 'هەنگوین و کەرە'},
    icon: '🍯',
    nutrition: NutritionalInfo(calories: 320, protein: 1, carbs: 40, fats: 18),
    category: MealCategory.breakfast,
    rating: 4.6,
    ratingCount: 98,
    ingredients: {
      'en': [
        '½ cup unsalted butter',
        '½ cup pure honey',
        'Pinch of salt',
        'Fresh Kurdish naan or bread',
        'Optional: crushed walnuts or almonds'
      ],
      'ku': [
        '١/٢ پەرداخ کەرەی بێ خوێ',
        '١/٢ پەرداخ هەنگوینی پاک',
        'بڵێسەی خوێ',
        'نانی کوردی یان نانی تازە',
        'ئارەزوویانە: گوێز یان بادەمی وردکراو'
      ],
    },
    steps: {
      'en': [
        '1. Allow butter to soften at room temperature for 30 minutes.',
        '2. In a mixing bowl, combine softened butter and honey.',
        '3. Add a pinch of salt to enhance flavors.',
        '4. Whisk vigorously or beat with electric mixer for 2-3 minutes until light and fluffy.',
        '5. If using nuts, fold in crushed walnuts or almonds.',
        '6. Toast bread lightly until warm and slightly crisp.',
        '7. Spread honey-butter mixture generously on warm bread.',
        '8. Serve immediately with hot tea or milk.'
      ],
      'ku': [
        '١. ڕێگە بە کەرە بدە بۆ ٣٠ خولەک لە پلەی گەرمی ژووردا نەرم بێت.',
        '٢. لە قاپێکی تێکەڵکردندا، کەرەی نەرمکراو و هەنگوین تێکەڵ بکە.',
        '٣. بڵێسەیەک خوێ زیاد بکە بۆ باشترکردنی تامەکان.',
        '٤. بە بەهێزی تێکەڵ بکە یان بە تێکەڵکەری کارەبایی بۆ ٢-٣ خولەک بدە تا ڕووناک و پڕ بێت.',
        '٥. ئەگەر چەرەز بەکاردێنیت، گوێز یان بادەمی وردکراو زیاد بکە.',
        '٦. نان بە نەرمی ببرژێنە تا گەرم بێت و کەمێک ڕەق بێت.',
        '٧. تێکەڵەی هەنگوین و کەرە بە دەروونی لەسەر نانی گەرمدا بڵاو بکەرەوە.',
        '٨. یەکسەر لەگەڵ چایە گەرم یان شیر پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '14',
    title: {'en': 'Kurdish Naan', 'ku': 'نانی کوردی'},
    icon: '🫓',
    nutrition: NutritionalInfo(calories: 260, protein: 7, carbs: 50, fats: 3),
    category: MealCategory.breakfast,
    rating: 4.8,
    ratingCount: 145,
    ingredients: {
      'en': [
        '4 cups all-purpose flour',
        '1½ cups warm water',
        '2 tsp active dry yeast',
        '1 tsp sugar',
        '1 tsp salt',
        '2 tbsp plain yogurt',
        'Sesame seeds or nigella seeds for topping'
      ],
      'ku': [
        '٤ پەرداخ ئاردی هەموو مەبەست',
        '١١/٢ پەرداخ ئاوی گەرم',
        '٢ قاشقە چای خمیری وشک',
        '١ قاشقە چای شەکر',
        '١ قاشقە چای خوێ',
        '٢ قاشق خواردن ماست',
        'تۆوی کنجد یان کەوەرە بۆ سەرەوە'
      ],
    },
    steps: {
      'en': [
        '1. Dissolve sugar in warm water, then sprinkle yeast over top. Let sit for 10 minutes until foamy.',
        '2. In large bowl, combine flour and salt. Make a well in center.',
        '3. Pour yeast mixture and yogurt into the well. Mix until dough comes together.',
        '4. Knead dough on floured surface for 8-10 minutes until smooth and elastic.',
        '5. Place dough in oiled bowl, cover, and let rise in warm place for 1-2 hours until doubled.',
        '6. Punch down dough and divide into 6 equal portions.',
        '7. Roll each portion into oval shape, about ¼-inch thick.',
        '8. Preheat oven to 475°F (245°C) with pizza stone or baking sheet inside.',
        '9. Wet fingers and make indentations across naan. Sprinkle with seeds.',
        '10. Bake for 6-8 minutes until puffed and golden brown.',
        '11. Brush with butter immediately after removing from oven.'
      ],
      'ku': [
        '١. شەکر لە ئاوی گەرمدا بڕەواز بکە، پاشان خمیر بپاش بە سەری. ڕێگە بدە بۆ ١٠ خولەک بمێنێتەوە تا کەف دروست بکات.',
        '٢. لە قاپێکی گەورەدا، ئارد و خوێ تێکەڵ بکە. چاڵێک لە ناوەڕاستیدا دروست بکە.',
        '٣. تێکەڵەی خمیر و ماست بخەرە ناو چاڵەکە. تێکەڵ بکە تا هەویر یەک بگرێت.',
        '٤. هەویرەکە لەسەر ڕوویەکی ئاردپاشی بۆ ٨-١٠ خولەک چەقێنە تا ڕێک و وەرگیراو بێت.',
        '٥. هەویرەکە بخەرە ناو قاپێکی ڕۆنپاشی، دایبخە و ڕێگە بدە لە شوێنێکی گەرمدا بۆ ١-٢ کاتژمێر بڕوا بێت تا دوو هێندە ببێت.',
        '٦. هەویرەکە بچەقێنە و بڕی بە ٦ پارچەی یەکسانی.',
        '٧. هەر پارچەیەک بکە بە شێوەی سەرە، نزیکەی چارەگی ئینج ئەستوور.',
        '٨. فڕنەکە بۆ ٢٤٥ پلەی سیلیزی گەرم بکە لەگەڵ بەردی پیتزا یان پانیەکی برژاندن لە ناوی.',
        '٩. پەنجەکانت شڵەق بکە و چاڵ لەناو نانەکە دروست بکە. تۆوی کنجد یان کەوەرە بپاش بە سەری.',
        '١٠. بۆ ٦-٨ خولەک ببرژێنە تا بفورکێت و زەردی قاوەیی بێت.',
        '١١. یەکسەر دوای دەرکردنی لە فڕنەکە بە کەرە بیڕەواز بکە.'
      ],
    },
  ),
  Recipe(
    id: '15',
    title: {'en': 'Masgouf (Fish)', 'ku': 'مەسگوف'},
    icon: '🐟',
    nutrition: NutritionalInfo(calories: 400, protein: 45, carbs: 0, fats: 20),
    category: MealCategory.dinner,
    rating: 4.7,
    ratingCount: 132,
    ingredients: {
      'en': [
        '1 whole carp or similar firm fish (2-3kg)',
        '½ cup olive oil',
        '3 tbsp tamarind paste',
        '2 tbsp tomato paste',
        '2 onions (sliced)',
        '4 cloves garlic (minced)',
        '1 tsp turmeric',
        '1 tsp paprika',
        'Salt to taste',
        'Lemon wedges for serving'
      ],
      'ku': [
        '١ ماسی تەواو (٢-٣ کیلۆ)',
        '١/٢ پەرداخ ڕۆنی زەیتوون',
        '٣ قاشق خواردن دۆشاوی تەمر هیندی',
        '٢ قاشق خواردن دۆشاوی تەماتە',
        '٢ پیاز (پەڕەکراوە)',
        '٤ خاو سیر (وردکراوە)',
        '١ قاشقە چای زەردەچەوە',
        '١ قاشقە چای بیبەری سوور',
        'خوێ بەپێی دڵخوازی',
        'پارچە لیمۆ بۆ پێشکەشکردن'
      ],
    },
    steps: {
      'en': [
        '1. Clean fish thoroughly, removing scales and guts. Rinse under cold water.',
        '2. Make 3-4 deep diagonal cuts on each side of fish to help marinade penetrate.',
        '3. In bowl, mix olive oil, tamarind paste, tomato paste, garlic, turmeric, paprika, and salt.',
        '4. Rub marinade all over fish, inside cuts, and cavity. Marinate for 1-2 hours.',
        '5. Prepare charcoal grill with medium-hot coals.',
        '6. Place fish on grill, skin side down first. Cook for 15-20 minutes.',
        '7. Carefully flip fish using two spatulas. Cook other side for 15-20 minutes.',
        '8. Baste occasionally with remaining marinade.',
        '9. Fish is done when flesh flakes easily with fork and skin is crispy.',
        '10. Serve with lemon wedges, onions, and fresh herbs.'
      ],
      'ku': [
        '١. ماسیەکە بە باشی پاک بکەرەوە، قەبارەکانی لابە و ڕیخۆڵەکەی. لە ژێر ئاوی سارددا بشۆ.',
        '٣. لە قاپێکدا، ڕۆنی زەیتوون و دۆشاوی تەمر هیندی و دۆشاوی تەماتە و سیر و زەردەچەوە و بیبەری سوور و خوێ تێکەڵ بکە.',
        '٤. تێکەڵەکە بە سەر هەموو ماسیەکە بڵاو بکەرەوە، لەناو برینەکان و ناوەوەش. بۆ ١-٢ کاتژمێر بخۆشێنە.',
        '٥. برژێنەری خەڵوز ئامادە بکە بە خەڵوزی ناوەڕاست گەرم.',
        '٦. ماسیەکە بخەرە سەر برژێنەرەکە، لای پێستەکە یەکەم خوارەوە بێت. بۆ ١٥-٢٠ خولەک بکوڵێنە.',
        '٧. بە وردبینی ماسیەکە بگۆڕە بە بەکارهێنانی دوو ڕووکەش. لایەکەی تری بۆ ١٥-٢٠ خولەک بکوڵێنە.',
        '٨. هەندێک جار بە تێکەڵەی ماوە ڕووکەشی بکە.',
        '٩. ماسیەکە ئامادەیە کاتێک گۆشتەکە بە کەوچکەوە بە ئاسانی دەپچڕێت و پێستەکە ڕەقە.',
        '١٠. لەگەڵ پارچە لیمۆ و پیاز و گیای تازە پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '16',
    title: {'en': 'Kutilk (Boiled Kubba)', 'ku': 'کوتلک'},
    icon: '🥟',
    nutrition: NutritionalInfo(calories: 450, protein: 20, carbs: 55, fats: 15),
    category: MealCategory.lunch,
    rating: 4.5,
    ratingCount: 87,
    ingredients: {
      'en': [
        '2 cups fine bulgur',
        '1 cup semolina flour',
        '500g ground lamb',
        '2 onions (finely chopped)',
        '2 tbsp tomato paste',
        '1 tsp allspice',
        '½ tsp cinnamon',
        '8 cups chicken or beef broth',
        'Salt and pepper to taste',
        'Mint for garnish'
      ],
      'ku': [
        '٢ پەرداخ بڕوێشی ورد',
        '١ پەرداخ ئاردی سمید',
        '٥٠٠ گرام گۆشتی بەرخ',
        '٢ پیاز (وردکراوە)',
        '٢ قاشق خواردن دۆشاوی تەماتە',
        '١ قاشقە چای بەهاراتی هەموو جۆرە',
        '١/٢ قاشقە چای دارچین',
        '٨ پەرداخ ئاوی مریشک یان گۆشت',
        'خوێ و بیبەر بەپێی دڵخوازی',
        'نەعنا بۆ ڕازاندنەوە'
      ],
    },
    steps: {
      'en': [
        '1. Soak bulgur in warm water for 30 minutes, then drain and squeeze out excess water.',
        '2. Prepare filling: Sauté onions until golden, add lamb and cook until browned. Add tomato paste and spices.',
        '3. For dough: Combine bulgur, semolina, and 1 tsp salt. Knead into smooth dough.',
        '4. Take small portion of dough, form into ball, make indentation with thumb.',
        '5. Place teaspoon of filling in center, seal edges to form dumpling.',
        '6. Bring broth to boil in large pot. Add dumplings carefully.',
        '7. Simmer for 20-25 minutes until dumplings float to surface.',
        '8. Serve in bowls with broth. Garnish with fresh mint.'
      ],
      'ku': [
        '١. بڕوێشەکە بۆ ٣٠ خولەک لە ئاوی گەرمدا بخۆشێنە، پاشان بیپاڵێوە و ئاوی زیادەکەی پەستێنە.',
        '٢. ناوەکە ئامادە بکە: پیاز ببرژێنە تا زەرد بێت، بەرخ زیاد بکە و بکوڵێنە تا سوور بێت. دۆشاوی تەماتە و بەهاراتەکان زیاد بکە.',
        '٣. بۆ هەویری: بڕوێش و سمید و ١ قاشقە چای خوێ تێکەڵ بکە. چەقێنە تا هەویریەکی ڕێک بێت.',
        '٤. پارچەیەکی بچووک لە هەویرەکە وەربگرە، بیکە بە تۆپێک، بە پەنجەیەوە چاڵێکی تێدا دروست بکە.',
        '٥. کەوچکێکی چای لە ناوەکە بخەرە ناوەڕاستی، لایەکان داخڵ بکە بۆ دروستکردنی کوبە.',
        '٦. ئاوەکە لە مەنجەڵێکی گەورەدا بگەڕێنەوە بۆ کوڵان. کوبەکان بە وردبینی زیاد بکە.',
        '٧. بۆ ٢٠-٢٥ خولەک بگەڕێ تا کوبەکان لەسەر ڕوو بهێنن.',
        '٨. لە قاپەکاندا لەگەڵ ئاوەکە پێشکەشی بکە. بە نەعنای تازە ڕازێنەرەوە.'
      ],
    },
  ),
  Recipe(
    id: '17',
    title: {'en': 'Yaprak', 'ku': 'یاپراخ'},
    icon: '🥗',
    nutrition: NutritionalInfo(calories: 480, protein: 15, carbs: 70, fats: 12),
    category: MealCategory.dinner,
    rating: 4.6,
    ratingCount: 103,
    ingredients: {
      'en': [
        '40-50 grape leaves (fresh or jarred)',
        '2 cups short-grain rice',
        '500g ground lamb or beef',
        '1 large onion (grated)',
        '½ cup olive oil',
        '¼ cup lemon juice',
        '2 tbsp dried mint',
        '1 tbsp sugar',
        'Salt and pepper to taste',
        '2 cups chicken broth'
      ],
      'ku': [
        '٤٠-٥٠ گەڵاوی مێو',
        '٢ پەرداخ برنجی تۆکە کورت',
        '٥٠٠ گرام گۆشتی بەرخ یان مانگای هاڕاو',
        '١ پیازی گەورە (هەڕەکراوە)',
        '١/٢ پەرداخ ڕۆنی زەیتوون',
        '١/٤ پەرداخ ئاوی لیمۆ',
        '٢ قاشق خواردن نەعنای وشک',
        '١ قاشق خواردن شەکر',
        'خوێ و بیبەر بەپێی دڵخوازی',
        '٢ پەرداخ ئاوی مریشک'
      ],
    },
    steps: {
      'en': [
        '1. Rinse grape leaves thoroughly if using jarred. Blanch fresh leaves in boiling water for 2 minutes.',
        '2. In bowl, mix rice, ground meat, grated onion, ¼ cup olive oil, dried mint, salt and pepper.',
        '3. Place grape leaf shiny side down. Place 1 tablespoon of filling near stem end.',
        '4. Fold sides over filling, then roll tightly toward tip of leaf.',
        '5. Layer rolled yaprak tightly in pot, seam side down.',
        '6. Mix remaining olive oil, lemon juice, sugar, and broth. Pour over yaprak.',
        '7. Place plate on top to keep yaprak submerged. Bring to boil then simmer 45-50 minutes.',
        '8. Let cool 30 minutes before serving. Can be served warm or at room temperature.'
      ],
      'ku': [
        '١. گەڵاوی مێو باش بشۆ ئەگەر قووتاو بەکاردێنیت. گەڵاوی تازە بۆ ٢ خولەک لە ئاوی کوڵاندابکە.',
        '٢. لە قاپێکدا، برنج و گۆشتی هاڕاو و پیازی هەڕاو و ١/٤ پەرداخ ڕۆنی زەیتوون و نەعنای وشک و خوێ و بیبەر تێکەڵ بکە.',
        '٣. گەڵاوی مێو دانێ بە لای بریقەدارەکەی خوارەوە. ١ قاشق خواردن لە ناوەکە دانێ نزیک کۆتایی قەدەکە.',
        '٤. لایەکان بپێچەرەوە بەسەر ناوەکە، پاشان بە تەنگی بڕۆ بەرەو سەری گەڵاکە.',
        '٥. یاپراخە پێچراوەکان بە تەنگی لە مەنجەڵدا ڕیز بکە، لای داخڵکراوەکە خوارەوە بێت.',
        '٦. ڕۆنی زەیتوونی ماوە و ئاوی لیمۆ و شەکر و ئاوی مریشک تێکەڵ بکە. بکە بەسەر یاپراخەکاندا.',
        '٧. قاپێک لە سەریاندا بێنە بۆ ئەوەی یاپراخەکان لە ئاو بمێننەوە. بگەڕێنەوە بۆ کوڵان پاشان بۆ ٤٥-٥٠ خولەک بگەڕێ.',
        '٨. ڕێگە بدە بۆ ٣٠ خولەک سارد ببن پێش خواردن. دەتوانرێت گەرم یان لە پلەی گەرمی ژوور پێشکەش بکرێت.'
      ],
    },
  ),
  Recipe(
    id: '18',
    title: {'en': 'Shish Tawook', 'ku': 'شیش تاووق'},
    icon: '🍢',
    nutrition: NutritionalInfo(calories: 380, protein: 40, carbs: 5, fats: 15),
    category: MealCategory.dinner,
    rating: 4.8,
    ratingCount: 178,
    ingredients: {
      'en': [
        '1kg chicken breast (cut into 1-inch cubes)',
        '1 cup plain yogurt',
        '¼ cup lemon juice',
        '4 cloves garlic (minced)',
        '2 tbsp tomato paste',
        '1 tbsp paprika',
        '1 tsp cumin',
        '½ tsp cinnamon',
        '¼ cup olive oil',
        'Salt and pepper to taste',
        'Wooden or metal skewers'
      ],
      'ku': [
        '١ کیلۆگرام سنگی مریشک (بڕدراوە بە چوارگۆشەی ١ ئینج)',
        '١ پەرداخ ماست',
        '١/٤ پەرداخ ئاوی لیمۆ',
        '٤ خاو سیر (وردکراوە)',
        '٢ قاشق خواردن دۆشاوی تەماتە',
        '١ قاشق خواردن بیبەری سوور',
        '١ قاشقە چای کەمون',
        '١/٢ قاشقە چای دارچین',
        '١/٤ پەرداخ ڕۆنی زەیتوون',
        'خوێ و بیبەر بەپێی دڵخوازی',
        'شیشی دار یان کانزا'
      ],
    },
    steps: {
      'en': [
        '1. Soak wooden skewers in water for 30 minutes to prevent burning.',
        '2. In bowl, mix yogurt, lemon juice, garlic, tomato paste, spices, and olive oil.',
        '3. Add chicken cubes to marinade, coating thoroughly. Cover and refrigerate 4-24 hours.',
        '4. Thread chicken onto skewers, leaving small space between pieces.',
        '5. Preheat grill to medium-high heat (400°F/200°C).',
        '6. Grill skewers for 8-10 minutes, turning occasionally, until chicken is cooked through and charred in spots.',
        '7. Let rest 5 minutes before serving with garlic sauce, rice, and grilled vegetables.'
      ],
      'ku': [
        '١. شیشە دارەکان بۆ ٣٠ خولەک لە ئاو بخۆشێنە بۆ ڕێگری لە سووتان.',
        '٢. لە قاپێکدا، ماست و ئاوی لیمۆ و سیر و دۆشاوی تەماتە و بەهاراتەکان و ڕۆنی زەیتوون تێکەڵ بکە.',
        '٣. پارچە مریشکەکان زیاد بکە بۆ تێکەڵەکە، باش بپۆشیان بە. دایبخە و بۆ ٤-٢٤ کاتژمێر لە سەلادەر بخۆشێنەرەوە.',
        '٤. مریشکەکان بخەرە ناو شیشەکان، بۆشاییەکی بچووک لە نێوان پارچەکاندا بەجێبهێڵە.',
        '٥. برژێنەرەکە بۆ گەرمی ناوەڕاست گەرم بکە.',
        '٦. شیشەکان بۆ ٨-١٠ خولەک ببرژێنە، هەندێک جار بگۆڕەرێنە، تا مریشکەکە بپوختێت و لە هەندێک شوێندا سوور بێت.',
        '٧. بۆ ٥ خولەک پێش خواردن ڕایان بگەڕێنە و لەگەڵ سۆسی سیر و برنج و سەوزەی برژاو پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '19',
    title: {'en': 'Beef Shawarma', 'ku': 'گەسی گۆشت'},
    icon: '🥙',
    nutrition: NutritionalInfo(calories: 520, protein: 35, carbs: 30, fats: 28),
    category: MealCategory.lunch,
    rating: 4.7,
    ratingCount: 156,
    ingredients: {
      'en': [
        '800g beef sirloin or flank (thinly sliced)',
        '¼ cup olive oil',
        '¼ cup lemon juice',
        '4 cloves garlic (minced)',
        '1 tbsp paprika',
        '1 tbsp cumin',
        '1 tsp coriander',
        '1 tsp cinnamon',
        'Pita or lavash bread',
        'Tahini sauce',
        'Pickles, tomatoes, onions for serving'
      ],
      'ku': [
        '٨٠٠ گرام گۆشتی مانگا (بە تەنکی پەڕەکراوە)',
        '١/٤ پەرداخ ڕۆنی زەیتوون',
        '١/٤ پەرداخ ئاوی لیمۆ',
        '٤ خاو سیر (وردکراوە)',
        '١ قاشق خواردن بیبەری سوور',
        '١ قاشق خواردن کەمون',
        '١ قاشقە چای گوێزەبەڕۆ',
        '١ قاشقە چای دارچین',
        'نانی پیتا یان لەڤاش',
        'سۆسی تەحین',
        'ترشیات، تەماتە، پیاز بۆ پێشکەشکردن'
      ],
    },
    steps: {
      'en': [
        '1. Freeze beef for 30 minutes to make slicing easier. Slice as thinly as possible against the grain.',
        '2. Mix olive oil, lemon juice, garlic, and all spices in bowl.',
        '3. Add beef slices to marinade, mixing well. Marinate 2-4 hours or overnight.',
        '4. Heat large skillet or griddle over high heat. Cook beef in batches for 2-3 minutes per side.',
        '5. Alternatively, thread onto skewers and grill for 3-4 minutes per side.',
        '6. Warm bread slightly. Spread tahini sauce on bread.',
        '7. Add beef, pickles, sliced tomatoes, and onions.',
        '8. Roll tightly and serve immediately.'
      ],
      'ku': [
        '١. گۆشتی مانگا بۆ ٣٠ خولەک بەستە بۆ ئاسانترکردنی پەڕەکردن. وەک دەتوانیت بە تەنکی ببڕە دژ بە ڕیشاڵەکانی.',
        '٢. لە قاپێکدا، ڕۆنی زەیتوون و ئاوی لیمۆ و سیر و هەموو بەهاراتەکان تێکەڵ بکە.',
        '٣. پەڕەکانی گۆشت زیاد بکە بۆ تێکەڵەکە، باش تێکەڵی بکە. بۆ ٢-٤ کاتژمێر یان شەو بخۆشێنە.',
        '٤. تاوێکی گەورە یان ساج لە گەرمی بەرزدا گەرم بکە. گۆشتەکە بە کۆمەڵە بکوڵێنە بۆ ٢-٣ خولەک لە هەر لایەک.',
        '٥. بەجێیانە، بخەرە ناو شیشەکان و ببرژێنە بۆ ٣-٤ خولەک لە هەر لایەک.',
        '٦. نانەکە کەمێک گەرم بکە. سۆسی تەحین لەسەر نانەکە بڵاو بکەرەوە.',
        '٧. گۆشت و ترشیات و تەماتەی پەڕەکراو و پیاز زیاد بکە.',
        '٨. بە تەنگی بیپێچەرەوە و یەکسەر پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '20',
    title: {'en': 'Mutabal', 'ku': 'موتەبەل'},
    icon: '🍆',
    nutrition: NutritionalInfo(calories: 160, protein: 4, carbs: 10, fats: 12),
    category: MealCategory.snack,
    rating: 4.5,
    ratingCount: 92,
    ingredients: {
      'en': [
        '2 large eggplants',
        '¼ cup tahini',
        '3 cloves garlic (minced)',
        '3 tbsp lemon juice',
        '2 tbsp olive oil',
        '1 tbsp yogurt',
        'Salt to taste',
        'Pomegranate seeds and parsley for garnish'
      ],
      'ku': [
        '٢ باینجانی گەورە',
        '١/٤ پەرداخ تەحین',
        '٣ خاو سیر (وردکراوە)',
        '٣ قاشق خواردن ئاوی لیمۆ',
        '٢ قاشق خواردن ڕۆنی زەیتوون',
        '١ قاشق خواردن ماست',
        'خوێ بەپێی دڵخوازی',
        'تۆوی هەنار و جەعفەری بۆ ڕازاندنەوە'
      ],
    },
    steps: {
      'en': [
        '1. Preheat oven to 400°F (200°C). Pierce eggplants several times with fork.',
        '2. Place eggplants on baking sheet and roast for 45-60 minutes until completely soft and collapsed.',
        '3. Let eggplants cool until manageable. Peel off skin and drain excess liquid.',
        '4. Place eggplant flesh in bowl and mash with fork until smooth.',
        '5. Add tahini, garlic, lemon juice, and salt. Mix well.',
        '6. Stir in yogurt for creamier texture.',
        '7. Transfer to serving dish, drizzle with olive oil.',
        '8. Garnish with pomegranate seeds and parsley.',
        '9. Serve with warm pita bread or vegetables.'
      ],
      'ku': [
        '١. فڕنەکە بۆ ٢٠٠ پلەی سیلیزی گەرم بکە. باینجانەکان چەند جارێک بە کەوچک پێبدە.',
        '٢. باینجانەکان بخەرە سەر پانیەکی برژاندن و بۆ ٤٥-٦٠ خولەک ببرژێنە تا بە تەواوی نەرم بن و بڕوخێن.',
        '٣. ڕێگە بە باینجانەکان بدە تا بتوانرێت دەستیان پێبگیرێت. پێستیان لابە و ئاوی زیادەکەیان پەستێنە.',
        '٤. گۆشتی باینجانەکان بخەرە ناو قاپێک و بە کەوچکەوە بپلیشێنەرەوە تا ڕێک بێت.',
        '٥. تەحین و سیر و ئاوی لیمۆ و خوێ زیاد بکە. باش تێکەڵ بکە.',
        '٦. ماست تێکەڵی بکە بۆ قەبارەیەکی کرێمی.',
        '٧. بگوێرەوە بۆ قاپێکی پێشکەشکردن، ڕۆنی زەیتوونی پێدا بکە.',
        '٨. بە تۆوی هەنار و جەعفەری ڕازێنەرەوە.',
        '٩. لەگەڵ نانی پیتای گەرم یان سەوزە پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '21',
    title: {'en': 'Tabbouleh', 'ku': 'تەبولە'},
    icon: '🥗',
    nutrition: NutritionalInfo(calories: 140, protein: 3, carbs: 18, fats: 8),
    category: MealCategory.snack,
    rating: 4.6,
    ratingCount: 85,
    ingredients: {
      'en': [
        '1 cup fine bulgur',
        '3 bunches fresh parsley (finely chopped)',
        '½ bunch fresh mint (finely chopped)',
        '4 tomatoes (diced)',
        '1 cucumber (diced)',
        '4 green onions (thinly sliced)',
        '½ cup lemon juice',
        '⅓ cup olive oil',
        'Salt to taste'
      ],
      'ku': [
        '١ پەرداخ بڕوێشی ورد',
        '٣ کۆپی جەعفەری تازە (وردکراوە)',
        '١/٢ کۆپی نەعنای تازە (وردکراوە)',
        '٤ تەماتە (چوارگۆشەکراوە)',
        '١ خەیار (چوارگۆشەکراوە)',
        '٤ پیازی سەوز (بە تەنکی پەڕەکراوە)',
        '١/٢ پەرداخ ئاوی لیمۆ',
        '١/٣ پەرداخ ڕۆنی زەیتوون',
        'خوێ بەپێی دڵخوازی'
      ],
    },
    steps: {
      'en': [
        '1. Soak bulgur in hot water for 15 minutes until softened. Drain well, pressing out excess water.',
        '2. Wash parsley and mint thoroughly. Remove thick stems. Chop very finely with sharp knife.',
        '3. Dice tomatoes and cucumber. Slice green onions.',
        '4. In large bowl, combine bulgur, chopped herbs, and vegetables.',
        '5. Whisk together lemon juice, olive oil, and salt.',
        '6. Pour dressing over tabbouleh and toss gently to combine.',
        '7. Refrigerate for at least 1 hour before serving to allow flavors to develop.',
        '8. Adjust seasoning if needed and serve chilled.'
      ],
      'ku': [
        '١. بڕوێشەکە بۆ ١٥ خولەک لە ئاوی گەرمدا بخۆشێنە تا نەرم بێت. باش بیپاڵێوە، ئاوی زیادەکەشی پەستێنە.',
        '٢. جەعفەری و نەعنا باش بشۆ. قەدە قورسەکان لابە. بە چەقۆیەکی تیژ بە وردی ببڕە.',
        '٣. تەماتە و خەیار چوارگۆشە بکە. پیازی سەوز پەڕە بکە.',
        '٤. لە قاپێکی گەورەدا، بڕوێش و گیای وردکراو و سەوزەکان تێکەڵ بکە.',
        '٥. ئاوی لیمۆ و ڕۆنی زەیتوون و خوێ تێکەڵ بکە.',
        '٦. ڕۆنەکە بکە بەسەر تەبولەکە و بە نەرمی تێکەڵی بکە.',
        '٧. بۆ کەمترین ١ کاتژمێر پێش خواردن لە سەلادەر بخۆشێنەرەوە بۆ گەشەسەندنی تامەکان.',
        '٨. ئەگەر پێویست بوو بەهاراتەکە دەستکاری بکە و سارد پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '22',
    title: {'en': 'Fattoush', 'ku': 'فەتوش'},
    icon: '🥗',
    nutrition: NutritionalInfo(calories: 180, protein: 4, carbs: 25, fats: 7),
    category: MealCategory.snack,
    rating: 4.5,
    ratingCount: 79,
    ingredients: {
      'en': [
        '2 pieces pita bread',
        '1 head romaine lettuce (chopped)',
        '2 cucumbers (diced)',
        '4 tomatoes (diced)',
        '1 green bell pepper (diced)',
        '1 bunch radishes (sliced)',
        '½ cup fresh mint (chopped)',
        '½ cup fresh parsley (chopped)',
        '3 tbsp sumac',
        '¼ cup lemon juice',
        '¼ cup olive oil',
        '2 cloves garlic (minced)',
        'Salt to taste'
      ],
      'ku': [
        '٢ پارچە نانی پیتا',
        '١ سەری خاس (وردکراوە)',
        '٢ خەیار (چوارگۆشەکراوە)',
        '٤ تەماتە (چوارگۆشەکراوە)',
        '١ بیبەری سەوز (چوارگۆشەکراوە)',
        '١ کۆپی ترب (پەڕەکراوە)',
        '١/٢ پەرداخ نەعنای تازە (وردکراوە)',
        '١/٢ پەرداخ جەعفەری تازە (وردکراوە)',
        '٣ قاشق خواردن سماق',
        '١/٤ پەرداخ ئاوی لیمۆ',
        '١/٤ پەرداخ ڕۆنی زەیتوون',
        '٢ خاو سیر (وردکراوە)',
        'خوێ بەپێی دڵخوازی'
      ],
    },
    steps: {
      'en': [
        '1. Preheat oven to 350°F (175°C). Cut pita bread into small triangles.',
        '2. Bake bread pieces for 10-12 minutes until crisp and golden. Let cool.',
        '3. Wash all vegetables thoroughly. Chop lettuce, dice cucumbers, tomatoes, and bell pepper.',
        '4. Slice radishes thinly. Chop mint and parsley.',
        '5. In large salad bowl, combine all vegetables and herbs.',
        '6. In small bowl, whisk together lemon juice, olive oil, garlic, sumac, and salt.',
        '7. Pour dressing over salad and toss to combine.',
        '8. Add toasted pita pieces just before serving to maintain crispness.',
        '9. Toss gently and serve immediately.'
      ],
      'ku': [
        '١. فڕنەکە بۆ ١٧٥ پلەی سیلیزی گەرم بکە. نانی پیتا ببڕە بە سێگۆشەی بچووک.',
        '٢. پارچە نانەکان بۆ ١٠-١٢ خولەک ببرژێنە تا ڕەق بن و زەردی قاوەیی. ڕێگە بدە سارد بن.',
        '٣. هەموو سەوزەکان باش بشۆ. خاس ورد بکە، خەیار و تەماتە و بیبەری سەوز چوارگۆشە بکە.',
        '٤. تربەکان بە تەنکی پەڕە بکە. نەعنا و جەعفەری ورد بکە.',
        '٥. لە قاپێکی زەڵاتەی گەورەدا، هەموو سەوزەکان و گیاکان تێکەڵ بکە.',
        '٦. لە قاپێکی بچووکدا، ئاوی لیمۆ و ڕۆنی زەیتوون و سیر و سماق و خوێ تێکەڵ بکە.',
        '٧. ڕۆنەکە بکە بەسەر زەڵاتەکە و تێکەڵی بکە.',
        '٨. پارچە نانە برژاوەکان یەکسەر پێش خواردن زیاد بکە بۆ پاراستنی ڕەقبوونیان.',
        '٩. بە نەرمی تێکەڵ بکە و یەکسەر پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '23',
    title: {'en': 'Lobia (Black Eyed Peas)', 'ku': 'شۆربای لۆبیا'},
    icon: '🥘',
    nutrition: NutritionalInfo(calories: 310, protein: 18, carbs: 45, fats: 3),
    category: MealCategory.lunch,
    rating: 4.4,
    ratingCount: 68,
    ingredients: {
      'en': [
        '2 cups dried black-eyed peas',
        '2 tbsp olive oil',
        '1 large onion (chopped)',
        '4 cloves garlic (minced)',
        '2 tbsp tomato paste',
        '1 tsp cumin',
        '1 tsp paprika',
        '6 cups vegetable broth',
        '2 tomatoes (diced)',
        'Fresh cilantro for garnish',
        'Salt and pepper to taste'
      ],
      'ku': [
        '٢ پەرداخ لۆبیای وشک',
        '٢ قاشق خواردن ڕۆنی زەیتوون',
        '١ پیازی گەورە (وردکراوە)',
        '٤ خاو سیر (وردکراوە)',
        '٢ قاشق خواردن دۆشاوی تەماتە',
        '١ قاشقە چای کەمون',
        '١ قاشقە چای بیبەری سوور',
        '٦ پەرداخ ئاوی سەوزە',
        '٢ تەماتە (چوارگۆشەکراوە)',
        'کەزەره یان جەعفەری بۆ ڕازاندنەوە',
        'خوێ و بیبەر بەپێی دڵخوازی'
      ],
    },
    steps: {
      'en': [
        '1. Soak black-eyed peas overnight in plenty of water. Drain and rinse.',
        '2. Heat olive oil in large pot over medium heat. Sauté onion until soft (5-7 minutes).',
        '3. Add garlic and cook 1 minute until fragrant.',
        '4. Stir in tomato paste, cumin, and paprika. Cook 2 minutes.',
        '5. Add drained black-eyed peas and vegetable broth.',
        '6. Bring to boil, then reduce heat and simmer for 45-60 minutes until peas are tender.',
        '7. Add diced tomatoes and cook 10 more minutes.',
        '8. Season with salt and pepper. Garnish with fresh cilantro.',
        '9. Serve hot with rice or bread.'
      ],
      'ku': [
        '١. لۆبیاکە بە شەو لە زۆر ئاودا بخۆشێنە. بیپاڵێوە و بشۆ.',
        '٢. ڕۆنی زەیتوون لە مەنجەڵێکی گەورەدا گەرم بکە لە گەرمی ناوەڕاست. پیاز ببرژێنە تا نەرم بێت (٥-٧ خولەک).',
        '٣. سیر زیاد بکە و بۆ ١ خولەک بکوڵێنە تا بۆنێکی خۆش هەبێت.',
        '٤. دۆشاوی تەماتە و کەمون و بیبەری سوور تێکەڵی بکە. بۆ ٢ خولەک بکوڵێنە.',
        '٥. لۆبیای پاڵێوراو و ئاوی سەوزە زیاد بکە.',
        '٦. بگەڕێنەوە بۆ کوڵان، پاشان گەرمی کەم بکە و بۆ ٤٥-٦٠ خولەک بگەڕێ تا لۆبیاکە نەرم بێت.',
        '٧. تەماتەی چوارگۆشەکراو زیاد بکە و ١٠ خولەکی زیاتر بکوڵێنە.',
        '٨. بە خوێ و بیبەر بەهارات بدە. بە کەزەره یان جەعفەری تازە ڕازێنەرەوە.',
        '٩. گەرم لەگەڵ برنج یان نان پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '24',
    title: {'en': 'Aruk (Kurdish Patty)', 'ku': 'عەروک'},
    icon: '🥯',
    nutrition: NutritionalInfo(calories: 280, protein: 10, carbs: 35, fats: 12),
    category: MealCategory.snack,
    rating: 4.3,
    ratingCount: 54,
    ingredients: {
      'en': [
        '2 cups grated zucchini',
        '1 cup grated potato',
        '1 onion (grated)',
        '1 cup flour',
        '250g ground beef or lamb',
        '2 eggs',
        '1 tsp baking powder',
        '1 tsp salt',
        '½ tsp black pepper',
        'Vegetable oil for frying'
      ],
      'ku': [
        '٢ پەرداخ کوسەی هەڕاو',
        '١ پەرداخ پەتاتەی هەڕاو',
        '١ پیاز (هەڕاو)',
        '١ پەرداخ ئارد',
        '٢٥٠ گرام گۆشتی مانگای یان بەرخ',
        '٢ هێلکە',
        '١ قاشقە چای خمیری خوێشتن',
        '١ قاشقە چای خوێ',
        '١/٢ قاشقە چای بیبەری ڕەش',
        'ڕۆنی ڕوەک بۆ سوورکردنەوە'
      ],
    },
    steps: {
      'en': [
        '1. Place grated zucchini and potato in colander. Sprinkle with salt and let drain 30 minutes.',
        '2. Squeeze out as much liquid as possible from vegetables.',
        '3. In large bowl, combine drained vegetables, grated onion, ground meat, and eggs.',
        '4. Add flour, baking powder, salt, and pepper. Mix until well combined.',
        '5. Heat ½ inch oil in skillet over medium heat.',
        '6. Form mixture into small patties (about 2-3 inches in diameter).',
        '7. Fry patties for 3-4 minutes per side until golden brown and cooked through.',
        '8. Drain on paper towels. Serve warm with yogurt or tahini sauce.'
      ],
      'ku': [
        '١. کوسە و پەتاتەی هەڕاو لە پاڵێورێکدا دانێ. خوێ بپاش بە سەریان و ڕێگە بدە بۆ ٣٠ خولەک بپاڵێورێنەوە.',
        '٢. وەک دەتوانیت ئاو لە سەوزەکان پەستێنە.',
        '٣. لە قاپێکی گەورەدا، سەوزە پاڵێوراوەکان و پیازی هەڕاو و گۆشتی هاڕاو و هێلکەکان تێکەڵ بکە.',
        '٤. ئارد و خمیری خوێشتن و خوێ و بیبەر زیاد بکە. تێکەڵ بکە تا باش یەک بگرن.',
        '٥. نیوەی ئینج ڕۆن لە تاوێکدا گەرم بکە لە گەرمی ناوەڕاست.',
        '٦. تێکەڵەکە بکە بە سەرە بچووک (نزیکەی ٢-٣ ئینج لە تیرە).',
        '٧. سەرەکان بۆ ٣-٤ خولەک لە هەر لایەک ببرژێنە تا زەردی قاوەیی ببن و بپوختن.',
        '٨. بە کلینکس وشکیان بکە. گەرم لەگەڵ ماست یان سۆسی تەحین پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '25',
    title: {'en': 'Burghul with Vermicelli', 'ku': 'بڕوێش بە شەعریە'},
    icon: '🍚',
    nutrition: NutritionalInfo(calories: 330, protein: 8, carbs: 65, fats: 5),
    category: MealCategory.lunch,
    rating: 4.4,
    ratingCount: 62,
    ingredients: {
      'en': [
        '2 cups coarse bulgur',
        '1 cup vermicelli noodles',
        '3 tbsp butter or ghee',
        '1 onion (finely chopped)',
        '4 cups chicken or vegetable broth',
        '1 tsp salt',
        '½ tsp black pepper',
        '¼ cup slivered almonds (toasted)'
      ],
      'ku': [
        '٢ پەرداخ بڕوێشی زبر',
        '١ پەرداخ شەعریە',
        '٣ قاشق خواردن کەرە یان گی',
        '١ پیاز (وردکراوە)',
        '٤ پەرداخ ئاوی مریشک یان سەوزە',
        '١ قاشقە چای خوێ',
        '١/٢ قاشقە چای بیبەری ڕەش',
        '١/٤ پەرداخ بادەمی وردکراو (برژاو)'
      ],
    },
    steps: {
      'en': [
        '1. Rinse bulgur under cold water and drain well.',
        '2. Melt butter in large pot over medium heat. Add vermicelli and cook, stirring constantly, until golden brown.',
        '3. Add chopped onion and cook until softened (3-4 minutes).',
        '4. Add bulgur to pot and stir to coat with butter.',
        '5. Pour in broth, add salt and pepper. Bring to a boil.',
        '6. Reduce heat to low, cover, and simmer for 15-20 minutes until liquid is absorbed and bulgur is tender.',
        '7. Remove from heat and let stand covered for 5 minutes.',
        '8. Fluff with fork and garnish with toasted almonds before serving.'
      ],
      'ku': [
        '١. بڕوێشەکە لە ژێر ئاوی سارددا بشۆ و باش بیپاڵێوە.',
        '٢. کەرە لە مەنجەڵێکی گەورەدا بوونەوە بێنە لە گەرمی ناوەڕاست. شەعریە زیاد بکە و بکوڵێنە، بە بەردەوامی تێکەڵی بکە، تا زەردی قاوەیی بێت.',
        '٣. پیازی وردکراو زیاد بکە و بکوڵێنە تا نەرم بێت (٣-٤ خولەک).',
        '٤. بڕوێش زیاد بکە بۆ مەنجەڵەکە و تێکەڵی بکە تا بە کەرە بپۆشرێت.',
        '٥. ئاوەکە زیاد بکە، خوێ و بیبەریش زیاد بکە. بگەڕێنەوە بۆ کوڵان.',
        '٦. گەرمی کەم بکە، دایبخە و بۆ ١٥-٢٠ خولەک بگەڕێ تا ئاوەکە هەڵبمژرێت و بڕوێشەکە نەرم بێت.',
        '٧. لە گەرمی لابە و بۆ ٥ خولەک بە داپۆشراوی بمێنێتەوە.',
        '٨. بە کەوچکەوە لێی بدە و بە بادەمی برژاو ڕازێنەرەوە پێش پێشکەشکردن.'
      ],
    },
  ),
  Recipe(
    id: '26',
    title: {'en': 'Chicken Soup', 'ku': 'شۆربای مریشک'},
    icon: '🍲',
    nutrition: NutritionalInfo(calories: 250, protein: 28, carbs: 10, fats: 10),
    category: MealCategory.lunch,
    rating: 4.5,
    ratingCount: 87,
    ingredients: {
      'en': [
        '1 whole chicken (cut into pieces)',
        '2 carrots (chopped)',
        '2 celery stalks (chopped)',
        '1 onion (quartered)',
        '4 cloves garlic (crushed)',
        '1 bay leaf',
        '1 tsp whole peppercorns',
        '2 tsp salt',
        '8 cups water',
        'Fresh dill or parsley for garnish'
      ],
      'ku': [
        '١ مریشکی تەواو (بڕدراوە بۆ پارچە)',
        '٢ گێزەر (وردکراوە)',
        '٢ قەدە کەرەوز (وردکراوە)',
        '١ پیاز (چوارپارچەکراوە)',
        '٤ خاو سیر (چەقێنراوە)',
        '١ گەڵای ڕازە',
        '١ قاشقە چای تۆوی بیبەری تەواو',
        '٢ قاشقە چای خوێ',
        '٨ پەرداخ ئاو',
        'شووید یان جەعفەری تازە بۆ ڕازاندنەوە'
      ],
    },
    steps: {
      'en': [
        '1. Place chicken pieces in large stockpot. Cover with cold water.',
        '2. Bring to a boil, then reduce heat to simmer. Skim off foam that rises to surface.',
        '3. Add carrots, celery, onion, garlic, bay leaf, peppercorns, and salt.',
        '4. Simmer gently for 1.5-2 hours until chicken is very tender.',
        '5. Remove chicken pieces from broth and let cool slightly.',
        '6. Strain broth through fine mesh sieve. Discard vegetables and spices.',
        '7. Shred chicken meat, discarding skin and bones.',
        '8. Return shredded chicken to strained broth.',
        '9. Reheat if necessary. Garnish with fresh dill or parsley before serving.'
      ],
      'ku': [
        '١. پارچە مریشکەکان بخەرە ناو مەنجەڵێکی گەورە. بە ئاوی سارد داپۆشیان بکە.',
        '٢. بگەڕێنەوە بۆ کوڵان، پاشان گەرمی کەم بکە بۆ نەرمکوڵان. کەفەکە لەسەر ڕوو کەڵەکەوە بسڕەوە.',
        '٣. گێزەر و کەرەوز و پیاز و سیر و گەڵای ڕازە و تۆوی بیبەر و خوێ زیاد بکە.',
        '٤. بە نەرمی بۆ ١.٥-٢ کاتژمێر بگەڕێ تا مریشکەکە زۆر نەرم بێت.',
        '٥. پارچە مریشکەکان لە ئاوەکە دەربکە و ڕێگە بدە کەمێک سارد بن.',
        '٦. ئاوەکە بە گۆزێکی ورد بیپاڵێوە. سەوزەکان و بەهاراتەکان فڕێ بدە.',
        '٧. گۆشتی مریشک هەڵی بکە، پێست و ئێسکەکان فڕێ بدە.',
        '٨. گۆشتی هەڵکراوەکە بگەڕێنەوە ناو ئاوی پاڵێوراوەکە.',
        '٩. ئەگەر پێویست بوو دیسان گەرمی بکەرەوە. بە شووید یان جەعفەری تازە ڕازێنەرەوە پێش پێشکەشکردن.'
      ],
    },
  ),
  Recipe(
    id: '27',
    title: {'en': 'Baklava', 'ku': 'بەقلاوە'},
    icon: '🥮',
    nutrition: NutritionalInfo(calories: 450, protein: 6, carbs: 55, fats: 25),
    category: MealCategory.snack,
    rating: 4.8,
    ratingCount: 134,
    ingredients: {
      'en': [
        '1 package phyllo dough (thawed)',
        '2 cups pistachios (finely chopped)',
        '1 cup walnuts (finely chopped)',
        '1 cup unsalted butter (melted)',
        '1 tsp cinnamon',
        '1 cup sugar',
        '1 cup water',
        '½ cup honey',
        '1 tbsp lemon juice',
        '1 tsp rose water (optional)'
      ],
      'ku': [
        '١ پاکەتی هەویری فیلۆ (نەرمکراوە)',
        '٢ پەرداخ فستق (وردکراوە)',
        '١ پەرداخ گوێز (وردکراوە)',
        '١ پەرداخ کەرەی بێ خوێ (بوونەوە بێنە)',
        '١ قاشقە چای دارچین',
        '١ پەرداخ شەکر',
        '١ پەرداخ ئاو',
        '١/٢ پەرداخ هەنگوین',
        '١ قاشق خواردن ئاوی لیمۆ',
        '١ قاشقە چای ئاوی گوڵ (ئارەزوویانە)'
      ],
    },
    steps: {
      'en': [
        '1. Preheat oven to 350°F (175°C). Butter 9x13 inch baking dish.',
        '2. Combine chopped pistachios, walnuts, and cinnamon in bowl.',
        '3. Unroll phyllo dough. Cover with damp towel to prevent drying.',
        '4. Place 1 sheet of phyllo in pan, brush with melted butter. Repeat 7 more times.',
        '5. Sprinkle ½ cup nut mixture over phyllo.',
        '6. Add 2 more phyllo sheets, brushing each with butter. Sprinkle ½ cup nuts.',
        '7. Continue layering until all nuts are used, ending with 8 phyllo sheets on top.',
        '8. Cut into diamond shapes before baking.',
        '9. Bake 45-50 minutes until golden brown.',
        '10. Meanwhile, make syrup: Combine sugar, water, honey, lemon juice. Simmer 10 minutes. Add rose water if using.',
        '11. Pour hot syrup over hot baklava. Let cool completely before serving.'
      ],
      'ku': [
        '١. فڕنەکە بۆ ١٧٥ پلەی سیلیزی گەرم بکە. قاپێکی ٩x١٣ ئینج بە کەرە بیڕەواز بکە.',
        '٢. فستق و گوێزی وردکراو و دارچین لە قاپێکدا تێکەڵ بکە.',
        '٣. هەویری فیلۆ بڕووخێنە. بە خاولێکی تریاکەرەوە دایبخە بۆ ڕێگری لە وشکبوون.',
        '٤. ١ پەڕە لە هەویرەکە بخەرە ناو تاسیەکە، بە کەرەی بوونەوە بیڕەواز بکە. ٧ جاری زیاتر دووبارە بکەرەوە.',
        '٥. ١/٢ پەرداخ لە تێکەڵەی چەرەز بپاش بەسەر هەویرەکە.',
        '٦. ٢ پەڕەی هەویری زیاتر زیاد بکە، هەر یەکێکیان بە کەرە بیڕەواز بکە. ١/٢ پەرداخ چەرەز بپاش.',
        '٧. بەردەوام بە لە چین چینکردن تا هەموو چەرەزەکان بەکاربهێنرێن، کۆتایی پێبێت بە ٨ پەڕە هەویری لە سەرەوە.',
        '٨. پێش برژاندن ببڕە بە شێوەی ئەڵماس.',
        '٩. بۆ ٤٥-٥٠ خولەک ببرژێنە تا زەردی قاوەیی بێت.',
        '١٠. لە هەمان کاتدا، شیرە دروست بکە: شەکر و ئاو و هەنگوین و ئاوی لیمۆ تێکەڵ بکە. بۆ ١٠ خولەک بگەڕێ. ئاوی گوڵ زیاد بکە ئەگەر بەکاردێنیت.',
        '١١. شیرەی گەرم بکە بەسەر بەقلاوە گەرمەکە. ڕێگە بدە بە تەواوی سارد بێت پێش پێشکەشکردن.'
      ],
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
        '10 sheets phyllo dough',
        '3 cups basmati rice',
        '500g chicken (cubed)',
        '½ cup slivered almonds',
        '½ cup raisins',
        '½ cup green peas',
        '1 onion (sliced)',
        '2 tbsp biryani spice mix',
        '1 cup yogurt',
        '½ cup ghee or butter',
        '4 cups chicken broth',
        'Saffron strands soaked in ¼ cup warm milk'
      ],
      'ku': [
        '١٠ پەڕە هەویری فیلۆ',
        '٣ پەرداخ برنجی بەسمەتی',
        '٥٠٠ گرام مریشک (چوارگۆشەکراوە)',
        '١/٢ پەرداخ بادەمی وردکراو',
        '١/٢ پەرداخ مێوژ',
        '١/٢ پەرداخ پۆتکەی سەوز',
        '١ پیاز (پەڕەکراوە)',
        '٢ قاشق خواردن بەهاراتی بریانی',
        '١ پەرداخ ماست',
        '١/٢ پەرداخ گی یان کەرە',
        '٤ پەرداخ ئاوی مریشک',
        'چەند ڕیشاڵەی زەعفەران خوساوە لە ١/٤ پەرداخ شیردا'
      ],
    },
    steps: {
      'en': [
        '1. Soak rice for 30 minutes, then parboil in salted water for 10 minutes. Drain.',
        '2. Marinate chicken in yogurt and half the spices for 1 hour.',
        '3. Sauté onions in ghee until golden. Remove half for garnish.',
        '4. Brown marinated chicken in same pan. Remove and set aside.',
        '5. Sauté almonds, raisins, and peas briefly in remaining ghee.',
        '6. Line large ovenproof pot with phyllo sheets, letting edges hang over sides.',
        '7. Layer rice, chicken, and nut mixture in pot, sprinkling spices between layers.',
        '8. Fold phyllo edges over filling to create sealed package.',
        '9. Pour broth and saffron milk over top.',
        '10. Cover with foil and bake at 375°F (190°C) for 45 minutes.',
        '11. Let rest 10 minutes, then invert onto serving platter.',
        '12. Garnish with reserved fried onions.'
      ],
      'ku': [
        '١. برنجەکە بۆ ٣٠ خولەک بخۆشێنە، پاشان بۆ ١٠ خولەک لە ئاوی خوێداردا بکوڵێنە. بیپاڵێوە.',
        '٢. مریشکەکە بۆ ١ کاتژمێر لە ماست و نیوەی بەهاراتەکان بخۆشێنە.',
        '٣. پیاز لە گی دا ببرژێنە تا زەرد بێت. نیوەی بکە بۆ ڕازاندنەوە.',
        '٤. مریشکی خوساوەکە لە هەمان تاوێکدا سووری بکەرەوە. لابە و دانێ.',
        '٥. بادەم و مێوژ و پۆتکە بە خێرایی لە گیی ماوەدا ببرژێنە.',
        '٦. مەنجەڵێکی گەورەی ئاسایشی فڕن بە پەڕەی هەویری داپۆشە، ڕێگە بدە لایەکان لەسەر لایەکاندا هەڵواسرێن.',
        '٧. برنج و مریشک و تێکەڵەی چەرەز لە مەنجەڵدا ڕیز بکە، بەهارات لە نێوان چینەکاندا بپاش.',
        '٨. لایەکانی هەویرەکە بپێچەرەوە بەسەر ناوەکە بۆ دروستکردنی پاکەتێکی داخڵکراو.',
        '٩. ئاو و شیرە زەعفەرانەکە بکە بەسەری.',
        '١٠. بە فۆیلیۆم دایبخە و لە ١٩٠ پلەی سیلیزی بۆ ٤٥ خولەک ببرژێنە.',
        '١١. بۆ ١٠ خولەک ڕای بگەڕێنە، پاشان سەرەوژێری بکە بۆ سینی پێشکەشکردن.',
        '١٢. بە پیازی سوورکراوی پاشەکەوتوو ڕازێنەرەوە.'
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
        '500g fresh okra',
        '500g lamb shanks or stew meat',
        '2 onions (chopped)',
        '4 cloves garlic (minced)',
        '3 tbsp tomato paste',
        '2 tbsp lemon juice',
        '1 tsp coriander',
        '1 tsp paprika',
        '½ tsp turmeric',
        '¼ cup olive oil',
        '4 cups water or broth',
        'Salt and pepper to taste'
      ],
      'ku': [
        '٥٠٠ گرام بامیەی تازە',
        '٥٠٠ گرام ڕانی بەرخ یان گۆشتی شۆربا',
        '٢ پیاز (وردکراوە)',
        '٤ خاو سیر (وردکراوە)',
        '٣ قاشق خواردن دۆشاوی تەماتە',
        '٢ قاشق خواردن ئاوی لیمۆ',
        '١ قاشقە چای گوێزەبەڕۆ',
        '١ قاشقە چای بیبەری سوور',
        '١/٢ قاشقە چای زەردەچەوە',
        '١/٤ پەرداخ ڕۆنی زەیتوون',
        '٤ پەرداخ ئاو یان ئاوی گۆشت',
        'خوێ و بیبەر بەپێی دڵخوازی'
      ],
    },
    steps: {
      'en': [
        '1. Trim okra stems carefully without cutting into pods.',
        '2. Soak okra in vinegar water for 30 minutes to reduce sliminess. Rinse and pat dry.',
        '3. Brown lamb in olive oil in large pot. Remove and set aside.',
        '4. Sauté onions in same pot until golden. Add garlic and spices.',
        '5. Return lamb to pot. Add tomato paste and water/broth.',
        '6. Simmer for 1 hour until lamb is tender.',
        '7. In separate pan, quickly sauté okra in oil for 2-3 minutes.',
        '8. Add okra to stew along with lemon juice. Simmer 20-30 minutes until okra is tender.',
        '9. Adjust seasoning. Serve hot with rice.'
      ],
      'ku': [
        '١. قەدەکانی بامیە بە وردبینی ببڕە بەبێ بریندارکردنی بەربەستەکە.',
        '٢. بامیەکە بۆ ٣٠ خولەک لە ئاوی سرکە بخۆشێنە بۆ کەمکردنەوەی لیزبوون. بشۆ و وشکی بکە.',
        '٣. بەرخ لە ڕۆنی زەیتووندا لە مەنجەڵێکی گەورەدا سووری بکەرەوە. لابە و دانێ.',
        '٤. پیاز لە هەمان مەنجەڵدا ببرژێنە تا زەرد بێت. سیر و بەهاراتەکان زیاد بکە.',
        '٥. بەرخەکە بگەڕێنەوە ناو مەنجەڵ. دۆشاوی تەماتە و ئاو زیاد بکە.',
        '٦. بۆ ١ کاتژمێر بگەڕێ تا بەرخەکە نەرم بێت.',
        '٧. لە تاوێکی جیادا، بامیە بە خێرایی لە ڕۆندا بۆ ٢-٣ خولەک ببرژێنە.',
        '٨. بامیە زیاد بکە بۆ شۆرباکە لەگەڵ ئاوی لیمۆ. بۆ ٢٠-٣٠ خولەک بگەڕێ تا بامیە نەرم بێت.',
        '٩. بەهاراتەکە دەستکاری بکە. گەرم لەگەڵ برنج پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '30',
    title: {'en': 'Kurdish Kulacha', 'ku': 'کولێرە یان کولێچە'},
    icon: '🍪',
    nutrition: NutritionalInfo(calories: 250, protein: 4, carbs: 35, fats: 12),
    category: MealCategory.snack,
    rating: 4.7,
    ratingCount: 96,
    ingredients: {
      'en': [
        '3 cups all-purpose flour',
        '1 cup butter (softened)',
        '½ cup sugar',
        '1 egg',
        '1 tsp cardamom',
        '1 tsp baking powder',
        'Filling: date paste or crushed walnuts mixed with cinnamon',
        '1 egg yolk for brushing',
        'Nigella seeds or sesame seeds for topping'
      ],
      'ku': [
        '٣ پەرداخ ئاردی هەموو مەبەست',
        '١ پەرداخ کەرە (نەرمکراوە)',
        '١/٢ پەرداخ شەکر',
        '١ هێلکە',
        '١ قاشقە چای هێل',
        '١ قاشقە چای خمیری خوێشتن',
        'ناوەکە: دەڕەکی خورما یان گوێزی وردکراو تێکەڵ بە دارچین',
        '١ زەردە هێلکە بۆ ڕەوازکردن',
        'تۆوی کەوەرە یان کنجد بۆ سەرەوە'
      ],
    },
    steps: {
      'en': [
        '1. Cream butter and sugar until light and fluffy.',
        '2. Beat in egg and cardamom.',
        '3. Sift flour and baking powder. Gradually add to butter mixture.',
        '4. Knead briefly until dough comes together. Do not overwork.',
        '5. Divide dough into small balls (golf ball size).',
        '6. Flatten each ball, place teaspoon of filling in center.',
        '7. Fold edges over filling, seal, and reshape into round ball.',
        '8. Press with decorative mold or fork to create pattern.',
        '9. Place on baking sheet. Brush with egg yolk, sprinkle with seeds.',
        '10. Bake at 350°F (175°C) for 20-25 minutes until golden.',
        '11. Cool on wire rack before serving.'
      ],
      'ku': [
        '١. کەرە و شەکر تێکەڵ بکە تا ڕووناک و پڕ بێت.',
        '٢. هێلکە و هێل تێکەڵی بکە.',
        '٣. ئارد و خمیری خوێشتن پاڵێوە. بەرەبەرە زیاد بکە بۆ تێکەڵەی کەرە.',
        '٤. بە کورتەقام هەویرەکە چەقێنە تا یەک بگرێت. زۆر چەقێنی مەدە.',
        '٥. هەویرەکە بڕی بە تۆپێکی بچووک.',
        '٦. هەر تۆپێک پەت بکە، کەوچکێکی چای لە ناوەکە بخەرە ناوەڕاستی.',
        '٧. لایەکان بپێچەرەوە بەسەر ناوەکە، داخڵ بکە، و دیسان بکەرەوە بە تۆپێکی بازنەیی.',
        '٨. بە قاڵبێکی ڕازێنەر یان کەوچک پەستی پێبکە بۆ دروستکردنی شێواز.',
        '٩. بخەرە سەر پانیەکی برژاندن. بە زەردە هێلکە بیڕەواز بکە، تۆوی کەوەرە یان کنجد بپاش بە سەری.',
        '١٠. لە ١٧٥ پلەی سیلیزی بۆ ٢٠-٢٥ خولەک ببرژێنە تا زەرد بێت.',
        '١١. پێش پێشکەشکردن لەسەر ڕەفەی دار سارد بکە.'
      ],
    },
  ),
  Recipe(
    id: '31',
    title: {'en': 'Fasolia (White Bean Stew)', 'ku': 'شۆربای فاسۆلیا'},
    icon: '🍲',
    nutrition: NutritionalInfo(calories: 380, protein: 28, carbs: 45, fats: 12),
    category: MealCategory.lunch,
    rating: 4.5,
    ratingCount: 78,
    ingredients: {
      'en': [
        '2 cups dried white beans',
        '500g lamb or beef cubes',
        '2 onions (chopped)',
        '4 cloves garlic (minced)',
        '3 tbsp tomato paste',
        '2 dried limes (pierced)',
        '1 tsp turmeric',
        '1 tsp paprika',
        '¼ cup olive oil',
        '6 cups water or broth',
        'Salt and pepper to taste'
      ],
      'ku': [
        '٢ پەرداخ فاسۆلیای سپی',
        '٥٠٠ گرام گۆشتی بەرخ یان مانگای چوارگۆشەکراو',
        '٢ پیاز (وردکراوە)',
        '٤ خاو سیر (وردکراوە)',
        '٣ قاشق خواردن دۆشاوی تەماتە',
        '٢ لیمۆی وشک (پێدراوە)',
        '١ قاشقە چای زەردەچەوە',
        '١ قاشقە چای بیبەری سوور',
        '١/٤ پەرداخ ڕۆنی زەیتوون',
        '٦ پەرداخ ئاو یان ئاوی گۆشت',
        'خوێ و بیبەر بەپێی دڵخوازی'
      ],
    },
    steps: {
      'en': [
        '1. Soak beans overnight in plenty of water. Drain and rinse.',
        '2. Brown meat in olive oil in large pot. Remove and set aside.',
        '3. Sauté onions until golden. Add garlic and spices.',
        '4. Return meat to pot. Add tomato paste and water/broth.',
        '5. Add drained beans and dried limes.',
        '6. Bring to boil, then reduce heat and simmer 1.5-2 hours until beans are tender.',
        '7. Remove dried limes before serving.',
        '8. Adjust seasoning. Serve with rice and lemon wedges.'
      ],
      'ku': [
        '١. فاسۆلیاکە بە شەو لە زۆر ئاودا بخۆشێنە. بیپاڵێوە و بشۆ.',
        '٢. گۆشت لە ڕۆنی زەیتووندا لە مەنجەڵێکی گەورەدا سووری بکەرەوە. لابە و دانێ.',
        '٣. پیاز ببرژێنە تا زەرد بێت. سیر و بەهاراتەکان زیاد بکە.',
        '٤. گۆشتەکە بگەڕێنەوە ناو مەنجەڵ. دۆشاوی تەماتە و ئاو زیاد بکە.',
        '٥. فاسۆلیای پاڵێوراو و لیمۆی وشک زیاد بکە.',
        '٦. بگەڕێنەوە بۆ کوڵان، پاشان گەرمی کەم بکە و بۆ ١.٥-٢ کاتژمێر بگەڕێ تا فاسۆلیاکە نەرم بێت.',
        '٧. لیمۆی وشکەکان لابە پێش پێشکەشکردن.',
        '٨. بەهاراتەکە دەستکاری بکە. لەگەڵ برنج و پارچە لیمۆ پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '32',
    title: {'en': 'Tepsi Baytinjan', 'ku': 'تەپسی باینجان'},
    icon: '🍆',
    nutrition: NutritionalInfo(calories: 450, protein: 25, carbs: 30, fats: 28),
    category: MealCategory.dinner,
    rating: 4.6,
    ratingCount: 89,
    ingredients: {
      'en': [
        '2 large eggplants (sliced)',
        '4 potatoes (sliced)',
        '2 onions (sliced)',
        '500g ground meat (beef/lamb mix)',
        '2 cups tomato sauce',
        '2 cloves garlic (minced)',
        '1 tsp allspice',
        '½ tsp cinnamon',
        'Olive oil for frying',
        'Salt and pepper to taste'
      ],
      'ku': [
        '٢ باینجانی گەورە (پەڕەکراوە)',
        '٤ پەتاتە (پەڕەکراوە)',
        '٢ پیاز (پەڕەکراوە)',
        '٥٠٠ گرام گۆشتی هاڕاو',
        '٢ پەرداخ ئاوی تەماتە',
        '٢ خاو سیر (وردکراوە)',
        '١ قاشقە چای بەهاراتی هەموو جۆرە',
        '١/٢ قاشقە چای دارچین',
        'ڕۆنی زەیتوون بۆ سوورکردنەوە',
        'خوێ و بیبەر بەپێی دڵخوازی'
      ],
    },
    steps: {
      'en': [
        '1. Salt eggplant slices and let sit 30 minutes to remove bitterness. Rinse and pat dry.',
        '2. Fry eggplant, potato, and onion slices separately until golden. Drain on paper towels.',
        '3. Season ground meat with garlic, spices, salt and pepper.',
        '4. Form meat into small patties. Fry until browned.',
        '5. Preheat oven to 375°F (190°C).',
        '6. In baking dish, layer: potatoes, onions, eggplant, meat patties.',
        '7. Pour tomato sauce over everything.',
        '8. Bake 30-40 minutes until bubbly and vegetables are tender.',
        '9. Let cool 10 minutes before serving.'
      ],
      'ku': [
        '١. پەڕە باینجانەکان خوێ بپاش بە سەریان و ڕێگە بدە بۆ ٣٠ خولەک بمێننەوە بۆ لابردنی تامی تاڵ. بشۆ و وشکی بکە.',
        '٢. پەڕەکانی باینجان و پەتاتە و پیاز بە جیا ببرژێنە تا زەرد بن. بە کلینکس وشکیان بکە.',
        '٣. گۆشتی هاڕاوەکە بە سیر و بەهارات و خوێ و بیبەر بەهارات بدە.',
        '٤. گۆشتەکە بکە بە سەرە بچووک. ببرژێنە تا سوور ببن.',
        '٥. فڕنەکە بۆ ١٩٠ پلەی سیلیزی گەرم بکە.',
        '٦. لە تاسێکدا ڕیز بکە: پەتاتە، پیاز، باینجان، سەرەکانی گۆشت.',
        '٧. ئاوی تەماتە بکە بەسەر هەموویاندا.',
        '٨. بۆ ٣٠-٤٠ خولەک ببرژێنە تا کوڵبڵکە و سەوزەکان نەرم بن.',
        '٩. بۆ ١٠ خولەک پێش خواردن ڕای بگەڕێنە.'
      ],
    },
  ),
  Recipe(
    id: '33',
    title: {'en': 'Qouzi (Roasted Lamb)', 'ku': 'قۆزی'},
    icon: '🍗',
    nutrition: NutritionalInfo(calories: 720, protein: 45, carbs: 65, fats: 32),
    category: MealCategory.bulking,
    rating: 4.9,
    ratingCount: 167,
    ingredients: {
      'en': [
        '1 whole lamb shoulder or leg (3-4kg)',
        '½ cup olive oil',
        '10 cloves garlic (crushed)',
        '2 tbsp baharat spice mix',
        '2 tbsp salt',
        '1 tbsp black pepper',
        '4 cups spiced rice',
        '2 cups vermicelli noodles (toasted)',
        '½ cup mixed nuts (almonds, pine nuts, pistachios)',
        'Fresh herbs for garnish'
      ],
      'ku': [
        '١ شان یان قاچی بەرخ (٣-٤ کیلۆ)',
        '١/٢ پەرداخ ڕۆنی زەیتوون',
        '١٠ خاو سیر (چەقێنراوە)',
        '٢ قاشق خواردن بەهاراتی بەهارات',
        '٢ قاشق خواردن خوێ',
        '١ قاشق خواردن بیبەری ڕەش',
        '٤ پەرداخ برنجی بەهارات',
        '٢ پەرداخ شەعریە (برژاو)',
        '١/٢ پەرداخ چەرەزی تێکەڵ',
        'گیای تازە بۆ ڕازاندنەوە'
      ],
    },
    steps: {
      'en': [
        '1. Make deep cuts all over lamb. Rub with olive oil, garlic, and spices.',
        '2. Marinate lamb overnight in refrigerator.',
        '3. Preheat oven to 325°F (160°C).',
        '4. Place lamb on rack in roasting pan. Add 2 cups water to pan.',
        '5. Roast 4-5 hours, basting every 30 minutes, until internal temperature reaches 160°F (71°C).',
        '6. Increase heat to 425°F (220°C) for last 15 minutes for crispy skin.',
        '7. Let lamb rest 30 minutes before carving.',
        '8. Prepare rice with vermicelli and nuts.',
        '9. Serve lamb slices over bed of rice. Garnish with fresh herbs.'
      ],
      'ku': [
        '١. برینێکی قوڵ لەسەر هەموو بەرخەکە دروست بکە. بە ڕۆنی زەیتوون و سیر و بەهارات بیڕەواز بکە.',
        '٢. بەرخەکە بە شەو لە سەلادەر بخۆشێنەرەوە.',
        '٣. فڕنەکە بۆ ١٦٠ پلەی سیلیزی گەرم بکە.',
        '٤. بەرخەکە بخەرە سەر ڕەفە لە تاسێکی برژاندندا. ٢ پەرداخ ئاو زیاد بکە بۆ تاسەکە.',
        '٥. بۆ ٤-٥ کاتژمێر ببرژێنە، هەر ٣٠ خولەک جارێک ڕووکەشی بکە، تا گەرمی ناوەوەی بگاتە ٧١ پلەی سیلیزی.',
        '٦. گەرمی بەرز بکە بۆ ٢٢٠ پلەی سیلیزی بۆ ١٥ خولەکی کۆتایی بۆ پێستێکی ڕەق.',
        '٧. بۆ ٣٠ خولەک پێش بڕینی بەرخەکە ڕای بگەڕێنە.',
        '٨. برنج لەگەڵ شەعریە و چەرەز ئامادە بکە.',
        '٩. پەڕەکانی بەرخ لەسەر بنەچەیەکی برنج پێشکەشی بکە. بە گیای تازە ڕازێنەرەوە.'
      ],
    },
  ),
  Recipe(
    id: '34',
    title: {'en': 'Savar (Bulgur Pilaf)', 'ku': 'ساوەر'},
    icon: '🌾',
    nutrition: NutritionalInfo(calories: 320, protein: 10, carbs: 60, fats: 5),
    category: MealCategory.lunch,
    rating: 4.4,
    ratingCount: 56,
    ingredients: {
      'en': [
        '2 cups coarse bulgur',
        '1 cup vermicelli noodles',
        '1 onion (chopped)',
        '2 tbsp tomato paste',
        '¼ cup olive oil',
        '4 cups chicken or vegetable broth',
        '1 tsp paprika',
        '1 tsp cumin',
        'Salt and pepper to taste',
        'Fresh parsley for garnish'
      ],
      'ku': [
        '٢ پەرداخ بڕوێشی زبر',
        '١ پەرداخ شەعریە',
        '١ پیاز (وردکراوە)',
        '٢ قاشق خواردن دۆشاوی تەماتە',
        '١/٤ پەرداخ ڕۆنی زەیتوون',
        '٤ پەرداخ ئاوی مریشک یان سەوزە',
        '١ قاشقە چای بیبەری سوور',
        '١ قاشقە چای کەمون',
        'خوێ و بیبەر بەپێی دڵخوازی',
        'جەعفەری تازە بۆ ڕازاندنەوە'
      ],
    },
    steps: {
      'en': [
        '1. Rinse bulgur and soak in warm water for 15 minutes. Drain.',
        '2. Heat olive oil in large pot. Add vermicelli and cook until golden brown.',
        '3. Add chopped onion and cook until softened.',
        '4. Stir in tomato paste, paprika, and cumin. Cook 1-2 minutes.',
        '5. Add drained bulgur and stir to coat with oil.',
        '6. Pour in broth, season with salt and pepper.',
        '7. Bring to boil, then reduce heat to low, cover, and simmer 15-20 minutes.',
        '8. Remove from heat and let stand covered 5 minutes.',
        '9. Fluff with fork, garnish with parsley, and serve.'
      ],
      'ku': [
        '١. بڕوێشەکە بشۆ و بۆ ١٥ خولەک لە ئاوی گەرمدا بخۆشێنە. بیپاڵێوە.',
        '٢. ڕۆنی زەیتوون لە مەنجەڵێکی گەورەدا گەرم بکە. شەعریە زیاد بکە و بکوڵێنە تا زەردی قاوەیی بێت.',
        '٣. پیازی وردکراو زیاد بکە و بکوڵێنە تا نەرم بێت.',
        '٤. دۆشاوی تەماتە و بیبەری سوور و کەمون تێکەڵی بکە. بۆ ١-٢ خولەک بکوڵێنە.',
        '٥. بڕوێشی پاڵێوراو زیاد بکە و تێکەڵی بکە تا بە ڕۆن بپۆشرێت.',
        '٦. ئاوەکە زیاد بکە، بە خوێ و بیبەر بەهارات بدە.',
        '٧. بگەڕێنەوە بۆ کوڵان، پاشان گەرمی کەم بکە، دایبخە و بۆ ١٥-٢٠ خولەک بگەڕێ.',
        '٨. لە گەرمی لابە و بۆ ٥ خولەک بە داپۆشراوی بمێنێتەوە.',
        '٩. بە کەوچکەوە لێی بدە، بە جەعفەری ڕازێنەرەوە و پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '35',
    title: {'en': 'Hummus', 'ku': 'حومس'},
    icon: '🥣',
    nutrition: NutritionalInfo(calories: 250, protein: 8, carbs: 20, fats: 15),
    category: MealCategory.snack,
    rating: 4.7,
    ratingCount: 145,
    ingredients: {
      'en': [
        '2 cups cooked chickpeas (canned or dried)',
        '½ cup tahini',
        '¼ cup lemon juice',
        '3 cloves garlic',
        '½ tsp cumin',
        '¼ cup olive oil',
        '¼ cup chickpea liquid or water',
        'Salt to taste',
        'Paprika and parsley for garnish'
      ],
      'ku': [
        '٢ پەرداخ نۆکی کوڵاو',
        '١/٢ پەرداخ تەحین',
        '١/٤ پەرداخ ئاوی لیمۆ',
        '٣ خاو سیر',
        '١/٢ قاشقە چای کەمون',
        '١/٤ پەرداخ ڕۆنی زەیتوون',
        '١/٤ پەرداخ ئاوی نۆک یان ئاو',
        'خوێ بەپێی دڵخوازی',
        'بیبەری سوور و جەعفەری بۆ ڕازاندنەوە'
      ],
    },
    steps: {
      'en': [
        '1. If using dried chickpeas, soak overnight and cook until very soft.',
        '2. Reserve some whole chickpeas for garnish.',
        '3. In food processor, combine chickpeas, tahini, lemon juice, garlic, and cumin.',
        '4. Process until smooth, scraping down sides as needed.',
        '5. With motor running, slowly add olive oil and chickpea liquid.',
        '6. Process until creamy and smooth. Add more liquid if too thick.',
        '7. Season with salt to taste.',
        '8. Transfer to serving dish. Create swirl pattern with spoon.',
        '9. Drizzle with olive oil, sprinkle paprika, and garnish with chickpeas and parsley.',
        '10. Serve with pita bread or vegetables.'
      ],
      'ku': [
        '١. ئەگەر نۆکی وشک بەکاردێنیت، بە شەو بخۆشێنە و بکوڵێنە تا زۆر نەرم بێت.',
        '٢. هەندێک نۆکی تەواو پاشەکەوت بکە بۆ ڕازاندنەوە.',
        '٣. لە بەشی خواردن دروستکەردا، نۆک و تەحین و ئاوی لیمۆ و سیر و کەمون تێکەڵ بکە.',
        '٤. بلفێنە تا ڕێک بێت، ڕووەکان دەستکاری بکە ئەگەر پێویست بوو.',
        '٥. لەگەڵ ڕێکخستنی مووتەرەکە، بەرەبەرە ڕۆنی زەیتوون و ئاوی نۆک زیاد بکە.',
        '٦. بلفێنە تا کرێمی و ڕێک بێت. ئاوی زیاتر زیاد بکە ئەگەر زۆر ئەستوور بوو.',
        '٧. بە خوێ بەپێی دڵخوازی بەهارات بدە.',
        '٨. بگوێرەوە بۆ قاپێکی پێشکەشکردن. شێوازێکی سوڕانەوە دروست بکە بە کەوچک.',
        '٩. ڕۆنی زەیتوونی پێدا بکە، بیبەری سوور بپاش بە سەری و بە نۆک و جەعفەری ڕازێنەرەوە.',
        '١٠. لەگەڵ نانی پیتا یان سەوزە پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '36',
    title: {'en': 'Falafel', 'ku': 'فەلافل'},
    icon: '🧆',
    nutrition: NutritionalInfo(calories: 330, protein: 13, carbs: 32, fats: 18),
    category: MealCategory.lunch,
    rating: 4.6,
    ratingCount: 112,
    ingredients: {
      'en': [
        '2 cups dried chickpeas (soaked overnight)',
        '1 onion (quartered)',
        '4 cloves garlic',
        '1 cup fresh parsley',
        '1 cup fresh cilantro',
        '2 tsp cumin',
        '2 tsp coriander',
        '1 tsp baking soda',
        'Salt and pepper to taste',
        'Vegetable oil for frying'
      ],
      'ku': [
        '٢ پەرداخ نۆکی وشک (خوساوە بە شەو)',
        '١ پیاز (چوارپارچەکراوە)',
        '٤ خاو سیر',
        '١ پەرداخ جەعفەری تازە',
        '١ پەرداخ کەزەره یان جەعفەری تازە',
        '٢ قاشقە چای کەمون',
        '٢ قاشقە چای گوێزەبەڕۆ',
        '١ قاشقە چای سۆدای خوێشتن',
        'خوێ و بیبەر بەپێی دڵخوازی',
        'ڕۆنی ڕوەک بۆ سوورکردنەوە'
      ],
    },
    steps: {
      'en': [
        '1. DO NOT use canned chickpeas. Use dried chickpeas soaked overnight.',
        '2. Drain soaked chickpeas and pat dry.',
        '3. In food processor, pulse chickpeas, onion, garlic, parsley, and cilantro until coarse meal forms.',
        '4. Add spices, baking soda, salt and pepper. Pulse until combined but not pureed.',
        '5. Transfer mixture to bowl, cover, refrigerate 1-2 hours.',
        '6. Form mixture into small balls or patties.',
        '7. Heat oil to 350°F (175°C) in deep fryer or heavy pot.',
        '8. Fry falafel in batches 3-4 minutes until golden brown.',
        '9. Drain on paper towels. Serve in pita with tahini sauce and vegetables.'
      ],
      'ku': [
        '١. نۆکی قووتاو مەبەکاربهێنە. نۆکی وشکی خوساوە بە شەو بەکاربهێنە.',
        '٢. نۆکی خوساوەکە بیپاڵێوە و وشکی بکە.',
        '٣. لە بەشی خواردن دروستکەردا، نۆک و پیاز و سیر و جەعفەری و کەزەره بلفێنە تا خواردنێکی زبر دروست بێت.',
        '٤. بەهارات و سۆدای خوێشتن و خوێ و بیبەر زیاد بکە. بلفێنە تا یەک بگرن بەڵام پاک نەکرێت.',
        '٥. تێکەڵەکە بگوێرەوە بۆ قاپێک، دایبخە، بۆ ١-٢ کاتژمێر لە سەلادەر بخۆشێنەرەوە.',
        '٦. تێکەڵەکە بکە بە تۆپێکی بچووک یان سەرە.',
        '٧. ڕۆن بۆ ١٧٥ پلەی سیلیزی گەرم بکە لە برژێنەرێکی قوڵ یان مەنجەڵێکی قورسدا.',
        '٨. فەلافلەکان بە کۆمەڵە ببرژێنە بۆ ٣-٤ خولەک تا زەردی قاوەیی ببن.',
        '٩. بە کلینکس وشکیان بکە. لە نانی پیتا پێشکەشی بکە لەگەڵ سۆسی تەحین و سەوزە.'
      ],
    },
  ),
  Recipe(
    id: '37',
    title: {'en': 'Maqluba', 'ku': 'مەقلوبە'},
    icon: '🥘',
    nutrition: NutritionalInfo(calories: 650, protein: 30, carbs: 75, fats: 25),
    category: MealCategory.dinner,
    rating: 4.8,
    ratingCount: 123,
    ingredients: {
      'en': [
        '1 kg chicken or lamb (cubed)',
        '3 cups basmati rice',
        '2 eggplants (sliced)',
        '1 cauliflower (cut into florets)',
        '2 tomatoes (sliced)',
        '2 onions (sliced)',
        '2 tbsp maqluba spice mix',
        '½ cup olive oil',
        '4 cups chicken or vegetable broth',
        'Salt and pepper to taste',
        'Toasted pine nuts for garnish'
      ],
      'ku': [
        '١ کیلۆگرام مریشک یان بەرخ (چوارگۆشەکراوە)',
        '٣ پەرداخ برنجی بەسمەتی',
        '٢ باینجان (پەڕەکراوە)',
        '١ قەنابیت (بردراوە بۆ گوڵەکان)',
        '٢ تەماتە (پەڕەکراوە)',
        '٢ پیاز (پەڕەکراوە)',
        '٢ قاشق خواردن بەهاراتی مەقلوبە',
        '١/٢ پەرداخ ڕۆنی زەیتوون',
        '٤ پەرداخ ئاوی مریشک یان سەوزە',
        'خوێ و بیبەر بەپێی دڵخوازی',
        'دەنکە سنۆبەری برژاو بۆ ڕازاندنەوە'
      ],
    },
    steps: {
      'en': [
        '1. Salt eggplant slices for 30 minutes, rinse, and pat dry. Fry until golden.',
        '2. Fry cauliflower florets until golden. Set aside.',
        '3. Brown meat in olive oil with spices. Remove and set aside.',
        '4. In large pot, layer: meat, eggplant, cauliflower, tomatoes, onions, rice.',
        '5. Sprinkle spices between layers.',
        '6. Pour broth over everything. Bring to boil.',
        '7. Reduce heat to low, cover, and simmer 30-40 minutes until rice is cooked.',
        '8. Remove from heat and let rest 10 minutes.',
        '9. Place large serving platter over pot. Carefully flip pot over.',
        '10. Garnish with toasted pine nuts and serve with yogurt.'
      ],
      'ku': [
        '١. پەڕە باینجانەکان بۆ ٣٠ خولەک خوێ بپاش بە سەریان، بشۆ و وشکی بکە. ببرژێنە تا زەرد بن.',
        '٢. گوڵە قەنابیتەکان ببرژێنە تا زەرد بن. دانێ.',
        '٣. گۆشت لە ڕۆنی زەیتووندا لەگەڵ بەهارات سووری بکەرەوە. لابە و دانێ.',
        '٤. لە مەنجەڵێکی گەورەدا ڕیز بکە: گۆشت، باینجان، قەنابیت، تەماتە، پیاز، برنج.',
        '٥. بەهارات لە نێوان چینەکاندا بپاش.',
        '٦. ئاوەکە بکە بەسەر هەموویاندا. بگەڕێنەوە بۆ کوڵان.',
        '٧. گەرمی کەم بکە، دایبخە و بۆ ٣٠-٤٠ خولەک بگەڕێ تا برنجەکە بپوختێت.',
        '٨. لە گەرمی لابە و بۆ ١٠ خولەک ڕای بگەڕێنە.',
        '٩. سینیێکی گەورەی پێشکەشکردن بخەرە سەر مەنجەڵەکە. بە وردبینی مەنجەڵەکە بگۆڕە.',
        '١٠. بە دەنکە سنۆبەری برژاو ڕازێنەرەوە و لەگەڵ ماست پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '38',
    title: {'en': 'Baba Ganoush', 'ku': 'بابا غەنووج'},
    icon: '🍆',
    nutrition: NutritionalInfo(calories: 180, protein: 3, carbs: 12, fats: 14),
    category: MealCategory.snack,
    rating: 4.6,
    ratingCount: 98,
    ingredients: {
      'en': [
        '2 large eggplants',
        '¼ cup tahini',
        '3 tbsp lemon juice',
        '3 cloves garlic (minced)',
        '2 tbsp olive oil',
        '1 tbsp yogurt',
        'Salt to taste',
        'Smoked paprika and parsley for garnish'
      ],
      'ku': [
        '٢ باینجانی گەورە',
        '١/٤ پەرداخ تەحین',
        '٣ قاشق خواردن ئاوی لیمۆ',
        '٣ خاو سیر (وردکراوە)',
        '٢ قاشق خواردن ڕۆنی زەیتوون',
        '١ قاشق خواردن ماست',
        'خوێ بەپێی دڵخوازی',
        'بیبەری سووری جگەرەکێشراو و جەعفەری بۆ ڕازاندنەوە'
      ],
    },
    steps: {
      'en': [
        '1. Preheat oven to 400°F (200°C) or prepare grill.',
        '2. Pierce eggplants all over with fork.',
        '3. Roast on baking sheet for 45-60 minutes or grill over open flame until charred and collapsed.',
        '4. Let eggplants cool until manageable. Peel off skin.',
        '5. Drain excess liquid from eggplant flesh.',
        '6. In bowl, mash eggplant with fork (not too smooth).',
        '7. Add tahini, lemon juice, garlic, and salt. Mix well.',
        '8. Stir in yogurt for creaminess.',
        '9. Transfer to serving dish. Drizzle with olive oil.',
        '10. Sprinkle smoked paprika and parsley. Serve with pita.'
      ],
      'ku': [
        '١. فڕنەکە بۆ ٢٠٠ پلەی سیلیزی گەرم بکە یان برژێنەر ئامادە بکە.',
        '٢. باینجانەکان بە کەوچک پێبدە لە هەموو شوێنێک.',
        '٣. لەسەر پانیەکی برژاندن بۆ ٤٥-٦٠ خولەک ببرژێنە یان لەسەر ئاگرێکی کراوە ببرژێنە تا سوور ببن و بڕوخێن.',
        '٤. ڕێگە بە باینجانەکان بدە تا بتوانرێت دەستیان پێبگیرێت. پێستیان لابە.',
        '٥. ئاوی زیادە لە گۆشتی باینجان پەستێنە.',
        '٦. لە قاپێکدا، باینجانەکە بە کەوچکەوە بپلیشێنەرەوە (زۆر ڕێک مەبە).',
        '٧. تەحین و ئاوی لیمۆ و سیر و خوێ زیاد بکە. باش تێکەڵ بکە.',
        '٨. ماست تێکەڵی بکە بۆ کرێمی.',
        '٩. بگوێرەوە بۆ قاپێکی پێشکەشکردن. ڕۆنی زەیتوونی پێدا بکە.',
        '١٠. بیبەری سووری جگەرەکێشراو و جەعفەری بپاش بە سەری. لەگەڵ نانی پیتا پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '39',
    title: {'en': 'Fattoush Salad', 'ku': 'فەتوش'},
    icon: '🥗',
    nutrition: NutritionalInfo(calories: 150, protein: 3, carbs: 18, fats: 8),
    category: MealCategory.snack,
    rating: 4.5,
    ratingCount: 76,
    ingredients: {
      'en': [
        '2 pieces pita bread',
        '1 head romaine lettuce (chopped)',
        '2 cucumbers (diced)',
        '4 tomatoes (diced)',
        '1 green bell pepper (diced)',
        '1 bunch radishes (sliced)',
        '½ cup fresh mint (chopped)',
        '½ cup fresh parsley (chopped)',
        '3 tbsp sumac',
        '¼ cup lemon juice',
        '¼ cup olive oil',
        '2 cloves garlic (minced)',
        'Salt to taste'
      ],
      'ku': [
        '٢ پارچە نانی پیتا',
        '١ سەری خاس (وردکراوە)',
        '٢ خەیار (چوارگۆشەکراوە)',
        '٤ تەماتە (چوارگۆشەکراوە)',
        '١ بیبەری سەوز (چوارگۆشەکراوە)',
        '١ کۆپی ترب (پەڕەکراوە)',
        '١/٢ پەرداخ نەعنای تازە (وردکراوە)',
        '١/٢ پەرداخ جەعفەری تازە (وردکراوە)',
        '٣ قاشق خواردن سماق',
        '١/٤ پەرداخ ئاوی لیمۆ',
        '١/٤ پەرداخ ڕۆنی زەیتوون',
        '٢ خاو سیر (وردکراوە)',
        'خوێ بەپێی دڵخوازی'
      ],
    },
    steps: {
      'en': [
        '1. Preheat oven to 350°F (175°C). Cut pita bread into small triangles.',
        '2. Bake bread pieces for 10-12 minutes until crisp and golden. Let cool.',
        '3. Wash all vegetables thoroughly. Chop lettuce, dice cucumbers, tomatoes, and bell pepper.',
        '4. Slice radishes thinly. Chop mint and parsley.',
        '5. In large salad bowl, combine all vegetables and herbs.',
        '6. In small bowl, whisk together lemon juice, olive oil, garlic, sumac, and salt.',
        '7. Pour dressing over salad and toss to combine.',
        '8. Add toasted pita pieces just before serving to maintain crispness.',
        '9. Toss gently and serve immediately.'
      ],
      'ku': [
        '١. فڕنەکە بۆ ١٧٥ پلەی سیلیزی گەرم بکە. نانی پیتا ببڕە بە سێگۆشەی بچووک.',
        '٢. پارچە نانەکان بۆ ١٠-١٢ خولەک ببرژێنە تا ڕەق بن و زەردی قاوەیی. ڕێگە بدە سارد بن.',
        '٣. هەموو سەوزەکان باش بشۆ. خاس ورد بکە، خەیار و تەماتە و بیبەری سەوز چوارگۆشە بکە.',
        '٤. تربەکان بە تەنکی پەڕە بکە. نەعنا و جەعفەری ورد بکە.',
        '٥. لە قاپێکی زەڵاتەی گەورەدا، هەموو سەوزەکان و گیاکان تێکەڵ بکە.',
        '٦. لە قاپێکی بچووکدا، ئاوی لیمۆ و ڕۆنی زەیتوون و سیر و سماق و خوێ تێکەڵ بکە.',
        '٧. ڕۆنەکە بکە بەسەر زەڵاتەکە و تێکەڵی بکە.',
        '٨. پارچە نانە برژاوەکان یەکسەر پێش خواردن زیاد بکە بۆ پاراستنی ڕەقبوونیان.',
        '٩. بە نەرمی تێکەڵ بکە و یەکسەر پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '40',
    title: {'en': 'Tabbouleh', 'ku': 'تەبولە'},
    icon: '🥗',
    nutrition: NutritionalInfo(calories: 140, protein: 2, carbs: 15, fats: 9),
    category: MealCategory.snack,
    rating: 4.6,
    ratingCount: 85,
    ingredients: {
      'en': [
        '1 cup fine bulgur',
        '3 bunches fresh parsley (finely chopped)',
        '½ bunch fresh mint (finely chopped)',
        '4 tomatoes (diced)',
        '1 cucumber (diced)',
        '4 green onions (thinly sliced)',
        '½ cup lemon juice',
        '⅓ cup olive oil',
        'Salt to taste'
      ],
      'ku': [
        '١ پەرداخ بڕوێشی ورد',
        '٣ کۆپی جەعفەری تازە (وردکراوە)',
        '١/٢ کۆپی نەعنای تازە (وردکراوە)',
        '٤ تەماتە (چوارگۆشەکراوە)',
        '١ خەیار (چوارگۆشەکراوە)',
        '٤ پیازی سەوز (بە تەنکی پەڕەکراوە)',
        '١/٢ پەرداخ ئاوی لیمۆ',
        '١/٣ پەرداخ ڕۆنی زەیتوون',
        'خوێ بەپێی دڵخوازی'
      ],
    },
    steps: {
      'en': [
        '1. Soak bulgur in hot water for 15 minutes until softened. Drain well, pressing out excess water.',
        '2. Wash parsley and mint thoroughly. Remove thick stems. Chop very finely with sharp knife.',
        '3. Dice tomatoes and cucumber. Slice green onions.',
        '4. In large bowl, combine bulgur, chopped herbs, and vegetables.',
        '5. Whisk together lemon juice, olive oil, and salt.',
        '6. Pour dressing over tabbouleh and toss gently to combine.',
        '7. Refrigerate for at least 1 hour before serving to allow flavors to develop.',
        '8. Adjust seasoning if needed and serve chilled.'
      ],
      'ku': [
        '١. بڕوێشەکە بۆ ١٥ خولەک لە ئاوی گەرمدا بخۆشێنە تا نەرم بێت. باش بیپاڵێوە، ئاوی زیادەکەی پەستێنە.',
        '٢. جەعفەری و نەعنا باش بشۆ. قەدە قورسەکان لابە. بە چەقۆیەکی تیژ بە وردی ببڕە.',
        '٣. تەماتە و خەیار چوارگۆشە بکە. پیازی سەوز پەڕە بکە.',
        '٤. لە قاپێکی گەورەدا، بڕوێش و گیای وردکراو و سەوزەکان تێکەڵ بکە.',
        '٥. ئاوی لیمۆ و ڕۆنی زەیتوون و خوێ تێکەڵ بکە.',
        '٦. ڕۆنەکە بکە بەسەر تەبولەکە و بە نەرمی تێکەڵی بکە.',
        '٧. بۆ کەمترین ١ کاتژمێر پێش خواردن لە سەلادەر بخۆشێنەرەوە بۆ گەشەسەندنی تامەکان.',
        '٨. ئەگەر پێویست بوو بەهاراتەکە دەستکاری بکە و سارد پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '41',
    title: {'en': 'Kunafa', 'ku': 'کونافە'},
    icon: '🥧',
    nutrition: NutritionalInfo(calories: 450, protein: 8, carbs: 60, fats: 22),
    category: MealCategory.snack,
    rating: 4.8,
    ratingCount: 156,
    ingredients: {
      'en': [
        '1 package kunafa dough (shredded phyllo)',
        '500g akkawi cheese (or mozzarella)',
        '1 cup unsalted butter (melted)',
        '1 cup sugar',
        '1 cup water',
        '½ cup orange blossom water',
        '1 tbsp lemon juice',
        'Crushed pistachios for garnish'
      ],
      'ku': [
        '١ پاکەتی هەویری کونافە',
        '٥٠٠ گرام پەنیری عەکاوی',
        '١ پەرداخ کەرەی بێ خوێ (بوونەوە بێنە)',
        '١ پەرداخ شەکر',
        '١ پەرداخ ئاو',
        '١/٢ پەرداخ ئاوی گوڵی پرتەقاڵ',
        '١ قاشق خواردن ئاوی لیمۆ',
        'فستقی وردکراو بۆ ڕازاندنەوە'
      ],
    },
    steps: {
      'en': [
        '1. Shred cheese if needed. Soak in water 1 hour to reduce saltiness if using akkawi.',
        '2. Preheat oven to 350°F (175°C).',
        '3. Separate kunafa dough strands. Mix with melted butter until coated.',
        '4. Press half the dough into buttered 9x13 inch pan.',
        '5. Spread cheese evenly over dough.',
        '6. Top with remaining dough, pressing down gently.',
        '7. Bake 30-40 minutes until golden brown.',
        '8. Meanwhile, make syrup: Boil sugar, water, and lemon juice 10 minutes. Add orange blossom water.',
        '9. Pour hot syrup over hot kunafa immediately after removing from oven.',
        '10. Garnish with crushed pistachios. Let cool before serving.'
      ],
      'ku': [
        '١. پەنیرەکە هەڵی بکە ئەگەر پێویست بوو. بۆ ١ کاتژمێر لە ئاو بخۆشێنە بۆ کەمکردنەوەی خوێی ئەگەر عەکاوی بەکاردێنیت.',
        '٢. فڕنەکە بۆ ١٧٥ پلەی سیلیزی گەرم بکە.',
        '٣. ڕیشاڵەکانی هەویری کونافە جیا بکەرەوە. لەگەڵ کەرەی بوونەوە تێکەڵ بکە تا بپۆشرێت.',
        '٤. نیوەی هەویرەکە بکە بە ناو تاسیەکی ٩x١٣ ئینجی کەرەپاشی.',
        '٥. پەنیرەکە بە یەکسانی بڵاو بکەرەوە بەسەر هەویرەکە.',
        '٦. هەویری ماوەکەی سەری بێنە، بە نەرمی پەستی پێبکە.',
        '٧. بۆ ٣٠-٤٠ خولەک ببرژێنە تا زەردی قاوەیی بێت.',
        '٨. لە هەمان کاتدا، شیرە دروست بکە: شەکر و ئاو و ئاوی لیمۆ بۆ ١٠ خولەک بکوڵێنە. ئاوی گوڵی پرتەقاڵ زیاد بکە.',
        '٩. شیرەی گەرم بکە بەسەر کونافە گەرمەکە یەکسەر دوای دەرکردنی لە فڕنەکە.',
        '١٠. بە فستقی وردکراو ڕازێنەرەوە. ڕێگە بدە سارد بێت پێش پێشکەشکردن.'
      ],
    },
  ),
  Recipe(
    id: '42',
    title: {'en': 'Baklava', 'ku': 'باقڵاوە'},
    icon: '🥐',
    nutrition: NutritionalInfo(calories: 380, protein: 5, carbs: 45, fats: 20),
    category: MealCategory.snack,
    rating: 4.8,
    ratingCount: 134,
    ingredients: {
      'en': [
        '1 package phyllo dough (thawed)',
        '2 cups pistachios (finely chopped)',
        '1 cup walnuts (finely chopped)',
        '1 cup unsalted butter (melted)',
        '1 tsp cinnamon',
        '1 cup sugar',
        '1 cup water',
        '½ cup honey',
        '1 tbsp lemon juice',
        '1 tsp rose water (optional)'
      ],
      'ku': [
        '١ پاکەتی هەویری فیلۆ (نەرمکراوە)',
        '٢ پەرداخ فستق (وردکراوە)',
        '١ پەرداخ گوێز (وردکراوە)',
        '١ پەرداخ کەرەی بێ خوێ (بوونەوە بێنە)',
        '١ قاشقە چای دارچین',
        '١ پەرداخ شەکر',
        '١ پەرداخ ئاو',
        '١/٢ پەرداخ هەنگوین',
        '١ قاشق خواردن ئاوی لیمۆ',
        '١ قاشقە چای ئاوی گوڵ (ئارەزوویانە)'
      ],
    },
    steps: {
      'en': [
        '1. Preheat oven to 350°F (175°C). Butter 9x13 inch baking dish.',
        '2. Combine chopped pistachios, walnuts, and cinnamon in bowl.',
        '3. Unroll phyllo dough. Cover with damp towel to prevent drying.',
        '4. Place 1 sheet of phyllo in pan, brush with melted butter. Repeat 7 more times.',
        '5. Sprinkle ½ cup nut mixture over phyllo.',
        '6. Add 2 more phyllo sheets, brushing each with butter. Sprinkle ½ cup nuts.',
        '7. Continue layering until all nuts are used, ending with 8 phyllo sheets on top.',
        '8. Cut into diamond shapes before baking.',
        '9. Bake 45-50 minutes until golden brown.',
        '10. Meanwhile, make syrup: Combine sugar, water, honey, lemon juice. Simmer 10 minutes. Add rose water if using.',
        '11. Pour hot syrup over hot baklava. Let cool completely before serving.'
      ],
      'ku': [
        '١. فڕنەکە بۆ ١٧٥ پلەی سیلیزی گەرم بکە. قاپێکی ٩x١٣ ئینج بە کەرە بیڕەواز بکە.',
        '٢. فستق و گوێزی وردکراو و دارچین لە قاپێکدا تێکەڵ بکە.',
        '٣. هەویری فیلۆ بڕووخێنە. بە خاولێکی تریاکەرەوە دایبخە بۆ ڕێگری لە وشکبوون.',
        '٤. ١ پەڕە لە هەویرەکە بخەرە ناو تاسیەکە، بە کەرەی بوونەوە بیڕەواز بکە. ٧ جاری زیاتر دووبارە بکەرەوە.',
        '٥. ١/٢ پەرداخ لە تێکەڵەی چەرەز بپاش بەسەر هەویرەکە.',
        '٦. ٢ پەڕەی هەویری زیاتر زیاد بکە، هەر یەکێکیان بە کەرە بیڕەواز بکە. ١/٢ پەرداخ چەرەز بپاش.',
        '٧. بەردەوام بە لە چین چینکردن تا هەموو چەرەزەکان بەکاربهێنرێن، کۆتایی پێبێت بە ٨ پەڕە هەویری لە سەرەوە.',
        '٨. پێش برژاندن ببڕە بە شێوەی ئەڵماس.',
        '٩. بۆ ٤٥-٥٠ خولەک ببرژێنە تا زەردی قاوەیی بێت.',
        '١٠. لە هەمان کاتدا، شیرە دروست بکە: شەکر و ئاو و هەنگوین و ئاوی لیمۆ تێکەڵ بکە. بۆ ١٠ خولەک بگەڕێ. ئاوی گوڵ زیاد بکە ئەگەر بەکاردێنیت.',
        '١١. شیرەی گەرم بکە بەسەر بەقلاوە گەرمەکە. ڕێگە بدە بە تەواوی سارد بێت پێش پێشکەشکردن.'
      ],
    },
  ),
  Recipe(
    id: '43',
    title: {'en': 'Qelî (Kurdish Fried Meat)', 'ku': 'قەلی'},
    icon: '🥩',
    nutrition: NutritionalInfo(calories: 580, protein: 45, carbs: 2, fats: 42),
    category: MealCategory.bulking,
    rating: 4.7,
    ratingCount: 89,
    ingredients: {
      'en': [
        '1kg lamb (diced)',
        '½ cup lamb fat or ghee',
        '2 onions (sliced)',
        '2 tsp salt',
        '1 tsp black pepper',
        '1 tsp turmeric',
        '1 cup water',
        'Fresh bread for serving'
      ],
      'ku': [
        '١ کیلۆگرام بەرخ (چوارگۆشەکراوە)',
        '١/٢ پەرداخ بەز یان گی',
        '٢ پیاز (پەڕەکراوە)',
        '٢ قاشقە چای خوێ',
        '١ قاشقە چای بیبەری ڕەش',
        '١ قاشقە چای زەردەچەوە',
        '١ پەرداخ ئاو',
        'نانی تازە بۆ پێشکەشکردن'
      ],
    },
    steps: {
      'en': [
        '1. Melt lamb fat in large heavy pot over medium heat.',
        '2. Add diced lamb and brown on all sides.',
        '3. Add sliced onions and cook until translucent.',
        '4. Add spices and water. Bring to a boil.',
        '5. Reduce heat to low, cover, and simmer 1.5-2 hours until meat is very tender.',
        '6. Remove lid and cook until most liquid evaporates, leaving meat frying in its own fat.',
        '7. Continue cooking until meat is crispy and golden brown.',
        '8. Serve hot with fresh bread to soak up the flavorful fat.'
      ],
      'ku': [
        '١. بەز لە مەنجەڵێکی گەورە و قورسدا بوونەوە بێنە لە گەرمی ناوەڕاست.',
        '٢. بەرخە چوارگۆشەکراوەکە زیاد بکە و سووری بکەرەوە لە هەموو لایەک.',
        '٣. پیازی پەڕەکراو زیاد بکە و بکوڵێنە تا نیمچە ڕووناک بێت.',
        '٤. بەهارات و ئاو زیاد بکە. بگەڕێنەوە بۆ کوڵان.',
        '٥. گەرمی کەم بکە، دایبخە و بۆ ١.٥-٢ کاتژمێر بگەڕێ تا گۆشتەکە زۆر نەرم بێت.',
        '٦. سەرپۆشەکە لابە و بکوڵێنە تا زۆربەی ئاوەکە بەرەبەرە بێت، گۆشت لە بەزی خۆیدا بمێنێتەوە.',
        '٧. بەردەوام بە کوڵاندن تا گۆشتەکە ڕەق بێت و زەردی قاوەیی بێت.',
        '٨. گەرم لەگەڵ نانی تازە پێشکەشی بکە بۆ هەڵمژینی بەزە بەتامەکە.'
      ],
    },
  ),
  Recipe(
    id: '44',
    title: {'en': 'Kurdish Biryani', 'ku': 'بریانی کوردی'},
    icon: '🍛',
    nutrition: NutritionalInfo(calories: 620, protein: 25, carbs: 80, fats: 20),
    category: MealCategory.lunch,
    rating: 4.8,
    ratingCount: 150,
    ingredients: {
      'en': [
        '2 cups basmati rice',
        '500g chicken or lamb (cubed)',
        '2 large potatoes (peeled and cubed)',
        '1 cup green peas (fresh or frozen)',
        '½ cup raisins',
        '½ cup slivered almonds',
        '2 large onions (sliced)',
        '4 cloves garlic (minced)',
        '2 tbsp biryani spice mix',
        '½ cup yogurt',
        '¼ cup ghee or butter',
        '4 cups chicken or vegetable broth',
        'Saffron strands (soaked in 2 tbsp milk)'
      ],
      'ku': [
        '٢ پەرداخ برنجی بەسمەتی',
        '٥٠٠ گرام مریشک یان بەرخ (چوارگۆشەکراوە)',
        '٢ پەتاتەی گەورە (پەستێنراوی و چوارگۆشەکراوە)',
        '١ پەرداخ پۆتکەی سەوز',
        '١/٢ پەرداخ مێوژ',
        '١/٢ پەرداخ بادەمی وردکراو',
        '٢ پیازی گەورە (پەڕەکراوە)',
        '٤ خاو سیر (وردکراوە)',
        '٢ قاشق خواردن بەهاراتی بریانی',
        '١/٢ پەرداخ ماست',
        '١/٤ پەرداخ گی یان کەرە',
        '٤ پەرداخ ئاوی مریشک یان سەوزە',
        'چەند ڕیشاڵەی زەعفەران (خوساوە لە ٢ قاشق خواردن شیردا)'
      ],
    },
    steps: {
      'en': [
        '1. Wash rice and soak in water for 30 minutes, then drain.',
        '2. Marinate meat in yogurt, half the biryani spices, and garlic for 1 hour.',
        '3. Heat ghee in a large pot and fry onions until golden brown. Remove half for garnish.',
        '4. Add marinated meat and cook until browned on all sides.',
        '5. Add potatoes, peas, and remaining spices. Cook for 5 minutes.',
        '6. Layer soaked rice over the meat mixture, then sprinkle raisins and almonds.',
        '7. Pour hot broth over rice, add saffron milk, and bring to a boil.',
        '8. Reduce heat to low, cover tightly, and cook for 20-25 minutes until rice is tender.',
        '9. Let rest for 10 minutes before fluffing with a fork. Garnish with fried onions.'
      ],
      'ku': [
        '١. برنج بشۆ و بۆ ٣٠ خولەک لە ئاو بخۆشێنە، پاشان بیپاڵێوە.',
        '٢. گۆشت بۆ ١ کاتژمێر لە ماست و نیوەی بەهاراتی بریانی و سیر بخۆشێنە.',
        '٣. گی لە مەنجەڵێکی گەورەدا گەرم بکە و پیاز ببرژێنە تا زەردی قاوەیی. نیوەی بکە بۆ ڕازاندنەوە.',
        '٤. گۆشتی خوساوەکە زیاد بکە و بکوڵێنە تا لە هەموو لایەک سوور بێت.',
        '٥. پەتاتە و پۆتکە و بەهاراتی ماوە زیاد بکە. بۆ ٥ خولەک بکوڵێنە.',
        '٦. برنجی خوساوە لەسەر تێکەڵەی گۆشت ڕیز بکە، پاشان مێوژ و بادەم بپاش بە سەری.',
        '٧. ئاوی گەرم بکە بەسەر برنجەکە، شیرە زەعفەرانەکەش زیاد بکە و بگەڕێنەوە بۆ کوڵان.',
        '٨. گەرمی کەم بکە، دایبخە و بۆ ٢٠-٢٥ خولەک بکوڵێنە تا برنج نەرم بێت.',
        '٩. بۆ ١٠ خولەک پێش خواردن ڕای بگەڕێنە و بە کەوچکەوە لێی بدە. بە پیازی سوورکراوە ڕازێنەرەوە.'
      ],
    },
  ),
  Recipe(
    id: '45',
    title: {'en': 'Niska (Kurdish Sausage)', 'ku': 'نیسکا'},
    icon: '🌭',
    nutrition: NutritionalInfo(calories: 420, protein: 35, carbs: 5, fats: 28),
    category: MealCategory.lunch,
    rating: 4.5,
    ratingCount: 67,
    ingredients: {
      'en': [
        '1kg ground lamb or beef',
        '500g lamb fat (back fat)',
        '2 tbsp salt',
        '1 tbsp black pepper',
        '1 tbsp paprika',
        '2 tsp cumin',
        '1 tsp cinnamon',
        'Natural lamb casings',
        'Butter or oil for cooking'
      ],
      'ku': [
        '١ کیلۆگرام گۆشتی بەرخ یان مانگای هاڕاو',
        '٥٠٠ گرام بەزی بەرخ',
        '٢ قاشق خواردن خوێ',
        '١ قاشق خواردن بیبەری ڕەش',
        '١ قاشق خواردن بیبەری سوور',
        '٢ قاشقە چای کەمون',
        '١ قاشقە چای دارچین',
        'ڕیخۆڵەی سروشتی بەرخ',
        'کەرە یان ڕۆن بۆ چێشتلێنان'
      ],
    },
    steps: {
      'en': [
        '1. Grind lamb fat until fine paste. Mix with ground meat.',
        '2. Add all spices and mix thoroughly for 10-15 minutes until sticky.',
        '3. Soak casings in warm water 30 minutes. Rinse inside and out.',
        '4. Attach casing to sausage stuffer or piping bag.',
        '5. Fill casings with meat mixture, being careful not to overfill.',
        '6. Twist into 4-6 inch links.',
        '7. Prick any air bubbles with needle.',
        '8. Hang sausages in cool place for 24 hours to dry slightly.',
        '9. Cook in butter or oil over medium heat until browned and cooked through.',
        '10. Serve with bread and vegetables.'
      ],
      'ku': [
        '١. بەزەکە بلفێنە تا پەستێنەیەکی ورد بێت. لەگەڵ گۆشتی هاڕاو تێکەڵ بکە.',
        '٢. هەموو بەهاراتەکان زیاد بکە و بۆ ١٠-١٥ خولەک باش تێکەڵ بکە تا نەرم بێت.',
        '٣. ڕیخۆڵەکان بۆ ٣٠ خولەک لە ئاوی گەرمدا بخۆشێنە. ناوەوە و دەرەوەیان بشۆ.',
        '٤. ڕیخۆڵەکە ببەستە بە پڕکەرەوەی سجوق یان دەوری لولەی.',
        '٥. ڕیخۆڵەکان پڕ بکە بە تێکەڵەی گۆشت، وردبین بە لە زیاد پڕکردنیان.',
        '٦. بیپێچەرەوە بە درێژی ٤-٦ ئینج.',
        '٧. هەموو بۆڵەی هەوایەک بە درزێک بپێکە.',
        '٨. سجوقەکان بۆ ٢٤ کاتژمێر لە شوێنێکی سارددا هەڵواڵێنە تا کەمێک وشک بێت.',
        '٩. لە کەرە یان ڕۆندا بکوڵێنە لە گەرمی ناوەڕاست تا سوور بن و بپوختن.',
        '١٠. لەگەڵ نان و سەوزە پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '46',
    title: {'en': 'Shish Tawook', 'ku': 'شیش تاووق'},
    icon: '🍢',
    nutrition: NutritionalInfo(calories: 380, protein: 40, carbs: 5, fats: 15),
    category: MealCategory.dinner,
    rating: 4.8,
    ratingCount: 178,
    ingredients: {
      'en': [
        '1kg chicken breast (cut into 1-inch cubes)',
        '1 cup plain yogurt',
        '¼ cup lemon juice',
        '4 cloves garlic (minced)',
        '2 tbsp tomato paste',
        '1 tbsp paprika',
        '1 tsp cumin',
        '½ tsp cinnamon',
        '¼ cup olive oil',
        'Salt and pepper to taste',
        'Wooden or metal skewers'
      ],
      'ku': [
        '١ کیلۆگرام سنگی مریشک (بڕدراوە بە چوارگۆشەی ١ ئینج)',
        '١ پەرداخ ماست',
        '١/٤ پەرداخ ئاوی لیمۆ',
        '٤ خاو سیر (وردکراوە)',
        '٢ قاشق خواردن دۆشاوی تەماتە',
        '١ قاشق خواردن بیبەری سوور',
        '١ قاشقە چای کەمون',
        '١/٢ قاشقە چای دارچین',
        '١/٤ پەرداخ ڕۆنی زەیتوون',
        'خوێ و بیبەر بەپێی دڵخوازی',
        'شیشی دار یان کانزا'
      ],
    },
    steps: {
      'en': [
        '1. Soak wooden skewers in water for 30 minutes to prevent burning.',
        '2. In bowl, mix yogurt, lemon juice, garlic, tomato paste, spices, and olive oil.',
        '3. Add chicken cubes to marinade, coating thoroughly. Cover and refrigerate 4-24 hours.',
        '4. Thread chicken onto skewers, leaving small space between pieces.',
        '5. Preheat grill to medium-high heat (400°F/200°C).',
        '6. Grill skewers for 8-10 minutes, turning occasionally, until chicken is cooked through and charred in spots.',
        '7. Let rest 5 minutes before serving with garlic sauce, rice, and grilled vegetables.'
      ],
      'ku': [
        '١. شیشە دارەکان بۆ ٣٠ خولەک لە ئاو بخۆشێنە بۆ ڕێگری لە سووتان.',
        '٢. لە قاپێکدا، ماست و ئاوی لیمۆ و سیر و دۆشاوی تەماتە و بەهاراتەکان و ڕۆنی زەیتوون تێکەڵ بکە.',
        '٣. پارچە مریشکەکان زیاد بکە بۆ تێکەڵەکە، باش بپۆشیان بە. دایبخە و بۆ ٤-٢٤ کاتژمێر لە سەلادەر بخۆشێنەرەوە.',
        '٤. مریشکەکان بخەرە ناو شیشەکان، بۆشاییەکی بچووک لە نێوان پارچەکاندا بەجێبهێڵە.',
        '٥. برژێنەرەکە بۆ گەرمی ناوەڕاست گەرم بکە.',
        '٦. شیشەکان بۆ ٨-١٠ خولەک ببرژێنە، هەندێک جار بگۆڕەرێنە، تا مریشکەکە بپوختێت و لە هەندێک شوێندا سوور بێت.',
        '٧. بۆ ٥ خولەک پێش خواردن ڕایان بگەڕێنە و لەگەڵ سۆسی سیر و برنج و سەوزەی برژاو پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '47',
    title: {'en': 'Kibbeh', 'ku': 'کێبە'},
    icon: '🥩',
    nutrition: NutritionalInfo(calories: 350, protein: 25, carbs: 30, fats: 15),
    category: MealCategory.lunch,
    rating: 4.7,
    ratingCount: 94,
    ingredients: {
      'en': [
        '2 cups fine bulgur',
        '500g ground lamb',
        '1 onion (grated)',
        '1 tsp allspice',
        '1 tsp cinnamon',
        'Salt and pepper to taste',
        'Filling: ground meat, pine nuts, onions, spices',
        'Oil for frying'
      ],
      'ku': [
        '٢ پەرداخ بڕوێشی ورد',
        '٥٠٠ گرام گۆشتی بەرخ',
        '١ پیاز (هەڕاو)',
        '١ قاشقە چای بەهاراتی هەموو جۆرە',
        '١ قاشقە چای دارچین',
        'خوێ و بیبەر بەپێی دڵخوازی',
        'ناوەکە: گۆشتی هاڕاو، دەنکە سنۆبەر، پیاز، بەهارات',
        'ڕۆن بۆ سوورکردنەوە'
      ],
    },
    steps: {
      'en': [
        '1. Soak bulgur in water 30 minutes. Drain and squeeze out excess water.',
        '2. Mix bulgur with ground lamb, grated onion, and spices. Knead 10 minutes until smooth.',
        '3. Prepare filling: sauté onions, add ground meat, pine nuts, and spices.',
        '4. Wet hands, take egg-sized portion of kibbeh mixture.',
        '5. Form into oval shape, make hole with thumb.',
        '6. Fill with meat mixture, close opening, and reshape into oval.',
        '7. Heat oil to 350°F (175°C). Fry kibbeh until golden brown.',
        '8. Drain on paper towels. Serve with yogurt or tahini sauce.'
      ],
      'ku': [
        '١. بڕوێشەکە بۆ ٣٠ خولەک لە ئاودا بخۆشێنە. بیپاڵێوە و ئاوی زیادەکەی پەستێنە.',
        '٢. بڕوێش لەگەڵ گۆشتی بەرخ و پیازی هەڕاو و بەهارات تێکەڵ بکە. بۆ ١٠ خولەک چەقێنە تا ڕێک بێت.',
        '٣. ناوەکە ئامادە بکە: پیاز ببرژێنە، گۆشتی هاڕاو و دەنکە سنۆبەر و بەهارات زیاد بکە.',
        '٤. دەستەکانت شڵەق بکە، پارچەیەک بە قەبارەی هێلکە لە تێکەڵەی کێبە وەربگرە.',
        '٥. بیکە بە شێوەی سەرە، بە پەنجەیەوە چاڵێکی تێدا دروست بکە.',
        '٦. پڕی بکە بە تێکەڵەی گۆشت، دەرگاکە داخڵ بکە و دیسان بکەرەوە بە شێوەی سەرە.',
        '٧. ڕۆن بۆ ١٧٥ پلەی سیلیزی گەرم بکە. کێبەکان ببرژێنە تا زەردی قاوەیی ببن.',
        '٨. بە کلینکس وشکیان بکە. لەگەڵ ماست یان سۆسی تەحین پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '48',
    title: {'en': 'Kurdish Tea', 'ku': 'چای کوردی'},
    icon: '☕',
    nutrition: NutritionalInfo(calories: 50, protein: 0, carbs: 12, fats: 0),
    category: MealCategory.snack,
    rating: 4.9,
    ratingCount: 210,
    ingredients: {
      'en': [
        '4 cups water',
        '3 tbsp black tea leaves',
        '4 cardamom pods (crushed)',
        '2 cinnamon sticks',
        'Sugar to taste',
        'Fresh mint leaves (optional)'
      ],
      'ku': [
        '٤ پەرداخ ئاو',
        '٣ قاشق خواردن گەڵای چای',
        '٤ پاکەتی هێل (چەقێنراوە)',
        '٢ قەلیبی دارچین',
        'شەکر بەپێی دڵخوازی',
        'گەڵای نەعنای تازە (ئارەزوویانە)'
      ],
    },
    steps: {
      'en': [
        '1. Bring water to boil in traditional Kurdish tea pot or saucepan.',
        '2. Add tea leaves, cardamom, and cinnamon to pot.',
        '3. Reduce heat and simmer 5-7 minutes.',
        '4. Add mint leaves if using and simmer 1 more minute.',
        '5. Remove from heat and let steep 2-3 minutes.',
        '6. Pour through strainer into glasses.',
        '7. Add sugar to taste.',
        '8. Serve hot with dried fruits or sweets.'
      ],
      'ku': [
        '١. ئاو لە قەزەی چایە کوردییەکە یان قازانێک بگەڕێنەوە بۆ کوڵان.',
        '٢. گەڵای چای و هێل و دارچین زیاد بکە بۆ قازانەکە.',
        '٣. گەرمی کەم بکە و بۆ ٥-٧ خولەک بگەڕێ.',
        '٤. گەڵای نەعنا زیاد بکە ئەگەر بەکاردێنیت و بۆ ١ خولەکی زیاتر بگەڕێ.',
        '٥. لە گەرمی لابە و ڕێگە بدە بۆ ٢-٣ خولەک بمێنێتەوە.',
        '٦. بە پاڵێورێکەوە بکە بۆ پەرداخەکان.',
        '٧. شەکر بەپێی دڵخوازی زیاد بکە.',
        '٨. گەرم لەگەڵ میوەی وشک یان شیرینی پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '49',
    title: {'en': 'Kurdish Coffee', 'ku': 'قاوەی کوردی'},
    icon: '☕',
    nutrition: NutritionalInfo(calories: 30, protein: 1, carbs: 5, fats: 1),
    category: MealCategory.snack,
    rating: 4.7,
    ratingCount: 123,
    ingredients: {
      'en': [
        '1 cup water',
        '2 tbsp finely ground coffee',
        '1 tsp sugar (optional)',
        'Cardamom (optional)'
      ],
      'ku': [
        '١ پەرداخ ئاو',
        '٢ قاشق خواردن قاوەی وردکراو',
        '١ قاشقە چای شەکر (ئارەزوویانە)',
        'هێل (ئارەزوویانە)'
      ],
    },
    steps: {
      'en': [
        '1. Use traditional cezve (small coffee pot).',
        '2. Add water and heat until warm but not boiling.',
        '3. Add coffee and sugar if using. Do not stir.',
        '4. Heat slowly until foam rises to top.',
        '5. Remove from heat just before boiling point.',
        '6. Return to heat, allowing foam to rise again. Repeat 2-3 times.',
        '7. Remove from heat and let settle 1 minute.',
        '8. Pour slowly into small cups, dividing foam equally.',
        '9. Serve with glass of water on the side.'
      ],
      'ku': [
        '١. سەوزەیەکی نەریتی بەکاربهێنە.',
        '٢. ئاو زیاد بکە و گەرمی بکەرەوە تا گەرم بێت بەڵام کوڵان نەبێت.',
        '٣. قاوە و شەکر زیاد بکە ئەگەر بەکاردێنیت. تێکەڵی مەکە.',
        '٤. بە هێواشی گەرمی بکەرەوە تا کەفەکە بەرەو سەرەوە بڕوا بێت.',
        '٥. لە گەرمی لابە کاتی لێشاو لێدان.',
        '٦. بگەڕێنەوە بۆ گەرمی، ڕێگە بە کەفەکە بدە دیسان بەرز بێتەوە. ٢-٣ جار دووبارە بکەرەوە.',
        '٧. لە گەرمی لابە و ڕێگە بدە بۆ ١ خولەک راون بێتەوە.',
        '٨. بە هێواشی بکە بۆ پەرداخە بچووکەکان، کەفەکە بە یەکسانی دابەش بکە.',
        '٩. لەگەڵ پەرداخێک ئاو لە لایەکەوە پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '50',
    title: {'en': 'Kurdish Pizza', 'ku': 'پیتزای کوردی'},
    icon: '🍕',
    nutrition: NutritionalInfo(calories: 380, protein: 18, carbs: 45, fats: 14),
    category: MealCategory.lunch,
    rating: 4.6,
    ratingCount: 87,
    ingredients: {
      'en': [
        '2 cups flour',
        '1 cup yogurt',
        '1 tsp baking powder',
        '1 tsp salt',
        'Topping: ground meat, tomatoes, peppers, onions',
        'Spices: paprika, cumin, pepper',
        'Olive oil for brushing'
      ],
      'ku': [
        '٢ پەرداخ ئارد',
        '١ پەرداخ ماست',
        '١ قاشقە چای خمیری خوێشتن',
        '١ قاشقە چای خوێ',
        'سەرەوە: گۆشتی هاڕاو، تەماتە، بیبەر، پیاز',
        'بەهارات: بیبەری سوور، کەمون، بیبەر',
        'ڕۆنی زەیتوون بۆ ڕەوازکردن'
      ],
    },
    steps: {
      'en': [
        '1. Mix flour, yogurt, baking powder, and salt to form dough.',
        '2. Knead 5 minutes, cover, rest 30 minutes.',
        '3. Prepare topping: sauté meat with vegetables and spices.',
        '4. Divide dough into 4 portions. Roll each into oval shape.',
        '5. Place on baking sheet. Spread topping evenly.',
        '6. Brush edges with olive oil.',
        '7. Bake at 400°F (200°C) for 15-20 minutes until golden.',
        '8. Serve hot with yogurt or salad.'
      ],
      'ku': [
        '١. ئارد و ماست و خمیری خوێشتن و خوێ تێکەڵ بکە بۆ دروستکردنی هەویری.',
        '٢. بۆ ٥ خولەک چەقێنە، دایبخە، بۆ ٣٠ خولەک ڕای بگەڕێنە.',
        '٣. سەرەوەکە ئامادە بکە: گۆشت لەگەڵ سەوزە و بەهارات ببرژێنە.',
        '٤. هەویرەکە بڕی بە ٤ پارچە. هەر پارچەیەک بکە بە شێوەی سەرە.',
        '٥. بخەرە سەر پانیەکی برژاندن. سەرەوەکە بە یەکسانی بڵاو بکەرەوە.',
        '٦. لایەکان بە ڕۆنی زەیتوون بیڕەواز بکە.',
        '٧. لە ٢٠٠ پلەی سیلیزی بۆ ١٥-٢٠ خولەک ببرژێنە تا زەرد بێت.',
        '٨. گەرم لەگەڵ ماست یان زەڵاتە پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '51',
    title: {'en': 'Kurdish Stew', 'ku': 'شۆربای کوردی'},
    icon: '🍲',
    nutrition: NutritionalInfo(calories: 420, protein: 35, carbs: 25, fats: 20),
    category: MealCategory.lunch,
    rating: 4.5,
    ratingCount: 76,
    ingredients: {
      'en': [
        '1kg lamb or beef (cubed)',
        '2 onions (chopped)',
        '4 tomatoes (diced)',
        '2 bell peppers (sliced)',
        '3 tbsp tomato paste',
        '2 tsp turmeric',
        '2 tsp paprika',
        '1 tsp cinnamon',
        '¼ cup olive oil',
        '4 cups water',
        'Salt and pepper to taste'
      ],
      'ku': [
        '١ کیلۆگرام بەرخ یان مانگا (چوارگۆشەکراوە)',
        '٢ پیاز (وردکراوە)',
        '٤ تەماتە (چوارگۆشەکراوە)',
        '٢ بیبەر (پەڕەکراوە)',
        '٣ قاشق خواردن دۆشاوی تەماتە',
        '٢ قاشقە چای زەردەچەوە',
        '٢ قاشقە چای بیبەری سوور',
        '١ قاشقە چای دارچین',
        '١/٤ پەرداخ ڕۆنی زەیتوون',
        '٤ پەرداخ ئاو',
        'خوێ و بیبەر بەپێی دڵخوازی'
      ],
    },
    steps: {
      'en': [
        '1. Heat olive oil in large pot. Brown meat on all sides.',
        '2. Add onions and cook until softened.',
        '3. Add tomatoes, peppers, tomato paste, and spices.',
        '4. Cook 5 minutes until vegetables begin to soften.',
        '5. Add water, bring to boil, then reduce to simmer.',
        '6. Cover and cook 1.5-2 hours until meat is tender.',
        '7. Adjust seasoning.',
        '8. Serve hot with rice or bread.'
      ],
      'ku': [
        '١. ڕۆنی زەیتوون لە مەنجەڵێکی گەورەدا گەرم بکە. گۆشت لە هەموو لایەک سووری بکەرەوە.',
        '٢. پیاز زیاد بکە و بکوڵێنە تا نەرم بێت.',
        '٣. تەماتە و بیبەر و دۆشاوی تەماتە و بەهاراتەکان زیاد بکە.',
        '٤. بۆ ٥ خولەک بکوڵێنە تا سەوزەکان دەست بکەن بە نەرمبوون.',
        '٥. ئاو زیاد بکە، بگەڕێنەوە بۆ کوڵان، پاشان بگەڕێ بۆ نەرمکوڵان.',
        '٦. دایبخە و بۆ ١.٥-٢ کاتژمێر بکوڵێنە تا گۆشت نەرم بێت.',
        '٧. بەهاراتەکە دەستکاری بکە.',
        '٨. گەرم لەگەڵ برنج یان نان پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '52',
    title: {'en': 'Kurdish Omelette', 'ku': 'ئۆملیتی کوردی'},
    icon: '🍳',
    nutrition: NutritionalInfo(calories: 280, protein: 20, carbs: 8, fats: 18),
    category: MealCategory.breakfast,
    rating: 4.4,
    ratingCount: 65,
    ingredients: {
      'en': [
        '6 eggs',
        '1 onion (chopped)',
        '1 tomato (diced)',
        '1 green pepper (chopped)',
        '2 tbsp olive oil',
        '1 tsp salt',
        '½ tsp black pepper',
        '½ tsp paprika',
        'Fresh parsley for garnish'
      ],
      'ku': [
        '٦ هێلکە',
        '١ پیاز (وردکراوە)',
        '١ تەماتە (چوارگۆشەکراوە)',
        '١ بیبەری سەوز (وردکراوە)',
        '٢ قاشق خواردن ڕۆنی زەیتوون',
        '١ قاشقە چای خوێ',
        '١/٢ قاشقە چای بیبەری ڕەش',
        '١/٢ قاشقە چای بیبەری سوور',
        'جەعفەری تازە بۆ ڕازاندنەوە'
      ],
    },
    steps: {
      'en': [
        '1. Beat eggs with salt, pepper, and paprika.',
        '2. Heat olive oil in large skillet.',
        '3. Sauté onions until translucent.',
        '4. Add peppers and tomatoes, cook 3-4 minutes.',
        '5. Pour egg mixture over vegetables.',
        '6. Cook over medium heat until edges set.',
        '7. Flip carefully and cook other side 1-2 minutes.',
        '8. Garnish with parsley and serve hot with bread.'
      ],
      'ku': [
        '١. هێلکەکان بە خوێ و بیبەر و بیبەری سوور تێکەڵ بکە.',
        '٢. ڕۆنی زەیتوون لە تاوێکی گەورەدا گەرم بکە.',
        '٣. پیاز ببرژێنە تا نیمچە ڕووناک بێت.',
        '٤. بیبەر و تەماتە زیاد بکە، بۆ ٣-٤ خولەک بکوڵێنە.',
        '٥. تێکەڵەی هێلکە بکە بەسەر سەوزەکاندا.',
        '٦. لە گەرمی ناوەڕاست بکوڵێنە تا لایەکان ڕەق ببن.',
        '٧. بە وردبینی بیگۆڕە و لایەکەی تری بۆ ١-٢ خولەک بکوڵێنە.',
        '٨. بە جەعفەری ڕازێنەرەوە و گەرم لەگەڵ نان پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '53',
    title: {'en': 'Kurdish Pancakes', 'ku': 'پانکێیکی کوردی'},
    icon: '🥞',
    nutrition: NutritionalInfo(calories: 220, protein: 8, carbs: 35, fats: 6),
    category: MealCategory.breakfast,
    rating: 4.3,
    ratingCount: 54,
    ingredients: {
      'en': [
        '2 cups flour',
        '2 cups yogurt',
        '2 eggs',
        '1 tsp baking soda',
        '1 tsp salt',
        'Butter for cooking',
        'Honey or syrup for serving'
      ],
      'ku': [
        '٢ پەرداخ ئارد',
        '٢ پەرداخ ماست',
        '٢ هێلکە',
        '١ قاشقە چای سۆدای خوێشتن',
        '١ قاشقە چای خوێ',
        'کەرە بۆ چێشتلێنان',
        'هەنگوین یان شیرە بۆ پێشکەشکردن'
      ],
    },
    steps: {
      'en': [
        '1. Mix flour, yogurt, eggs, baking soda, and salt.',
        '2. Let batter rest 15 minutes.',
        '3. Heat butter in skillet over medium heat.',
        '4. Pour ¼ cup batter for each pancake.',
        '5. Cook until bubbles form on surface.',
        '6. Flip and cook other side until golden.',
        '7. Serve hot with honey or syrup.'
      ],
      'ku': [
        '١. ئارد و ماست و هێلکە و سۆدای خوێشتن و خوێ تێکەڵ بکە.',
        '٢. ڕێگە بە تێکەڵەکە بدە بۆ ١٥ خولەک بمێنێتەوە.',
        '٣. کەرە لە تاوێکدا گەرم بکە لە گەرمی ناوەڕاست.',
        '٤. ١/٤ پەرداخ تێکەڵە بۆ هەر پانکێکێک.',
        '٥. بکوڵێنە تا بۆڵە لەسەر ڕوو دروست ببێت.',
        '٦. بیگۆڕە و لایەکەی تری بکوڵێنە تا زەرد بێت.',
        '٧. گەرم لەگەڵ هەنگوین یان شیرە پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '54',
    title: {'en': 'Kurdish Pickles', 'ku': 'ترشی کوردی'},
    icon: '🥒',
    nutrition: NutritionalInfo(calories: 30, protein: 1, carbs: 6, fats: 0),
    category: MealCategory.snack,
    rating: 4.6,
    ratingCount: 89,
    ingredients: {
      'en': [
        '2 lbs mixed vegetables (cucumbers, carrots, cauliflower)',
        '4 cups water',
        '1 cup white vinegar',
        '3 tbsp salt',
        '2 tbsp sugar',
        '4 cloves garlic',
        '2 tbsp mustard seeds',
        '1 tbsp dill',
        '1 tsp black peppercorns'
      ],
      'ku': [
        '٢ پاوەند سەوزی تێکەڵ',
        '٤ پەرداخ ئاو',
        '١ پەرداخ سرکەی سپی',
        '٣ قاشق خواردن خوێ',
        '٢ قاشق خواردن شەکر',
        '٤ خاو سیر',
        '٢ قاشق خواردن تۆوی خەردەل',
        '١ قاشق خواردن شووید',
        '١ قاشقە چای تۆوی بیبەری تەواو'
      ],
    },
    steps: {
      'en': [
        '1. Wash vegetables thoroughly. Cut into desired sizes.',
        '2. Pack vegetables tightly into sterilized jars.',
        '3. Add garlic, mustard seeds, dill, and peppercorns.',
        '4. Bring water, vinegar, salt, and sugar to boil.',
        '5. Pour hot brine over vegetables, leaving ½ inch headspace.',
        '6. Seal jars tightly.',
        '7. Let cool to room temperature, then refrigerate.',
        '8. Wait at least 1 week before eating for best flavor.'
      ],
      'ku': [
        '١. سەوزەکان باش بشۆ. ببڕە بە قەبارەی دڵخواز.',
        '٢. سەوزەکان بە تەنگی بخەرە ناو پەرداخە پاککراوەکان.',
        '٣. سیر و تۆوی خەردەل و شووید و تۆوی بیبەری تەواو زیاد بکە.',
        '٤. ئاو و سرکە و خوێ و شەکر بگەڕێنەوە بۆ کوڵان.',
        '٥. ئاوی گەرم بکە بەسەر سەوزەکاندا، ١/٢ ئینج بۆشایی بەجێبهێڵە.',
        '٦. پەرداخەکان بە تەنگی داخڵ بکە.',
        '٧. ڕێگە بدە تا پلەی گەرمی ژوور سارد بێت، پاشان بخەرە سەلادەر.',
        '٨. بۆ کەمترین ١ هەفتە چاوەڕێ بکە پێش خواردن بۆ باشترین تام.'
      ],
    },
  ),
  Recipe(
    id: '55',
    title: {'en': 'Kurdish Yogurt', 'ku': 'ماستی کوردی'},
    icon: '🥛',
    nutrition: NutritionalInfo(calories: 150, protein: 8, carbs: 10, fats: 9),
    category: MealCategory.snack,
    rating: 4.7,
    ratingCount: 112,
    ingredients: {
      'en': [
        '1 gallon whole milk',
        '2 tbsp plain yogurt (with active cultures)',
        'Thermometer',
        'Clean glass jars'
      ],
      'ku': [
        '١ گالۆن شیر',
        '٢ قاشق خواردن ماست',
        'پلەپێو',
        'پەرداخە شووشەییە پاککراوەکان'
      ],
    },
    steps: {
      'en': [
        '1. Heat milk to 180°F (82°C), stirring occasionally.',
        '2. Cool milk to 110°F (43°C).',
        '3. Mix 1 cup warm milk with yogurt starter.',
        '4. Stir yogurt mixture back into remaining milk.',
        '5. Pour into clean jars, cover with lids.',
        '6. Keep at 110°F (43°C) for 8-12 hours.',
        '7. Refrigerate for at least 4 hours before serving.',
        '8. Save 2 tbsp as starter for next batch.'
      ],
      'ku': [
        '١. شیرەکە گەرمی بکەرەوە بۆ ٨٢ پلەی سیلیزی، هەندێک جار تێکەڵی بکە.',
        '٢. شیرەکە سارد بکەرەوە بۆ ٤٣ پلەی سیلیزی.',
        '٣. ١ پەرداخ شیرە گەرمەکە لەگەڵ سەرەتای ماست تێکەڵ بکە.',
        '٤. تێکەڵەی ماستەکە بگەڕێنەوە ناو شیرە ماوەکە.',
        '٥. بیکە بۆ پەرداخە پاککراوەکان، بە سەرپۆش دایبخە.',
        '٦. لە ٤٣ پلەی سیلیزی بۆ ٨-١٢ کاتژمێر بەجێبهێڵە.',
        '٧. بۆ کەمترین ٤ کاتژمێر پێش خواردن بخەرە سەلادەر.',
        '٨. ٢ قاشق خواردن پاشەکەوت بکە وەک سەرەتا بۆ چەرخی داهاتوو.'
      ],
    },
  ),
  Recipe(
    id: '56',
    title: {'en': 'Kurdish Cheese', 'ku': 'پەنیری کوردی'},
    icon: '🧀',
    nutrition: NutritionalInfo(calories: 280, protein: 18, carbs: 2, fats: 22),
    category: MealCategory.breakfast,
    rating: 4.6,
    ratingCount: 78,
    ingredients: {
      'en': [
        '1 gallon whole milk',
        '¼ cup lemon juice or vinegar',
        '1 tsp salt',
        'Cheesecloth'
      ],
      'ku': [
        '١ گالۆن شیر',
        '١/٤ پەرداخ ئاوی لیمۆ یان سرکە',
        '١ قاشقە چای خوێ',
        'پۆشی پەنیر'
      ],
    },
    steps: {
      'en': [
        '1. Heat milk to 185°F (85°C), stirring gently.',
        '2. Remove from heat, add lemon juice or vinegar.',
        '3. Stir gently until curds separate from whey.',
        '4. Let stand 10 minutes.',
        '5. Line colander with cheesecloth.',
        '6. Pour curds into colander to drain.',
        '7. Add salt and mix gently.',
        '8. Gather corners of cloth, tie, and hang to drain 2-4 hours.',
        '9. Refrigerate before serving.'
      ],
      'ku': [
        '١. شیرەکە گەرمی بکەرەوە بۆ ٨٥ پلەی سیلیزی، بە نەرمی تێکەڵی بکە.',
        '٢. لە گەرمی لابە، ئاوی لیمۆ یان سرکە زیاد بکە.',
        '٣. بە نەرمی تێکەڵی بکە تا خڕەکان لە ئاو جیا ببنەوە.',
        '٤. ڕێگە بدە بۆ ١٠ خولەک راون بێتەوە.',
        '٥. پاڵێورێک بە پۆشی پەنیر داپۆشە.',
        '٦. خڕەکان بکە بۆ پاڵێورەکە بۆ پاڵێوران.',
        '٧. خوێ زیاد بکە و بە نەرمی تێکەڵی بکە.',
        '٨. سەری پۆشەکە کۆبکەرەوە، بیبەستە و هەڵی واڵێنە بۆ پاڵێوران بۆ ٢-٤ کاتژمێر.',
        '٩. پێش خواردن بخەرە سەلادەر.'
      ],
    },
  ),
  Recipe(
    id: '57',
    title: {'en': 'Kurdish Bread Pudding', 'ku': 'پودینگی نانی کوردی'},
    icon: '🍮',
    nutrition: NutritionalInfo(calories: 320, protein: 10, carbs: 45, fats: 12),
    category: MealCategory.snack,
    rating: 4.4,
    ratingCount: 45,
    ingredients: {
      'en': [
        '4 cups stale Kurdish bread',
        '4 cups milk',
        '½ cup sugar',
        '3 eggs',
        '1 tsp vanilla',
        '½ tsp cinnamon',
        '½ cup raisins',
        '2 tbsp butter'
      ],
      'ku': [
        '٤ پەرداخ نانی کوردی',
        '٤ پەرداخ شیر',
        '١/٢ پەرداخ شەکر',
        '٣ هێلکە',
        '١ قاشقە چای ڤانیلا',
        '١/٢ قاشقە چای دارچین',
        '١/٢ پەرداخ مێوژ',
        '٢ قاشق خواردن کەرە'
      ],
    },
    steps: {
      'en': [
        '1. Tear bread into small pieces.',
        '2. Soak in milk 30 minutes.',
        '3. Preheat oven to 350°F (175°C).',
        '4. Beat eggs with sugar and vanilla.',
        '5. Mix with bread mixture.',
        '6. Add raisins and cinnamon.',
        '7. Pour into buttered baking dish.',
        '8. Dot with butter.',
        '9. Bake 45-50 minutes until set and golden.',
        '10. Serve warm or cold.'
      ],
      'ku': [
        '١. نانەکە بپچڕێنە بە پارچە بچووک.',
        '٢. بۆ ٣٠ خولەک لە شیردا بخۆشێنە.',
        '٣. فڕنەکە بۆ ١٧٥ پلەی سیلیزی گەرم بکە.',
        '٤. هێلکە لەگەڵ شەکر و ڤانیلا تێکەڵ بکە.',
        '٥. لەگەڵ تێکەڵەی نان تێکەڵی بکە.',
        '٦. مێوژ و دارچین زیاد بکە.',
        '٧. بیکە بۆ تاسیەکی کەرەپاشی.',
        '٨. بە کەرە پشتی پێبکە.',
        '٩. بۆ ٤٥-٥٠ خولەک ببرژێنە تا ڕەق بێت و زەرد بێت.',
        '١٠. گەرم یان سارد پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '58',
    title: {'en': 'Kurdish Halva', 'ku': 'هەلواوی کوردی'},
    icon: '🧆',
    nutrition: NutritionalInfo(calories: 380, protein: 8, carbs: 45, fats: 20),
    category: MealCategory.snack,
    rating: 4.7,
    ratingCount: 98,
    ingredients: {
      'en': [
        '1 cup semolina',
        '1 cup sugar',
        '1 cup water',
        '½ cup ghee or butter',
        '½ cup chopped nuts',
        '½ tsp cardamom',
        'Saffron strands (optional)'
      ],
      'ku': [
        '١ پەرداخ سمید',
        '١ پەرداخ شەکر',
        '١ پەرداخ ئاو',
        '١/٢ پەرداخ گی یان کەرە',
        '١/٢ پەرداخ چەرەزی وردکراو',
        '١/٢ قاشقە چای هێل',
        'چەند ڕیشاڵەی زەعفەران (ئارەزوویانە)'
      ],
    },
    steps: {
      'en': [
        '1. Heat ghee in heavy pan.',
        '2. Add semolina and cook, stirring constantly, until golden.',
        '3. In separate pot, boil sugar and water to make syrup.',
        '4. Add cardamom and saffron to syrup.',
        '5. Carefully pour hot syrup into semolina mixture.',
        '6. Stir vigorously until well combined.',
        '7. Add nuts and mix.',
        '8. Press into serving dish.',
        '9. Let cool before cutting into pieces.',
        '10. Garnish with additional nuts.'
      ],
      'ku': [
        '١. گی لە تاوێکی قورسدا گەرم بکە.',
        '٢. سمید زیاد بکە و بکوڵێنە، بە بەردەوامی تێکەڵی بکە، تا زەرد بێت.',
        '٣. لە مەنجەڵێکی جیادا، شەکر و ئاو بکوڵێنە بۆ دروستکردنی شیرە.',
        '٤. هێل و زەعفەران زیاد بکە بۆ شیرەکە.',
        '٥. بە وردبینی شیرەی گەرم بکە بۆ ناو تێکەڵەی سمید.',
        '٦. بە بەهێزی تێکەڵی بکە تا باش یەک بگرن.',
        '٧. چەرەز زیاد بکە و تێکەڵی بکە.',
        '٨. بکە بۆ قاپێکی پێشکەشکردن.',
        '٩. ڕێگە بدە سارد بێت پێش بڕینی بە پارچە.',
        '١٠. بە چەرەزی زیادە ڕازێنەرەوە.'
      ],
    },
  ),
  Recipe(
    id: '59',
    title: {'en': 'Kurdish Rice Pudding', 'ku': 'پودینگی برنجی کوردی'},
    icon: '🍚',
    nutrition: NutritionalInfo(calories: 280, protein: 8, carbs: 45, fats: 8),
    category: MealCategory.snack,
    rating: 4.5,
    ratingCount: 67,
    ingredients: {
      'en': [
        '½ cup rice',
        '4 cups milk',
        '½ cup sugar',
        '1 tsp rose water',
        '½ tsp cardamom',
        '¼ cup chopped pistachios',
        'Cinnamon for garnish'
      ],
      'ku': [
        '١/٢ پەرداخ برنج',
        '٤ پەرداخ شیر',
        '١/٢ پەرداخ شەکر',
        '١ قاشقە چای ئاوی گوڵ',
        '١/٢ قاشقە چای هێل',
        '١/٤ پەرداخ فستقی وردکراو',
        'دارچین بۆ ڕازاندنەوە'
      ],
    },
    steps: {
      'en': [
        '1. Wash rice and soak 30 minutes.',
        '2. Drain and cook with 1 cup water until soft.',
        '3. Add milk and simmer 30-40 minutes, stirring frequently.',
        '4. Add sugar, rose water, and cardamom.',
        '5. Cook until thickened to pudding consistency.',
        '6. Pour into serving bowls.',
        '7. Sprinkle with pistachios and cinnamon.',
        '8. Serve warm or chilled.'
      ],
      'ku': [
        '١. برنج بشۆ و بۆ ٣٠ خولەک بخۆشێنە.',
        '٢. بیپاڵێوە و لەگەڵ ١ پەرداخ ئاو بکوڵێنە تا نەرم بێت.',
        '٣. شیر زیاد بکە و بۆ ٣٠-٤٠ خولەک بگەڕێ، بە زۆری تێکەڵی بکە.',
        '٤. شەکر و ئاوی گوڵ و هێل زیاد بکە.',
        '٥. بکوڵێنە تا خەست ببێتەوە بۆ قەبارەی پودینگ.',
        '٦. بیکە بۆ قاپەکانی پێشکەشکردن.',
        '٧. بە فستق و دارچین بپاش بە سەریان.',
        '٨. گەرم یان سارد پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '60',
    title: {'en': 'Kechke', 'ku': 'کەشکە'},
    icon: '🥣',
    nutrition: NutritionalInfo(calories: 340, protein: 12, carbs: 55, fats: 8),
    category: MealCategory.lunch,
    rating: 4.4,
    ratingCount: 56,
    ingredients: {
      'en': [
        '2 cups cracked wheat',
        '1 cup yogurt',
        '2 tbsp butter',
        '1 tbsp dried mint',
        '1 tsp salt',
        '4 cups water'
      ],
      'ku': [
        '٢ پەرداخ دانەوێڵەی کوتراو',
        '١ پەرداخ ماست',
        '٢ قاشق خواردن کەرە',
        '١ قاشق خواردن نەعنای وشک',
        '١ قاشقە چای خوێ',
        '٤ پەرداخ ئاو'
      ],
    },
    steps: {
      'en': [
        '1. Cook cracked wheat in water with salt until soft (about 20 minutes).',
        '2. Drain any excess water.',
        '3. Stir in yogurt until well combined.',
        '4. Melt butter in small pan.',
        '5. Add dried mint to butter and cook 30 seconds.',
        '6. Pour mint butter over kechke.',
        '7. Mix gently and serve hot.'
      ],
      'ku': [
        '١. دانەوێڵەی کوتراو لە ئاودا لەگەڵ خوێ بکوڵێنە تا نەرم بێت (نزیکەی ٢٠ خولەک).',
        '٢. ئاوی زیادەی پاڵێوە.',
        '٣. ماست تێکەڵی بکە تا باش یەک بگرن.',
        '٤. کەرە لە تاوێکی بچووکدا بوونەوە بێنە.',
        '٥. نەعنای وشک زیاد بکە بۆ کەرە و بۆ ٣٠ چرکە بکوڵێنە.',
        '٦. کەرەی نەعنا بکە بەسەر کەشکە.',
        '٧. بە نەرمی تێکەڵی بکە و گەرم پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '61',
    title: {'en': 'Girara (Kurdish Soup)', 'ku': 'گەرارە'},
    icon: '🍲',
    nutrition: NutritionalInfo(calories: 220, protein: 6, carbs: 40, fats: 4),
    category: MealCategory.lunch,
    rating: 4.3,
    ratingCount: 45,
    ingredients: {
      'en': [
        '½ cup rice',
        '1 cup yogurt',
        '2 cups chard (chopped)',
        '1 tbsp dried mint',
        '1 tsp salt',
        '4 cups water'
      ],
      'ku': [
        '١/٢ پەرداخ برنج',
        '١ پەرداخ ماست',
        '٢ پەرداخ سڵق (وردکراوە)',
        '١ قاشق خواردن نەعنای وشک',
        '١ قاشقە چای خوێ',
        '٤ پەرداخ ئاو'
      ],
    },
    steps: {
      'en': [
        '1. Cook rice in water until soft (about 15 minutes).',
        '2. Add chard and cook 5 more minutes.',
        '3. Remove from heat and let cool slightly.',
        '4. Whisk yogurt until smooth.',
        '5. Slowly add yogurt to soup, stirring constantly.',
        '6. Return to low heat, but do not boil.',
        '7. Add salt and dried mint.',
        '8. Serve warm.'
      ],
      'ku': [
        '١. برنج لە ئاودا بکوڵێنە تا نەرم بێت (نزیکەی ١٥ خولەک).',
        '٢. سڵق زیاد بکە و ٥ خولەکی زیاتر بکوڵێنە.',
        '٣. لە گەرمی لابە و ڕێگە بدە کەمێک سارد بێت.',
        '٤. ماستەکە تێکەڵ بکە تا ڕێک بێت.',
        '٥. بەرەبەرە ماستەکە زیاد بکە بۆ شۆرباکە، بە بەردەوامی تێکەڵی بکە.',
        '٦. بگەڕێنەوە بۆ گەرمی نزم، بەڵام مەکوڵێنە.',
        '٧. خوێ و نەعنای وشک زیاد بکە.',
        '٨. گەرم پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '62',
    title: {'en': 'Sîrim', 'ku': 'سیرم'},
    icon: '🧄',
    nutrition: NutritionalInfo(calories: 310, protein: 8, carbs: 50, fats: 10),
    category: MealCategory.lunch,
    rating: 4.4,
    ratingCount: 34,
    ingredients: {
      'en': [
        '2 cups wheat',
        '1 cup yogurt',
        '4 cloves garlic (minced)',
        '1 tsp salt',
        '4 cups water'
      ],
      'ku': [
        '٢ پەرداخ دانەوێڵە',
        '١ پەرداخ ماست',
        '٤ خاو سیر (وردکراوە)',
        '١ قاشقە چای خوێ',
        '٤ پەرداخ ئاو'
      ],
    },
    steps: {
      'en': [
        '1. Cook wheat in water until very soft (about 1 hour).',
        '2. Drain excess water.',
        '3. Mix with yogurt and garlic.',
        '4. Add salt to taste.',
        '5. Serve at room temperature with bread.'
      ],
      'ku': [
        '١. دانەوێڵە لە ئاودا بکوڵێنە تا زۆر نەرم بێت (نزیکەی ١ کاتژمێر).',
        '٢. ئاوی زیادەی پاڵێوە.',
        '٣. لەگەڵ ماست و سیر تێکەڵی بکە.',
        '٤. خوێ بەپێی دڵخوازی زیاد بکە.',
        '٥. لە پلەی گەرمی ژوور لەگەڵ نان پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '63',
    title: {'en': 'Giyabenî', 'ku': 'گیا بەنی'},
    icon: '🌿',
    nutrition: NutritionalInfo(calories: 200, protein: 4, carbs: 30, fats: 7),
    category: MealCategory.lunch,
    rating: 4.2,
    ratingCount: 23,
    ingredients: {
      'en': [
        '4 cups wild spring greens',
        '2 eggs',
        '1 onion (chopped)',
        '2 tbsp olive oil',
        '1 tsp salt',
        '½ tsp black pepper'
      ],
      'ku': [
        '٤ پەرداخ گیای بەهاری',
        '٢ هێلکە',
        '١ پیاز (وردکراوە)',
        '٢ قاشق خواردن ڕۆنی زەیتوون',
        '١ قاشقە چای خوێ',
        '١/٢ قاشقە چای بیبەری ڕەش'
      ],
    },
    steps: {
      'en': [
        '1. Wash greens thoroughly.',
        '2. Heat olive oil in pan.',
        '3. Sauté onions until golden.',
        '4. Add greens and cook until wilted.',
        '5. Beat eggs with salt and pepper.',
        '6. Pour eggs over greens.',
        '7. Cook until eggs are set.',
        '8. Serve hot with bread.'
      ],
      'ku': [
        '١. گیاکان باش بشۆ.',
        '٢. ڕۆنی زەیتوون لە تاوێکدا گەرم بکە.',
        '٣. پیاز ببرژێنە تا زەرد بێت.',
        '٤. گیاکان زیاد بکە و بکوڵێنە تا پژێن.',
        '٥. هێلکە لەگەڵ خوێ و بیبەر تێکەڵ بکە.',
        '٦. هێلکەکان بکە بەسەر گیاکاندا.',
        '٧. بکوڵێنە تا هێلکەکان ڕەق ببن.',
        '٨. گەرم لەگەڵ نان پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '64',
    title: {'en': 'Mastaw (Doogh)', 'ku': 'ماستاو'},
    icon: '🥛',
    nutrition: NutritionalInfo(calories: 80, protein: 4, carbs: 6, fats: 4),
    category: MealCategory.snack,
    rating: 4.6,
    ratingCount: 78,
    ingredients: {
      'en': [
        '2 cups yogurt',
        '4 cups cold water',
        '1 tsp salt',
        '2 tbsp dried mint',
        'Ice cubes'
      ],
      'ku': [
        '٢ پەرداخ ماست',
        '٤ پەرداخ ئاوی سارد',
        '١ قاشقە چای خوێ',
        '٢ قاشق خواردن نەعنای وشک',
        'گۆڕە یخ'
      ],
    },
    steps: {
      'en': [
        '1. Whisk yogurt until smooth.',
        '2. Gradually add water while whisking.',
        '3. Add salt and mint.',
        '4. Chill in refrigerator for at least 1 hour.',
        '5. Serve over ice cubes.'
      ],
      'ku': [
        '١. ماستەکە تێکەڵ بکە تا ڕێک بێت.',
        '٢. بەرەبەرە ئاو زیاد بکە لە کاتی تێکەڵکردندا.',
        '٣. خوێ و نەعنا زیاد بکە.',
        '٤. بۆ کەمترین ١ کاتژمێر لە سەلادەر سارد بکە.',
        '٥. لەسەر گۆڕە یخ پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '65',
    title: {'en': 'Zarda (Sweet Rice)', 'ku': 'زەردە'},
    icon: '🥣',
    nutrition: NutritionalInfo(calories: 320, protein: 4, carbs: 70, fats: 3),
    category: MealCategory.snack,
    rating: 4.5,
    ratingCount: 45,
    ingredients: {
      'en': [
        '2 cups basmati rice',
        '1 cup sugar',
        '½ tsp saffron',
        '1 tbsp rose water',
        '¼ cup slivered almonds',
        '¼ cup raisins',
        '4 cups water'
      ],
      'ku': [
        '٢ پەرداخ برنجی بەسمەتی',
        '١ پەرداخ شەکر',
        '١/٢ قاشقە چای زەعفەران',
        '١ قاشق خواردن ئاوی گوڵ',
        '١/٤ پەرداخ بادەمی وردکراو',
        '١/٤ پەرداخ مێوژ',
        '٤ پەرداخ ئاو'
      ],
    },
    steps: {
      'en': [
        '1. Soak rice for 30 minutes, then drain.',
        '2. Cook rice in water until almost done.',
        '3. Dissolve saffron in 2 tbsp warm water.',
        '4. Mix sugar, saffron water, and rose water.',
        '5. Add to rice and cook on low heat until syrup thickens.',
        '6. Stir in almonds and raisins.',
        '7. Serve warm or at room temperature.'
      ],
      'ku': [
        '١. برنجەکە بۆ ٣٠ خولەک بخۆشێنە، پاشان بیپاڵێوە.',
        '٢. برنجەکە لە ئاودا بکوڵێنە تا بەنزیکەیی ئامادە بێت.',
        '٣. زەعفەران بڕەواز بکە لە ٢ قاشق خواردن ئاوی گەرم.',
        '٤. شەکر و ئاوی زەعفەران و ئاوی گوڵ تێکەڵ بکە.',
        '٥. زیاد بکە بۆ برنج و لە گەرمی نزم بکوڵێنە تا شیرەکە خەست ببێتەوە.',
        '٦. بادەم و مێوژ تێکەڵی بکە.',
        '٧. گەرم یان لە پلەی گەرمی ژوور پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '66',
    title: {'en': 'Sutlac (Rice Pudding)', 'ku': 'سوتلاج'},
    icon: '🍮',
    nutrition: NutritionalInfo(calories: 280, protein: 8, carbs: 45, fats: 8),
    category: MealCategory.snack,
    rating: 4.7,
    ratingCount: 89,
    ingredients: {
      'en': [
        '½ cup rice',
        '4 cups milk',
        '½ cup sugar',
        '1 tsp vanilla',
        '2 tbsp cornstarch',
        'Cinnamon for garnish'
      ],
      'ku': [
        '١/٢ پەرداخ برنج',
        '٤ پەرداخ شیر',
        '١/٢ پەرداخ شەکر',
        '١ قاشقە چای ڤانیلا',
        '٢ قاشق خواردن نیشاستە',
        'دارچین بۆ ڕازاندنەوە'
      ],
    },
    steps: {
      'en': [
        '1. Wash rice and cook in 1 cup water until soft.',
        '2. Add milk and simmer 30 minutes.',
        '3. Mix cornstarch with ¼ cup cold milk.',
        '4. Add to rice mixture and cook until thickened.',
        '5. Add sugar and vanilla.',
        '6. Pour into serving bowls.',
        '7. Sprinkle with cinnamon.',
        '8. Chill before serving.'
      ],
      'ku': [
        '١. برنج بشۆ و لە ١ پەرداخ ئاودا بکوڵێنە تا نەرم بێت.',
        '٢. شیر زیاد بکە و بۆ ٣٠ خولەک بگەڕێ.',
        '٣. نیشاستە لەگەڵ ١/٤ پەرداخ شیرە سارد تێکەڵ بکە.',
        '٤. زیاد بکە بۆ تێکەڵەی برنج و بکوڵێنە تا خەست ببێتەوە.',
        '٥. شەکر و ڤانیلا زیاد بکە.',
        '٦. بیکە بۆ قاپەکانی پێشکەشکردن.',
        '٧. بە دارچین بپاش بە سەریان.',
        '٨. پێش خواردن سارد بکە.'
      ],
    },
  ),
  Recipe(
    id: '67',
    title: {'en': 'Halva', 'ku': 'هەلوا'},
    icon: '🧆',
    nutrition: NutritionalInfo(calories: 380, protein: 8, carbs: 45, fats: 20),
    category: MealCategory.snack,
    rating: 4.7,
    ratingCount: 98,
    ingredients: {
      'en': [
        '1 cup semolina',
        '1 cup sugar',
        '1 cup water',
        '½ cup ghee',
        '½ cup chopped nuts',
        '½ tsp cardamom'
      ],
      'ku': [
        '١ پەرداخ سمید',
        '١ پەرداخ شەکر',
        '١ پەرداخ ئاو',
        '١/٢ پەرداخ گی',
        '١/٢ پەرداخ چەرەزی وردکراو',
        '١/٢ قاشقە چای هێل'
      ],
    },
    steps: {
      'en': [
        '1. Heat ghee in pan.',
        '2. Add semolina and cook until golden.',
        '3. Boil sugar and water to make syrup.',
        '4. Add cardamom to syrup.',
        '5. Carefully pour syrup into semolina.',
        '6. Stir vigorously until combined.',
        '7. Add nuts and mix.',
        '8. Press into dish and let cool.',
        '9. Cut into pieces and serve.'
      ],
      'ku': [
        '١. گی لە تاوێکدا گەرم بکە.',
        '٢. سمید زیاد بکە و بکوڵێنە تا زەرد بێت.',
        '٣. شەکر و ئاو بکوڵێنە بۆ دروستکردنی شیرە.',
        '٤. هێل زیاد بکە بۆ شیرەکە.',
        '٥. بە وردبینی شیرەکە بکە بۆ ناو سمید.',
        '٦. بە بەهێزی تێکەڵی بکە تا یەک بگرن.',
        '٧. چەرەز زیاد بکە و تێکەڵی بکە.',
        '٨. بکە بۆ قاپێک و ڕێگە بدە سارد بێت.',
        '٩. ببڕە بە پارچە و پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '68',
    title: {'en': 'Umm Ali', 'ku': 'ئوم عەلی'},
    icon: '🍮',
    nutrition: NutritionalInfo(calories: 350, protein: 8, carbs: 50, fats: 14),
    category: MealCategory.snack,
    rating: 4.6,
    ratingCount: 67,
    ingredients: {
      'en': [
        '4 cups milk',
        '1 cup sugar',
        '1 tsp vanilla',
        '½ cup raisins',
        '½ cup coconut flakes',
        '½ cup chopped nuts',
        'Puff pastry or bread pieces'
      ],
      'ku': [
        '٤ پەرداخ شیر',
        '١ پەرداخ شەکر',
        '١ قاشقە چای ڤانیلا',
        '١/٢ پەرداخ مێوژ',
        '١/٢ پەرداخ پارچە کۆکۆ',
        '١/٢ پەرداخ چەرەزی وردکراو',
        'هەویری پەف یان پارچە نان'
      ],
    },
    steps: {
      'en': [
        '1. Preheat oven to 350°F (175°C).',
        '2. Tear pastry or bread into pieces.',
        '3. Place in baking dish.',
        '4. Sprinkle with raisins, coconut, and nuts.',
        '5. Heat milk with sugar and vanilla.',
        '6. Pour over bread mixture.',
        '7. Bake 30-40 minutes until golden.',
        '8. Serve warm.'
      ],
      'ku': [
        '١. فڕنەکە بۆ ١٧٥ پلەی سیلیزی گەرم بکە.',
        '٢. هەویر یان نان بپچڕێنە بە پارچە.',
        '٣. بخەرە ناو تاسێکی برژاندن.',
        '٤. بە مێوژ و کۆکۆ و چەرەز بپاش بە سەری.',
        '٥. شیر لەگەڵ شەکر و ڤانیلا گەرمی بکەرەوە.',
        '٦. بکە بەسەر تێکەڵەی نان.',
        '٧. بۆ ٣٠-٤٠ خولەک ببرژێنە تا زەرد بێت.',
        '٨. گەرم پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '69',
    title: {'en': 'Knafeh', 'ku': 'کونافە'},
    icon: '🥧',
    nutrition: NutritionalInfo(calories: 450, protein: 8, carbs: 60, fats: 22),
    category: MealCategory.snack,
    rating: 4.8,
    ratingCount: 156,
    ingredients: {
      'en': [
        '1 package knafeh dough',
        '500g cheese',
        '1 cup butter',
        '1 cup sugar',
        '1 cup water',
        '½ cup rose water'
      ],
      'ku': [
        '١ پاکەتی هەویری کونافە',
        '٥٠٠ گرام پەنیر',
        '١ پەرداخ کەرە',
        '١ پەرداخ شەکر',
        '١ پەرداخ ئاو',
        '١/٢ پەرداخ ئاوی گوڵ'
      ],
    },
    steps: {
      'en': [
        '1. Shred cheese if needed.',
        '2. Preheat oven to 350°F (175°C).',
        '3. Mix dough with melted butter.',
        '4. Press half into pan.',
        '5. Spread cheese evenly.',
        '6. Top with remaining dough.',
        '7. Bake 30-40 minutes.',
        '8. Make syrup: boil sugar, water, and rose water.',
        '9. Pour syrup over hot knafeh.',
        '10. Garnish with nuts and serve.'
      ],
      'ku': [
        '١. پەنیرەکە هەڵی بکە ئەگەر پێویست بوو.',
        '٢. فڕنەکە بۆ ١٧٥ پلەی سیلیزی گەرم بکە.',
        '٣. هەویر لەگەڵ کەرەی بوونەوە تێکەڵ بکە.',
        '٤. نیوەی بکە بە ناو تاسیەکە.',
        '٥. پەنیرەکە بە یەکسانی بڵاو بکەرەوە.',
        '٦. هەویری ماوەکەی سەری بێنە.',
        '٧. بۆ ٣٠-٤٠ خولەک ببرژێنە.',
        '٨. شیرە دروست بکە: شەکر و ئاو و ئاوی گوڵ بکوڵێنە.',
        '٩. شیرەکە بکە بەسەر کونافە گەرمەکە.',
        '١٠. بە چەرەز ڕازێنەرەوە و پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '70',
    title: {'en': 'Baklava', 'ku': 'بەقلاوە'},
    icon: '🥮',
    nutrition: NutritionalInfo(calories: 450, protein: 6, carbs: 55, fats: 25),
    category: MealCategory.snack,
    rating: 4.8,
    ratingCount: 134,
    ingredients: {
      'en': [
        '1 package phyllo dough',
        '2 cups pistachios',
        '1 cup walnuts',
        '1 cup butter',
        '1 cup sugar',
        '1 cup water',
        '½ cup honey'
      ],
      'ku': [
        '١ پاکەتی هەویری فیلۆ',
        '٢ پەرداخ فستق',
        '١ پەرداخ گوێز',
        '١ پەرداخ کەرە',
        '١ پەرداخ شەکر',
        '١ پەرداخ ئاو',
        '١/٢ پەرداخ هەنگوین'
      ],
    },
    steps: {
      'en': [
        '1. Preheat oven to 350°F (175°C).',
        '2. Mix nuts with cinnamon.',
        '3. Layer phyllo with butter and nuts.',
        '4. Cut into diamonds.',
        '5. Bake 45-50 minutes.',
        '6. Make syrup with sugar, water, and honey.',
        '7. Pour over hot baklava.',
        '8. Let cool before serving.'
      ],
      'ku': [
        '١. فڕنەکە بۆ ١٧٥ پلەی سیلیزی گەرم بکە.',
        '٢. چەرەز لەگەڵ دارچین تێکەڵ بکە.',
        '٣. چینی فیلۆ لەگەڵ کەرە و چەرەز.',
        '٤. ببڕە بە ئەڵماس.',
        '٥. بۆ ٤٥-٥٠ خولەک ببرژێنە.',
        '٦. شیرە دروست بکە لەگەڵ شەکر و ئاو و هەنگوین.',
        '٧. بکە بەسەر بەقلاوە گەرمەکە.',
        '٨. ڕێگە بدە سارد بێت پێش پێشکەشکردن.'
      ],
    },
  ),
  Recipe(
    id: '71',
    title: {'en': 'Kurdish Tea', 'ku': 'چای کوردی'},
    icon: '☕',
    nutrition: NutritionalInfo(calories: 50, protein: 0, carbs: 12, fats: 0),
    category: MealCategory.snack,
    rating: 4.9,
    ratingCount: 210,
    ingredients: {
      'en': [
        '4 cups water',
        '3 tbsp black tea',
        '4 cardamom pods',
        '2 cinnamon sticks',
        'Sugar to taste'
      ],
      'ku': [
        '٤ پەرداخ ئاو',
        '٣ قاشق خواردن چای',
        '٤ پاکەتی هێل',
        '٢ قەلیبی دارچین',
        'شەکر بەپێی دڵخوازی'
      ],
    },
    steps: {
      'en': [
        '1. Bring water to boil.',
        '2. Add tea, cardamom, and cinnamon.',
        '3. Simmer 5-7 minutes.',
        '4. Strain into cups.',
        '5. Add sugar if desired.',
        '6. Serve hot.'
      ],
      'ku': [
        '١. ئاو بگەڕێنەوە بۆ کوڵان.',
        '٢. چای و هێل و دارچین زیاد بکە.',
        '٣. بۆ ٥-٧ خولەک بگەڕێ.',
        '٤. بپاڵێوە بۆ پەرداخەکان.',
        '٥. شەکر زیاد بکە ئەگەر دەتەوێت.',
        '٦. گەرم پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '72',
    title: {'en': 'Kurdish Coffee', 'ku': 'قاوەی کوردی'},
    icon: '☕',
    nutrition: NutritionalInfo(calories: 30, protein: 1, carbs: 5, fats: 1),
    category: MealCategory.snack,
    rating: 4.7,
    ratingCount: 123,
    ingredients: {
      'en': [
        '1 cup water',
        '2 tbsp finely ground coffee',
        '1 tsp sugar (optional)',
        'Cardamom (optional)'
      ],
      'ku': [
        '١ پەرداخ ئاو',
        '٢ قاشق خواردن قاوەی وردکراو',
        '١ قاشقە چای شەکر (ئارەزوویانە)',
        'هێل (ئارەزوویانە)'
      ],
    },
    steps: {
      'en': [
        '1. Heat water in cezve.',
        '2. Add coffee and sugar if using.',
        '3. Heat until foam rises.',
        '4. Remove from heat, then return.',
        '5. Repeat 2-3 times.',
        '6. Let settle 1 minute.',
        '7. Pour into cups.',
        '8. Serve with water.'
      ],
      'ku': [
        '١. ئاو لە سەوزەکە گەرمی بکەرەوە.',
        '٢. قاوە و شەکر زیاد بکە ئەگەر بەکاردێنیت.',
        '٣. گەرمی بکەرەوە تا کەف بەرز بێتەوە.',
        '٤. لە گەرمی لابە، پاشان بگەڕێنەوە.',
        '٥. ٢-٣ جار دووبارە بکەرەوە.',
        '٦. ڕێگە بدە بۆ ١ خولەک راون بێتەوە.',
        '٧. بیکە بۆ پەرداخەکان.',
        '٨. لەگەڵ ئاو پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '73',
    title: {'en': 'Kurdish Pizza', 'ku': 'پیتزای کوردی'},
    icon: '🍕',
    nutrition: NutritionalInfo(calories: 380, protein: 18, carbs: 45, fats: 14),
    category: MealCategory.lunch,
    rating: 4.6,
    ratingCount: 87,
    ingredients: {
      'en': [
        '2 cups flour',
        '1 cup yogurt',
        '1 tsp baking powder',
        '1 tsp salt',
        'Topping: ground meat, tomatoes, peppers, onions',
        'Spices: paprika, cumin, pepper',
        'Olive oil'
      ],
      'ku': [
        '٢ پەرداخ ئارد',
        '١ پەرداخ ماست',
        '١ قاشقە چای خمیری خوێشتن',
        '١ قاشقە چای خوێ',
        'سەرەوە: گۆشتی هاڕاو، تەماتە، بیبەر، پیاز',
        'بەهارات: بیبەری سوور، کەمون، بیبەر',
        'ڕۆنی زەیتوون'
      ],
    },
    steps: {
      'en': [
        '1. Mix flour, yogurt, baking powder, and salt.',
        '2. Knead 5 minutes, rest 30 minutes.',
        '3. Prepare topping: sauté meat with vegetables and spices.',
        '4. Divide dough into 4 portions.',
        '5. Roll each into oval.',
        '6. Add topping.',
        '7. Bake at 400°F (200°C) for 15-20 minutes.',
        '8. Serve hot.'
      ],
      'ku': [
        '١. ئارد و ماست و خمیری خوێشتن و خوێ تێکەڵ بکە.',
        '٢. بۆ ٥ خولەک چەقێنە، بۆ ٣٠ خولەک ڕای بگەڕێنە.',
        '٣. سەرەوەکە ئامادە بکە: گۆشت لەگەڵ سەوزە و بەهارات ببرژێنە.',
        '٤. هەویرەکە بڕی بە ٤ پارچە.',
        '٥. هەر پارچەیەک بکە بە سەرە.',
        '٦. سەرەوەکە زیاد بکە.',
        '٧. لە ٢٠٠ پلەی سیلیزی بۆ ١٥-٢٠ خولەک ببرژێنە.',
        '٨. گەرم پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '74',
    title: {'en': 'Kurdish Stew', 'ku': 'شۆربای کوردی'},
    icon: '🍲',
    nutrition: NutritionalInfo(calories: 420, protein: 35, carbs: 25, fats: 20),
    category: MealCategory.lunch,
    rating: 4.5,
    ratingCount: 76,
    ingredients: {
      'en': [
        '1kg lamb or beef',
        '2 onions',
        '4 tomatoes',
        '2 bell peppers',
        '3 tbsp tomato paste',
        '2 tsp turmeric',
        '2 tsp paprika',
        '1 tsp cinnamon',
        '¼ cup olive oil',
        '4 cups water'
      ],
      'ku': [
        '١ کیلۆگرام بەرخ یان مانگا',
        '٢ پیاز',
        '٤ تەماتە',
        '٢ بیبەر',
        '٣ قاشق خواردن دۆشاوی تەماتە',
        '٢ قاشقە چای زەردەچەوە',
        '٢ قاشقە چای بیبەری سوور',
        '١ قاشقە چای دارچین',
        '١/٤ پەرداخ ڕۆنی زەیتوون',
        '٤ پەرداخ ئاو'
      ],
    },
    steps: {
      'en': [
        '1. Brown meat in olive oil.',
        '2. Add onions and cook until soft.',
        '3. Add tomatoes, peppers, tomato paste, and spices.',
        '4. Cook 5 minutes.',
        '5. Add water and simmer 1.5-2 hours.',
        '6. Serve hot with rice.'
      ],
      'ku': [
        '١. گۆشت لە ڕۆنی زەیتوون سووری بکەرەوە.',
        '٢. پیاز زیاد بکە و بکوڵێنە تا نەرم بێت.',
        '٣. تەماتە و بیبەر و دۆشاوی تەماتە و بەهارات زیاد بکە.',
        '٤. بۆ ٥ خولەک بکوڵێنە.',
        '٥. ئاو زیاد بکە و بۆ ١.٥-٢ کاتژمێر بگەڕێ.',
        '٦. گەرم لەگەڵ برنج پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '75',
    title: {'en': 'Kurdish Omelette', 'ku': 'ئۆملیتی کوردی'},
    icon: '🍳',
    nutrition: NutritionalInfo(calories: 280, protein: 20, carbs: 8, fats: 18),
    category: MealCategory.breakfast,
    rating: 4.4,
    ratingCount: 65,
    ingredients: {
      'en': [
        '6 eggs',
        '1 onion',
        '1 tomato',
        '1 green pepper',
        '2 tbsp olive oil',
        '1 tsp salt',
        '½ tsp black pepper',
        '½ tsp paprika'
      ],
      'ku': [
        '٦ هێلکە',
        '١ پیاز',
        '١ تەماتە',
        '١ بیبەری سەوز',
        '٢ قاشق خواردن ڕۆنی زەیتوون',
        '١ قاشقە چای خوێ',
        '١/٢ قاشقە چای بیبەری ڕەش',
        '١/٢ قاشقە چای بیبەری سوور'
      ],
    },
    steps: {
      'en': [
        '1. Beat eggs with salt, pepper, and paprika.',
        '2. Heat olive oil in pan.',
        '3. Sauté onions until translucent.',
        '4. Add peppers and tomatoes, cook 3-4 minutes.',
        '5. Pour eggs over vegetables.',
        '6. Cook until set.',
        '7. Flip and cook other side.',
        '8. Serve hot.'
      ],
      'ku': [
        '١. هێلکە لەگەڵ خوێ و بیبەر و بیبەری سوور تێکەڵ بکە.',
        '٢. ڕۆنی زەیتوون لە تاوێکدا گەرم بکە.',
        '٣. پیاز ببرژێنە تا نیمچە ڕووناک بێت.',
        '٤. بیبەر و تەماتە زیاد بکە، بۆ ٣-٤ خولەک بکوڵێنە.',
        '٥. هێلکەکان بکە بەسەر سەوزەکاندا.',
        '٦. بکوڵێنە تا ڕەق بێت.',
        '٧. بیگۆڕە و لایەکەی تری بکوڵێنە.',
        '٨. گەرم پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '76',
    title: {'en': 'Kurdish Pancakes', 'ku': 'پانکێیکی کوردی'},
    icon: '🥞',
    nutrition: NutritionalInfo(calories: 220, protein: 8, carbs: 35, fats: 6),
    category: MealCategory.breakfast,
    rating: 4.3,
    ratingCount: 54,
    ingredients: {
      'en': [
        '2 cups flour',
        '2 cups yogurt',
        '2 eggs',
        '1 tsp baking soda',
        '1 tsp salt',
        'Butter',
        'Honey or syrup'
      ],
      'ku': [
        '٢ پەرداخ ئارد',
        '٢ پەرداخ ماست',
        '٢ هێلکە',
        '١ قاشقە چای سۆدای خوێشتن',
        '١ قاشقە چای خوێ',
        'کەرە',
        'هەنگوین یان شیرە'
      ],
    },
    steps: {
      'en': [
        '1. Mix flour, yogurt, eggs, baking soda, and salt.',
        '2. Rest batter 15 minutes.',
        '3. Heat butter in skillet.',
        '4. Pour ¼ cup batter for each pancake.',
        '5. Cook until bubbles form.',
        '6. Flip and cook other side.',
        '7. Serve with honey or syrup.'
      ],
      'ku': [
        '١. ئارد و ماست و هێلکە و سۆدای خوێشتن و خوێ تێکەڵ بکە.',
        '٢. ڕێگە بە تێکەڵەکە بدە بۆ ١٥ خولەک.',
        '٣. کەرە لە تاوێکدا گەرم بکە.',
        '٤. ١/٤ پەرداخ تێکەڵە بۆ هەر پانکێکێک.',
        '٥. بکوڵێنە تا بۆڵە دروست ببێت.',
        '٦. بیگۆڕە و لایەکەی تری بکوڵێنە.',
        '٧. لەگەڵ هەنگوین یان شیرە پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '77',
    title: {'en': 'Kurdish Pickles', 'ku': 'ترشی کوردی'},
    icon: '🥒',
    nutrition: NutritionalInfo(calories: 30, protein: 1, carbs: 6, fats: 0),
    category: MealCategory.snack,
    rating: 4.6,
    ratingCount: 89,
    ingredients: {
      'en': [
        '2 lbs mixed vegetables',
        '4 cups water',
        '1 cup vinegar',
        '3 tbsp salt',
        '2 tbsp sugar',
        '4 cloves garlic',
        '2 tbsp mustard seeds',
        '1 tbsp dill'
      ],
      'ku': [
        '٢ پاوەند سەوزی تێکەڵ',
        '٤ پەرداخ ئاو',
        '١ پەرداخ سرکە',
        '٣ قاشق خواردن خوێ',
        '٢ قاشق خواردن شەکر',
        '٤ خاو سیر',
        '٢ قاشق خواردن تۆوی خەردەل',
        '١ قاشق خواردن شووید'
      ],
    },
    steps: {
      'en': [
        '1. Wash and cut vegetables.',
        '2. Pack into jars.',
        '3. Add garlic, mustard seeds, and dill.',
        '4. Boil water, vinegar, salt, and sugar.',
        '5. Pour over vegetables.',
        '6. Seal jars.',
        '7. Let cool, then refrigerate.',
        '8. Wait 1 week before eating.'
      ],
      'ku': [
        '١. سەوزەکان بشۆ و ببڕە.',
        '٢. بخەرە ناو پەرداخەکان.',
        '٣. سیر و تۆوی خەردەل و شووید زیاد بکە.',
        '٤. ئاو و سرکە و خوێ و شەکر بکوڵێنە.',
        '٥. بکە بەسەر سەوزەکاندا.',
        '٦. پەرداخەکان داخڵ بکە.',
        '٧. ڕێگە بدە سارد بێت، پاشان بخەرە سەلادەر.',
        '٨. ١ هەفتە چاوەڕێ بکە پێش خواردن.'
      ],
    },
  ),
  Recipe(
    id: '78',
    title: {'en': 'Kurdish Yogurt', 'ku': 'ماستی کوردی'},
    icon: '🥛',
    nutrition: NutritionalInfo(calories: 150, protein: 8, carbs: 10, fats: 9),
    category: MealCategory.snack,
    rating: 4.7,
    ratingCount: 112,
    ingredients: {
      'en': ['1 gallon milk', '2 tbsp yogurt', 'Thermometer', 'Glass jars'],
      'ku': [
        '١ گالۆن شیر',
        '٢ قاشق خواردن ماست',
        'پلەپێو',
        'پەرداخە شووشەییەکان'
      ],
    },
    steps: {
      'en': [
        '1. Heat milk to 180°F (82°C).',
        '2. Cool to 110°F (43°C).',
        '3. Mix yogurt with some warm milk.',
        '4. Stir into remaining milk.',
        '5. Pour into jars.',
        '6. Keep at 110°F (43°C) for 8-12 hours.',
        '7. Refrigerate before serving.',
        '8. Save 2 tbsp for next batch.'
      ],
      'ku': [
        '١. شیرەکە گەرمی بکەرەوە بۆ ٨٢ پلەی سیلیزی.',
        '٢. سارد بکەرەوە بۆ ٤٣ پلەی سیلیزی.',
        '٣. ماست لەگەڵ هەندێک شیرە گەرم تێکەڵ بکە.',
        '٤. تێکەڵی بکە بۆ شیرە ماوەکە.',
        '٥. بیکە بۆ پەرداخەکان.',
        '٦. لە ٤٣ پلەی سیلیزی بۆ ٨-١٢ کاتژمێر بەجێبهێڵە.',
        '٧. پێش خواردن بخەرە سەلادەر.',
        '٨. ٢ قاشق خواردن پاشەکەوت بکە بۆ چەرخی داهاتوو.'
      ],
    },
  ),
  Recipe(
    id: '79',
    title: {'en': 'Kurdish Cheese', 'ku': 'پەنیری کوردی'},
    icon: '🧀',
    nutrition: NutritionalInfo(calories: 280, protein: 18, carbs: 2, fats: 22),
    category: MealCategory.breakfast,
    rating: 4.6,
    ratingCount: 78,
    ingredients: {
      'en': [
        '1 gallon milk',
        '¼ cup lemon juice or vinegar',
        '1 tsp salt',
        'Cheesecloth'
      ],
      'ku': [
        '١ گالۆن شیر',
        '١/٤ پەرداخ ئاوی لیمۆ یان سرکە',
        '١ قاشقە چای خوێ',
        'پۆشی پەنیر'
      ],
    },
    steps: {
      'en': [
        '1. Heat milk to 185°F (85°C).',
        '2. Remove from heat, add lemon juice or vinegar.',
        '3. Stir until curds form.',
        '4. Let stand 10 minutes.',
        '5. Drain through cheesecloth.',
        '6. Add salt and mix.',
        '7. Hang to drain 2-4 hours.',
        '8. Refrigerate before serving.'
      ],
      'ku': [
        '١. شیرەکە گەرمی بکەرەوە بۆ ٨٥ پلەی سیلیزی.',
        '٢. لە گەرمی لابە، ئاوی لیمۆ یان سرکە زیاد بکە.',
        '٣. تێکەڵی بکە تا خڕە دروست ببێت.',
        '٤. ڕێگە بدە بۆ ١٠ خولەک راون بێتەوە.',
        '٥. بە پۆشی پەنیر بیپاڵێوە.',
        '٦. خوێ زیاد بکە و تێکەڵی بکە.',
        '٧. هەڵی واڵێنە بۆ پاڵێوران بۆ ٢-٤ کاتژمێر.',
        '٨. پێش خواردن بخەرە سەلادەر.'
      ],
    },
  ),
  Recipe(
    id: '80',
    title: {'en': 'Sambousek', 'ku': 'سەمبوسە'},
    icon: '🥟',
    nutrition: NutritionalInfo(calories: 280, protein: 10, carbs: 30, fats: 14),
    category: MealCategory.snack,
    rating: 4.6,
    ratingCount: 98,
    ingredients: {
      'en': [
        '2 cups flour',
        '½ cup water',
        '½ cup oil',
        '1 tsp salt',
        'Filling: ground meat or cheese, onions, parsley',
        'Oil for frying'
      ],
      'ku': [
        '٢ پەرداخ ئارد',
        '١/٢ پەرداخ ئاو',
        '١/٢ پەرداخ ڕۆن',
        '١ قاشقە چای خوێ',
        'ناوەکە: گۆشتی هاڕاو یان پەنیر، پیاز، جەعفەری',
        'ڕۆن بۆ سوورکردنەوە'
      ],
    },
    steps: {
      'en': [
        '1. Mix flour, water, oil, and salt to form dough.',
        '2. Knead 5 minutes, rest 30 minutes.',
        '3. Prepare filling: cook meat with onions and parsley.',
        '4. Roll dough thin, cut into circles.',
        '5. Place filling on each circle.',
        '6. Fold into triangles, seal edges.',
        '7. Heat oil, fry until golden.',
        '8. Drain and serve.'
      ],
      'ku': [
        '١. ئارد و ئاو و ڕۆن و خوێ تێکەڵ بکە بۆ دروستکردنی هەویری.',
        '٢. بۆ ٥ خولەک چەقێنە، بۆ ٣٠ خولەک ڕای بگەڕێنە.',
        '٣. ناوەکە ئامادە بکە: گۆشت لەگەڵ پیاز و جەعفەری بکوڵێنە.',
        '٤. هەویرەکە بە تەنکی بڕووخێنە، ببڕە بە بازنە.',
        '٥. ناوەکە بخەرە سەر هەر بازنەیەک.',
        '٦. بیپێچەرەوە بە سێگۆشە، لایەکان داخڵ بکە.',
        '٧. ڕۆن گەرم بکە، ببرژێنە تا زەرد بێت.',
        '٨. بیپاڵێوە و پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '81',
    title: {'en': 'Manakish', 'ku': 'مەناقیش'},
    icon: '🍕',
    nutrition: NutritionalInfo(calories: 310, protein: 7, carbs: 40, fats: 14),
    category: MealCategory.breakfast,
    rating: 4.7,
    ratingCount: 112,
    ingredients: {
      'en': [
        '2 cups flour',
        '1 cup water',
        '1 tsp yeast',
        '1 tsp sugar',
        '1 tsp salt',
        'Topping: zaatar, olive oil, cheese'
      ],
      'ku': [
        '٢ پەرداخ ئارد',
        '١ پەرداخ ئاو',
        '١ قاشقە چای خمیر',
        '١ قاشقە چای شەکر',
        '١ قاشقە چای خوێ',
        'سەرەوە: زەعتەر، ڕۆنی زەیتوون، پەنیر'
      ],
    },
    steps: {
      'en': [
        '1. Dissolve yeast and sugar in warm water.',
        '2. Mix with flour and salt to form dough.',
        '3. Knead 10 minutes, let rise 1 hour.',
        '4. Divide into small balls.',
        '5. Roll each into circle.',
        '6. Spread zaatar and oil mixture or cheese.',
        '7. Bake at 475°F (245°C) for 8-10 minutes.',
        '8. Serve hot.'
      ],
      'ku': [
        '١. خمیر و شەکر لە ئاوی گەرم بڕەواز بکە.',
        '٢. لەگەڵ ئارد و خوێ تێکەڵ بکە بۆ دروستکردنی هەویری.',
        '٣. بۆ ١٠ خولەک چەقێنە، بۆ ١ کاتژمێر ڕێگە بدە بڕوا بێت.',
        '٤. بڕی بە تۆپێکی بچووک.',
        '٥. هەر تۆپێک بکە بە بازنە.',
        '٦. تێکەڵەی زەعتەر و ڕۆن یان پەنیر بڵاو بکەرەوە.',
        '٧. لە ٢٤٥ پلەی سیلیزی بۆ ٨-١٠ خولەک ببرژێنە.',
        '٨. گەرم پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '82',
    title: {'en': 'Mujadara', 'ku': 'موجەدەرە'},
    icon: '🍚',
    nutrition: NutritionalInfo(calories: 350, protein: 12, carbs: 55, fats: 9),
    category: MealCategory.lunch,
    rating: 4.5,
    ratingCount: 78,
    ingredients: {
      'en': [
        '1 cup lentils',
        '1 cup rice',
        '2 onions',
        '¼ cup olive oil',
        '1 tsp cumin',
        '1 tsp salt',
        '4 cups water'
      ],
      'ku': [
        '١ پەرداخ نیسک',
        '١ پەرداخ برنج',
        '٢ پیاز',
        '١/٤ پەرداخ ڕۆنی زەیتوون',
        '١ قاشقە چای کەمون',
        '١ قاشقە چای خوێ',
        '٤ پەرداخ ئاو'
      ],
    },
    steps: {
      'en': [
        '1. Cook lentils in water until almost done.',
        '2. Add rice, cumin, and salt.',
        '3. Cook until rice is tender.',
        '4. Slice onions thinly.',
        '5. Fry in olive oil until crispy and brown.',
        '6. Mix half into mujadara.',
        '7. Top with remaining onions.',
        '8. Serve with yogurt.'
      ],
      'ku': [
        '١. نیسک لە ئاودا بکوڵێنە تا بەنزیکەیی ئامادە بێت.',
        '٢. برنج و کەمون و خوێ زیاد بکە.',
        '٣. بکوڵێنە تا برنج نەرم بێت.',
        '٤. پیاز بە تەنکی پەڕە بکە.',
        '٥. لە ڕۆنی زەیتوون ببرژێنە تا ڕەق و قاوەیی بێت.',
        '٦. نیوەی تێکەڵی بکە بە موجەدەرە.',
        '٧. پیازی ماوەکەی سەری بێنە.',
        '٨. لەگەڵ ماست پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '83',
    title: {'en': 'Lahmacun', 'ku': 'لەحمەجون'},
    icon: '🍕',
    nutrition: NutritionalInfo(calories: 290, protein: 18, carbs: 32, fats: 10),
    category: MealCategory.lunch,
    rating: 4.6,
    ratingCount: 89,
    ingredients: {
      'en': [
        '2 cups flour',
        '1 cup water',
        '1 tsp yeast',
        '1 tsp sugar',
        '1 tsp salt',
        'Topping: ground beef, tomatoes, peppers, onions, parsley'
      ],
      'ku': [
        '٢ پەرداخ ئارد',
        '١ پەرداخ ئاو',
        '١ قاشقە چای خمیر',
        '١ قاشقە چای شەکر',
        '١ قاشقە چای خوێ',
        'سەرەوە: گۆشتی هاڕاو، تەماتە، بیبەر، پیاز، جەعفەری'
      ],
    },
    steps: {
      'en': [
        '1. Make dough: dissolve yeast in warm water with sugar.',
        '2. Mix with flour and salt, knead 10 minutes.',
        '3. Let rise 1 hour.',
        '4. Prepare topping: mix all ingredients.',
        '5. Divide dough into small balls.',
        '6. Roll each very thin.',
        '7. Spread topping thinly.',
        '8. Bake at 500°F (260°C) for 5-7 minutes.',
        '9. Serve with lemon and parsley.'
      ],
      'ku': [
        '١. هەویر دروست بکە: خمیر لە ئاوی گەرم بڕەواز بکە لەگەڵ شەکر.',
        '٢. لەگەڵ ئارد و خوێ تێکەڵ بکە، بۆ ١٠ خولەک چەقێنە.',
        '٣. بۆ ١ کاتژمێر ڕێگە بدە بڕوا بێت.',
        '٤. سەرەوەکە ئامادە بکە: هەموو کەرەستەکان تێکەڵ بکە.',
        '٥. هەویرەکە بڕی بە تۆپێکی بچووک.',
        '٦. هەر تۆپێک زۆر بە تەنکی بڕووخێنە.',
        '٧. سەرەوەکە بە تەنکی بڵاو بکەرەوە.',
        '٨. لە ٢٦٠ پلەی سیلیزی بۆ ٥-٧ خولەک ببرژێنە.',
        '٩. لەگەڵ لیمۆ و جەعفەری پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '84',
    title: {'en': 'Keledoş', 'ku': 'کەلەدۆش'},
    icon: '🍲',
    nutrition: NutritionalInfo(calories: 520, protein: 35, carbs: 20, fats: 34),
    category: MealCategory.dinner,
    rating: 4.5,
    ratingCount: 67,
    ingredients: {
      'en': [
        '1kg lamb (cubed)',
        '1 cup chickpeas',
        '2 cups yogurt',
        '2 tbsp dried mint',
        '1 tsp salt',
        '½ tsp black pepper',
        '4 cups water'
      ],
      'ku': [
        '١ کیلۆگرام بەرخ (چوارگۆشەکراوە)',
        '١ پەرداخ نۆک',
        '٢ پەرداخ ماست',
        '٢ قاشق خواردن نەعنای وشک',
        '١ قاشقە چای خوێ',
        '١/٢ قاشقە چای بیبەری ڕەش',
        '٤ پەرداخ ئاو'
      ],
    },
    steps: {
      'en': [
        '1. Soak chickpeas overnight.',
        '2. Cook lamb in water until tender.',
        '3. Add chickpeas and cook until soft.',
        '4. Whisk yogurt until smooth.',
        '5. Slowly add to soup, stirring constantly.',
        '6. Do not boil after adding yogurt.',
        '7. Add mint, salt, and pepper.',
        '8. Serve hot.'
      ],
      'ku': [
        '١. نۆکەکە بە شەو بخۆشێنە.',
        '٢. بەرخ لە ئاودا بکوڵێنە تا نەرم بێت.',
        '٣. نۆک زیاد بکە و بکوڵێنە تا نەرم بێت.',
        '٤. ماستەکە تێکەڵ بکە تا ڕێک بێت.',
        '٥. بەرەبەرە زیاد بکە بۆ شۆرباکە، بە بەردەوامی تێکەڵی بکە.',
        '٦. دوای زیادکردنی ماست مەکوڵێنە.',
        '٧. نەعنا و خوێ و بیبەر زیاد بکە.',
        '٨. گەرم پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '85',
    title: {'en': 'Kurdish Coffee', 'ku': 'قاوەی کوردی'},
    icon: '☕',
    nutrition: NutritionalInfo(calories: 30, protein: 1, carbs: 5, fats: 1),
    category: MealCategory.snack,
    rating: 4.7,
    ratingCount: 123,
    ingredients: {
      'en': [
        '1 cup water',
        '2 tbsp finely ground coffee',
        '1 tsp sugar (optional)',
        'Cardamom (optional)'
      ],
      'ku': [
        '١ پەرداخ ئاو',
        '٢ قاشق خواردن قاوەی وردکراو',
        '١ قاشقە چای شەکر (ئارەزوویانە)',
        'هێل (ئارەزوویانە)'
      ],
    },
    steps: {
      'en': [
        '1. Heat water in cezve.',
        '2. Add coffee and sugar if using.',
        '3. Heat until foam rises.',
        '4. Remove from heat, then return.',
        '5. Repeat 2-3 times.',
        '6. Let settle 1 minute.',
        '7. Pour into cups.',
        '8. Serve with water.'
      ],
      'ku': [
        '١. ئاو لە سەوزەکە گەرمی بکەرەوە.',
        '٢. قاوە و شەکر زیاد بکە ئەگەر بەکاردێنیت.',
        '٣. گەرمی بکەرەوە تا کەف بەرز بێتەوە.',
        '٤. لە گەرمی لابە، پاشان بگەڕێنەوە.',
        '٥. ٢-٣ جار دووبارە بکەرەوە.',
        '٦. ڕێگە بدە بۆ ١ خولەک راون بێتەوە.',
        '٧. بیکە بۆ پەرداخەکان.',
        '٨. لەگەڵ ئاو پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '86',
    title: {'en': 'Masgouf', 'ku': 'مەسگوف'},
    icon: '🐟',
    nutrition: NutritionalInfo(calories: 400, protein: 45, carbs: 0, fats: 20),
    category: MealCategory.dinner,
    rating: 4.7,
    ratingCount: 132,
    ingredients: {
      'en': [
        '1 whole fish',
        '½ cup olive oil',
        '3 tbsp tamarind paste',
        '2 tbsp tomato paste',
        '2 onions',
        '4 cloves garlic',
        '1 tsp turmeric',
        '1 tsp paprika',
        'Salt to taste'
      ],
      'ku': [
        '١ ماسی تەواو',
        '١/٢ پەرداخ ڕۆنی زەیتوون',
        '٣ قاشق خواردن دۆشاوی تەمر هیندی',
        '٢ قاشق خواردن دۆشاوی تەماتە',
        '٢ پیاز',
        '٤ خاو سیر',
        '١ قاشقە چای زەردەچەوە',
        '١ قاشقە چای بیبەری سوور',
        'خوێ بەپێی دڵخوازی'
      ],
    },
    steps: {
      'en': [
        '1. Clean fish and make cuts.',
        '2. Mix marinade ingredients.',
        '3. Rub fish with marinade.',
        '4. Marinate 1-2 hours.',
        '5. Grill over charcoal.',
        '6. Cook 15-20 minutes per side.',
        '7. Baste with marinade.',
        '8. Serve with lemon and onions.'
      ],
      'ku': [
        '١. ماسیەکە پاک بکەرەوە و برین دروست بکە.',
        '٢. کەرەستەکانی خوسێنەرەکە تێکەڵ بکە.',
        '٣. ماسیەکە بە خوسێنەرەکە بیڕەواز بکە.',
        '٤. بۆ ١-٢ کاتژمێر بخۆشێنە.',
        '٥. لەسەر خەڵوز ببرژێنە.',
        '٦. بۆ ١٥-٢٠ خولەک لە هەر لایەک بکوڵێنە.',
        '٧. بە خوسێنەرەکە ڕووکەشی بکە.',
        '٨. لەگەڵ لیمۆ و پیاز پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '87',
    title: {'en': 'Mansaf', 'ku': 'منسەف'},
    icon: '🍲',
    nutrition: NutritionalInfo(calories: 650, protein: 50, carbs: 60, fats: 25),
    category: MealCategory.dinner,
    rating: 4.8,
    ratingCount: 145,
    ingredients: {
      'en': [
        '1kg lamb',
        '2 cups rice',
        '2 cups yogurt',
        '1 cup jameed (dried yogurt)',
        '1 tsp turmeric',
        '1 tsp cardamom',
        'Pine nuts and almonds for garnish'
      ],
      'ku': [
        '١ کیلۆگرام بەرخ',
        '٢ پەرداخ برنج',
        '٢ پەرداخ ماست',
        '١ پەرداخ جامید',
        '١ قاشقە چای زەردەچەوە',
        '١ قاشقە چای هێل',
        'دەنکە سنۆبەر و بادەم بۆ ڕازاندنەوە'
      ],
    },
    steps: {
      'en': [
        '1. Soak jameed in water overnight.',
        '2. Cook lamb until tender.',
        '3. Blend jameed with yogurt.',
        '4. Add to lamb and simmer.',
        '5. Cook rice with turmeric and cardamom.',
        '6. Toast nuts.',
        '7. Serve rice topped with lamb and sauce.',
        '8. Garnish with nuts.'
      ],
      'ku': [
        '١. جامید بە شەو لە ئاودا بخۆشێنە.',
        '٢. بەرخ بکوڵێنە تا نەرم بێت.',
        '٣. جامید لەگەڵ ماست بلفێنە.',
        '٤. زیاد بکە بۆ بەرخ و بگەڕێ.',
        '٥. برنج لەگەڵ زەردەچەوە و هێل بکوڵێنە.',
        '٦. چەرەزەکان ببرژێنە.',
        '٧. برنج پێشکەشی بکە بە بەرخ و سۆس.',
        '٨. بە چەرەزەکان ڕازێنەرەوە.'
      ],
    },
  ),
  Recipe(
    id: '88',
    title: {'en': 'Makdous', 'ku': 'مەعدوس'},
    icon: '🍆',
    nutrition: NutritionalInfo(calories: 180, protein: 4, carbs: 12, fats: 14),
    category: MealCategory.snack,
    rating: 4.5,
    ratingCount: 67,
    ingredients: {
      'en': [
        '10 small eggplants',
        '2 cups walnuts',
        '4 cloves garlic',
        '1 tsp salt',
        '½ tsp chili flakes',
        'Olive oil'
      ],
      'ku': [
        '١٠ باینجانی بچووک',
        '٢ پەرداخ گوێز',
        '٤ خاو سیر',
        '١ قاشقە چای خوێ',
        '١/٢ قاشقە چای پارچە بیبەری توون',
        'ڕۆنی زەیتوون'
      ],
    },
    steps: {
      'en': [
        '1. Boil eggplants until soft.',
        '2. Drain and cool.',
        '3. Make slit in each eggplant.',
        '4. Mix walnuts, garlic, salt, and chili.',
        '5. Stuff eggplants with mixture.',
        '6. Pack into jars.',
        '7. Cover with olive oil.',
        '8. Seal and store 2 weeks before eating.'
      ],
      'ku': [
        '١. باینجانەکان بکوڵێنە تا نەرم بێت.',
        '٢. بیپاڵێوە و سارد بکەرەوە.',
        '٣. لە هەر باینجانێک برینێک دروست بکە.',
        '٤. گوێز و سیر و خوێ و بیبەری توون تێکەڵ بکە.',
        '٥. باینجانەکان پڕ بکە بە تێکەڵەکە.',
        '٦. بخەرە ناو پەرداخەکان.',
        '٧. بە ڕۆنی زەیتوون داپۆشیان بکە.',
        '٨. داخڵ بکە و بۆ ٢ هەفتە پاشەکەوت بکە پێش خواردن.'
      ],
    },
  ),
  Recipe(
    id: '89',
    title: {'en': 'Warak Enab', 'ku': 'وارق عەنب'},
    icon: '🍃',
    nutrition: NutritionalInfo(calories: 350, protein: 12, carbs: 45, fats: 10),
    category: MealCategory.lunch,
    rating: 4.6,
    ratingCount: 78,
    ingredients: {
      'en': [
        '40 grape leaves',
        '1 cup rice',
        '500g ground lamb',
        '1 onion',
        '½ cup olive oil',
        '¼ cup lemon juice',
        '2 tbsp dried mint',
        'Salt and pepper'
      ],
      'ku': [
        '٤٠ گەڵاوی مێو',
        '١ پەرداخ برنج',
        '٥٠٠ گرام گۆشتی بەرخ',
        '١ پیاز',
        '١/٢ پەرداخ ڕۆنی زەیتوون',
        '١/٤ پەرداخ ئاوی لیمۆ',
        '٢ قاشق خواردن نەعنای وشک',
        'خوێ و بیبەر'
      ],
    },
    steps: {
      'en': [
        '1. Rinse grape leaves.',
        '2. Mix rice, meat, onion, and spices.',
        '3. Place filling on each leaf.',
        '4. Roll leaves tightly.',
        '5. Layer in pot.',
        '6. Mix oil, lemon juice, and water.',
        '7. Pour over rolls.',
        '8. Simmer 45-50 minutes.',
        '9. Serve warm or cold.'
      ],
      'ku': [
        '١. گەڵاوەکان بشۆ.',
        '٢. برنج و گۆشت و پیاز و بەهارات تێکەڵ بکە.',
        '٣. ناوەکە بخەرە سەر هەر گەڵاوێک.',
        '٤. گەڵاوەکان بە تەنگی بیپێچەرەوە.',
        '٥. لە مەنجەڵدا ڕیز بکە.',
        '٦. ڕۆن و ئاوی لیمۆ و ئاو تێکەڵ بکە.',
        '٧. بکە بەسەر پێچراوەکاندا.',
        '٨. بۆ ٤٥-٥٠ خولەک بگەڕێ.',
        '٩. گەرم یان سارد پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '90',
    title: {'en': 'Fattet Hummus', 'ku': 'فەتەی حومس'},
    icon: '🥣',
    nutrition: NutritionalInfo(calories: 420, protein: 20, carbs: 45, fats: 18),
    category: MealCategory.lunch,
    rating: 4.6,
    ratingCount: 89,
    ingredients: {
      'en': [
        '2 cups chickpeas',
        '2 pieces pita bread',
        '2 cups yogurt',
        '2 cloves garlic',
        '¼ cup tahini',
        '2 tbsp lemon juice',
        'Pine nuts',
        'Parsley'
      ],
      'ku': [
        '٢ پەرداخ نۆک',
        '٢ پارچە نانی پیتا',
        '٢ پەرداخ ماست',
        '٢ خاو سیر',
        '١/٤ پەرداخ تەحین',
        '٢ قاشق خواردن ئاوی لیمۆ',
        'دەنکە سنۆبەر',
        'جەعفەری'
      ],
    },
    steps: {
      'en': [
        '1. Cook chickpeas until soft.',
        '2. Toast pita bread and break into pieces.',
        '3. Mix yogurt, garlic, tahini, and lemon juice.',
        '4. Layer: bread, chickpeas, yogurt sauce.',
        '5. Toast pine nuts.',
        '6. Garnish with pine nuts and parsley.',
        '7. Serve immediately.'
      ],
      'ku': [
        '١. نۆکەکان بکوڵێنە تا نەرم بێت.',
        '٢. نانی پیتا ببرژێنە و بپچڕێنە بە پارچە.',
        '٣. ماست و سیر و تەحین و ئاوی لیمۆ تێکەڵ بکە.',
        '٤. ڕیز بکە: نان، نۆک، سۆسی ماست.',
        '٥. دەنکە سنۆبەرەکان ببرژێنە.',
        '٦. بە دەنکە سنۆبەر و جەعفەری ڕازێنەرەوە.',
        '٧. یەکسەر پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '91',
    title: {'en': 'Shish Barak', 'ku': 'شیش بەرەک'},
    icon: '🥟',
    nutrition: NutritionalInfo(calories: 380, protein: 25, carbs: 40, fats: 12),
    category: MealCategory.lunch,
    rating: 4.5,
    ratingCount: 67,
    ingredients: {
      'en': [
        '2 cups flour',
        '½ cup water',
        '1 tsp salt',
        'Filling: ground meat, onions, pine nuts',
        'Sauce: yogurt, garlic, dried mint'
      ],
      'ku': [
        '٢ پەرداخ ئارد',
        '١/٢ پەرداخ ئاو',
        '١ قاشقە چای خوێ',
        'ناوەکە: گۆشتی هاڕاو، پیاز، دەنکە سنۆبەر',
        'سۆس: ماست، سیر، نەعنای وشک'
      ],
    },
    steps: {
      'en': [
        '1. Make dough from flour, water, and salt.',
        '2. Roll thin and cut into circles.',
        '3. Prepare filling: cook meat with onions and pine nuts.',
        '4. Place filling on each circle.',
        '5. Fold into half-moons and seal.',
        '6. Boil dumplings until they float.',
        '7. Make yogurt sauce.',
        '8. Serve dumplings with sauce.'
      ],
      'ku': [
        '١. هەویر دروست بکە لە ئارد و ئاو و خوێ.',
        '٢. بە تەنکی بڕووخێنە و ببڕە بە بازنە.',
        '٣. ناوەکە ئامادە بکە: گۆشت لەگەڵ پیاز و دەنکە سنۆبەر بکوڵێنە.',
        '٤. ناوەکە بخەرە سەر هەر بازنەیەک.',
        '٥. بیپێچەرەوە بە نیوەمانگ و داخڵ بکە.',
        '٦. کوبەکان بکوڵێنە تا لەسەر ئاو بهێنن.',
        '٧. سۆسی ماست دروست بکە.',
        '٨. کوبەکان لەگەڵ سۆس پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '92',
    title: {'en': 'Mulukhiyah', 'ku': 'مولوخیا'},
    icon: '🌿',
    nutrition: NutritionalInfo(calories: 280, protein: 25, carbs: 20, fats: 12),
    category: MealCategory.lunch,
    rating: 4.4,
    ratingCount: 56,
    ingredients: {
      'en': [
        '500g mulukhiyah leaves',
        '1kg chicken or rabbit',
        '4 cloves garlic',
        '1 tbsp coriander',
        '½ cup lemon juice',
        'Salt and pepper'
      ],
      'ku': [
        '٥٠٠ گرام گەڵای مولوخیا',
        '١ کیلۆگرام مریشک یان کەروێشک',
        '٤ خاو سیر',
        '١ قاشق خواردن گوێزەبەڕۆ',
        '١/٢ پەرداخ ئاوی لیمۆ',
        'خوێ و بیبەر'
      ],
    },
    steps: {
      'en': [
        '1. Cook meat until tender.',
        '2. Remove meat, reserve broth.',
        '3. Chop mulukhiyah finely.',
        '4. Add to broth and simmer.',
        '5. Crush garlic with coriander.',
        '6. Fry in oil until golden.',
        '7. Add to mulukhiyah.',
        '8. Add lemon juice.',
        '9. Serve with rice and meat.'
      ],
      'ku': [
        '١. گۆشت بکوڵێنە تا نەرم بێت.',
        '٢. گۆشت لابە، ئاوی پاشەکەوت بکە.',
        '٣. مولوخیا بە وردی ببڕە.',
        '٤. زیاد بکە بۆ ئاوەکە و بگەڕێ.',
        '٥. سیر لەگەڵ گوێزەبەڕۆ چەقێنە.',
        '٦. لە ڕۆندا ببرژێنە تا زەرد بێت.',
        '٧. زیاد بکە بۆ مولوخیا.',
        '٨. ئاوی لیمۆ زیاد بکە.',
        '٩. لەگەڵ برنج و گۆشت پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '93',
    title: {'en': 'Sayadiyah', 'ku': 'صیادیە'},
    icon: '🐟',
    nutrition: NutritionalInfo(calories: 450, protein: 35, carbs: 50, fats: 12),
    category: MealCategory.lunch,
    rating: 4.5,
    ratingCount: 45,
    ingredients: {
      'en': [
        '1kg fish',
        '2 cups rice',
        '2 onions',
        '¼ cup olive oil',
        '1 tsp cumin',
        '1 tsp turmeric',
        'Salt and pepper'
      ],
      'ku': [
        '١ کیلۆگرام ماسی',
        '٢ پەرداخ برنج',
        '٢ پیاز',
        '١/٤ پەرداخ ڕۆنی زەیتوون',
        '١ قاشقە چای کەمون',
        '١ قاشقە چای زەردەچەوە',
        'خوێ و بیبەر'
      ],
    },
    steps: {
      'en': [
        '1. Clean and season fish.',
        '2. Fry fish until cooked.',
        '3. Sauté onions until caramelized.',
        '4. Add rice and spices.',
        '5. Add water and cook rice.',
        '6. Flake fish, removing bones.',
        '7. Layer rice and fish.',
        '8. Serve with lemon.'
      ],
      'ku': [
        '١. ماسیەکە پاک بکەرەوە و بەهارات بدە.',
        '٢. ماسیەکە ببرژێنە تا بپوختێت.',
        '٣. پیاز ببرژێنە تا کارامێلیز ببێت.',
        '٤. برنج و بەهاراتەکان زیاد بکە.',
        '٥. ئاو زیاد بکە و برنجەکە بکوڵێنە.',
        '٦. ماسیەکە هەڵی بکە، ئێسکەکانی لابە.',
        '٧. برنج و ماسی ڕیز بکە.',
        '٨. لەگەڵ لیمۆ پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '94',
    title: {'en': 'Fasolia', 'ku': 'فاسۆلیا'},
    icon: '🥘',
    nutrition: NutritionalInfo(calories: 380, protein: 28, carbs: 45, fats: 12),
    category: MealCategory.lunch,
    rating: 4.5,
    ratingCount: 78,
    ingredients: {
      'en': [
        '2 cups white beans',
        '500g lamb',
        '2 onions',
        '4 cloves garlic',
        '3 tbsp tomato paste',
        '2 dried limes',
        '1 tsp turmeric',
        '¼ cup olive oil'
      ],
      'ku': [
        '٢ پەرداخ فاسۆلیای سپی',
        '٥٠٠ گرام بەرخ',
        '٢ پیاز',
        '٤ خاو سیر',
        '٣ قاشق خواردن دۆشاوی تەماتە',
        '٢ لیمۆی وشک',
        '١ قاشقە چای زەردەچەوە',
        '١/٤ پەرداخ ڕۆنی زەیتوون'
      ],
    },
    steps: {
      'en': [
        '1. Soak beans overnight.',
        '2. Brown meat in olive oil.',
        '3. Add onions and garlic.',
        '4. Add tomato paste and spices.',
        '5. Add beans and water.',
        '6. Add dried limes.',
        '7. Simmer 1.5-2 hours.',
        '8. Serve with rice.'
      ],
      'ku': [
        '١. فاسۆلیاکە بە شەو بخۆشێنە.',
        '٢. گۆشت لە ڕۆنی زەیتوون سووری بکەرەوە.',
        '٣. پیاز و سیر زیاد بکە.',
        '٤. دۆشاوی تەماتە و بەهاراتەکان زیاد بکە.',
        '٥. فاسۆلیا و ئاو زیاد بکە.',
        '٦. لیمۆی وشک زیاد بکە.',
        '٧. بۆ ١.٥-٢ کاتژمێر بگەڕێ.',
        '٨. لەگەڵ برنج پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '95',
    title: {'en': 'Bazella', 'ku': 'بازیلا'},
    icon: '🥘',
    nutrition: NutritionalInfo(calories: 350, protein: 25, carbs: 40, fats: 10),
    category: MealCategory.lunch,
    rating: 4.4,
    ratingCount: 45,
    ingredients: {
      'en': [
        '500g lamb',
        '2 cups peas',
        '2 carrots',
        '2 onions',
        '3 tbsp tomato paste',
        '1 tsp cinnamon',
        '¼ cup olive oil'
      ],
      'ku': [
        '٥٠٠ گرام بەرخ',
        '٢ پەرداخ پۆتکە',
        '٢ گێزەر',
        '٢ پیاز',
        '٣ قاشق خواردن دۆشاوی تەماتە',
        '١ قاشقە چای دارچین',
        '١/٤ پەرداخ ڕۆنی زەیتوون'
      ],
    },
    steps: {
      'en': [
        '1. Brown meat in olive oil.',
        '2. Add onions and cook until soft.',
        '3. Add tomato paste and cinnamon.',
        '4. Add carrots and peas.',
        '5. Add water and simmer 1 hour.',
        '6. Serve with rice.'
      ],
      'ku': [
        '١. گۆشت لە ڕۆنی زەیتوون سووری بکەرەوە.',
        '٢. پیاز زیاد بکە و بکوڵێنە تا نەرم بێت.',
        '٣. دۆشاوی تەماتە و دارچین زیاد بکە.',
        '٤. گێزەر و پۆتکە زیاد بکە.',
        '٥. ئاو زیاد بکە و بۆ ١ کاتژمێر بگەڕێ.',
        '٦. لەگەڵ برنج پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '96',
    title: {'en': 'Koosa', 'ku': 'کوسا'},
    icon: '🥒',
    nutrition: NutritionalInfo(calories: 320, protein: 20, carbs: 35, fats: 12),
    category: MealCategory.lunch,
    rating: 4.5,
    ratingCount: 56,
    ingredients: {
      'en': [
        '8 small zucchini',
        '500g ground meat',
        '1 cup rice',
        '1 onion',
        '2 tbsp tomato paste',
        '1 tsp allspice',
        'Salt and pepper'
      ],
      'ku': [
        '٨ کوسەی بچووک',
        '٥٠٠ گرام گۆشتی هاڕاو',
        '١ پەرداخ برنج',
        '١ پیاز',
        '٢ قاشق خواردن دۆشاوی تەماتە',
        '١ قاشقە چای بەهاراتی هەموو جۆرە',
        'خوێ و بیبەر'
      ],
    },
    steps: {
      'en': [
        '1. Hollow out zucchini.',
        '2. Mix meat, rice, onion, and spices.',
        '3. Stuff zucchini with mixture.',
        '4. Arrange in pot.',
        '5. Mix tomato paste with water.',
        '6. Pour over zucchini.',
        '7. Simmer 45-60 minutes.',
        '8. Serve with yogurt.'
      ],
      'ku': [
        '١. کوسەکان بەتاڵ بکە.',
        '٢. گۆشت و برنج و پیاز و بەهارات تێکەڵ بکە.',
        '٣. کوسەکان پڕ بکە بە تێکەڵەکە.',
        '٤. لە مەنجەڵدا ڕیز بکە.',
        '٥. دۆشاوی تەماتە لەگەڵ ئاو تێکەڵ بکە.',
        '٦. بکە بەسەر کوسەکاندا.',
        '٧. بۆ ٤٥-٦٠ خولەک بگەڕێ.',
        '٨. لەگەڵ ماست پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '97',
    title: {'en': 'Bamia', 'ku': 'بامیە'},
    icon: '🥘',
    nutrition: NutritionalInfo(calories: 410, protein: 32, carbs: 15, fats: 22),
    category: MealCategory.lunch,
    rating: 4.8,
    ratingCount: 310,
    ingredients: {
      'en': [
        '500g okra',
        '500g lamb',
        '2 onions',
        '4 cloves garlic',
        '3 tbsp tomato paste',
        '2 tbsp lemon juice',
        '1 tsp coriander',
        '¼ cup olive oil'
      ],
      'ku': [
        '٥٠٠ گرام بامیە',
        '٥٠٠ گرام بەرخ',
        '٢ پیاز',
        '٤ خاو سیر',
        '٣ قاشق خواردن دۆشاوی تەماتە',
        '٢ قاشق خواردن ئاوی لیمۆ',
        '١ قاشقە چای گوێزەبەڕۆ',
        '١/٤ پەرداخ ڕۆنی زەیتوون'
      ],
    },
    steps: {
      'en': [
        '1. Trim okra stems.',
        '2. Soak in vinegar water 30 minutes.',
        '3. Brown lamb in olive oil.',
        '4. Add onions and garlic.',
        '5. Add tomato paste and spices.',
        '6. Add water and simmer 1 hour.',
        '7. Sauté okra briefly.',
        '8. Add to stew with lemon juice.',
        '9. Simmer 20-30 minutes.',
        '10. Serve with rice.'
      ],
      'ku': [
        '١. قەدەکانی بامیە ببڕە.',
        '٢. بۆ ٣٠ خولەک لە ئاوی سرکە بخۆشێنە.',
        '٣. بەرخ لە ڕۆنی زەیتوون سووری بکەرەوە.',
        '٤. پیاز و سیر زیاد بکە.',
        '٥. دۆشاوی تەماتە و بەهاراتەکان زیاد بکە.',
        '٦. ئاو زیاد بکە و بۆ ١ کاتژمێر بگەڕێ.',
        '٧. بامیە بە خێرایی ببرژێنە.',
        '٨. زیاد بکە بۆ شۆرباکە لەگەڵ ئاوی لیمۆ.',
        '٩. بۆ ٢٠-٣٠ خولەک بگەڕێ.',
        '١٠. لەگەڵ برنج پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '98',
    title: {'en': 'Moussaka', 'ku': 'موساکا'},
    icon: '🍆',
    nutrition: NutritionalInfo(calories: 450, protein: 25, carbs: 30, fats: 28),
    category: MealCategory.dinner,
    rating: 4.6,
    ratingCount: 89,
    ingredients: {
      'en': [
        '2 eggplants',
        '4 potatoes',
        '2 onions',
        '500g ground meat',
        '2 cups tomato sauce',
        '2 cloves garlic',
        '1 tsp allspice',
        'Olive oil'
      ],
      'ku': [
        '٢ باینجان',
        '٤ پەتاتە',
        '٢ پیاز',
        '٥٠٠ گرام گۆشتی هاڕاو',
        '٢ پەرداخ ئاوی تەماتە',
        '٢ خاو سیر',
        '١ قاشقە چای بەهاراتی هەموو جۆرە',
        'ڕۆنی زەیتوون'
      ],
    },
    steps: {
      'en': [
        '1. Salt eggplant slices 30 minutes.',
        '2. Fry eggplant, potatoes, and onions.',
        '3. Cook meat with garlic and spices.',
        '4. Layer in baking dish.',
        '5. Pour tomato sauce over.',
        '6. Bake 30-40 minutes.',
        '7. Let cool 10 minutes.',
        '8. Serve warm.'
      ],
      'ku': [
        '١. پەڕە باینجانەکان بۆ ٣٠ خولەک خوێ بپاش بە سەریان.',
        '٢. باینجان و پەتاتە و پیاز ببرژێنە.',
        '٣. گۆشت لەگەڵ سیر و بەهارات بکوڵێنە.',
        '٤. لە تاسێکی برژاندندا ڕیز بکە.',
        '٥. ئاوی تەماتە بکە بەسەری.',
        '٦. بۆ ٣٠-٤٠ خولەک ببرژێنە.',
        '٧. بۆ ١٠ خولەک ڕای بگەڕێنە.',
        '٨. گەرم پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '99',
    title: {'en': 'Kebab', 'ku': 'کەباب'},
    icon: '🍢',
    nutrition: NutritionalInfo(calories: 420, protein: 40, carbs: 5, fats: 25),
    category: MealCategory.dinner,
    rating: 4.7,
    ratingCount: 145,
    ingredients: {
      'en': [
        '1kg ground lamb',
        '2 onions',
        '1 bunch parsley',
        '1 tsp sumac',
        '1 tsp paprika',
        'Salt and pepper',
        'Skewers'
      ],
      'ku': [
        '١ کیلۆگرام گۆشتی بەرخ',
        '٢ پیاز',
        '١ کۆپی جەعفەری',
        '١ قاشقە چای سماق',
        '١ قاشقە چای بیبەری سوور',
        'خوێ و بیبەر',
        'شیش'
      ],
    },
    steps: {
      'en': [
        '1. Grate onions and squeeze out juice.',
        '2. Chop parsley finely.',
        '3. Mix meat, onions, parsley, and spices.',
        '4. Knead 10 minutes.',
        '5. Form around skewers.',
        '6. Grill over charcoal.',
        '7. Cook 8-10 minutes, turning occasionally.',
        '8. Serve with bread and onions.'
      ],
      'ku': [
        '١. پیاز هەڕە بکە و ئاوەکەی پەستێنە.',
        '٢. جەعفەری بە وردی ببڕە.',
        '٣. گۆشت و پیاز و جەعفەری و بەهارات تێکەڵ بکە.',
        '٤. بۆ ١٠ خولەک چەقێنە.',
        '٥. دروستی بکە دەوری شیشەکان.',
        '٦. لەسەر خەڵوز ببرژێنە.',
        '٧. بۆ ٨-١٠ خولەک بکوڵێنە، هەندێک جار بگۆڕەرێنە.',
        '٨. لەگەڵ نان و پیاز پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '100',
    title: {'en': 'Sahlab (Milk Pudding)', 'ku': 'سەحلەب'},
    icon: '🥛',
    nutrition: NutritionalInfo(calories: 220, protein: 6, carbs: 35, fats: 6),
    category: MealCategory.snack,
    rating: 4.6,
    ratingCount: 98,
    ingredients: {
      'en': [
        '4 cups milk',
        '4 tbsp cornstarch',
        '½ cup sugar',
        '1 tsp rose water',
        'Cinnamon',
        'Chopped pistachios'
      ],
      'ku': [
        '٤ پەرداخ شیر',
        '٤ قاشق خواردن نیشاستە',
        '١/٢ پەرداخ شەکر',
        '١ قاشقە چای ئاوی گوڵ',
        'دارچین',
        'فستقی وردکراو'
      ],
    },
    steps: {
      'en': [
        '1. Dissolve cornstarch in ½ cup cold milk.',
        '2. Heat remaining milk with sugar.',
        '3. Add cornstarch mixture slowly.',
        '4. Stir constantly until thickened.',
        '5. Add rose water.',
        '6. Pour into serving cups.',
        '7. Sprinkle with cinnamon and pistachios.',
        '8. Serve warm or chilled.'
      ],
      'ku': [
        '١. نیشاستە بڕەواز بکە لە ١/٢ پەرداخ شیرە سارد.',
        '٢. شیرە ماوەکە گەرمی بکەرەوە لەگەڵ شەکر.',
        '٣. تێکەڵەی نیشاستە بەرەبەرە زیاد بکە.',
        '٤. بە بەردەوامی تێکەڵی بکە تا خەست ببێتەوە.',
        '٥. ئاوی گوڵ زیاد بکە.',
        '٦. بیکە بۆ پەرداخەکانی پێشکەشکردن.',
        '٧. بە دارچین و فستق بپاش بە سەریان.',
        '٨. گەرم یان سارد پێشکەشی بکە.'
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
        '2 cups rice',
        '1 cup lentils',
        '1 cup macaroni',
        '1 cup chickpeas',
        '2 onions (sliced)',
        '3 tbsp tomato paste',
        '4 cloves garlic (minced)',
        '2 tbsp vinegar',
        '1 tsp cumin',
        '1 tsp chili powder',
        'Vegetable oil for frying',
        'Salt to taste'
      ],
      'ku': [
        '٢ پەرداخ برنج',
        '١ پەرداخ نیسک',
        '١ پەرداخ ماکەرۆنی',
        '١ پەرداخ نۆک',
        '٢ پیاز (پەڕەکراوە)',
        '٣ قاشق خواردن دۆشاوی تەماتە',
        '٤ خاو سیر (وردکراوە)',
        '٢ قاشق خواردن سرکە',
        '١ قاشقە چای کەمون',
        '١ قاشقە چای بیبەری توون',
        'ڕۆنی ڕوەک بۆ سوورکردنەوە',
        'خوێ بەپێی دڵخوازی'
      ],
    },
    steps: {
      'en': [
        '1. Cook rice separately until fluffy.',
        '2. Cook lentils until tender but not mushy.',
        '3. Cook macaroni according to package directions.',
        '4. Heat chickpeas until warm.',
        '5. Fry onions in oil until crispy and brown. Drain on paper towels.',
        '6. Make tomato sauce: sauté garlic, add tomato paste, 2 cups water, cumin, and chili. Simmer 15 minutes.',
        '7. Make garlic vinegar: mix minced garlic with vinegar.',
        '8. Layer in bowls: rice, lentils, macaroni, chickpeas.',
        '9. Top with tomato sauce, fried onions, and garlic vinegar.',
        '10. Mix at the table and serve immediately.'
      ],
      'ku': [
        '١. برنج بە جیا بکوڵێنە تا پڕ بێت.',
        '٢. نیسک بکوڵێنە تا نەرم بێت بەڵام نەبووە پلیش.',
        '٣. ماکەرۆنی بکوڵێنە بەپێی ڕێنماییەکانی پاکەت.',
        '٤. نۆکەکان گەرمی بکەرەوە تا گەرم بن.',
        '٥. پیاز لە ڕۆن ببرژێنە تا ڕەق و قاوەیی بن. بە کلینکس وشکیان بکە.',
        '٦. سۆسی تەماتە دروست بکە: سیر ببرژێنە، دۆشاوی تەماتە زیاد بکە، ٢ پەرداخ ئاو، کەمون، و بیبەری توون. بۆ ١٥ خولەک بگەڕێ.',
        '٧. سرکەی سیر دروست بکە: سیر وردکراو لەگەڵ سرکە تێکەڵ بکە.',
        '٨. لە قاپەکاندا ڕیز بکە: برنج، نیسک، ماکەرۆنی، نۆک.',
        '٩. سۆسی تەماتە و پیازی سوورکراو و سرکەی سیر لەسەر بکە.',
        '١٠. لەسەر مێز تێکەڵی بکە و یەکسەر پێشکەشی بکە.'
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
        '4 chicken breasts',
        '1 cup buttermilk',
        '2 tbsp hot sauce',
        '2 cups all-purpose flour',
        '1 tbsp paprika',
        '2 tsp garlic powder',
        '2 tsp onion powder',
        '1 tsp cayenne pepper',
        '4 burger buns',
        'Lettuce leaves',
        'Tomato slices',
        'Mayonnaise',
        'Vegetable oil for frying'
      ],
      'ku': [
        '٤ سنگی مریشک',
        '١ پەرداخ شیرەمەڕ',
        '٢ قاشق خواردن سۆسی توون',
        '٢ پەرداخ ئاردی هەموو مەبەست',
        '١ قاشق خواردن بیبەری سوور',
        '٢ قاشقە چای پۆودەری سیر',
        '٢ قاشقە چای پۆودەری پیاز',
        '١ قاشقە چای بیبەری کیین',
        '٤ نانی برگر',
        'گەڵای خاس',
        'پەڕە تەماتە',
        'مایۆنیز',
        'ڕۆنی ڕوەک بۆ سوورکردنەوە'
      ],
    },
    steps: {
      'en': [
        '1. Pound chicken breasts to even thickness.',
        '2. Mix buttermilk and hot sauce. Marinate chicken for at least 2 hours.',
        '3. Mix flour with all spices in shallow dish.',
        '4. Remove chicken from marinade, letting excess drip off.',
        '5. Dredge chicken in flour mixture, pressing to adhere.',
        '6. Heat oil to 350°F (175°C) in deep fryer or heavy pot.',
        '7. Fry chicken for 6-8 minutes until golden brown and internal temperature reaches 165°F (74°C).',
        '8. Toast burger buns lightly.',
        '9. Spread mayonnaise on buns.',
        '10. Assemble burgers with lettuce, tomato, and crispy chicken.',
        '11. Serve immediately with fries or salad.'
      ],
      'ku': [
        '١. سنگی مریشکەکان بکێشە تا ئەستووری یەکسان بێت.',
        '٢. شیرەمەڕ و سۆسی توون تێکەڵ بکە. مریشکەکان بۆ کەمترین ٢ کاتژمێر بخۆشێنە.',
        '٣. ئارد لەگەڵ هەموو بەهاراتەکان لە قاپێکی تەنکدا تێکەڵ بکە.',
        '٤. مریشکەکان لە خوسێنەرەکە دەربکە، ڕێگە بە زیادەکە بدە بڕوا بێت.',
        '٥. مریشکەکان بخەرە ناو تێکەڵەی ئاردەوە، پەستی پێبکە تا بچەسپێت.',
        '٦. ڕۆن بۆ ١٧٥ پلەی سیلیزی گەرم بکە لە برژێنەرێکی قوڵ یان مەنجەڵێکی قورسدا.',
        '٧. مریشکەکان بۆ ٦-٨ خولەک ببرژێنە تا زەردی قاوەیی ببن و گەرمی ناوەوەی بگاتە ٧٤ پلەی سیلیزی.',
        '٨. نانی برگرەکان بە نەرمی ببرژێنە.',
        '٩. مایۆنیز لەسەر نانەکان بڵاو بکەرەوە.',
        '١٠. برگرەکان ئامادە بکە لەگەڵ خاس و تەماتە و مریشکی کریسپی.',
        '١١. یەکسەر لەگەڵ پەتاتەی سوورکراو یان زەڵاتە پێشکەشی بکە.'
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
    ratingCount: 234,
    ingredients: {
      'en': [
        '2 cups all-purpose flour',
        '1 cup warm water',
        '2 tsp active dry yeast',
        '1 tsp sugar',
        '1 tsp salt',
        '2 tbsp olive oil',
        '½ cup zaatar',
        '⅓ cup olive oil (for topping)'
      ],
      'ku': [
        '٢ پەرداخ ئاردی هەموو مەبەست',
        '١ پەرداخ ئاوی گەرم',
        '٢ قاشقە چای خمیری وشک',
        '١ قاشقە چای شەکر',
        '١ قاشقە چای خوێ',
        '٢ قاشق خواردن ڕۆنی زەیتوون',
        '١/٢ پەرداخ زەعتەر',
        '١/٣ پەرداخ ڕۆنی زەیتوون (بۆ سەرەوە)'
      ],
    },
    steps: {
      'en': [
        '1. Dissolve sugar in warm water, sprinkle yeast on top, let sit 10 minutes until foamy.',
        '2. In large bowl, mix flour and salt. Add yeast mixture and 2 tbsp olive oil.',
        '3. Knead dough for 8-10 minutes until smooth and elastic.',
        '4. Place in oiled bowl, cover, let rise 1-2 hours until doubled.',
        '5. Preheat oven to 475°F (245°C) with pizza stone or baking sheet inside.',
        '6. Punch down dough and divide into 6 equal pieces.',
        '7. Roll each piece into circle about ¼-inch thick.',
        '8. Mix zaatar with ⅓ cup olive oil to make spreadable paste.',
        '9. Spread zaatar mixture evenly over each dough round.',
        '10. Bake for 8-10 minutes until edges are crisp and golden.',
        '11. Serve warm with fresh vegetables and olives.'
      ],
      'ku': [
        '١. شەکر لە ئاوی گەرم بڕەواز بکە، خمیر بپاش بە سەری، ڕێگە بدە بۆ ١٠ خولەک بمێنێتەوە تا کەف دروست بکات.',
        '٢. لە قاپێکی گەورەدا، ئارد و خوێ تێکەڵ بکە. تێکەڵەی خمیر و ٢ قاشق خواردن ڕۆنی زەیتوون زیاد بکە.',
        '٣. هەویرەکە بۆ ٨-١٠ خولەک چەقێنە تا ڕێک و وەرگیراو بێت.',
        '٤. بخەرە ناو قاپێکی ڕۆنپاشی، دایبخە، بۆ ١-٢ کاتژمێر ڕێگە بدە بڕوا بێت تا دوو هێندە ببێت.',
        '٥. فڕنەکە بۆ ٢٤٥ پلەی سیلیزی گەرم بکە لەگەڵ بەردی پیتزا یان پانیەکی برژاندن لە ناوی.',
        '٦. هەویرەکە بچەقێنە و بڕی بە ٦ پارچەی یەکسانی.',
        '٧. هەر پارچەیەک بکە بە بازنە نزیکەی چارەگی ئینج ئەستوور.',
        '٨. زەعتەر لەگەڵ ١/٣ پەرداخ ڕۆنی زەیتوون تێکەڵ بکە بۆ دروستکردنی پەستێنەیەکی بڵاوکراوە.',
        '٩. تێکەڵەی زەعتەر بە یەکسانی بڵاو بکەرەوە بەسەر هەر بازنەیەکی هەویر.',
        '١٠. بۆ ٨-١٠ خولەک ببرژێنە تا لایەکان ڕەق بن و زەردی قاوەیی بێت.',
        '١١. گەرم لەگەڵ سەوزە تازە و زەیتوون پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '104',
    title: {'en': 'Hawawshi (Meat Pie)', 'ku': 'هەواوشی (نانی گۆشت)'},
    icon: '🥙',
    nutrition: NutritionalInfo(calories: 580, protein: 35, carbs: 40, fats: 32),
    category: MealCategory.lunch,
    rating: 4.7,
    ratingCount: 156,
    ingredients: {
      'en': [
        '4 large pita bread rounds',
        '500g ground beef',
        '2 onions (finely chopped)',
        '2 green bell peppers (finely chopped)',
        '4 cloves garlic (minced)',
        '2 tbsp tomato paste',
        '1 tbsp paprika',
        '1 tsp cumin',
        '1 tsp coriander',
        '½ tsp cinnamon',
        '2 tbsp butter (melted)',
        'Salt and pepper to taste'
      ],
      'ku': [
        '٤ نانی پیتای گەورە',
        '٥٠٠ گرام گۆشتی مانگای هاڕاو',
        '٢ پیاز (وردکراوە)',
        '٢ بیبەری سەوز (وردکراوە)',
        '٤ خاو سیر (وردکراوە)',
        '٢ قاشق خواردن دۆشاوی تەماتە',
        '١ قاشق خواردن بیبەری سوور',
        '١ قاشقە چای کەمون',
        '١ قاشقە چای گوێزەبەڕۆ',
        '١/٢ قاشقە چای دارچین',
        '٢ قاشق خواردن کەرە (بوونەوە بێنە)',
        'خوێ و بیبەر بەپێی دڵخوازی'
      ],
    },
    steps: {
      'en': [
        '1. Preheat oven to 400°F (200°C).',
        '2. In bowl, mix ground beef, onions, peppers, garlic, tomato paste, and all spices.',
        '3. Cut pita bread rounds in half to create pockets.',
        '4. Divide meat mixture evenly among pita pockets, spreading but not overfilling.',
        '5. Brush outside of pita with melted butter.',
        '6. Place on baking sheet and bake for 20-25 minutes until meat is cooked and bread is crispy.',
        '7. Alternatively, cook on preheated grill for 8-10 minutes per side.',
        '8. Let cool for 5 minutes before serving.',
        '9. Serve with tahini sauce and pickles.'
      ],
      'ku': [
        '١. فڕنەکە بۆ ٢٠٠ پلەی سیلیزی گەرم بکە.',
        '٢. لە قاپێکدا، گۆشتی مانگای هاڕاو و پیاز و بیبەر و سیر و دۆشاوی تەماتە و هەموو بەهاراتەکان تێکەڵ بکە.',
        '٣. نانی پیتای بازنەیی ببڕە بە نیوە بۆ دروستکردنی گیرفان.',
        '٤. تێکەڵەی گۆشت بە یەکسانی دابەش بکە لە نێوان گیرفانی پیتا، بڵاوی بکەرەوە بەڵام زیاد پڕی مەکە.',
        '٥. دەرەوەی پیتا بە کەرەی بوونەوە بیڕەواز بکە.',
        '٦. بخەرە سەر پانیەکی برژاندن و بۆ ٢٠-٢٥ خولەک ببرژێنە تا گۆشتەکە بپوختێت و نانەکە ڕەق بێت.',
        '٧. بەجێیانە، لەسەر برژێنەرێکی پێش گەرمکراو بکوڵێنە بۆ ٨-١٠ خولەک لە هەر لایەک.',
        '٨. بۆ ٥ خولەک پێش خواردن ڕایان بگەڕێنە.',
        '٩. لەگەڵ سۆسی تەحین و ترشیات پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '105',
    title: {'en': 'Tunisian Brik', 'ku': 'بریکی تونسی'},
    icon: '🥟',
    nutrition: NutritionalInfo(calories: 350, protein: 18, carbs: 20, fats: 22),
    category: MealCategory.snack,
    rating: 4.6,
    ratingCount: 98,
    ingredients: {
      'en': [
        '4 sheets malsouka or phyllo dough',
        '4 eggs',
        '1 can tuna (drained)',
        '½ cup parsley (chopped)',
        '2 tbsp capers',
        '1 onion (finely chopped)',
        'Vegetable oil for frying',
        'Salt and pepper to taste'
      ],
      'ku': [
        '٤ پەڕە مەلسووقا یان هەویری فیلۆ',
        '٤ هێلکە',
        '١ قوتوی ماسی توون',
        '١/٢ پەرداخ جەعفەری (وردکراوە)',
        '٢ قاشق خواردن کەیپەر',
        '١ پیاز (وردکراوە)',
        'ڕۆنی ڕوەک بۆ سوورکردنەوە',
        'خوێ و بیبەر بەپێی دڵخوازی'
      ],
    },
    steps: {
      'en': [
        '1. Mix tuna, parsley, capers, onion, salt and pepper in bowl.',
        '2. Lay one sheet of malsouka on work surface.',
        '3. Place ¼ of tuna mixture in center of sheet.',
        '4. Make small well in center of tuna mixture and crack one egg into it.',
        '5. Fold dough over filling to form triangle, sealing edges with water.',
        '6. Heat 1 inch of oil in skillet to 350°F (175°C).',
        '7. Carefully slide brik into hot oil.',
        '8. Fry for 2-3 minutes per side until golden brown and crispy.',
        '9. Remove with slotted spoon and drain on paper towels.',
        '10. Serve immediately while egg yolk is still runny.'
      ],
      'ku': [
        '١. ماسی توون و جەعفەری و کەیپەر و پیاز و خوێ و بیبەر لە قاپێکدا تێکەڵ بکە.',
        '٢. یەک پەڕە مەلسووقا دانێ لەسەر ڕووی کار.',
        '٣. ١/٤ لە تێکەڵەی ماسی توون بخەرە ناوەڕاستی پەڕەکە.',
        '٤. چاڵێکی بچووک لە ناوەڕاستی تێکەڵەی ماسی توون دروست بکە و هێلکەیەک بخەرە ناوی.',
        '٥. هەویرەکە بپێچەرەوە بەسەر ناوەکە بۆ دروستکردنی سێگۆشە، لایەکان بە ئاو داخڵ بکە.',
        '٦. ١ ئینج ڕۆن لە تاوێکدا گەرم بکە بۆ ١٧٥ پلەی سیلیزی.',
        '٧. بە وردبینی بریک بخەرە ناو ڕۆنی گەرمەوە.',
        '٨. بۆ ٢-٣ خولەک لە هەر لایەک ببرژێنە تا زەردی قاوەیی و ڕەق بێت.',
        '٩. بە کەوچکێکی کوندار لابە و بە کلینکس وشکی بکە.',
        '١٠. یەکسەر پێشکەشی بکە لەکاتێکدا زەردە هێلکە هێشتا شلە.'
      ],
    },
  ),
  Recipe(
    id: '106',
    title: {'en': 'Halloumi Saj Wrap', 'ku': 'لەتەی سەج بە هەلۆمی'},
    icon: '🌯',
    nutrition: NutritionalInfo(calories: 420, protein: 22, carbs: 35, fats: 20),
    category: MealCategory.breakfast,
    rating: 4.7,
    ratingCount: 112,
    ingredients: {
      'en': [
        '4 saj or lavash bread',
        '250g halloumi cheese (sliced)',
        '1 cucumber (sliced)',
        '2 tomatoes (sliced)',
        '½ cup fresh mint leaves',
        '½ cup Kalamata olives',
        '2 tbsp olive oil',
        '1 tbsp zaatar (optional)'
      ],
      'ku': [
        '٤ نانی سەج یان لەڤاش',
        '٢٥٠ گرام پەنیری هەلۆمی (پەڕەکراوە)',
        '١ خەیار (پەڕەکراوە)',
        '٢ تەماتە (پەڕەکراوە)',
        '١/٢ پەرداخ گەڵای نەعنای تازە',
        '١/٢ پەرداخ زەیتوونی کالاماتا',
        '٢ قاشق خواردن ڕۆنی زەیتوون',
        '١ قاشق خواردن زەعتەر (ئارەزوویانە)'
      ],
    },
    steps: {
      'en': [
        '1. Heat grill pan or skillet over medium-high heat.',
        '2. Grill halloumi slices for 2-3 minutes per side until golden grill marks appear.',
        '3. Warm saj bread slightly on grill or in dry skillet.',
        '4. Place warm bread on work surface.',
        '5. Layer grilled halloumi, cucumber, tomatoes, mint leaves, and olives on bread.',
        '6. Drizzle with olive oil and sprinkle with zaatar if using.',
        '7. Roll bread tightly around filling.',
        '8. Place wrap back on grill for 1-2 minutes per side to toast slightly.',
        '9. Cut in half and serve immediately.'
      ],
      'ku': [
        '١. تاوێکی برژێنەر یان تاوێک لە گەرمی ناوەڕاست گەرم بکە.',
        '٢. پەڕەکانی هەلۆمی بۆ ٢-٣ خولەک لە هەر لایەک ببرژێنە تا نیشانەی برژێنەری زەرد دەرکەوت.',
        '٣. نانی سەج بە نەرمی گەرمی بکەرەوە لەسەر برژێنەر یان لە تاوێکی وشکدا.',
        '٤. نانی گەرم بخەرە سەر ڕووی کار.',
        '٥. هەلۆمی برژاو و خەیار و تەماتە و گەڵای نەعنا و زەیتوون لەسەر نان ڕیز بکە.',
        '٦. ڕۆنی زەیتوونی پێدا بکە و زەعتەر بپاش بە سەری ئەگەر بەکاردێنیت.',
        '٧. نانەکە بە تەنگی بپێچەرەوە بە دەوری ناوەکە.',
        '٨. لەتەکە بگەڕێنەوە سەر برژێنەر بۆ ١-٢ خولەک لە هەر لایەک بۆ برژاندنی کەمێک.',
        '٩. ببڕە بە نیوە و یەکسەر پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '107',
    title: {'en': 'Mahjouba (Crepe)', 'ku': 'مەحجوبەی جەزائیری'},
    icon: '🥞',
    nutrition: NutritionalInfo(calories: 380, protein: 10, carbs: 55, fats: 12),
    category: MealCategory.lunch,
    rating: 4.6,
    ratingCount: 87,
    ingredients: {
      'en': [
        '2 cups semolina flour',
        '1 cup all-purpose flour',
        '1 tsp salt',
        '1½ cups warm water',
        'Filling: 2 onions (sliced), 4 tomatoes (diced), 2 tbsp tomato paste, 1 tsp paprika, ½ tsp chili flakes',
        'Olive oil for cooking'
      ],
      'ku': [
        '٢ پەرداخ ئاردی سمید',
        '١ پەرداخ ئاردی هەموو مەبەست',
        '١ قاشقە چای خوێ',
        '١١/٢ پەرداخ ئاوی گەرم',
        'ناوەکە: ٢ پیاز (پەڕەکراوە)، ٤ تەماتە (چوارگۆشەکراوە)، ٢ قاشق خواردن دۆشاوی تەماتە، ١ قاشقە چای بیبەری سوور، ١/٢ قاشقە چای پارچە بیبەری توون',
        'ڕۆنی زەیتوون بۆ چێشتلێنان'
      ],
    },
    steps: {
      'en': [
        '1. For dough: Mix semolina, flour, and salt. Gradually add water until soft dough forms.',
        '2. Knead 10 minutes until smooth. Divide into 8 balls, cover, rest 30 minutes.',
        '3. For filling: Sauté onions in olive oil until soft. Add tomatoes, tomato paste, and spices. Cook until thick.',
        '4. On oiled surface, flatten dough ball with oiled hands until very thin and almost transparent.',
        '5. Place 2-3 tbsp filling in center.',
        '6. Fold sides over filling to form square packet.',
        '7. Cook on hot griddle or skillet with olive oil for 3-4 minutes per side until golden.',
        '8. Serve hot.'
      ],
      'ku': [
        '١. بۆ هەویری: سمید و ئارد و خوێ تێکەڵ بکە. بەرەبەرە ئاو زیاد بکە تا هەویریەکی نەرم دروست بێت.',
        '٢. بۆ ١٠ خولەک چەقێنە تا ڕێک بێت. بڕی بە ٨ تۆپ، دایبخە، بۆ ٣٠ خولەک ڕای بگەڕێنە.',
        '٣. بۆ ناوەکە: پیاز لە ڕۆنی زەیتوون ببرژێنە تا نەرم بێت. تەماتە و دۆشاوی تەماتە و بەهاراتەکان زیاد بکە. بکوڵێنە تا خەست ببێتەوە.',
        '٤. لەسەر ڕوویەکی ڕۆنپاشی، تۆپە هەویرەکە پەت بکە بە دەستی ڕۆنپاشەوە تا زۆر بە تەنکی و نزیکەی ڕووناک بێت.',
        '٥. ٢-٣ قاشق خواردن لە ناوەکە بخەرە ناوەڕاستی.',
        '٦. لایەکان بپێچەرەوە بەسەر ناوەکە بۆ دروستکردنی پاکەتێکی چوارگۆشە.',
        '٧. لەسەر ساجێکی گەرم یان تاوێک بە ڕۆنی زەیتوون بکوڵێنە بۆ ٣-٤ خولەک لە هەر لایەک تا زەرد بێت.',
        '٨. گەرم پێشکەشی بکە.'
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
        '500g chicken thighs (thinly sliced)',
        '4 cloves garlic (minced)',
        '¼ cup lemon juice',
        '2 tbsp olive oil',
        '1 tbsp paprika',
        '1 tbsp cumin',
        '1 tsp cinnamon',
        '4 saj or pita bread',
        '1 cup garlic sauce (toum)',
        '1 cup pickles (sliced)',
        '1 onion (thinly sliced)',
        '2 tomatoes (sliced)',
        'Fresh parsley'
      ],
      'ku': [
        '٥٠٠ گرام ڕانی مریشک (بە تەنکی پەڕەکراوە)',
        '٤ خاو سیر (وردکراوە)',
        '١/٤ پەرداخ ئاوی لیمۆ',
        '٢ قاشق خواردن ڕۆنی زەیتوون',
        '١ قاشق خواردن بیبەری سوور',
        '١ قاشق خواردن کەمون',
        '١ قاشقە چای دارچین',
        '٤ نانی سەج یان پیتا',
        '١ پەرداخ سۆسی سیر',
        '١ پەرداخ ترشیات (پەڕەکراوە)',
        '١ پیاز (بە تەنکی پەڕەکراوە)',
        '٢ تەماتە (پەڕەکراوە)',
        'جەعفەری تازە'
      ],
    },
    steps: {
      'en': [
        '1. Mix garlic, lemon juice, olive oil, and spices in bowl.',
        '2. Add chicken slices, coat thoroughly, marinate 2-24 hours.',
        '3. Heat large skillet or grill pan over high heat.',
        '4. Cook chicken in batches for 3-4 minutes per side until charred and cooked through.',
        '5. Warm bread slightly on grill or in dry skillet.',
        '6. Spread garlic sauce on bread.',
        '7. Add chicken, pickles, onions, tomatoes, and parsley.',
        '8. Roll tightly, tucking in ends.',
        '9. Grill wrap for 1-2 minutes per side to toast.',
        '10. Serve immediately.'
      ],
      'ku': [
        '١. سیر و ئاوی لیمۆ و ڕۆنی زەیتوون و بەهاراتەکان لە قاپێکدا تێکەڵ بکە.',
        '٢. پەڕەکانی مریشک زیاد بکە، باش بپۆشیان بە، بۆ ٢-٢٤ کاتژمێر بخۆشێنە.',
        '٣. تاوێکی گەورە یان تاوێکی برژێنەر لە گەرمی بەرز گەرم بکە.',
        '٤. مریشکەکان بە کۆمەڵە بکوڵێنە بۆ ٣-٤ خولەک لە هەر لایەک تا سوور ببن و بپوختن.',
        '٥. نانەکە بە نەرمی گەرمی بکەرەوە لەسەر برژێنەر یان لە تاوێکی وشکدا.',
        '٦. سۆسی سیر لەسەر نان بڵاو بکەرەوە.',
        '٧. مریشک و ترشیات و پیاز و تەماتە و جەعفەری زیاد بکە.',
        '٨. بە تەنگی بیپێچەرەوە، کۆتاییەکان بخەرە ناوەوە.',
        '٩. لەتەکە بۆ ١-٢ خولەک لە هەر لایەک ببرژێنە بۆ برژاندن.',
        '١٠. یەکسەر پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '109',
    title: {'en': 'Beef Kofta Wrap', 'ku': 'لەتەی کفتەی گۆشت'},
    icon: '🌯',
    nutrition: NutritionalInfo(calories: 550, protein: 38, carbs: 35, fats: 25),
    category: MealCategory.dinner,
    rating: 4.7,
    ratingCount: 156,
    ingredients: {
      'en': [
        '500g ground beef',
        '1 onion (grated)',
        '½ cup parsley (chopped)',
        '1 tbsp paprika',
        '1 tsp cumin',
        '1 tsp allspice',
        '4 pita bread',
        '1 cup hummus',
        '1 onion (thinly sliced)',
        'Fresh parsley',
        'Lemon wedges'
      ],
      'ku': [
        '٥٠٠ گرام گۆشتی مانگای هاڕاو',
        '١ پیاز (هەڕاو)',
        '١/٢ پەرداخ جەعفەری (وردکراوە)',
        '١ قاشق خواردن بیبەری سوور',
        '١ قاشقە چای کەمون',
        '١ قاشقە چای بەهاراتی هەموو جۆرە',
        '٤ نانی پیتا',
        '١ پەرداخ حومس',
        '١ پیاز (بە تەنکی پەڕەکراوە)',
        'جەعفەری تازە',
        'پارچە لیمۆ'
      ],
    },
    steps: {
      'en': [
        '1. Mix beef, grated onion, parsley, and spices. Knead 5 minutes.',
        '2. Form into sausage shapes around skewers.',
        '3. Grill over medium-high heat for 8-10 minutes, turning occasionally.',
        '4. Warm pita bread.',
        '5. Spread hummus on bread.',
        '6. Remove kofta from skewers, place on bread.',
        '7. Add sliced onions and fresh parsley.',
        '8. Squeeze lemon over.',
        '9. Roll and serve.'
      ],
      'ku': [
        '١. گۆشتی مانگا و پیازی هەڕاو و جەعفەری و بەهارات تێکەڵ بکە. بۆ ٥ خولەک چەقێنە.',
        '٢. دروستی بکە بە شێوەی سجوق دەوری شیشەکان.',
        '٣. لە گەرمی ناوەڕاست ببرژێنە بۆ ٨-١٠ خولەک، هەندێک جار بگۆڕەرێنە.',
        '٤. نانی پیتا گەرمی بکەرەوە.',
        '٥. حومس لەسەر نان بڵاو بکەرەوە.',
        '٦. کفتەکان لە شیشەکان لابە، بخەرە سەر نان.',
        '٧. پیازی پەڕەکراو و جەعفەری تازە زیاد بکە.',
        '٨. لیمۆی پێدا بکە.',
        '٩. بیپێچەرەوە و پێشکەشی بکە.'
      ],
    },
  ),
  Recipe(
    id: '110',
    title: {'en': 'Batata Harra (Spicy Potatoes)', 'ku': 'پەتاتەی توون'},
    icon: '🍟',
    nutrition: NutritionalInfo(calories: 320, protein: 4, carbs: 45, fats: 14),
    category: MealCategory.snack,
    rating: 4.6,
    ratingCount: 98,
    ingredients: {
      'en': [
        '4 large potatoes (cubed)',
        '¼ cup olive oil',
        '6 cloves garlic (minced)',
        '1 tsp chili flakes',
        '½ cup cilantro (chopped)',
        '2 tbsp lemon juice',
        'Salt to taste'
      ],
      'ku': [
        '٤ پەتاتەی گەورە (چوارگۆشەکراوە)',
        '١/٤ پەرداخ ڕۆنی زەیتوون',
        '٦ خاو سیر (وردکراوە)',
        '١ قاشقە چای پارچە بیبەری توون',
        '١/٢ پەرداخ کەزەره (وردکراوە)',
        '٢ قاشق خواردن ئاوی لیمۆ',
        'خوێ بەپێی دڵخوازی'
      ],
    },
    steps: {
      'en': [
        '1. Boil potatoes until just tender, drain.',
        '2. Heat olive oil in large skillet.',
        '3. Add potatoes and fry until golden and crispy.',
        '4. Add garlic and chili flakes, cook 1 minute.',
        '5. Remove from heat, add cilantro and lemon juice.',
        '6. Toss to combine.',
        '7. Season with salt.',
        '8. Serve hot as side dish or appetizer.'
      ],
      'ku': [
        '١. پەتاتەکان بکوڵێنە تا تەنها نەرم بن، بیپاڵێوە.',
        '٢. ڕۆنی زەیتوون لە تاوێکی گەورەدا گەرم بکە.',
        '٣. پەتاتەکان زیاد بکە و ببرژێنە تا زەرد و ڕەق بن.',
        '٤. سیر و پارچە بیبەری توون زیاد بکە، بۆ ١ خولەک بکوڵێنە.',
        '٥. لە گەرمی لابە، کەزەره و ئاوی لیمۆ زیاد بکە.',
        '٦. تێکەڵی بکە تا یەک بگرن.',
        '٧. بە خوێ بەهارات بدە.',
        '٨. گەرم وەک خواردنی لاوەکی یان پیشخواردن پێشکەشی بکە.'
      ],
    },
  ),
];
