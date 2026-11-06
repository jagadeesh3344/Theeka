import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../theme/thekaa_colors.dart';
import '../widgets/order_confirmed_header.dart';
import '../widgets/order_details_eta_card.dart';
import '../widgets/order_details_illustration.dart';
import '../widgets/order_status_card.dart';
import '../widgets/order_summary_card.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import 'order_tracking_screen.dart';

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

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OrderTrackingScreen(
          order: order,
          onBack: () => Navigator.of(context).pop(),
          onViewOrderDetails: () => Navigator.of(context).pop(),
        ),
      ),
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

