import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

class ReviewBillDetailsCard extends StatelessWidget {
  final double itemTotal;
  final double deliveryFee;
  final double platformFee;
  final int coinsRedeemed;
  final double finalPayable;

  const ReviewBillDetailsCard({
    super.key,
    required this.itemTotal,
    required this.deliveryFee,
    required this.platformFee,
    this.coinsRedeemed = 0,
    required this.finalPayable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThekaaColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThekaaColors.border,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bill details',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: ThekaaColors.primaryText,
            ),
          ),
          const SizedBox(height: 12),

          // 1. Item total
          _buildRow('Item total', '₹${itemTotal.toInt()}'),
          const SizedBox(height: 8),

          // 2. Delivery fee
          _buildRow('Delivery fee', '₹${deliveryFee.toInt()}'),
          const SizedBox(height: 8),

          // 3. Platform fee
          _buildRow('Platform fee', '₹${platformFee.toInt()}'),
          const SizedBox(height: 8),

          // 4. Coins redeemed
          _buildRow(
            'Coins redeemed',
            coinsRedeemed > 0 ? '-₹$coinsRedeemed' : '0 TKC',
            valueColor: coinsRedeemed > 0 ? ThekaaColors.terracotta : ThekaaColors.primaryText,
          ),

          const SizedBox(height: 12),
          const Divider(color: ThekaaColors.border, height: 1, thickness: 1),
          const SizedBox(height: 12),

          // 5. To pay
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              const Text(
                'To pay',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: ThekaaColors.primaryText,
                ),
              ),
              Text(
                '₹${finalPayable.toInt()}',
                style: const TextStyle(
                  fontFamily: 'Playfair Display',
                  fontSize: 24,
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

  Widget _buildRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 13,
            color: ThekaaColors.secondaryText,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: valueColor ?? ThekaaColors.primaryText,
          ),
        ),
      ],
    );
  }
}

