import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

class DeliveredReviewReminderCard extends StatelessWidget {
  const DeliveredReviewReminderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF7EFE2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThekaaColors.border,
          width: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Icon(
              Icons.access_time_rounded,
              size: 21,
              color: ThekaaColors.terracotta,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Your honest review matters',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: ThekaaColors.primaryText,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Share on THEKAA SOCIALS. Coins stay pending until publication and eligibility checks; credited once.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF8F7D6D),
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

