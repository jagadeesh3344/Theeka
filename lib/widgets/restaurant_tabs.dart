import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

enum RestaurantDetailTab { menu, reviews, about }

class RestaurantTabs extends StatelessWidget {
  final RestaurantDetailTab activeTab;
  final ValueChanged<RestaurantDetailTab> onTabChanged;

  const RestaurantTabs({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: ThekaaColors.border.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _buildTab(
            label: 'Menu',
            tab: RestaurantDetailTab.menu,
            isActive: activeTab == RestaurantDetailTab.menu,
          ),
          _buildTab(
            label: 'Reviews',
            tab: RestaurantDetailTab.reviews,
            isActive: activeTab == RestaurantDetailTab.reviews,
          ),
          _buildTab(
            label: 'About',
            tab: RestaurantDetailTab.about,
            isActive: activeTab == RestaurantDetailTab.about,
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String label,
    required RestaurantDetailTab tab,
    required bool isActive,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChanged(tab),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? ThekaaColors.cardBackground : Colors.transparent,
            borderRadius: BorderRadius.circular(13),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12.5,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? ThekaaColors.primaryText : ThekaaColors.secondaryText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

