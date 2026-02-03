import 'package:flutter/material.dart';
import 'package:nutrizham/utils/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final String searchQuery;
  final Function(String) onChanged;
  final VoidCallback? onClear;
  final bool isDarkMode;
  final TextEditingController? controller;

  const CustomSearchBar({
    super.key,
    required this.hintText,
    required this.searchQuery,
    required this.onChanged,
    required this.isDarkMode,
    this.onClear,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isDarkMode ? AppColors.darkText : AppColors.lightText;

    return TextField(
      controller: controller,
      style: TextStyle(color: textColor),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: isDarkMode
              ? AppColors.darkTextSecondary
              : AppColors.lightTextSecondary,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: isDarkMode
              ? AppColors.darkTextSecondary
              : AppColors.lightTextSecondary,
        ),
        suffixIcon: searchQuery.isNotEmpty && onClear != null
            ? IconButton(
                icon: Icon(
                  Icons.clear,
                  color: isDarkMode
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
                onPressed: onClear,
              )
            : null,
        filled: true,
        fillColor: isDarkMode ? AppColors.darkCard : Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
