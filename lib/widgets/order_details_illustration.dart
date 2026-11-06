import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../theme/thekaa_colors.dart';
import 'dabba_icon.dart';

class OrderDetailsIllustration extends StatelessWidget {
  final OrderConfirmation order;

  const OrderDetailsIllustration({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4),
        Center(
          child: SizedBox(
            width: 112,
            height: 112,
            child: Stack(
              children: [
                Container(
                  width: 112,
                  height: 112,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF4E8D8),
                  ),
                  child: const Center(
                    child: DabbaIcon(
                      size: 58,
                      color: ThekaaColors.terracotta,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 6,
                  right: 6,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF4A6B53),
                      border: Border.all(
                        color: ThekaaColors.mainBackground,
                        width: 2.0,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check_rounded,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Cursive script message: "The kitchen has your order."
        const Text(
          'The kitchen has your order.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Caveat',
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: ThekaaColors.terracotta,
          ),
        ),
        const SizedBox(height: 14),

        // Order ID and Today Time Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.orderId,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: ThekaaColors.primaryText,
                ),
              ),
              Text(
                'Today, ${order.time}',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF8F7D6D),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

