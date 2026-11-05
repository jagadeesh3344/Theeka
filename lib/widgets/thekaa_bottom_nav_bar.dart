import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import 'dabba_icon.dart';

class ThekaaBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const ThekaaBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThekaaColors.cardBackground,
        border: const Border(
          top: BorderSide(
            color: ThekaaColors.border,
            width: 1.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Home
              _buildNavItem(
                index: 0,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
              ),

              // 2. Explore
              _buildNavItem(
                index: 1,
                icon: Icons.explore_outlined,
                activeIcon: Icons.explore,
                label: 'Explore',
              ),

              // 3. Central DABBA
              _buildDabbaItem(),

              // 4. Orders
              _buildNavItem(
                index: 3,
                icon: Icons.receipt_long_outlined,
                activeIcon: Icons.receipt_long,
                label: 'Orders',
              ),

              // 5. Profile
              _buildNavItem(
                index: 4,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isActive = currentIndex == index;
    final color = isActive ? ThekaaColors.terracotta : ThekaaColors.secondaryText;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        splashColor: ThekaaColors.terracotta.withValues(alpha: 0.08),
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              size: 23,
              color: color,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: isActive
                  ? ThekaaTypography.navLabelActive
                  : ThekaaTypography.navLabelInactive,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDabbaItem() {
    final isActive = currentIndex == 2;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(2),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular terracotta button
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: ThekaaColors.terracotta,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ThekaaColors.terracotta.withValues(alpha: 0.35),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: DabbaIcon(
                  size: 21,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'DABBA',
              style: ThekaaTypography.navLabelDabba.copyWith(
                color: isActive ? ThekaaColors.terracotta : ThekaaColors.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
