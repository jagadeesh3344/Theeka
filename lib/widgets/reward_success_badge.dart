import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

class RewardSuccessBadge extends StatelessWidget {
  final int rewardAmount;
  final String status;

  const RewardSuccessBadge({
    super.key,
    required this.rewardAmount,
    this.status = 'COMPLETED · VALIDATED REVIEW',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Section B — Circular Outlined Success Icon
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF66866C),
              width: 1.2,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.check,
              size: 20,
              color: Color(0xFF66866C),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Section C — Reward Amount
        Text(
          '+$rewardAmount TKC',
          style: const TextStyle(
            fontFamily: 'Playfair Display',
            fontSize: 38,
            fontWeight: FontWeight.bold,
            color: ThekaaColors.primaryText,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),

        // Section D — Completion Status
        Text(
          status,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Color(0xFF5A785E),
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}

