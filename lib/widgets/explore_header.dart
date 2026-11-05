import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class ExploreHeader extends StatelessWidget {
  final VoidCallback? onLocationTap;

  const ExploreHeader({
    super.key,
    this.onLocationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Eyebrow
        Text(
          '01 / FOOD DISCOVERY & ORDERING',
          style: ThekaaTypography.eyebrow,
        ),
        const SizedBox(height: 6),

        // Title and Location Badge Icon
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Explore Hyderabad',
              style: ThekaaTypography.sectionHeading.copyWith(
                fontSize: 26,
                letterSpacing: 0.5,
              ),
            ),
            GestureDetector(
              onTap: onLocationTap,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ThekaaColors.terracotta.withValues(alpha: 0.45),
                    width: 1.0,
                  ),
                ),
                child: const Icon(
                  Icons.shield_outlined,
                  size: 18,
                  color: ThekaaColors.terracotta,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

