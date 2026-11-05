import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class CartRestaurantInfo extends StatelessWidget {
  final Restaurant restaurant;

  const CartRestaurantInfo({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Cutlery square icon container
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFFF3E7D3),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: ThekaaColors.border.withValues(alpha: 0.6),
              width: 0.8,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.restaurant,
              size: 18,
              color: ThekaaColors.terracotta,
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Restaurant Name & Locality/Delivery
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurant.name,
              style: ThekaaTypography.restaurantName.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '${restaurant.locality} · 24–28 min',
              style: ThekaaTypography.deliveryInfo.copyWith(
                fontSize: 11.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

