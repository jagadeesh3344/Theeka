import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../theme/thekaa_colors.dart';
import '../widgets/order_status_timeline_card.dart';
import '../widgets/order_tracking_header.dart';
import '../widgets/order_tracking_meta_row.dart';
import '../widgets/order_tracking_restaurant_card.dart';
import '../widgets/order_tracking_summary_card.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import '../widgets/view_order_details_button.dart';
import 'order_details_screen.dart';

class OrderTrackingScreen extends StatelessWidget {
  final OrderConfirmation order;
  final VoidCallback? onBack;
  final VoidCallback? onViewOrderDetails;
  final ValueChanged<int>? onNavTap;

  const OrderTrackingScreen({
    super.key,
    required this.order,
    this.onBack,
    this.onViewOrderDetails,
    this.onNavTap,
  });

  void _handleBack(BuildContext context) {
    if (onBack != null) {
      onBack!();
      return;
    }
    Navigator.of(context).pop();
  }

  void _handleViewOrderDetails(BuildContext context) {
    if (onViewOrderDetails != null) {
      onViewOrderDetails!();
      return;
    }

    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OrderDetailsScreen(
            order: order,
            onBack: () => Navigator.of(context).pop(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Header: "< A little dum, a little time"
            OrderTrackingHeader(
              onBack: () => _handleBack(context),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order ID & Estimated Delivery Time Row
                    OrderTrackingMetaRow(order: order),

                    // 5-Stage Order Status Timeline Card
                    OrderStatusTimelineCard(order: order),

                    // Restaurant Status Card (Photo + Preparing Meal + Dish Finishing Touch)
                    OrderTrackingRestaurantCard(order: order),

                    // Compact Order Summary Card (Receipt Icon + Items & Total + Locality)
                    OrderTrackingSummaryCard(order: order),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            // Fixed "View order details" Button
            ViewOrderDetailsButton(
              onTap: () => _handleViewOrderDetails(context),
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
