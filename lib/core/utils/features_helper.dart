import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';

List<Map<String, dynamic>> getFeatures(String languageCode) {
  switch (languageCode) {
    case 'ku':
      return [
        {
          'title': 'زانیاری خۆراکی',
          'description': 'کالۆری و مایکرۆ (پڕۆتین، کاربۆهایدرات، چەوری) بۆ هەر ڕێچەتەیەک',
          'icon': Icons.local_fire_department,
          'color': AppColors.caloriesColor,
        },
        {
          'title': 'پلانی ژەم',
          'description': 'ڕێچەتەکان کۆبکەرەوە و پلانی ڕۆژانە یان هەفتانە دروست بکە',
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
          'description': 'تایبەتمەندی بۆ جیاکردنەوەی خواردنە جیاوازەکان',
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
          'description': 'السعرات الحرارية والماكرو (بروتين، كربوهيدرات، دهون) لكل وصفة',
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
    default:
      return [
        {
          'title': 'Nutritional Information',
          'description': 'Calories and macros (protein, carbs, fats) for each recipe',
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
