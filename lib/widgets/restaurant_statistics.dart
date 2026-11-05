import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class RestaurantStatistics extends StatelessWidget {
  final List<RestaurantStat> statistics;

  const RestaurantStatistics({
    super.key,
    required this.statistics,
  });

  @override
  Widget build(BuildContext context) {
    if (statistics.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < statistics.length; i++) ...[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      statistics[i].value,
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      statistics[i].label,
                      style: ThekaaTypography.deliveryInfo.copyWith(
                        fontSize: 11,
                        color: ThekaaColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              if (i < statistics.length - 1)
                Container(
                  height: 28,
                  width: 1,
                  color: ThekaaColors.border.withValues(alpha: 0.6),
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                ),
            ],
          ],
        ),
        const SizedBox(height: 14),
        Divider(
          color: ThekaaColors.border.withValues(alpha: 0.45),
          thickness: 1.0,
          height: 1.0,
        ),
      ],
    );
  }
}

