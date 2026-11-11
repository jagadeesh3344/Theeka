import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../theme/thekaa_colors.dart';

class OrderPlacedActions extends StatelessWidget {
  final OrderConfirmation order;
  final VoidCallback onTrackOrder;
  final VoidCallback onViewOrderDetails;

  const OrderPlacedActions({
    super.key,
    required this.order,
    required this.onTrackOrder,
    required this.onViewOrderDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      color: ThekaaColors.mainBackground,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Payment summary note
          Text(
            order.paymentSummaryText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF8F7D6D),
            ),
          ),
          const SizedBox(height: 12),

          // Primary action: Track order
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onTrackOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: ThekaaColors.terracotta,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Track order',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.alt_route_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.0,
                      child: Center(
                        child: Text(
                          'Track your order',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Secondary action: View order details
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: onViewOrderDetails,
              style: OutlinedButton.styleFrom(
                backgroundColor: ThekaaColors.cardBackground,
                foregroundColor: ThekaaColors.primaryText,
                elevation: 0,
                side: const BorderSide(
                  color: ThekaaColors.border,
                  width: 1.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'View order details',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5D4037),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

