import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class NearbyHiddenGemsSection extends StatelessWidget {
  final List<Restaurant> gems;
  final VoidCallback? onViewAllTap;
  final ValueChanged<Restaurant>? onGemTap;

  const NearbyHiddenGemsSection({
    super.key,
    required this.gems,
    this.onViewAllTap,
    this.onGemTap,
  });

  @override
  Widget build(BuildContext context) {
    if (gems.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Nearby hidden gems',
              style: ThekaaTypography.sectionHeading.copyWith(fontSize: 19),
            ),
            GestureDetector(
              onTap: onViewAllTap,
              child: Text(
                'View all',
                style: ThekaaTypography.sectionAction.copyWith(fontSize: 12.5),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Food Gem Cards
        ...gems.map((gem) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () => onGemTap?.call(gem),
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
                    children: [
                      // Photo
                      SizedBox(
                        height: 95,
                        width: double.infinity,
                        child: Image.asset(
                          gem.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: ThekaaColors.border.withValues(alpha: 0.3),
                              child: const Center(
                                child: Icon(Icons.restaurant, color: ThekaaColors.secondaryText),
                              ),
                            );
                          },
                        ),
                      ),
                      // Details
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  gem.name,
                                  style: ThekaaTypography.restaurantName.copyWith(fontSize: 15),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${gem.distance} · ${gem.cuisine}',
                                  style: ThekaaTypography.deliveryInfo.copyWith(fontSize: 11),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_outline_rounded,
                                  size: 14,
                                  color: ThekaaColors.terracotta,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  gem.rating.toString(),
                                  style: ThekaaTypography.ratingText.copyWith(fontSize: 12),
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
            ),
          );
        }),
      ],
    );
  }
}

