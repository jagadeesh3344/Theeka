import 'package:flutter/material.dart';
import '../models/rider.dart';
import '../theme/thekaa_colors.dart';

class RiderStatusMessageCard extends StatelessWidget {
  final Rider rider;

  const RiderStatusMessageCard({
    super.key,
    required this.rider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF1E2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Icon(
              Icons.info_outline_rounded,
              size: 19,
              color: ThekaaColors.terracotta,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rider.statusHeading,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: ThekaaColors.primaryText,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  rider.statusBody,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6E5D4F),
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
