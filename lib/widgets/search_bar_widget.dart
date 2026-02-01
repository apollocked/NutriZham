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
      margin: const EdgeInsets.all(12),
      child: TextField(
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
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.primaryGreen,
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
      ),
    );
  }
}

class SearchBarWithFilter extends StatelessWidget {
  final String hintText;
  final String searchQuery;
  final Function(String) onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onFilterPressed;
  final bool isDarkMode;
  final bool hasActiveFilters;

  const SearchBarWithFilter({
    super.key,
    required this.hintText,
    required this.searchQuery,
    required this.onChanged,
    required this.isDarkMode,
    this.onClear,
    this.onFilterPressed,
    this.hasActiveFilters = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isDarkMode ? AppColors.darkText : AppColors.lightText;

    return Container(
      margin: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(color: textColor),
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: isDarkMode
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.primaryGreen,
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
            ),
          ),
          if (onFilterPressed != null) ...[
            const SizedBox(width: 8),
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: hasActiveFilters
                    ? AppColors.primaryGreen
                    : (isDarkMode ? AppColors.darkCard : Colors.grey[100]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.filter_list,
                  color: hasActiveFilters
                      ? Colors.white
                      : (isDarkMode
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary),
                ),
                onPressed: onFilterPressed,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
