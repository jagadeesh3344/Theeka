import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class RestaurantInfoSection extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantInfoSection({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name and Rating Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              child: Text(
                restaurant.name,
                style: ThekaaTypography.sectionHeading.copyWith(
                  fontSize: 24,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star_outline_rounded,
                  size: 15,
                  color: ThekaaColors.terracotta,
                ),
                const SizedBox(width: 3),
                Text(
                  restaurant.rating.toString(),
                  style: ThekaaTypography.ratingText.copyWith(
                    fontSize: 13,
                  ),
                ),
                Text(
                  ' (${restaurant.reviewsCount})',
                  style: ThekaaTypography.deliveryInfo.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 5),

        // THEKAA verified badge
        if (restaurant.isVerified)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 13.5,
                color: ThekaaColors.verifiedGreen,
              ),
              const SizedBox(width: 4),
              Text(
                'THEKAA verified',
                style: ThekaaTypography.verifiedText.copyWith(
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
        const SizedBox(height: 5),

        // Locality and Delivery Details
        Text(
          restaurant.deliveryDetails,
          style: ThekaaTypography.deliveryInfo.copyWith(
            fontSize: 12.5,
          ),
        ),
      ],
    );
  }
}

