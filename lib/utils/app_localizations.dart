import 'package:flutter/material.dart';
import 'package:nutrizham/utils/app_colors.dart';

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
  String get arabic => _get('arabic');
  String get editAccount => _get('editAccount');
  String get deleteAccount => _get('deleteAccount');
  String get areYouSure => _get('areYouSure');
  String get cancel => _get('cancel');
  String get delete => _get('delete');
  String get save => _get('save');
  String get update => _get('update');

  // Profile
  String get myProfile => _get('myProfile');
  String get appfeture => _get('appfeture');
  String get favorites => _get('favorites');
  String get accountSettings => _get('accountSettings');
  String get memberSince => _get('memberSince');

  // Planner
  String get mealPlanner => _get('mealPlanner');
  String get emptyplan => _get('emptyplan');

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
      'tapToSave': 'Tap the + icon on recipes to save them',

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
      'kurdish': 'کوردی',
      'arabic': 'العربية',
      'editAccount': 'Edit Account',
      'deleteAccount': 'Delete Account',
      'areYouSure': 'Are you sure?',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'save': 'Save',
      'update': 'Update',

      // Profile
      'appfeture': 'App Features',
      'myProfile': 'My Profile',
      'favorites': 'Favorites',
      'accountSettings': 'Account Settings',
      'memberSince': 'Member since',

      // Planner
      'mealPlanner': 'Meal Planner',
      'emptyplan': 'Your Daily Plan is Empty',
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
      'register': 'خۆتۆمارکردن',
      'logout': 'دەرچوون',
      'username': 'ناوی بەکارهێنەر',
      'email': 'ئیمەیڵ',
      'password': 'وشەی نهێنی',
      'age': 'تەمەن',
      'confirmPassword': 'دڵنیاکردنەوەی وشەی نهێنی',
      'alreadyHaveAccount': 'پێشتر هەژمارت هەبووە؟',
      'dontHaveAccount': 'هەژمارت نیە؟',
      'forgotPassword': 'وشەی نهێنیت بیر چووە؟',

      // Navigation
      'home': 'سەرەکی',
      'search': 'گەڕان',
      'planner': 'پلانەر',
      'profile': 'پڕۆفایل',

      // General
      'appTitle': 'نوتری ژەم',
      'recipes': 'ڕێچەتەکان',
      'searchPlaceholder': 'گەڕان بە دوای ڕێچەتە یان پێکهاتەکان...',
      'all': 'هەموو',
      'recipesFound': 'ڕێچەتەکان دۆزرانەوە',
      'recipeFound': 'ڕێچەتە دۆزرایەوە',
      'noRecipesFound': 'هیچ ڕێچەتەیەک نەدۆزرایەوە',
      'tryDifferentSearch': 'گەڕانێکی جیاواز یان فلتەرێکی تر تاقی بکەرەوە',
      'noFavorites': 'هێشتا هیچ دڵخوازێک نیە',
      'tapToSave': ' دەست لە نیشانەی + بدە بۆ پاشەکەوتکردنیان ',

      // Categories
      'breakfast': 'ژەمی بەیانی',
      'lunch': ' نیوەڕۆ',
      'dinner': ' ئێوارە',
      'snack': 'خواردنی سووک',
      'bulking': 'کێش سەرخستن',
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
      'english': 'English',
      'kurdish': 'کوردی',
      'arabic': 'العربية',
      'editAccount': 'دەستکاریکردنی هەژمار',
      'deleteAccount': 'سڕینەوەی هەژمار',
      'areYouSure': 'دڵنیایت؟',
      'cancel': 'پاشگەزبوونەوە',
      'delete': 'سڕینەوە',
      'save': 'پاشەکەوتکردن',
      'update': 'نوێکردنەوە',

      // Profile
      'appfeture': 'تایبەتمەندییەکان',
      'myProfile': 'پڕۆفایلەکەم',
      'favorites': 'دڵخوازەکان',
      'accountSettings': 'ڕێکخستنەکانی هەژمار',
      'memberSince': 'ئەندامی لەوەتەی',

      // Planner
      'mealPlanner': 'پلانی خواردن',
      'emptyplan': 'هیج پلانێکت هەڵنەبژاردوە',
      'dailyPlan': 'پلانی ڕۆژانە',
      'weeklyPlan': 'پلانی هەفتانە',
      'recommendedMeals': 'خواردنە پێشنیارکراوەکان',
      'basedOnYourGoals': 'لەسەر بنەمای ئامانجەکانت',
      'totalCalories': 'کۆی کالۆری',
      'todaysMeals': 'خواردنەکانی ئەمڕۆ',
      'addToPlan': 'زیادکرا بۆ پلان',
      'removeFromPlan': 'لابردا لە پلان',

      // Messages
      'passwordsDoNotMatch': 'وشەی نهێنیەکان هەمان شت نین',
      'success': 'سەرکەوتوو',
      'error': 'هەڵە',
      'loading': 'بارکردن',
      'pleaseWait': 'تکایە چاوەڕێبکە...',
      'accountDeleted': 'هەژمار بە سەرکەوتوویی سڕایەوە',
      'accountUpdated': 'هەژمار بە سەرکەوتوویی نوێکرایەوە',
      'loginSuccess': 'چوونەژوورەوە سەرکەوتوو بوو',
      'registerSuccess': 'تۆمارکردن سەرکەوتوو بوو',
    },
    'ar': {
      // Auth
      'login': 'تسجيل الدخول',
      'register': 'التسجيل',
      'logout': 'تسجيل الخروج',
      'username': 'اسم المستخدم',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'age': 'العمر',
      'confirmPassword': 'تأكيد كلمة المرور',
      'alreadyHaveAccount': 'هل لديك حساب بالفعل؟',
      'dontHaveAccount': 'ليس لديك حساب؟',
      'forgotPassword': 'نسيت كلمة المرور؟',

      // Navigation
      'home': 'الرئيسية',
      'search': 'بحث',
      'planner': 'المخطط',
      'profile': ' الملف الشخصي',

      // General
      'appTitle': 'نوتري ژام',
      'recipes': 'الوصفات',
      'searchPlaceholder': 'ابحث عن وصفات أو مكونات...',
      'all': 'الكل',
      'recipesFound': 'وصفة تم العثور عليها',
      'recipeFound': 'وصفات تم العثور عليها',
      'noRecipesFound': 'لم يتم العثور على وصفات',
      'tryDifferentSearch': 'جرب بحثًا مختلفًا أو مرشحًا آخر',
      'noFavorites': 'لا توجد مفضلات حتى الآن',
      'tapToSave': 'انقر على أيقونة + لحفظ الوصفات',

      // Categories
      'breakfast': 'الفطور',
      'lunch': 'الغداء',
      'dinner': 'العشاء',
      'snack': 'وجبة خفيفة',
      'bulking': 'زيادة الوزن',
      'cutting': 'إنقاص الوزن',

      // Nutrition
      'nutritionalInfo': 'المعلومات الغذائية',
      'calories': 'السعرات الحرارية',
      'protein': 'البروتين',
      'carbs': 'الكربوهيدرات',
      'fats': 'الدهون',

      // Recipe
      'ingredients': 'المكونات',
      'preparationSteps': 'خطوات التحضير',
      'rating': 'التقييم',
      'ratings': 'التقييمات',
      'rateThisMeal': 'قيم هذه الوجبة',
      'yourRating': 'تقييمك',
      'submitRating': 'إرسال التقييم',

      // Settings
      'settings': 'الإعدادات',
      'language': 'اللغة',
      'darkMode': 'الوضع المظلم',
      'english': 'English',
      'kurdish': 'کوردی',
      'arabic': 'العربية',
      'editAccount': 'تعديل الحساب',
      'deleteAccount': 'حذف الحساب',
      'areYouSure': 'هل أنت متأكد؟',
      'cancel': 'إلغاء',
      'delete': 'حذف',
      'save': 'حفظ',
      'update': 'تحديث',

      // Profile
      'appfeture': 'مميزات التطبيق',
      'myProfile': 'ملفي الشخصي',
      'favorites': 'المفضلات',
      'accountSettings': 'إعدادات الحساب',
      'memberSince': 'عضو منذ',

      // Planner
      'mealPlanner': 'مخطط الوجبات',
      'emptyplan': ' بلا الخطة',
      'dailyPlan': 'الخطة اليومية',
      'weeklyPlan': 'الخطة الأسبوعية',
      'recommendedMeals': 'الوجبات الموصى بها',
      'basedOnYourGoals': 'بناءً على أهدافك الرياضية',
      'totalCalories': 'إجمالي السعرات الحرارية',
      'todaysMeals': 'وجبات اليوم',
      'addToPlan': 'إضافة إلى الخطة',
      'removeFromPlan': 'إزالة من الخطة',

      // Messages
      'passwordsDoNotMatch': 'كلمات المرور غير متطابقة',
      'success': 'نجاح',
      'error': 'خطأ',
      'loading': 'جاري التحميل',
      'pleaseWait': 'يرجى الانتظار...',
      'accountDeleted': 'تم حذف الحساب بنجاح',
      'accountUpdated': 'تم تحديث الحساب بنجاح',
      'loginSuccess': 'تم تسجيل الدخول بنجاح',
      'registerSuccess': 'تم التسجيل بنجاح',
    },
  };
}

// Get content based on language
List<Map<String, dynamic>> getFeatures(dynamic languageCode) {
  switch (languageCode) {
    case 'ku':
      return [
        {
          'title': 'زانیاری خۆراکی',
          'description':
              'کالۆری و مایکرۆ (پڕۆتین، کاربۆهایدرات، چەوری) بۆ هەر ڕێچەتەیەک',
          'icon': Icons.local_fire_department,
          'color': AppColors.caloriesColor,
        },
        {
          'title': 'پلانی ژەم',
          'description':
              'ڕێچەتەکان کۆبکەرەوە و پلانی ڕۆژانە یان هەفتانە دروست بکە',
          'icon': Icons.calendar_today,
          'color': AppColors.primaryGreen,
        },
        {
          'title': 'ڕێچەتە دڵخوازەکان',
          'description': 'ڕێچەتە دڵخوازەکانت پاشەکەوت بکە بۆ بینینی دواتر',
          'icon': Icons.favorite,
          'color': AppColors.accentRed,
        },
        {
          'title': 'گەڕانێکی باش',
          'description': 'بە ناو یان پێکهاتەوە ڕێچەتە بدۆزەرەوە',
          'icon': Icons.search,
          'color': AppColors.accentBlue,
        },
        {
          'title': 'سەرجەم جۆرە خواردنەکان',
          'description': 'تایبەتمەندی بۆ جیاکردنەوەی خواردنە جیاوازەکان ',
          'icon': Icons.category,
          'color': AppColors.accentPurple,
        },
        {
          'title': 'سێ زمان',
          'description': 'ئینگلیزی، کوردی، عەرەبی',
          'icon': Icons.language,
          'color': AppColors.accentOrange,
        },
        {
          'title': 'دۆخی تاریک',
          'description': 'بەکارهێنانی ئەپ لە دۆخی تاریک یان ڕووناک',
          'icon': Icons.dark_mode,
          'color': AppColors.darkText,
        },
        {
          'title': 'ڕێژەدان',
          'description': 'ڕێچەتەکان هەڵبسەنگێنە و ڕێژە بدە',
          'icon': Icons.star,
          'color': AppColors.starActive,
        },
        {
          'title': 'پێکهاتە و هەنگاوەکان',
          'description': 'وێنەی پێکهاتەکان و هەنگاوەکانی ئامادەکردن',
          'icon': Icons.list,
          'color': AppColors.success,
        },
        {
          'title': 'تایبەتمەندی پڕۆفایل',
          'description': 'بینینی ئامارەکان و ڕێکخستنەکان',
          'icon': Icons.person,
          'color': AppColors.primaryGreen,
        },
      ];
    case 'ar':
      return [
        {
          'title': 'المعلومات الغذائية',
          'description':
              'السعرات الحرارية والماكرو (بروتين، كربوهيدرات، دهون) لكل وصفة',
          'icon': Icons.local_fire_department,
          'color': AppColors.caloriesColor,
        },
        {
          'title': 'مخطط الوجبات',
          'description': 'اجمع الوصفات وأنشئ خطط يومية أو أسبوعية',
          'icon': Icons.calendar_today,
          'color': AppColors.primaryGreen,
        },
        {
          'title': 'الوصفات المفضلة',
          'description': 'احفظ وصفاتك المفضلة لعرضها لاحقًا',
          'icon': Icons.favorite,
          'color': AppColors.accentRed,
        },
        {
          'title': 'بحث متقدم',
          'description': 'ابحث عن الوصفات بالاسم أو المكونات',
          'icon': Icons.search,
          'color': AppColors.accentBlue,
        },
        {
          'title': 'جميع الفئات',
          'description': 'ميزات لفئات مختلفة (زيادة الوزن، فقدان الوزن)',
          'icon': Icons.category,
          'color': AppColors.accentPurple,
        },
        {
          'title': 'ثلاث لغات',
          'description': 'الإنجليزية، الكردية، العربية',
          'icon': Icons.language,
          'color': AppColors.accentOrange,
        },
        {
          'title': 'الوضع المظلم',
          'description': 'استخدم التطبيق في الوضع المظلم أو الفاتح',
          'icon': Icons.dark_mode,
          'color': AppColors.darkText,
        },
        {
          'title': 'التقييم',
          'description': 'قيم الوصفات وأعط تقييمات',
          'icon': Icons.star,
          'color': AppColors.starActive,
        },
        {
          'title': 'المكونات والخطوات',
          'description': 'عرض المكونات وخطوات التحضير',
          'icon': Icons.list,
          'color': AppColors.success,
        },
        {
          'title': 'ميزات الملف الشخصي',
          'description': 'عرض الإحصائيات والإعدادات',
          'icon': Icons.person,
          'color': AppColors.primaryGreen,
        },
      ];
    default: // English
      return [
        {
          'title': 'Nutritional Information',
          'description':
              'Calories and macros (protein, carbs, fats) for each recipe',
          'icon': Icons.local_fire_department,
          'color': AppColors.caloriesColor,
        },
        {
          'title': 'Meal Planner',
          'description': 'Collect recipes and create daily or weekly plans',
          'icon': Icons.calendar_today,
          'color': AppColors.primaryGreen,
        },
        {
          'title': 'Favorite Recipes',
          'description': 'Save your favorite recipes to view later',
          'icon': Icons.favorite,
          'color': AppColors.accentRed,
        },
        {
          'title': 'Smart Search',
          'description': 'Search recipes by name or ingredients',
          'icon': Icons.search,
          'color': AppColors.accentBlue,
        },
        {
          'title': 'All Categories',
          'description': 'Features for different categories (bulking, cutting)',
          'icon': Icons.category,
          'color': AppColors.accentPurple,
        },
        {
          'title': 'Three Languages',
          'description': 'English, Kurdish, Arabic',
          'icon': Icons.language,
          'color': AppColors.accentOrange,
        },
        {
          'title': 'Dark Mode',
          'description': 'Use app in dark or light mode',
          'icon': Icons.dark_mode,
          'color': AppColors.darkText,
        },
        {
          'title': 'Rating System',
          'description': 'Rate recipes and give feedback',
          'icon': Icons.star,
          'color': AppColors.starActive,
        },
        {
          'title': 'Ingredients & Steps',
          'description': 'View ingredients and preparation steps',
          'icon': Icons.list,
          'color': AppColors.success,
        },
        {
          'title': 'Profile Features',
          'description': 'View statistics and settings',
          'icon': Icons.person,
          'color': AppColors.primaryGreen,
        },
      ];
  }
}
