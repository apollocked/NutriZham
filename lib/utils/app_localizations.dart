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

  // Change Password
  String get changePassword => _get('changePassword');
  String get currentPassword => _get('currentPassword');
  String get newPassword => _get('newPassword');
  String get enterCurrentPassword => _get('enterCurrentPassword');
  String get enterNewPassword => _get('enterNewPassword');
  String get confirmNewPassword => _get('confirmNewPassword');
  String get currentPasswordRequired => _get('currentPasswordRequired');
  String get newPasswordRequired => _get('newPasswordRequired');
  String get passwordTooShort => _get('passwordTooShort');
  String get confirmPasswordRequired => _get('confirmPasswordRequired');
  String get passwordsDoNotMatch => _get('passwordsDoNotMatch');
  String get verifyPassword => _get('verifyPassword');
  String get validating => _get('validating');
  String get passwordVerified => _get('passwordVerified');
  String get wrongPassword => _get('wrongPassword');
  String get pleaseVerifyCurrentPassword => _get('pleaseVerifyCurrentPassword');
  String get updatePassword => _get('updatePassword');
  String get passwordInfoMessage => _get('passwordInfoMessage');
  String get pleaseFillAllFields => _get('pleaseFillAllFields');
  String get errorUpdatingPassword => _get('errorUpdatingPassword');

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

      // Change Password
      'changePassword': 'Change Password',
      'currentPassword': 'Current Password',
      'newPassword': 'New Password',
      'enterCurrentPassword': 'Enter current password',
      'enterNewPassword': 'Enter new password',
      'confirmNewPassword': 'Confirm new password',
      'currentPasswordRequired': 'Current password is required',
      'newPasswordRequired': 'New password is required',
      'passwordTooShort': 'Password must be 6 characters',
      'confirmPasswordRequired': 'Please confirm your password',
      'passwordsDoNotMatch': 'Passwords do not match',
      'verifyPassword': 'Verify Password',
      'validating': 'Validating...',
      'passwordVerified': 'Password verified',
      'wrongPassword': 'Wrong password',
      'pleaseVerifyCurrentPassword': 'Please verify current password first',
      'updatePassword': 'Update Password',
      'passwordInfoMessage':
          'Please enter your current password and your new password. Your new password must be 6 characters.',
      'pleaseFillAllFields': 'Please fill in all required fields',
      'errorUpdatingPassword': 'Error updating password',

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

      // Change Password
      'changePassword': 'گۆڕینی وشەی نهێنی',
      'currentPassword': 'وشەی نهێنی ئێستا',
      'newPassword': 'وشەی نهێنی نوێ',
      'enterCurrentPassword': 'وشەی نهێنی ئێستات بنووسە',
      'enterNewPassword': 'وشەی نهێنی نوێ بنووسە',
      'confirmNewPassword': 'وشەی نهێنی نوێ دڵنیا بکەرەوە',
      'currentPasswordRequired': 'وشەی نهێنی ئێستا پێویستە',
      'newPasswordRequired': 'وشەی نهێنی نوێ پێویستە',
      'passwordTooShort': 'وشەی نهێنی دەبێت ٦ پیت بێت',
      'confirmPasswordRequired': 'تکایە وشەی نهێنیەکەت دڵنیا بکەرەوە',
      'passwordsDoNotMatch': 'وشەکانی نهێنی یەکناگرنەوە',
      'verifyPassword': 'پشتڕاستکردنەوەی وشەی نهێنی',
      'validating': 'پشتڕاستکردنەوە...',
      'passwordVerified': 'وشەی نهێنی پشتڕاستکرایەوە',
      'wrongPassword': 'وشەی نهێنی هەڵەیە',
      'pleaseVerifyCurrentPassword':
          'تکایە سەرەتا وشەی نهێنی ئێستا پشتڕاست بکەرەوە',
      'updatePassword': 'گۆڕینی وشەی نهێنی',
      'passwordInfoMessage':
          'تکایە وشەی نهێنی ئێستا و وشەی نهێنی نوێ بنووسە. وشەی نهێنی نوێ دەبێت ٦ پیت بێت.',
      'pleaseFillAllFields': 'تکایە هەموو خانە پێویستەکان پڕبکەرەوە',
      'errorUpdatingPassword': 'هەڵە لە نوێکردنەوەی وشەی نهێنی',

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
      'tryDifferentSearch': 'گەڕانێکی جیاواز تاقی بکەرەوە',
      'noFavorites': 'هێشتا هیچ دڵخوازێک نییە',
      'tapToSave': 'دوگمەی + دابگرە لەسەر ڕێچەتەکان بۆ پاشەکەوتکردنیان',

      // Categories
      'breakfast': 'نانی بەیانی',
      'lunch': 'نانی نیوەڕۆ',
      'dinner': 'نانی ئێوارە',
      'snack': 'خواردنەوەی سووک',
      'bulking': 'زیادکردنی کێش',
      'cutting': 'کەمکردنەوەی کێش',

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
      'rateThisMeal': 'هەڵسەنگاندنی ئەم خواردنە',
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
      'appfeture': 'تایبەتمەندییەکانی ئەپ',
      'myProfile': 'پڕۆفایلی من',
      'favorites': 'دڵخوازەکان',
      'accountSettings': 'ڕێکخستنەکانی هەژمار',
      'memberSince': 'ئەندام لە',

      // Planner
      'mealPlanner': 'پلانی ژەم',
      'emptyplan': 'پلانی ڕۆژانەت بەتاڵە',
      'dailyPlan': 'پلانی ڕۆژانە',
      'weeklyPlan': 'پلانی هەفتانە',
      'recommendedMeals': 'خواردنە پێشنیارکراوەکان',
      'basedOnYourGoals': 'لەسەر بنەمای ئامانجەکانی وەرزشت',
      'totalCalories': 'کۆی کالۆری',
      'todaysMeals': 'خواردنەکانی ئەمڕۆ',
      'addToPlan': 'زیادکردن بۆ پلان',
      'removeFromPlan': 'لابردن لە پلان',

      // Messages
      'success': 'سەرکەوتوو',
      'error': 'هەڵە',
      'loading': 'بارکردن',
      'pleaseWait': 'تکایە چاوەڕێبە...',
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

      // Change Password
      'changePassword': 'تغيير كلمة المرور',
      'currentPassword': 'كلمة المرور الحالية',
      'newPassword': 'كلمة المرور الجديدة',
      'enterCurrentPassword': 'أدخل كلمة المرور الحالية',
      'enterNewPassword': 'أدخل كلمة المرور الجديدة',
      'confirmNewPassword': 'تأكيد كلمة المرور الجديدة',
      'currentPasswordRequired': 'كلمة المرور الحالية مطلوبة',
      'newPasswordRequired': 'كلمة المرور الجديدة مطلوبة',
      'passwordTooShort': 'يجب أن تكون كلمة المرور 6 أحرف',
      'confirmPasswordRequired': 'يرجى تأكيد كلمة المرور',
      'passwordsDoNotMatch': 'كلمات المرور غير متطابقة',
      'verifyPassword': 'تحقق من كلمة المرور',
      'validating': 'جاري التحقق...',
      'passwordVerified': 'تم التحقق من كلمة المرور',
      'wrongPassword': 'كلمة مرور خاطئة',
      'pleaseVerifyCurrentPassword': 'يرجى التحقق من كلمة المرور الحالية أولاً',
      'updatePassword': 'تحديث كلمة المرور',
      'passwordInfoMessage':
          'يرجى إدخال كلمة المرور الحالية وكلمة المرور الجديدة. يجب أن تكون كلمة المرور الجديدة 6 أحرف.',
      'pleaseFillAllFields': 'يرجى ملء جميع الحقول المطلوبة',
      'errorUpdatingPassword': 'خطأ في تحديث كلمة المرور',

      // Navigation
      'home': 'الرئيسية',
      'search': 'البحث',
      'planner': 'المخطط',
      'profile': 'الملف الشخصي',

      // General
      'appTitle': 'نوتري ژەم',
      'recipes': 'الوصفات',
      'searchPlaceholder': 'ابحث عن الوصفات أو المكونات...',
      'all': 'الكل',
      'recipesFound': 'وصفات موجودة',
      'recipeFound': 'وصفة موجودة',
      'noRecipesFound': 'لم يتم العثور على وصفات',
      'tryDifferentSearch': 'جرب بحثًا أو فلترًا مختلفًا',
      'noFavorites': 'لا توجد مفضلات بعد',
      'tapToSave': 'اضغط على أيقونة + على الوصفات لحفظها',

      // Categories
      'breakfast': 'الإفطار',
      'lunch': 'الغداء',
      'dinner': 'العشاء',
      'snack': 'وجبة خفيفة',
      'bulking': 'زيادة الوزن',
      'cutting': 'فقدان الوزن',

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
      'emptyplan': 'خطتك اليومية فارغة',
      'dailyPlan': 'الخطة اليومية',
      'weeklyPlan': 'الخطة الأسبوعية',
      'recommendedMeals': 'الوجبات الموصى بها',
      'basedOnYourGoals': 'بناءً على أهدافك الرياضية',
      'totalCalories': 'إجمالي السعرات الحرارية',
      'todaysMeals': 'وجبات اليوم',
      'addToPlan': 'إضافة إلى الخطة',
      'removeFromPlan': 'إزالة من الخطة',

      // Messages
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
          'color': AppColors.primaryGreen,
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
