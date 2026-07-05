import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';

List<Map<String, dynamic>> getFeatures(String languageCode) {
  final list = [
    (Icons.local_fire_department, AppColors.caloriesColor, 'Nutritional Information', 'Calories and macros (protein, carbs, fats) for each recipe',
        'زانیاری خۆراکی', 'کالۆری و مایکرۆ (پڕۆتین، کاربۆهایدرات، چەوری) بۆ هەر ڕێچەتەیەک',
        'المعلومات الغذائية', 'السعرات الحرارية والماكرو (بروتين، كربوهيدرات، دهون) لكل وصفة'),
    (Icons.calendar_today, AppColors.primaryGreen, 'Meal Planner', 'Collect recipes and create daily or weekly plans',
        'پلانی ژەم', 'ڕێچەتەکان کۆبکەرەوە و پلانی ڕۆژانە یان هەفتانە دروست بکە',
        'مخطط الوجبات', 'اجمع الوصفات وأنشئ خطط يومية أو أسبوعية'),
    (Icons.favorite, AppColors.accentRed, 'Favorite Recipes', 'Save your favorite recipes to view later',
        'ڕێچەتە دڵخوازەکان', 'ڕێچەتە دڵخوازەکانت پاشەکەوت بکە بۆ بینینی دواتر',
        'الوصفات المفضلة', 'احفظ وصفاتك المفضلة لعرضها لاحقًا'),
    (Icons.search, AppColors.accentBlue, 'Smart Search', 'Search recipes by name or ingredients',
        'گەڕانێکی باش', 'بە ناو یان پێکهاتەوە ڕێچەتە بدۆزەرەوە',
        'بحث متقدم', 'ابحث عن الوصفات بالاسم أو المكونات'),
    (Icons.category, AppColors.accentPurple, 'All Categories', 'Filter by diet goals (bulking, cutting)',
        'سەرجەم جۆرە خواردنەکان', 'پاڵاوتنی بەپێی ئامانجی خۆراکی',
        'جميع الفئات', 'تصفية حسب أهداف النظام الغذائي'),
    (Icons.sort_by_alpha_rounded, AppColors.accentOrange, 'A-Z Category Browse', 'Browse recipes alphabetically by category',
        'گەڕانی پۆل بە پیتی ئەلفوبێ', 'بەپێی پۆل و پیتی ئەلفوبێ ڕێچەتەکان ببینە',
        'تصفح الفئات أبجديًا', 'تصفح الوصفات أبجديًا حسب الفئة'),
    (Icons.language, AppColors.accentOrange, 'Three Languages', 'English, Kurdish, Arabic',
        'سێ زمان', 'ئینگلیزی، کوردی، عەرەبی',
        'ثلاث لغات', 'الإنجليزية، الكردية، العربية'),
    (Icons.dark_mode, AppColors.darkText, 'Dark Mode', 'Use app in dark or light mode',
        'دۆخی تاریک', 'بەکارهێنانی ئەپ لە دۆخی تاریک یان ڕووناک',
        'الوضع المظلم', 'استخدم التطبيق في الوضع المظلم أو الفاتح'),
    (Icons.star, AppColors.starActive, 'Rating System', 'Rate recipes and give feedback',
        'ڕێژەدان', 'ڕێچەتەکان هەڵبسەنگێنە و ڕێژە بدە',
        'التقييم', 'قيم الوصفات وأعط تقييمات'),
    (Icons.list, AppColors.success, 'Ingredients & Steps', 'View ingredients and preparation steps',
        'پێکهاتە و هەنگاوەکان', 'وێنەی پێکهاتەکان و هەنگاوەکانی ئامادەکردن',
        'المكونات والخطوات', 'عرض المكونات وخطوات التحضير'),
    (Icons.shopping_cart_rounded, AppColors.accentPurple, 'Grocery List', 'Auto-generated shopping list from your weekly meal plan',
        'لیستی کڕین', 'لیستی کڕینی خۆکار لە پلانی هەفتانەتەوە',
        'قائمة التسوق', 'قائمة تسوق تلقائية من خطة وجباتك الأسبوعية'),
    (Icons.track_changes_rounded, AppColors.primaryGreen, 'Nutrition Goals', 'Set daily targets for calories, protein, carbs, and fats',
        'ئامانجە خۆراکییەکان', 'دیاریکردنی ئامانجی ڕۆژانەی کالۆری، پڕۆتین، کاربۆهایدرات و چەوری',
        'الأهداف الغذائية', 'حدد أهدافًا يومية للسعرات والبروتين والكربوهيدرات والدهون'),
    (Icons.wifi_off_rounded, AppColors.accentRed, 'Offline Access', 'Browse saved recipes even without internet',
        'دەستگەیشتن بێ ئینتەرنێت', 'ڕێچەتە پاشەکەوتکراوەکان ببینە بێ ئینتەرنێت',
        'الوصول بدون إنترنت', 'تصفح الوصفات المحفوظة حتى بدون إنترنت'),
    (Icons.abc_rounded, AppColors.caloriesColor, 'Recipe of the Day', 'Featured recipe highlight on the home page',
        'ڕێچەتەی ڕۆژ', 'ڕێچەتەی تایبەت لە پەڕەی سەرەکی',
        'وصفة اليوم', 'وصفة مميزة في الصفحة الرئيسية'),
    (Icons.drag_handle_rounded, AppColors.accentBlue, 'Drag to Reorder', 'Reorder meals in your planner by dragging',
        'ڕێکخستن بە ڕاکێشان', 'ڕێچەتەکان لە پلانەکەتدا بە ڕاکێشان ڕێکبخە',
        'إعادة الترتيب بالسحب', 'أعد ترتيب الوجبات في مخططك عن طريق السحب'),
    (Icons.person, AppColors.primaryGreen, 'Profile Features', 'View statistics, settings, and manage your account',
        'تایبەتمەندی پڕۆفایل', 'بینینی ئامارەکان و ڕێکخستنەکان و بەڕێوەبردنی هەژمارەکەت',
        'ميزات الملف الشخصي', 'عرض الإحصائيات والإعدادات وإدارة حسابك'),
  ];

  final isKu = languageCode == 'ku';
  final isAr = languageCode == 'ar';
  return list.map((f) => {
    'title': isKu ? f.$5 : (isAr ? f.$7 : f.$3),
    'description': isKu ? f.$6 : (isAr ? f.$8 : f.$4),
    'icon': f.$1,
    'color': f.$2,
  }).toList();
}
