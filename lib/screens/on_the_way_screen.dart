import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../services/order_repository.dart';
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
import 'delivered_order_screen.dart';

class OnTheWayScreen extends StatelessWidget {
  final OrderConfirmation order;
  final VoidCallback? onBack;
  final VoidCallback? onViewOrderDetails;
  final VoidCallback? onCallRider;
  final VoidCallback? onChatRider;
  final VoidCallback? onOrderDelivered;
  final ValueChanged<int>? onNavTap;

  const OnTheWayScreen({
    super.key,
    required this.order,
    this.onBack,
    this.onViewOrderDetails,
    this.onCallRider,
    this.onChatRider,
    this.onOrderDelivered,
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

  void deliverOrder(BuildContext context) {
    if (onOrderDelivered != null) {
      onOrderDelivered!();
      return;
    }
    final current = OrderRepository.instance.getOrderById(order.orderId) ?? order;
    final deliveredOrder = current.copyWith(
      trackingStatus: OrderTrackingStatus.delivered,
      deliveredDate: current.deliveredDate ?? current.date,
      deliveredTime: current.deliveredTime ?? current.arrivalAroundTime,
    );
    OrderRepository.instance.addOrUpdateOrder(deliveredOrder);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => DeliveredOrderScreen(
          order: deliveredOrder,
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

    if (currentOrder.trackingStatus == OrderTrackingStatus.delivered) {
      return DeliveredOrderScreen(
        order: currentOrder,
        onBack: onBack,
        onNavTap: onNavTap,
      );
    }

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
                    OnTheWayMetaRow(order: currentOrder),

                    // Large Live Delivery Map
                    LiveDeliveryMap(order: currentOrder),

                    // ETA / Distance Card: 12 min (Arriving around 2:12 PM) · 2.8 km (remaining)
                    DeliveryEtaDistanceCard(order: currentOrder),

                    // Rider Profile Card (Avatar + Ravi K. + 4.8 + Shield + Call & Chat buttons)
                    RiderProfileCard(
                      rider: rider,
                      onCall: onCallRider,
                      onChat: onChatRider,
                    ),

                    // Delivering to Home Card (Address)
                    DeliveringToAddressCard(order: currentOrder),

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

