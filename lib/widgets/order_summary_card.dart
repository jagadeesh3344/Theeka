import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../theme/thekaa_colors.dart';

class OrderSummaryCard extends StatelessWidget {
  final OrderConfirmation order;

  const OrderSummaryCard({
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
        color: ThekaaColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThekaaColors.border,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Restaurant info header
          Row(
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
                    Icons.restaurant_outlined,
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
                      order.restaurantName,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${order.restaurantArea} · ${order.orderId}',
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

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              color: Color(0xFFEADBCE),
              height: 1.0,
              thickness: 1.0,
            ),
          ),

          // Order Items
          ...order.items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  item.formattedRow,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    color: ThekaaColors.primaryText,
                  ),
                ),
              )),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              color: Color(0xFFEADBCE),
              height: 1.0,
              thickness: 1.0,
            ),
          ),

          // Bottom Summary Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${order.totalItemCount} items · ${order.coinSummaryText}',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF8F7D6D),
                ),
              ),
              Text(
                '₹${order.totalPayable.toInt()}',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: ThekaaColors.primaryText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

