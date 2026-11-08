import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../theme/thekaa_colors.dart';
import '../widgets/delivering_to_address_card.dart';
import '../widgets/delivery_eta_distance_card.dart';
import '../widgets/live_delivery_map.dart';
import '../widgets/on_the_way_header.dart';
import '../widgets/on_the_way_meta_row.dart';
import '../widgets/rider_profile_card.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import '../widgets/view_order_details_button.dart';
import 'order_details_screen.dart';

class OnTheWayScreen extends StatelessWidget {
  final OrderConfirmation order;
  final VoidCallback? onBack;
  final VoidCallback? onViewOrderDetails;
  final VoidCallback? onCallRider;
  final VoidCallback? onChatRider;
  final ValueChanged<int>? onNavTap;

  const OnTheWayScreen({
    super.key,
    required this.order,
    this.onBack,
    this.onViewOrderDetails,
    this.onCallRider,
    this.onChatRider,
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
    final rider = order.rider;

    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Header: "< On the way to you"
            OnTheWayHeader(
              onBack: () => _handleBack(context),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Subheader: "#THK84291 · OUT FOR DELIVERY · 2:00 PM"
                    OnTheWayMetaRow(order: order),

                    // Large Live Delivery Map
                    LiveDeliveryMap(order: order),

                    // ETA / Distance Card: 12 min (Arriving around 2:12 PM) · 2.8 km (remaining)
                    DeliveryEtaDistanceCard(order: order),

                    // Rider Profile Card (Avatar + Ravi K. + 4.8 + Shield + Call & Chat buttons)
                    RiderProfileCard(
                      rider: rider,
                      onCall: onCallRider,
                      onChat: onChatRider,
                    ),

                    // Delivering to Home Card (Address)
                    DeliveringToAddressCard(order: order),

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
