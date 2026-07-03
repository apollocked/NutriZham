import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/settings_provider.dart';
import 'package:nutrizham/core/utils/features_helper.dart';
import 'package:nutrizham/widgets/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

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
    final langCode = context.watch<SettingsProvider>().languageCode;
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
                child: const Icon(Icons.restaurant_menu_rounded, color: Color(0xFF10B981), size: 32)),
              const SizedBox(width: 16),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('NutriZham', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: theme.colorScheme.onSurface)),
                const SizedBox(height: 4),
                Text(loc.recipesApp, style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 14)),
                const SizedBox(height: 4),
                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
                  child: Text('${loc.version} v2.0.0', style: const TextStyle(color: Color(0xFF10B981), fontSize: 11, fontWeight: FontWeight.w600)),
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
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: theme.cardColor, borderRadius: BorderRadius.circular(14), border: Border.all(color: theme.colorScheme.outline)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.developer_mode_rounded, color: Color(0xFF10B981), size: 20)),
                const SizedBox(width: 12),
                Text(loc.developedBy, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: theme.colorScheme.onSurface)),
              ]),
              const SizedBox(height: 16),
              Text(loc.descriptionFlutterFirebase, style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 14, height: 1.6)),
              const SizedBox(height: 16),
              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: const Color(0xFF3B82F6).withOpacity(0.08), borderRadius: BorderRadius.circular(8)),
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.code_rounded, color: Color(0xFF3B82F6), size: 16),
                  SizedBox(width: 8),
                  Text('Flutter • Firebase • Dart', style: TextStyle(color: Color(0xFF3B82F6), fontSize: 13, fontWeight: FontWeight.w500)),
                ])),
            ]),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: theme.cardColor, borderRadius: BorderRadius.circular(14), border: Border.all(color: theme.colorScheme.outline)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFFF59E0B).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.support_agent_rounded, color: Color(0xFFF59E0B), size: 20)),
                const SizedBox(width: 12),
                Text(loc.helpSupport, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: theme.colorScheme.onSurface)),
              ]),
              const SizedBox(height: 16),
              Text(loc.contactUs, style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 14, height: 1.5)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(10)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.email_rounded, color: Color(0xFF10B981), size: 18),
                  const SizedBox(width: 10),
                  InkWell(onTap: _sendEmail, child: const Text('hamabarznji1990@gmail.com', style: TextStyle(color: Color(0xFF10B981), fontSize: 14, fontWeight: FontWeight.w500, decoration: TextDecoration.underline))),
                ]),
              ),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity, padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [theme.colorScheme.primary.withOpacity(0.08), theme.colorScheme.secondary.withOpacity(0.04)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(14), border: Border.all(color: theme.colorScheme.primary.withOpacity(0.15)),
            ),
            child: Center(child: Text(loc.builtWith, style: const TextStyle(color: Color(0xFF10B981), fontSize: 14, fontWeight: FontWeight.w600))),
          ),
        ]),
      ),
    );
  }
}
