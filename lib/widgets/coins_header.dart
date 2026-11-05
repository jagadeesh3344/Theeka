import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class CoinsHeader extends StatelessWidget {
  final String restaurantName;
  final VoidCallback? onBack;

  const CoinsHeader({
    super.key,
    required this.restaurantName,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Eyebrow
        Text(
          '02 / CHECKOUT & PAYMENT',
          style: ThekaaTypography.eyebrow,
        ),
        const SizedBox(height: 8),

        // Back button + Main Heading
        Row(
          children: [
            GestureDetector(
              onTap: onBack,
              behavior: HitTestBehavior.opaque,
              child: const Padding(
                padding: EdgeInsets.only(right: 8.0, top: 2.0, bottom: 2.0),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: ThekaaColors.primaryText,
                ),
              ),
            ),
            Text(
              'A little give-back',
              style: ThekaaTypography.brandTitle.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Section B: Order Identification
        Text(
          'YOUR ORDER · ${restaurantName.toUpperCase()}',
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: ThekaaColors.terracotta,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}

