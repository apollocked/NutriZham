class AppLocalizations {
  final String languageCode;

  AppLocalizations(this.languageCode);

  static AppLocalizations of(String languageCode) {
    return AppLocalizations(languageCode);
  }

  // Authentication
  String get login => _get('login');
  String get register => _get('register');
  String get logout => _get('logout');
  String get username => _get('username');
  String get email => _get('email');
  String get password => _get('password');
  String get age => _get('age');
  String get confirmPassword => _get('confirmPassword');
  String get alreadyHaveAccount => _get('alreadyHaveAccount');
  String get dontHaveAccount => _get('dontHaveAccount');
  String get forgotPassword => _get('forgotPassword');

  // Navigation
  String get home => _get('home');
  String get search => _get('search');
  String get planner => _get('planner');
  String get profile => _get('profile');

  // App title and general
  String get appTitle => _get('appTitle');
  String get recipes => _get('recipes');
  String get searchPlaceholder => _get('searchPlaceholder');
  String get all => _get('all');
  String get recipesFound => _get('recipesFound');
  String get recipeFound => _get('recipeFound');
  String get noRecipesFound => _get('noRecipesFound');
  String get tryDifferentSearch => _get('tryDifferentSearch');
  String get noFavorites => _get('noFavorites');
  String get tapToSave => _get('tapToSave');

  // Categories
  String get breakfast => _get('breakfast');
  String get lunch => _get('lunch');
  String get dinner => _get('dinner');
  String get snack => _get('snack');
  String get bulking => _get('bulking');
  String get cutting => _get('cutting');

  // Nutrition
  String get nutritionalInfo => _get('nutritionalInfo');
  String get calories => _get('calories');
  String get protein => _get('protein');
  String get carbs => _get('carbs');
  String get fats => _get('fats');

  // Recipe details
  String get ingredients => _get('ingredients');
  String get preparationSteps => _get('preparationSteps');
  String get rating => _get('rating');
  String get ratings => _get('ratings');
  String get rateThisMeal => _get('rateThisMeal');
  String get yourRating => _get('yourRating');
  String get submitRating => _get('submitRating');

  // Settings
  String get settings => _get('settings');
  String get language => _get('language');
  String get darkMode => _get('darkMode');
  String get english => _get('english');
  String get kurdish => _get('kurdish');
  String get editAccount => _get('editAccount');
  String get deleteAccount => _get('deleteAccount');
  String get areYouSure => _get('areYouSure');
  String get cancel => _get('cancel');
  String get delete => _get('delete');
  String get save => _get('save');
  String get update => _get('update');

  // Profile
  String get myProfile => _get('myProfile');
  String get favorites => _get('favorites');
  String get accountSettings => _get('accountSettings');
  String get memberSince => _get('memberSince');

  // Planner
  String get mealPlanner => _get('mealPlanner');
  String get dailyPlan => _get('dailyPlan');
  String get weeklyPlan => _get('weeklyPlan');
  String get recommendedMeals => _get('recommendedMeals');
  String get basedOnYourGoals => _get('basedOnYourGoals');
  String get totalCalories => _get('totalCalories');
  String get todaysMeals => _get('todaysMeals');
  String get addToPlan => _get('addToPlan');
  String get removeFromPlan => _get('removeFromPlan');

  // Messages
  String get success => _get('success');
  String get error => _get('error');
  String get loading => _get('loading');
  String get pleaseWait => _get('pleaseWait');
  String get accountDeleted => _get('accountDeleted');
  String get accountUpdated => _get('accountUpdated');
  String get loginSuccess => _get('loginSuccess');
  String get registerSuccess => _get('registerSuccess');

  String _get(String key) {
    return _localizedValues[languageCode]?[key] ??
        _localizedValues['en']?[key] ??
        key;
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // Auth
      'login': 'Login',
      'register': 'Register',
      'logout': 'Logout',
      'username': 'Username',
      'email': 'Email',
      'password': 'Password',
      'age': 'Age',
      'confirmPassword': 'Confirm Password',
      'alreadyHaveAccount': 'Already have an account?',
      'dontHaveAccount': "Don't have an account?",
      'forgotPassword': 'Forgot Password?',

      // Navigation
      'home': 'Home',
      'search': 'Search',
      'planner': 'Planner',
      'profile': 'Profile',

      // General
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

      // Categories
      'breakfast': 'Breakfast',
      'lunch': 'Lunch',
      'dinner': 'Dinner',
      'snack': 'Snack',
      'bulking': 'Bulking',
      'cutting': 'Cutting',

      // Nutrition
      'nutritionalInfo': 'Nutritional Information',
      'calories': 'Calories',
      'protein': 'Protein',
      'carbs': 'Carbs',
      'fats': 'Fats',

      // Recipe
      'ingredients': 'Ingredients',
      'preparationSteps': 'Preparation Steps',
      'rating': 'Rating',
      'ratings': 'ratings',
      'rateThisMeal': 'Rate this Meal',
      'yourRating': 'Your Rating',
      'submitRating': 'Submit Rating',

      // Settings
      'settings': 'Settings',
      'language': 'Language',
      'darkMode': 'Dark Mode',
      'english': 'English',
      'kurdish': 'Kurdish',
      'editAccount': 'Edit Account',
      'deleteAccount': 'Delete Account',
      'areYouSure': 'Are you sure?',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'save': 'Save',
      'update': 'Update',

      // Profile
      'myProfile': 'My Profile',
      'favorites': 'Favorites',
      'accountSettings': 'Account Settings',
      'memberSince': 'Member since',

      // Planner
      'mealPlanner': 'Meal Planner',
      'dailyPlan': 'Daily Plan',
      'weeklyPlan': 'Weekly Plan',
      'recommendedMeals': 'Recommended Meals',
      'basedOnYourGoals': 'Based on your fitness goals',
      'totalCalories': 'Total Calories',
      'todaysMeals': "Today's Meals",
      'addToPlan': 'Add to Plan',
      'removeFromPlan': 'Remove from Plan',

      // Messages
      'passwordsDoNotMatch': 'Passwords do not match',
      'success': 'Success',
      'error': 'Error',
      'loading': 'Loading',
      'pleaseWait': 'Please wait...',
      'accountDeleted': 'Account deleted successfully',
      'accountUpdated': 'Account updated successfully',
      'loginSuccess': 'Login successful',
      'registerSuccess': 'Registration successful',
    },
    'ku': {
      // Auth
      'login': 'چوونەژوورەوە',
      'register': 'تۆمارکردن',
      'logout': 'دەرچوون',
      'username': 'ناوی بەکارهێنەر',
      'email': 'ئیمەیڵ',
      'password': 'وشەی نهێنی',
      'age': 'تەمەن',
      'confirmPassword': 'دڵنیاکردنەوەی وشەی نهێنی',
      'alreadyHaveAccount': 'پێشتر هەژمارت هەیە؟',
      'dontHaveAccount': 'هەژمارت نیە؟',
      'forgotPassword': 'وشەی نهێنیت بیر چووە؟',

      // Navigation
      'home': 'سەرەکی',
      'search': 'گەڕان',
      'planner': 'پلانەر',
      'profile': 'پڕۆفایل',

      // General
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

      // Categories
      'breakfast': 'تایبەتە',
      'lunch': 'نانی نیوەڕۆ',
      'dinner': 'نانی ئێوارە',
      'snack': 'خواردنی سووک',
      'bulking': 'زیادکردنی قەبارە',
      'cutting': 'لاوازبوون',

      // Nutrition
      'nutritionalInfo': 'زانیاری خۆراکی',
      'calories': 'کالۆری',
      'protein': 'پڕۆتین',
      'carbs': 'کاربۆهایدرات',
      'fats': 'چەوری',

      // Recipe
      'ingredients': 'پێکهاتەکان',
      'preparationSteps': 'هەنگاوەکانی ئامادەکردن',
      'rating': 'هەڵسەنگاندن',
      'ratings': 'هەڵسەنگاندنەکان',
      'rateThisMeal': 'ئەم خواردنە هەڵبسەنگێنە',
      'yourRating': 'هەڵسەنگاندنی تۆ',
      'submitRating': 'ناردنی هەڵسەنگاندن',

      // Settings
      'settings': 'ڕێکخستنەکان',
      'language': 'زمان',
      'darkMode': 'دۆخی تاریک',
      'english': 'ئینگلیزی',
      'kurdish': 'کوردی',
      'editAccount': 'دەستکاریکردنی هەژمار',
      'deleteAccount': 'سڕینەوەی هەژمار',
      'areYouSure': 'دڵنیایت؟',
      'cancel': 'پاشگەزبوونەوە',
      'delete': 'سڕینەوە',
      'save': 'پاشەکەوتکردن',
      'update': 'نوێکردنەوە',

      // Profile
      'myProfile': 'پڕۆفایلەکەم',
      'favorites': 'دڵخوازەکان',
      'accountSettings': 'ڕێکخستنەکانی هەژمار',
      'memberSince': 'ئەندامی لە',

      // Planner
      'mealPlanner': 'پلانی خواردن',
      'dailyPlan': 'پلانی ڕۆژانە',
      'weeklyPlan': 'پلانی هەفتانە',
      'recommendedMeals': 'خواردنە پێشنیارکراوەکان',
      'basedOnYourGoals': 'لەسەر بنەمای ئامانجەکانتی فیتنس',
      'totalCalories': 'کۆی کالۆری',
      'todaysMeals': 'خواردنەکانی ئەمڕۆ',
      'addToPlan': 'زیادکردن بۆ پلان',
      'removeFromPlan': 'لابردن لە پلان',

      // Messages
      'passwordsDoNotMatch': 'وشەی نهێنیەکان ناگونجێت',
      'success': 'سەرکەوتوو',
      'error': 'هەڵە',
      'loading': 'بارکردن',
      'pleaseWait': 'تکایە چاوەڕێبکە...',
      'accountDeleted': 'هەژمار بە سەرکەوتوویی سڕایەوە',
      'accountUpdated': 'هەژمار بە سەرکەوتوویی نوێکرایەوە',
      'loginSuccess': 'چوونەژوورەوە سەرکەوتوو بوو',
      'registerSuccess': 'تۆمارکردن سەرکەوتوو بوو',
    },
  };
}
