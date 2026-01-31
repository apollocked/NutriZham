class AppLocalizations {
  final String languageCode;

  AppLocalizations(this.languageCode);

  static AppLocalizations of(String languageCode) {
    return AppLocalizations(languageCode);
  }

  // App title and navigation
  String get appTitle => _localizedValues[languageCode]?['appTitle'] ?? 'NutriZham';
  String get recipes => _localizedValues[languageCode]?['recipes'] ?? 'Recipes';
  
  // Search and filter
  String get searchPlaceholder => _localizedValues[languageCode]?['searchPlaceholder'] ?? 'Search recipes or ingredients...';
  String get all => _localizedValues[languageCode]?['all'] ?? 'All';
  String get recipesFound => _localizedValues[languageCode]?['recipesFound'] ?? 'recipes found';
  String get recipeFound => _localizedValues[languageCode]?['recipeFound'] ?? 'recipe found';
  String get noRecipesFound => _localizedValues[languageCode]?['noRecipesFound'] ?? 'No recipes found';
  String get tryDifferentSearch => _localizedValues[languageCode]?['tryDifferentSearch'] ?? 'Try a different search or filter';
  String get noFavorites => _localizedValues[languageCode]?['noFavorites'] ?? 'No favorites yet';
  String get tapToSave => _localizedValues[languageCode]?['tapToSave'] ?? 'Tap the heart icon on recipes to save them';
  
  // Categories
  String get breakfast => _localizedValues[languageCode]?['breakfast'] ?? 'Breakfast';
  String get lunch => _localizedValues[languageCode]?['lunch'] ?? 'Lunch';
  String get dinner => _localizedValues[languageCode]?['dinner'] ?? 'Dinner';
  String get snack => _localizedValues[languageCode]?['snack'] ?? 'Snack';
  String get bulking => _localizedValues[languageCode]?['bulking'] ?? 'Bulking';
  String get cutting => _localizedValues[languageCode]?['cutting'] ?? 'Cutting';
  
  // Nutrition
  String get nutritionalInfo => _localizedValues[languageCode]?['nutritionalInfo'] ?? 'Nutritional Information';
  String get calories => _localizedValues[languageCode]?['calories'] ?? 'Calories';
  String get protein => _localizedValues[languageCode]?['protein'] ?? 'Protein';
  String get carbs => _localizedValues[languageCode]?['carbs'] ?? 'Carbs';
  String get fats => _localizedValues[languageCode]?['fats'] ?? 'Fats';
  
  // Recipe details
  String get ingredients => _localizedValues[languageCode]?['ingredients'] ?? 'Ingredients';
  String get preparationSteps => _localizedValues[languageCode]?['preparationSteps'] ?? 'Preparation Steps';
  
  // Settings
  String get settings => _localizedValues[languageCode]?['settings'] ?? 'Settings';
  String get language => _localizedValues[languageCode]?['language'] ?? 'Language';
  String get darkMode => _localizedValues[languageCode]?['darkMode'] ?? 'Dark Mode';
  String get english => _localizedValues[languageCode]?['english'] ?? 'English';
  String get kurdish => _localizedValues[languageCode]?['kurdish'] ?? 'Kurdish';

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'NutriZham',
      'recipes': 'Recipes',
      'searchPlaceholder': 'Search recipes or ingredients...',
      'all': 'All',
      'recipesFound': 'recipes found',
      'recipeFound': 'recipe found',
      'noRecipesFound': 'No recipes found',
      'tryDifferentSearch': 'Try a different search or filter',
      'noFavorites': 'No favorites yet',
      'tapToSave': 'Tap the heart icon on recipes to save them',
      'breakfast': 'Breakfast',
      'lunch': 'Lunch',
      'dinner': 'Dinner',
      'snack': 'Snack',
      'bulking': 'Bulking',
      'cutting': 'Cutting',
      'nutritionalInfo': 'Nutritional Information',
      'calories': 'Calories',
      'protein': 'Protein',
      'carbs': 'Carbs',
      'fats': 'Fats',
      'ingredients': 'Ingredients',
      'preparationSteps': 'Preparation Steps',
      'settings': 'Settings',
      'language': 'Language',
      'darkMode': 'Dark Mode',
      'english': 'English',
      'kurdish': 'Kurdish',
    },
    'ku': {
      'appTitle': 'نوتریژام',
      'recipes': 'ڕێچەتەکان',
      'searchPlaceholder': 'گەڕان بە دوای ڕێچەتە یان پێکهاتەکان...',
      'all': 'هەموو',
      'recipesFound': 'ڕێچەتە دۆزرایەوە',
      'recipeFound': 'ڕێچەتە دۆزرایەوە',
      'noRecipesFound': 'هیچ ڕێچەتەیەک نەدۆزرایەوە',
      'tryDifferentSearch': 'گەڕانێکی جیاواز یان فلتەرێکی تر تاقی بکەرەوە',
      'noFavorites': 'هێشتا هیچ دڵخوازێک نیە',
      'tapToSave': 'دەستی لە نیشانەی دڵ بدە بۆ پاشەکەوتکردنیان',
      'breakfast': 'تایبەتە',
      'lunch': 'نانی نیوەڕۆ',
      'dinner': 'نانی ئێوارە',
      'snack': 'خواردنی سووک',
      'bulking': 'زیادکردنی قەبارە',
      'cutting': 'لاوازبوون',
      'nutritionalInfo': 'زانیاری خۆراکی',
      'calories': 'کالۆری',
      'protein': 'پڕۆتین',
      'carbs': 'کاربۆهایدرات',
      'fats': 'چەوری',
      'ingredients': 'پێکهاتەکان',
      'preparationSteps': 'هەنگاوەکانی ئامادەکردن',
      'settings': 'ڕێکخستنەکان',
      'language': 'زمان',
      'darkMode': 'دۆخی تاریک',
      'english': 'ئینگلیزی',
      'kurdish': 'کوردی',
    },
  };
}
