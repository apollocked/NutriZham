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

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGreen.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: textColor, fontSize: 15),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: isDarkMode
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
            fontSize: 15,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: isDarkMode
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
          suffixIcon: searchQuery.isNotEmpty && onClear != null
              ? IconButton(
                  icon: Icon(
                    Icons.clear_rounded,
                    color: isDarkMode
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                  onPressed: onClear,
                )
              : null,
          filled: true,
          fillColor: isDarkMode ? AppColors.darkCard : const Color(0xFFF3F4F6),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
