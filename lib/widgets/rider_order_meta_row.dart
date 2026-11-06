import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../theme/thekaa_colors.dart';

class RiderOrderMetaRow extends StatelessWidget {
  final OrderConfirmation order;

  const RiderOrderMetaRow({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final assignedTime = order.rider.assignedTime;
    final text = '${order.orderId} · RIDER ASSIGNED · $assignedTime';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
          color: ThekaaColors.terracotta,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
