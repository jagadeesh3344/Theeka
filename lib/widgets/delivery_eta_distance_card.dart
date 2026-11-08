import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../theme/thekaa_colors.dart';

class DeliveryEtaDistanceCard extends StatelessWidget {
  final OrderConfirmation order;

  const DeliveryEtaDistanceCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: ThekaaColors.cardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: ThekaaColors.border,
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Clock Icon + Minutes + Arriving around time
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF4E8D8),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.access_time_rounded,
                      size: 19,
                      color: ThekaaColors.terracotta,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${order.remainingMinutes} min',
                        style: const TextStyle(
                          fontFamily: 'Playfair Display',
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: ThekaaColors.primaryText,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Arriving around ${order.arrivalAroundTime}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF8F7D6D),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Right: Remaining distance
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${order.remainingDistanceKm} km',
                style: const TextStyle(
                  fontFamily: 'Playfair Display',
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: ThekaaColors.primaryText,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'remaining',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF8F7D6D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
