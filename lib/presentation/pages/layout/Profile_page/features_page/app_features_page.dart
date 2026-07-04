import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/settings_cubit.dart';
import 'package:nutrizham/core/utils/features_helper.dart';
import 'package:nutrizham/presentation/widgets/common/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/widgets/profile/app_developer_section.dart';
import 'package:nutrizham/presentation/widgets/profile/app_support_section.dart';

class AppFeaturesPage extends StatelessWidget {
  const AppFeaturesPage({super.key});

  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'hamabarznji1990@gmail.com',
      query: 'subject=${Uri.encodeComponent('Support')}&body=${Uri.encodeComponent('Hello,\n\nI need help with...')}',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final langCode = context.watch<SettingsCubit>().state.languageCode;
    final features = getFeatures(langCode);

    return Scaffold(
      appBar: CustomAppBar(title: loc.appFeatures),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [theme.colorScheme.primary.withOpacity(0.1), theme.colorScheme.secondary.withOpacity(0.05)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(16), border: Border.all(color: theme.colorScheme.primary.withOpacity(0.3)),
            ),
            child: Row(children: [
              Container(width: 60, height: 60, decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(0.2), borderRadius: BorderRadius.circular(16)),
                child: Icon(Icons.restaurant_menu_rounded, color: theme.colorScheme.primary, size: 32)),
              const SizedBox(width: 16),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('NutriZham', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: theme.colorScheme.onSurface)),
                const SizedBox(height: 4),
                Text(loc.recipesApp, style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 14)),
                const SizedBox(height: 4),
                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
                  child: Text('${loc.version} v2.0.0', style: TextStyle(color: theme.colorScheme.primary, fontSize: 11, fontWeight: FontWeight.w600)),
                ),
              ])),
            ]),
          ),
          const SizedBox(height: 24),
          Row(children: [
            Container(width: 4, height: 20, decoration: BoxDecoration(color: theme.colorScheme.primary, borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 10),
            Text(loc.allFeatures, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: theme.colorScheme.onSurface)),
          ]),
          const SizedBox(height: 16),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.9),
            itemCount: features.length,
            itemBuilder: (context, index) {
              final feature = features[index];
              return Container(
                decoration: BoxDecoration(color: theme.cardColor, borderRadius: BorderRadius.circular(14), border: Border.all(color: theme.colorScheme.outline),
                  boxShadow: [BoxShadow(color: feature['color'].withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 2))]),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(width: 44, height: 44, decoration: BoxDecoration(color: feature['color'].withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                      child: Icon(feature['icon'], color: feature['color'], size: 24)),
                    const SizedBox(height: 12),
                    Text(feature['title'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: theme.colorScheme.onSurface), maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 8),
                    Expanded(child: Text(feature['description'], style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant, height: 1.4), maxLines: 3, overflow: TextOverflow.ellipsis)),
                  ]),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          const AppDeveloperSection(),
          const SizedBox(height: 24),
          AppSupportSection(onSendEmail: _sendEmail),
          const SizedBox(height: 16),
          Container(
            width: double.infinity, padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [theme.colorScheme.primary.withOpacity(0.08), theme.colorScheme.secondary.withOpacity(0.04)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(14), border: Border.all(color: theme.colorScheme.primary.withOpacity(0.15)),
            ),
            child: Center(child: Text(loc.builtWith, style: TextStyle(color: theme.colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w600))),
          ),
        ]),
      ),
    );
  }
}
