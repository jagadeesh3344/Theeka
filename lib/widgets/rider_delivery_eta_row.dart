import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../theme/thekaa_colors.dart';

class RiderDeliveryEtaRow extends StatelessWidget {
  final OrderConfirmation order;

  const RiderDeliveryEtaRow({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final etaText = order.deliveryEtaWindow
        .replaceAll('Estimated delivery · ', '')
        .replaceAll('Estimated ', '');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
      child: Text(
        'Estimated arrival: $etaText',
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 13.0,
          fontWeight: FontWeight.w700,
          color: ThekaaColors.terracotta,
        ),
      ),
    );
  }
}

