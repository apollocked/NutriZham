import 'package:flutter/material.dart';
import 'package:nutrizham/utils/app_colors.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isDarkMode;

  const StatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: isDarkMode
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class MenuItemTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;
  final bool showTrailing;
  final bool isDarkMode;

  const MenuItemTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.isDarkMode,
    this.subtitle,
    this.iconColor,
    this.textColor,
    this.showTrailing = true,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTextColor =
        textColor ?? (isDarkMode ? AppColors.darkText : AppColors.lightText);
    final defaultIconColor = iconColor ?? AppColors.primaryGreen;

    return ListTile(
      leading: Icon(icon, color: defaultIconColor),
      title: Text(
        title,
        style: TextStyle(
          color: defaultTextColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            )
          : null,
      trailing: showTrailing
          ? Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: defaultTextColor.withOpacity(0.5),
            )
          : null,
      onTap: onTap,
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? color;
  final bool isDarkMode;
  final Widget? trailing;

  const InfoCard({
    super.key,
    required this.title,
    required this.isDarkMode,
    this.subtitle,
    this.icon,
    this.color,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isDarkMode ? AppColors.darkText : AppColors.lightText;
    final backgroundColor = color?.withOpacity(0.1) ??
        (isDarkMode ? AppColors.darkCard : Colors.white);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border:
            color != null ? Border.all(color: color!.withOpacity(0.3)) : null,
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: color ?? AppColors.primaryGreen,
              size: 32,
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
