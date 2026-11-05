import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

class CurrentLocationRow extends StatelessWidget {
  final String locationText;
  final VoidCallback? onTap;

  const CurrentLocationRow({
    super.key,
    this.locationText = 'Gachibowli, Hyderabad',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF2E4D2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(
                Icons.my_location_rounded,
                color: ThekaaColors.terracotta,
                size: 19,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Use current location',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: ThekaaColors.primaryText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  locationText,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11.5,
                    color: ThekaaColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: ThekaaColors.secondaryText,
            size: 20,
          ),
        ],
      ),
    );
  }
}

