import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../theme/thekaa_colors.dart';
import 'dabba_icon.dart';

class DeliveredSuccessIllustration extends StatelessWidget {
  final OrderConfirmation order;

  const DeliveredSuccessIllustration({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        // Circular badge with Dabba pot line-art and green check
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
        const SizedBox(height: 12),

        // Cursive tagline: "Enjoy every last grain."
        const Text(
          'Enjoy every last grain.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Caveat',
            fontSize: 23,
            fontWeight: FontWeight.w600,
            color: ThekaaColors.terracotta,
          ),
        ),
        const SizedBox(height: 8),

        // Authoritative Delivered Timestamp: "DELIVERED · 01 NOV 2026 · 2:12 PM"
        Text(
          order.deliveredTimestampText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
            color: Color(0xFF3B6B4C),
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
