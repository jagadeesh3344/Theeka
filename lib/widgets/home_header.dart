import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class HomeHeader extends StatelessWidget {
  final String location;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onLocationTap;

  const HomeHeader({
    super.key,
    this.location = 'Gachibowli',
    this.onNotificationTap,
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

        // Brand name & Notification bell
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'THEKAA',
              style: ThekaaTypography.brandTitle,
            ),
            GestureDetector(
              onTap: onNotificationTap,
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ThekaaColors.terracotta.withValues(alpha: 0.45),
                    width: 1.0,
                  ),
                ),
                child: const Icon(
                  Icons.notifications_none_outlined,
                  color: ThekaaColors.terracotta,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Tagline & Location Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'KHAANA. SAMJH KE.',
              style: ThekaaTypography.brandTagline,
            ),
            InkWell(
              onTap: onLocationTap,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.place_outlined,
                      size: 15,
                      color: ThekaaColors.terracotta,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      location,
                      style: ThekaaTypography.locationText,
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 16,
                      color: ThekaaColors.primaryText,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
