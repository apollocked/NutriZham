import 'package:flutter/material.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:nutrizham/widgets/custom_app_bar.dart';

class AppFeaturesPage extends StatelessWidget {
  final bool isDarkMode;
  final String languageCode;

  const AppFeaturesPage({
    super.key,
    required this.isDarkMode,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(languageCode);
    final bgColor =
        isDarkMode ? AppColors.darkBackground : AppColors.lightBackground;
    final textColor = isDarkMode ? AppColors.darkText : AppColors.lightText;
    final secondaryTextColor =
        isDarkMode ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final cardColor = isDarkMode ? AppColors.darkCard : Colors.white;

    final features = getFeatures(languageCode);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar(
        title: languageCode == 'ku'
            ? 'تایبەتمەندییەکانی ئەپ'
            : languageCode == 'ar'
                ? 'مميزات التطبيق'
                : 'App Features',
        isDarkMode: isDarkMode,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primaryGreen.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.restaurant_menu,
                      color: AppColors.primaryGreen,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NutriZham',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          languageCode == 'ku'
                              ? ' ئەپلیکەیشنی خۆراک ئامادەکردن'
                              : languageCode == 'ar'
                                  ? 'تطبيق التغذية '
                                  : ' Recipes App',
                          style: TextStyle(
                            color: secondaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'v2.0.0',
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Features Grid
            Text(
              languageCode == 'ku'
                  ? 'هەموو تایبەتمەندییەکان'
                  : languageCode == 'ar'
                      ? 'جميع المميزات'
                      : 'All Features',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),

            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemCount: features.length,
              itemBuilder: (context, index) {
                final feature = features[index];
                return Container(
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDarkMode
                          ? AppColors.darkDivider
                          : AppColors.lightDivider,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: feature['color'].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            feature['icon'],
                            color: feature['color'],
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          feature['title'],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            feature['description'],
                            style: TextStyle(
                              fontSize: 12,
                              color: secondaryTextColor,
                              height: 1.4,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Development Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDarkMode
                      ? AppColors.darkDivider
                      : AppColors.lightDivider,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.developer_mode,
                        color: AppColors.primaryGreen,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        languageCode == 'ku'
                            ? 'گەشەپێدەران'
                            : languageCode == 'ar'
                                ? 'المطورون'
                                : 'Developed By',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    languageCode == 'ku'
                        ? 'ئەم ئەپە بە هۆکاری فێربوونی Flutter و Firebase دروست کراوە. کۆدەکە کراوەیە و دەتوانیت بیبینیت.'
                        : languageCode == 'ar'
                            ? 'تم تطوير هذا التطبيق لأغراض تعلم Flutter و Firebase. الكود مفتوح المصدر ويمكنك الاطلاع عليه.'
                            : 'This app was developed for Flutter and Firebase learning purposes. The code is open source and you can view it.',
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.code,
                        color: AppColors.accentBlue,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Flutter • Firebase • Dart',
                        style: TextStyle(
                          color: secondaryTextColor,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Contact Support
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDarkMode
                      ? AppColors.darkDivider
                      : AppColors.lightDivider,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.support_agent,
                        color: AppColors.accentOrange,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        languageCode == 'ku'
                            ? 'یارمەتی و پشتگیری'
                            : languageCode == 'ar'
                                ? 'المساعدة والدعم'
                                : 'Help & Support',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    languageCode == 'ku'
                        ? 'ئەگەر کێشەیەک یان پرسیارێکت هەیە، تکایە پەیوەندیمان پێوە بکە:'
                        : languageCode == 'ar'
                            ? 'إذا كان لديك أي مشكلة أو سؤال، يرجى الاتصال بنا:'
                            : 'If you have any issues or questions, please contact us:',
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: AppColors.primaryGreen,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'support@nutrizham.com',
                        style: TextStyle(
                          color: AppColors.primaryGreen,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
