import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../theme/thekaa_colors.dart';
import '../widgets/order_confirmed_header.dart';
import '../widgets/order_details_eta_card.dart';
import '../widgets/order_details_illustration.dart';
import '../widgets/order_status_card.dart';
import '../widgets/order_summary_card.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderConfirmation order;
  final VoidCallback? onBack;
  final VoidCallback? onTrackOrder;
  final ValueChanged<int>? onNavTap;

  const OrderDetailsScreen({
    super.key,
    required this.order,
    this.onBack,
    this.onTrackOrder,
    this.onNavTap,
  });

  void _handleTrackOrder(BuildContext context) {
    if (onTrackOrder != null) {
      onTrackOrder!();
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: ThekaaColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Live Tracking',
                      style: TextStyle(
                        fontFamily: 'Playfair Display',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: ThekaaColors.primaryText),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Kitchen is preparing your order at ${order.restaurantName}.',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: ThekaaColors.primaryText,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${order.deliveryEtaDuration} · ${order.deliveryEtaWindow}',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    color: ThekaaColors.terracotta,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Header: "< Order confirmed"
            OrderConfirmedHeader(
              onBack: onBack ?? () => Navigator.of(context).pop(),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Dabba Badge, Cursive Message & Order ID / Time Row
                    OrderDetailsIllustration(order: order),

                    const SizedBox(height: 10),

                    // Card 1: Accepted / Kitchen Status (Green Card)
                    OrderStatusCard(order: order),

                    // Card 2: ETA Card (White with clock icon)
                    OrderDetailsEtaCard(order: order),

                    // Card 3: Restaurant & Dishes Order Summary Card
                    OrderSummaryCard(order: order),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            // Action: Full-width "Track your order" Terracotta Button
            Container(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
              color: ThekaaColors.mainBackground,
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => _handleTrackOrder(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThekaaColors.terracotta,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Track your order',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.alt_route_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Fixed Bottom Navigation Bar with Orders tab active (index 3)
            ThekaaBottomNavBar(
              currentIndex: 3,
              onTap: (index) {
                if (onNavTap != null) {
                  onNavTap!(index);
                } else if (index == 0) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
