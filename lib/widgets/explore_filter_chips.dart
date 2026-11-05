import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

class ExploreFilterChips extends StatelessWidget {
  final String? selectedCuisine;
  final String? selectedPrice;
  final bool isWithin3Km;
  final VoidCallback? onCuisineTap;
  final VoidCallback? onPriceTap;
  final VoidCallback? onDistanceToggle;

  const ExploreFilterChips({
    super.key,
    this.selectedCuisine,
    this.selectedPrice,
    this.isWithin3Km = true,
    this.onCuisineTap,
    this.onPriceTap,
    this.onDistanceToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          // 1. Cuisine chip
          _buildChip(
            label: selectedCuisine != null ? 'Cuisine: $selectedCuisine' : 'Cuisine',
            hasDropdown: true,
            isActive: selectedCuisine != null,
            onTap: onCuisineTap,
          ),
          const SizedBox(width: 8),

          // 2. Price chip
          _buildChip(
            label: selectedPrice != null ? 'Price: $selectedPrice' : '₹ Price',
            hasDropdown: true,
            isActive: selectedPrice != null,
            onTap: onPriceTap,
          ),
          const SizedBox(width: 8),

          // 3. Within 3 km chip (terracotta filled pill as in screenshot)
          _buildFilledChip(
            label: 'Within 3 km',
            isActive: isWithin3Km,
            onTap: onDistanceToggle,
          ),
        ],
      ),
    );
  }

  Widget _buildChip({
    required String label,
    required bool hasDropdown,
    required bool isActive,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: isActive ? ThekaaColors.cardBackground : ThekaaColors.cardBackground.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive ? ThekaaColors.terracotta : ThekaaColors.border,
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
                color: isActive ? ThekaaColors.terracotta : ThekaaColors.primaryText,
              ),
            ),
            if (hasDropdown) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 14,
                color: isActive ? ThekaaColors.terracotta : ThekaaColors.secondaryText,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFilledChip({
    required String label,
    required bool isActive,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isActive ? ThekaaColors.terracotta : ThekaaColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive ? ThekaaColors.terracotta : ThekaaColors.border,
            width: 1.0,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : ThekaaColors.primaryText,
          ),
        ),
      ),
    );
  }
}

