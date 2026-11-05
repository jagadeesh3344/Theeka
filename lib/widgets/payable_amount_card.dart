import 'package:flutter/material.dart';
import '../models/address.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';

class PayableAmountCard extends StatelessWidget {
  final double payableAmount;
  final Restaurant restaurant;
  final int itemCount;
  final DeliveryAddress? deliveryAddress;

  const PayableAmountCard({
    super.key,
    required this.payableAmount,
    required this.restaurant,
    required this.itemCount,
    this.deliveryAddress,
  });

  @override
  Widget build(BuildContext context) {
    final addressLabel = deliveryAddress?.typeLabel ?? 'Home';
    final count = itemCount > 0 ? itemCount : 2;

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
          const Text(
            'Amount payable',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF8F7D6D),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${payableAmount.toInt()}',
                style: const TextStyle(
                  fontFamily: 'Playfair Display',
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: ThekaaColors.primaryText,
                  letterSpacing: -1.0,
                ),
              ),
              const Icon(
                Icons.verified_user_outlined,
                size: 28,
                color: ThekaaColors.verifiedGreen,
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
          Text(
            '${restaurant.name} · $count items · Delivery to $addressLabel',
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.5,
              fontWeight: FontWeight.w400,
              color: Color(0xFF8F7D6D),
            ),
          ),
        ],
      ),
    );
  }
}

