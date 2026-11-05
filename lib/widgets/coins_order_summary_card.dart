import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

class CoinsOrderSummaryCard extends StatelessWidget {
  final double orderValue;
  final int appliedCoins;
  final double coinDiscount;
  final double finalPayable;

  const CoinsOrderSummaryCard({
    super.key,
    required this.orderValue,
    required this.appliedCoins,
    required this.coinDiscount,
    required this.finalPayable,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasCoinsApplied = appliedCoins > 0 && coinDiscount > 0;

    return Container(
      decoration: BoxDecoration(
        color: ThekaaColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThekaaColors.border,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Order value
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Order value',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  color: ThekaaColors.secondaryText,
                ),
              ),
              Text(
                '₹${orderValue.toInt()}',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: ThekaaColors.primaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Row 2: Coins applied
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Coins applied',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  color: ThekaaColors.secondaryText,
                ),
              ),
              Text(
                hasCoinsApplied ? '$appliedCoins TKC (-₹${coinDiscount.toInt()})' : '0 TKC',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: hasCoinsApplied ? ThekaaColors.terracotta : ThekaaColors.primaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(color: ThekaaColors.border, height: 1, thickness: 1),
          const SizedBox(height: 10),

          // Row 3: Payable amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                hasCoinsApplied ? 'Payable, coins applied' : 'Payable, unchanged',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: ThekaaColors.primaryText,
                ),
              ),
              Text(
                '₹${finalPayable.toInt()}',
                style: const TextStyle(
                  fontFamily: 'Playfair Display',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: ThekaaColors.primaryText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

