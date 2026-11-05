import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_typography.dart';
import 'restaurant_card.dart';

class HandpickedSection extends StatelessWidget {
  final VoidCallback? onSeeAllTap;
  final ValueChanged<Restaurant>? onRestaurantTap;

  const HandpickedSection({
    super.key,
    this.onSeeAllTap,
    this.onRestaurantTap,
  });

  @override
  Widget build(BuildContext context) {
    const primaryCard = Restaurant.shadabBiryani;
    const secondCard = Restaurant.chutneys;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Handpicked for you',
              style: ThekaaTypography.sectionHeading,
            ),
            GestureDetector(
              onTap: onSeeAllTap,
              child: Text(
                'See all',
                style: ThekaaTypography.sectionAction,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Primary Card (Shadab Biryani)
        RestaurantCard(
          restaurant: primaryCard,
          onTap: () => onRestaurantTap?.call(primaryCard),
        ),
        const SizedBox(height: 14),

        // Second Card peek (Dosa card - Chutneys)
        RestaurantCard(
          restaurant: secondCard,
          onTap: () => onRestaurantTap?.call(secondCard),
        ),
      ],
    );
  }
}
