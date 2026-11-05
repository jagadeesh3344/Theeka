import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class CartHeader extends StatelessWidget {
  final VoidCallback onBack;

  const CartHeader({
    super.key,
    required this.onBack,
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

        // Back Chevron & Heading
        Row(
          children: [
            GestureDetector(
              onTap: onBack,
              behavior: HitTestBehavior.opaque,
              child: const Padding(
                padding: EdgeInsets.only(right: 8, top: 4, bottom: 4),
                child: Icon(
                  Icons.chevron_left_rounded,
                  size: 26,
                  color: ThekaaColors.primaryText,
                ),
              ),
            ),
            Text(
              'Your dabba awaits',
              style: ThekaaTypography.sectionHeading.copyWith(
                fontSize: 24,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

