import 'package:flutter/material.dart';
import '../models/address.dart';
import '../models/order_confirmation.dart';
import '../theme/thekaa_colors.dart';
import 'delivery_map_painter.dart';

class RiderDeliveryMap extends StatelessWidget {
  final OrderConfirmation order;

  const RiderDeliveryMap({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: ThekaaColors.mapBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThekaaColors.border,
          width: 1.0,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: CustomPaint(
        painter: DeliveryMapPainter(
          addressType: order.deliveryAddress?.type ?? AddressType.home,
        ),
      ),
    );
  }
}
