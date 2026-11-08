import 'package:flutter/material.dart';
import '../models/rider.dart';
import '../theme/thekaa_colors.dart';

class RiderStatsRow extends StatelessWidget {
  final Rider rider;

  const RiderStatsRow({
    super.key,
    required this.rider,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            rider.formattedDeliveries,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 13.0,
              fontWeight: FontWeight.w700,
              color: ThekaaColors.primaryText,
            ),
          ),
          Text(
            rider.formattedTenure,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: Color(0xFF8F7D6D),
            ),
          ),
        ],
      ),
    );
  }
}

