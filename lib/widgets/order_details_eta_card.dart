import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../theme/thekaa_colors.dart';

class OrderDetailsEtaCard extends StatelessWidget {
  final OrderConfirmation order;

  const OrderDetailsEtaCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final windowText = order.deliveryEtaWindow
        .replaceAll('Estimated delivery · ', 'Estimated ');

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ThekaaColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThekaaColors.border,
          width: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF4E8D8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(
                Icons.access_time_rounded,
                size: 22,
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
                  'Arriving in ${order.deliveryEtaDuration}',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: ThekaaColors.primaryText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  windowText,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF8F7D6D),
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
