import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class ThekaaCoinsCard extends StatelessWidget {
  final int coinsBalance;
  final bool isCoinsApplied;
  final VoidCallback onToggleCoins;

  const ThekaaCoinsCard({
    super.key,
    this.coinsBalance = 1200,
    required this.isCoinsApplied,
    required this.onToggleCoins,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: ThekaaColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThekaaColors.border,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          // Coins Icon container
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFF3E7D3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(
                Icons.toll_outlined,
                size: 18,
                color: ThekaaColors.terracotta,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Information text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your 1,200 THEKAA Coins',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: ThekaaColors.primaryText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Rate and limit confirmed at checkout',
                  style: ThekaaTypography.deliveryInfo.copyWith(fontSize: 10.5),
                ),
              ],
            ),
          ),

          // Action button
          GestureDetector(
            onTap: onToggleCoins,
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                Text(
                  isCoinsApplied ? 'Coins used' : 'Use coins',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isCoinsApplied
                        ? ThekaaColors.verifiedGreen
                        : ThekaaColors.terracotta,
                  ),
                ),
                const SizedBox(width: 2),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 16,
                  color: isCoinsApplied
                      ? ThekaaColors.verifiedGreen
                      : ThekaaColors.terracotta,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

