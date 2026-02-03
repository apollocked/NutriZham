import 'package:flutter/material.dart';
import 'package:nutrizham/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isDarkMode;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.isDarkMode,
    this.actions,
    this.leading,
    this.centerTitle = false,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: isDarkMode ? AppColors.darkBackground : Colors.white,
      foregroundColor: isDarkMode ? AppColors.darkText : AppColors.lightText,
      elevation: 0,
      centerTitle: centerTitle,
      actions: actions,
      leading: leading,
      bottom: bottom,
      surfaceTintColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );
}
