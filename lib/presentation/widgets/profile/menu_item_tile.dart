import 'package:flutter/material.dart';
import 'package:nutrizham/presentation/widgets/common/gradient_icon.dart';
import 'package:nutrizham/presentation/widgets/common/scale_tap.dart';

class MenuItemTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;
  final bool showTrailing;

  const MenuItemTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.iconColor,
    this.textColor,
    this.showTrailing = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final c = textColor ?? theme.colorScheme.onSurface;
    final ic = iconColor ?? theme.colorScheme.primary;

    return ScaleTap(
      child: Material(
        color: Colors.transparent,
        child: ListTile(
        leading: GradientIcon(icon: icon, color: ic),
        title: Text(title,
            style: TextStyle(
                color: c, fontWeight: FontWeight.w600, fontSize: 15)),
        subtitle: subtitle != null
            ? Text(subtitle!, style: theme.textTheme.bodySmall)
            : null,
        trailing: showTrailing
            ? Icon(Icons.chevron_right_rounded,
                size: 22, color: c.withValues(alpha: 0.4))
            : null,
        onTap: onTap,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      ),
      ),
    );
  }
}
