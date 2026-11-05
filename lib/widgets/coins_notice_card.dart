import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

class CoinsNoticeCard extends StatelessWidget {
  final bool isCoinsApplied;

  const CoinsNoticeCard({
    super.key,
    this.isCoinsApplied = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1E4CE),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 1.0),
            child: Icon(
              Icons.access_time_rounded,
              color: ThekaaColors.terracotta,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rate and limit confirmed at checkout',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF6A4833),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  isCoinsApplied
                      ? 'Coins have been successfully applied to your order bill!'
                      : "Your current order has no coins applied. We'll enable redemption after the checkout quote loads.",
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    color: Color(0xFF8C7563),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

