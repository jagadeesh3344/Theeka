import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../theme/thekaa_colors.dart';
import 'live_route_map_painter.dart';

class LiveDeliveryMap extends StatelessWidget {
  final OrderConfirmation order;

  const LiveDeliveryMap({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 230,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: ThekaaColors.mapBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: ThekaaColors.border,
          width: 1.0,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: CustomPaint(
        painter: LiveRouteMapPainter(
          riderLocation: order.riderLocation ?? const Offset(0.60, 0.28),
          restaurantLocation: order.restaurantLocation ?? const Offset(0.25, 0.70),
          dropoffLocation: order.dropoffLocation ?? const Offset(0.76, 0.38),
        ),
      ),
    );
  }
}

