import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../services/order_repository.dart';
import '../theme/thekaa_colors.dart';
import '../widgets/rider_delivery_eta_row.dart';
import '../widgets/rider_delivery_map.dart';
import '../widgets/rider_details_header.dart';
import '../widgets/rider_order_meta_row.dart';
import '../widgets/rider_pickup_dropoff_card.dart';
import '../widgets/rider_profile_card.dart';
import '../widgets/rider_stats_row.dart';
import '../widgets/rider_status_message_card.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import '../widgets/view_order_details_button.dart';
import 'on_the_way_screen.dart';
import 'order_details_screen.dart';

class RiderDetailsScreen extends StatelessWidget {
  final OrderConfirmation order;
  final VoidCallback? onBack;
  final VoidCallback? onViewOrderDetails;
  final VoidCallback? onCallRider;
  final VoidCallback? onChatRider;
  final VoidCallback? onMapTap;
  final ValueChanged<int>? onNavTap;

  const RiderDetailsScreen({
    super.key,
    required this.order,
    this.onBack,
    this.onViewOrderDetails,
    this.onCallRider,
    this.onChatRider,
    this.onMapTap,
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

    final current = OrderRepository.instance.getOrderById(order.orderId) ?? order;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OrderDetailsScreen(
          order: current,
          onBack: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  void _handleMapTap(BuildContext context) {
    if (onMapTap != null) {
      onMapTap!();
      return;
    }

    final current = OrderRepository.instance.getOrderById(order.orderId) ?? order;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OnTheWayScreen(
          order: current,
          onBack: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final repoOrder = OrderRepository.instance.getOrderById(order.orderId);
    final currentOrder = repoOrder != null && repoOrder.trackingStatus.index > order.trackingStatus.index
        ? repoOrder
        : order;
    final rider = currentOrder.rider;

    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      bottomNavigationBar: ThekaaBottomNavBar(
        currentIndex: 3,
        onTap: onNavTap,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Header: "< Meet your bhaiyya"
            RiderDetailsHeader(
              onBack: () => _handleBack(context),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order ID · RIDER ASSIGNED · 1:53 PM
                    RiderOrderMetaRow(order: currentOrder),

                    // Rider Profile Card (Avatar + Ravi K. + 4.8 + Shield + Call & Chat buttons)
                    RiderProfileCard(
                      rider: rider,
                      onCall: onCallRider,
                      onChat: onChatRider,
                    ),

                    // Deliveries and Tenure Stats Row
                    RiderStatsRow(rider: rider),

                    // Rider Status Message Card (Pale yellow info card)
                    RiderStatusMessageCard(rider: rider),

                    // Pickup and Drop-off Address Card
                    RiderPickupDropoffCard(order: currentOrder),

                    // Estimated Arrival Row
                    RiderDeliveryEtaRow(order: currentOrder),

                    // Contained Map Preview Section (Tappable to open "On the way to you")
                    RiderDeliveryMap(
                      order: currentOrder,
                      onTap: () => _handleMapTap(context),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            // Fixed "View order details" Button
            ViewOrderDetailsButton(
              onTap: () => _handleViewOrderDetails(context),
            ),
          ],
        ),
      ),
    );
  }
}

