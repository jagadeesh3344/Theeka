import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback? onTap;

  const RestaurantCard({
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
        decoration: BoxDecoration(
          color: ThekaaColors.cardBackground,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: ThekaaColors.border,
            width: 1.0,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Food Photography Image
              SizedBox(
                height: 145,
                width: double.infinity,
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
                          size: 36,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Information Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Restaurant name and Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          restaurant.name,
                          style: ThekaaTypography.restaurantName,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_outline_rounded,
                              size: 16,
                              color: ThekaaColors.mutedBrown,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              restaurant.rating.toString(),
                              style: ThekaaTypography.ratingText,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Delivery details
                    Text(
                      restaurant.deliveryDetails,
                      style: ThekaaTypography.deliveryInfo,
                    ),
                    const SizedBox(height: 6),

                    // Verification badge
                    if (restaurant.isVerified)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            size: 14,
                            color: ThekaaColors.verifiedGreen,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'THEKAA verified',
                            style: ThekaaTypography.verifiedText,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
