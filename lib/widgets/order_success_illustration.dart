import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../theme/thekaa_colors.dart';
import 'dabba_icon.dart';

class OrderSuccessIllustration extends StatelessWidget {
  final OrderConfirmation order;

  const OrderSuccessIllustration({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        // Circular badge with Dabba line-art and green check
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

        // Cursive message
        const Text(
          'Acha khaana, on its way.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Caveat',
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: ThekaaColors.terracotta,
          ),
        ),
        const SizedBox(height: 6),

        // Main heading
        const Text(
          'Order placed, bhaiyya.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Playfair Display',
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: ThekaaColors.primaryText,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 6),

        // Order ID · Date · Time
        Text(
          '${order.orderId} · ${order.date} · ${order.time}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12.5,
            fontWeight: FontWeight.w400,
            color: Color(0xFF8F7D6D),
            letterSpacing: -0.1,
          ),
        ),
      ],
    );
  }
}

