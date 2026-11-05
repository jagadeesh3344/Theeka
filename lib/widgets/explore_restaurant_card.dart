import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class ExploreRestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback? onTap;

  const ExploreRestaurantCard({
    super.key,
    required this.restaurant,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ThekaaColors.cardBackground,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: ThekaaColors.border,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Food Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 72,
                height: 72,
                child: Image.asset(
                  restaurant.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: ThekaaColors.border.withValues(alpha: 0.3),
                      child: const Center(
                        child: Icon(
                          Icons.restaurant,
                          color: ThekaaColors.secondaryText,
                          size: 28,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Right Info Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Restaurant Name
                  Text(
                    restaurant.name,
                    style: ThekaaTypography.restaurantName.copyWith(
                      fontSize: 16.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),

                  // Rating + Reviews count
                  Row(
                    children: [
                      const Icon(
                        Icons.star_outline_rounded,
                        size: 14.5,
                        color: ThekaaColors.terracotta,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        restaurant.rating.toString(),
                        style: ThekaaTypography.ratingText.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        ' · ${restaurant.reviewsCount}',
                        style: ThekaaTypography.deliveryInfo.copyWith(
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),

                  // Distance · Cuisine · Price
                  Text(
                    '${restaurant.distance} · ${restaurant.cuisine} · ${restaurant.priceRange}',
                    style: ThekaaTypography.deliveryInfo.copyWith(
                      fontSize: 11.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Verified badge
                  if (restaurant.isVerified)
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          size: 13,
                          color: ThekaaColors.verifiedGreen,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          restaurant.tag,
                          style: ThekaaTypography.verifiedText.copyWith(
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

