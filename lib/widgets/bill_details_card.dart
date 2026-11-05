import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class BillDetailsCard extends StatelessWidget {
  final double itemTotal;
  final double deliveryFee;
  final double platformFee;
  final bool isCoinsApplied;
  final double finalPayable;

  const BillDetailsCard({
    super.key,
    required this.itemTotal,
    required this.deliveryFee,
    required this.platformFee,
    required this.isCoinsApplied,
    required this.finalPayable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ThekaaColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThekaaColors.border,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Text(
            'Bill details',
            style: ThekaaTypography.sectionHeading.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),

          // 1. Item total
          _buildRow('Item total', '₹${itemTotal.toInt()}'),
          const SizedBox(height: 6),

          // 2. Delivery fee
          _buildRow('Delivery fee', '₹${deliveryFee.toInt()}'),
          const SizedBox(height: 6),

          // 3. Platform fee
          _buildRow('Platform fee', '₹${platformFee.toInt()}'),
          const SizedBox(height: 10),

          // Divider
          const Divider(
            color: ThekaaColors.border,
            thickness: 1.0,
            height: 1.0,
          ),
          const SizedBox(height: 10),

          // Final payable row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                isCoinsApplied ? 'To pay · coins applied' : 'To pay · no coins applied',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: ThekaaColors.primaryText,
                ),
              ),
              Text(
                '₹${finalPayable.toInt()}',
                style: ThekaaTypography.sectionHeading.copyWith(
                  fontSize: 18.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: ThekaaTypography.deliveryInfo.copyWith(
            fontSize: 12,
            color: ThekaaColors.secondaryText,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: ThekaaColors.primaryText,
          ),
        ),
      ],
    );
  }
}

