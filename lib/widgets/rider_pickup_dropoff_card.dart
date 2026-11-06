import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../theme/thekaa_colors.dart';

class RiderPickupDropoffCard extends StatelessWidget {
  final OrderConfirmation order;

  const RiderPickupDropoffCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final dropoffTag = order.deliveryAddress?.typeLabel ?? 'Home';
    final dropoffAddress = order.deliveryAddress?.singleLineAddress ??
        'Flat 302, Vertex Heights, Gachibowli, Hyderabad 500032';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ThekaaColors.cardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: ThekaaColors.border,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          // 1. Pickup Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4E8D8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(
                    Icons.restaurant_rounded,
                    size: 20,
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
                      'Pickup · ${order.restaurantName}',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${order.restaurantArea}, Hyderabad',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8F7D6D),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(
            color: Color(0xFFF0E5D8),
            height: 1.0,
            thickness: 1.0,
          ),
          const SizedBox(height: 12),

          // 2. Drop-off Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4E8D8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(
                    Icons.home_outlined,
                    size: 21,
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
                      'Drop-off · $dropoffTag',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      dropoffAddress,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8F7D6D),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
