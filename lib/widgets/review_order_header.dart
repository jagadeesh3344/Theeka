import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class ReviewOrderHeader extends StatelessWidget {
  final VoidCallback? onBack;

  const ReviewOrderHeader({
    super.key,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Small eyebrow
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
            Expanded(
              child: Text(
                'Review your order',
                style: ThekaaTypography.brandTitle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Step breadcrumbs: REVIEW ➔ ADDRESS ➔ COINS ➔ PAY
        Row(
          children: [
            _buildStep('REVIEW', isActive: true),
            _buildSeparator(),
            _buildStep('ADDRESS', isActive: false),
            _buildSeparator(),
            _buildStep('COINS', isActive: false),
            _buildSeparator(),
            _buildStep('PAY', isActive: false),
          ],
        ),
      ],
    );
  }

  Widget _buildStep(String title, {required bool isActive}) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: 10.5,
        fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
        color: isActive ? ThekaaColors.terracotta : ThekaaColors.secondaryText,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Icon(
        Icons.arrow_forward_rounded,
        size: 11,
        color: ThekaaColors.terracotta.withValues(alpha: 0.8),
      ),
    );
  }
}

