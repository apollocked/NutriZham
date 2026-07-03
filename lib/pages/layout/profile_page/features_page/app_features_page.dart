import 'package:flutter/material.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:nutrizham/widgets/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class AppFeaturesPage extends StatelessWidget {
  final bool isDarkMode;
  final String languageCode;

  const AppFeaturesPage({
    super.key,
    required this.isDarkMode,
    required this.languageCode,
  });
  Future<void> _sendEmail() async {
    const String subject = 'Support';
    const String body = 'Hello,\n\nI need help with...';

    // Use a string-based approach to ensure proper encoding
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'hamabarznji1990@gmail.com',
      query:
          'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch email app');
      // Optional: Show a SnackBar to the user saying "No email app found"
    }
  }

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
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryGreen.withOpacity(0.1),
                    AppColors.primaryGreenLight.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
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
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.restaurant_menu_rounded,
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
                            fontWeight: FontWeight.w700,
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
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primaryGreen.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'v2.0.0',
                            style: TextStyle(
                              color: AppColors.primaryGreen,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

              Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreen,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  languageCode == 'ku'
                      ? 'هەموو تایبەتمەندییەکان'
                      : languageCode == 'ar'
                          ? 'جميع المميزات'
                          : 'All Features',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
              ],
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
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isDarkMode
                          ? AppColors.darkDivider
                          : AppColors.lightDivider,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: feature['color'].withOpacity(0.06),
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
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: feature['color'].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
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
                            fontWeight: FontWeight.w700,
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
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(14),
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
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.developer_mode_rounded,
                          color: AppColors.primaryGreen,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        languageCode == 'ku'
                            ? 'گەشەپێدەران'
                            : languageCode == 'ar'
                                ? 'المطورون'
                                : 'Developed By',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    languageCode == 'ku'
                        ? 'ئەم ئەپە بە فڵەتەر و فایەربەیس دروست کراوە. کۆدەکە کراوەیە و دەتوانیت بیبینیت.'
                        : languageCode == 'ar'
                            ? 'تم تطوير هذا التطبيق لأغراض تعلم Flutter و Firebase. الكود مفتوح المصدر ويمكنك الاطلاع عليه.'
                            : 'This app was developed for Flutter and Firebase learning purposes. The code is open source and you can view it.',
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.accentBlue.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.code_rounded,
                          color: AppColors.accentBlue,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Flutter • Firebase • Dart',
                          style: TextStyle(
                            color: AppColors.accentBlue,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Contact Support
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(14),
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
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.accentOrange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.support_agent_rounded,
                          color: AppColors.accentOrange,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        languageCode == 'ku'
                            ? 'یارمەتی و پشتگیری'
                            : languageCode == 'ar'
                                ? 'المساعدة والدعم'
                                : 'Help & Support',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    languageCode == 'ku'
                        ? 'ئەگەر کێشەیەک یان پرسیارێکت هەیە، تکایە پەیوەندیمان پێوە بکە:'
                        : languageCode == 'ar'
                            ? 'إذا كان لديك أي مشكلة أو سؤال، يرجى الاتصال بنا:'
                            : 'If you have any issues or questions, please contact us:',
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.email_rounded,
                          color: AppColors.primaryGreen,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: _sendEmail,
                          child: const Text(
                            'hamabarznji1990@gmail.com',
                            style: TextStyle(
                              color: AppColors.primaryGreen,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryGreen.withOpacity(0.08),
                    AppColors.primaryGreenLight.withOpacity(0.04),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppColors.primaryGreen.withOpacity(0.15),
                ),
              ),
              child: const Center(
                child: Text(
                  "Built with ❤️ in Kurdistan.",
                  style: TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
