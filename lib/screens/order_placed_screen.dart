import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../theme/thekaa_colors.dart';
import '../widgets/delivery_estimate_card.dart';
import '../widgets/order_placed_actions.dart';
import '../widgets/order_success_header.dart';
import '../widgets/order_success_illustration.dart';
import '../widgets/order_summary_card.dart';
import 'order_details_screen.dart';
import 'order_tracking_screen.dart';

class OrderPlacedScreen extends StatelessWidget {
  final OrderConfirmation order;
  final VoidCallback? onBack;
  final VoidCallback? onTrackOrder;
  final VoidCallback? onViewOrderDetails;

  const OrderPlacedScreen({
    super.key,
    required this.order,
    this.onBack,
    this.onTrackOrder,
    this.onViewOrderDetails,
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
          onViewOrderDetails: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OrderDetailsScreen(
                  order: order,
                  onBack: () => Navigator.of(context).pop(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleViewOrderDetails(BuildContext context) {
    if (onViewOrderDetails != null) {
      onViewOrderDetails!();
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OrderDetailsScreen(
          order: order,
          onBack: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Header: "You're all set"
            OrderSuccessHeader(
              onBack: onBack ?? () => Navigator.of(context).popUntil((route) => route.isFirst),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Illustration & Main Titles
                    OrderSuccessIllustration(order: order),

                    const SizedBox(height: 14),

                    // Delivery ETA Card
                    DeliveryEstimateCard(order: order),

                    // Restaurant Order Summary Card
                    OrderSummaryCard(order: order),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            // Fixed Bottom Actions (Track order & View order details)
            OrderPlacedActions(
              order: order,
              onTrackOrder: () => _handleTrackOrder(context),
              onViewOrderDetails: () => _handleViewOrderDetails(context),
            ),
          ],
        ),
      ),
    );
  }
}

