import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../theme/thekaa_colors.dart';

class OrderTrackingMetaRow extends StatelessWidget {
  final OrderConfirmation order;

  const OrderTrackingMetaRow({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            order.orderId,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14.5,
              fontWeight: FontWeight.w800,
              color: ThekaaColors.primaryText,
              letterSpacing: -0.2,
            ),
          ),
          Text(
            order.estimatedTimeFormatted,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: ThekaaColors.terracotta,
            ),
          ),
        ],
      ),
    );
  }
}
