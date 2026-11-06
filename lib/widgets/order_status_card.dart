import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';

class OrderStatusCard extends StatelessWidget {
  final OrderConfirmation order;

  const OrderStatusCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE5EDE2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline_rounded,
                size: 18,
                color: Color(0xFF3F5E4D),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Confirmed by ${order.restaurantName}',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2E4D3B),
                    letterSpacing: -0.1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Padding(
            padding: EdgeInsets.only(left: 26.0),
            child: Text(
              "Your order is accepted. We'll let you know when preparation begins.",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF556B5B),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
