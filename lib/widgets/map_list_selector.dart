import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

enum ExploreViewMode { map, list }

class MapListSelector extends StatelessWidget {
  final String location;
  final ExploreViewMode currentMode;
  final ValueChanged<ExploreViewMode> onModeChanged;

  const MapListSelector({
    super.key,
    this.location = 'Gachibowli',
    required this.currentMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Location text
        Text(
          'Around $location',
          style: ThekaaTypography.exploreLocationLabel,
        ),

        // Segmented Control
        Container(
          padding: const EdgeInsets.all(2.5),
          decoration: BoxDecoration(
            color: ThekaaColors.border.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSegment(
                label: 'Map',
                mode: ExploreViewMode.map,
                isActive: currentMode == ExploreViewMode.map,
              ),
              _buildSegment(
                label: 'List',
                mode: ExploreViewMode.list,
                isActive: currentMode == ExploreViewMode.list,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSegment({
    required String label,
    required ExploreViewMode mode,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () => onModeChanged(mode),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          color: isActive ? ThekaaColors.cardBackground : Colors.transparent,
          borderRadius: BorderRadius.circular(11),
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
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            color: isActive ? ThekaaColors.primaryText : ThekaaColors.secondaryText,
          ),
        ),
      ),
    );
  }
}

