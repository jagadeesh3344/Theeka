import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../services/order_repository.dart';
import '../theme/thekaa_colors.dart';
import '../widgets/order_status_timeline_card.dart';
import '../widgets/order_tracking_header.dart';
import '../widgets/order_tracking_meta_row.dart';
import '../widgets/order_tracking_restaurant_card.dart';
import '../widgets/order_tracking_summary_card.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import '../widgets/view_order_details_button.dart';
import 'delivered_order_screen.dart';
import 'order_details_screen.dart';
import 'rider_details_screen.dart';

class OrderTrackingScreen extends StatefulWidget {
  final OrderConfirmation order;
  final Duration simulationStepDuration;
  final bool enableSimulation;
  final VoidCallback? onBack;
  final VoidCallback? onViewOrderDetails;
  final VoidCallback? onViewRiderDetails;
  final ValueChanged<OrderConfirmation>? onDelivered;
  final ValueChanged<int>? onNavTap;

  const OrderTrackingScreen({
    super.key,
    required this.order,
    this.simulationStepDuration = const Duration(seconds: 10),
    this.enableSimulation = true,
    this.onBack,
    this.onViewOrderDetails,
    this.onViewRiderDetails,
    this.onDelivered,
    this.onNavTap,
  });

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  late OrderConfirmation _currentOrder;

  bool get _isRiderAssigned =>
      _currentOrder.trackingStatus == OrderTrackingStatus.riderAssigned ||
      _currentOrder.trackingStatus == OrderTrackingStatus.outForDelivery ||
      _currentOrder.trackingStatus == OrderTrackingStatus.delivered;

  @override
  void initState() {
    super.initState();
    // Retrieve existing order if available to preserve current state, or use widget.order
    final existing = OrderRepository.instance.getOrderById(widget.order.orderId);
    _currentOrder = existing ?? widget.order;

    // Start or observe order lifecycle without resetting the order
    OrderRepository.instance.startOrderLifecycle(
      _currentOrder,
      stepDuration: widget.simulationStepDuration,
      enableSimulation: widget.enableSimulation,
    );

    OrderRepository.instance.addListener(_onRepositoryChanged);
  }

  void _onRepositoryChanged() {
    if (!mounted) return;
    final updated = OrderRepository.instance.getOrderById(widget.order.orderId);
    if (updated != null && updated.trackingStatus != _currentOrder.trackingStatus) {
      setState(() {
        _currentOrder = updated;
      });
      if (updated.trackingStatus == OrderTrackingStatus.delivered) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _navigateToDelivered();
        });
      }
    }
  }

  void _navigateToDelivered() {
    if (!mounted) return;
    if (ModalRoute.of(context)?.isCurrent != true) return;
    final deliveredOrder = OrderRepository.instance.getOrderById(widget.order.orderId) ?? _currentOrder;
    if (widget.onDelivered != null) {
      widget.onDelivered!(deliveredOrder);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DeliveredOrderScreen(
            order: deliveredOrder,
            onBack: () => Navigator.of(context).maybePop(),
          ),
        ),
      );
    }
  }

  @override
  void didUpdateWidget(covariant OrderTrackingScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.order != oldWidget.order) {
      _currentOrder = widget.order;
      setState(() {});
    }
  }

  @override
  void dispose() {
    OrderRepository.instance.removeListener(_onRepositoryChanged);
    OrderRepository.instance.stopOrderLifecycle(widget.order.orderId);
    super.dispose();
  }

  void _handleBack(BuildContext context) {
    if (widget.onBack != null) {
      widget.onBack!();
      return;
    }
    Navigator.of(context).maybePop();
  }

  void _handleViewOrderDetails(BuildContext context) {
    if (widget.onViewOrderDetails != null) {
      widget.onViewOrderDetails!();
      return;
    }

    final current = OrderRepository.instance.getOrderById(widget.order.orderId) ?? _currentOrder;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OrderDetailsScreen(
          order: current,
          onBack: () => Navigator.of(context).maybePop(),
        ),
      ),
    );
  }

  void _handleViewRiderDetails(BuildContext context) {
    if (!_isRiderAssigned) return;

    if (widget.onViewRiderDetails != null) {
      widget.onViewRiderDetails!();
      return;
    }

    final current = OrderRepository.instance.getOrderById(widget.order.orderId) ?? _currentOrder;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RiderDetailsScreen(
          order: current,
          onBack: () => Navigator.of(context).maybePop(),
          onViewOrderDetails: () => _handleViewOrderDetails(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final repoOrder = OrderRepository.instance.getOrderById(widget.order.orderId);
    final currentOrder = (repoOrder != null && repoOrder.trackingStatus.index > _currentOrder.trackingStatus.index)
        ? repoOrder
        : _currentOrder;
    _currentOrder = currentOrder;
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      bottomNavigationBar: ThekaaBottomNavBar(
        currentIndex: 3, // Orders active
        onTap: (index) {
          if (widget.onNavTap != null) {
            widget.onNavTap!(index);
          } else if (index == 0) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
      ),
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
                    OrderTrackingMetaRow(order: _currentOrder),

                    // 5-Stage Order Status Timeline Card
                    OrderStatusTimelineCard(order: _currentOrder),

                    // Restaurant Status Card (Photo + Preparing Meal + Dish Finishing Touch)
                    OrderTrackingRestaurantCard(order: _currentOrder),

                    // Compact Order Summary Card (Receipt Icon + Items & Total + Locality)
                    OrderTrackingSummaryCard(order: _currentOrder),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            // Fixed "View rider details" Button (Disabled until rider is assigned)
            ViewOrderDetailsButton(
              label: 'View rider details',
              isEnabled: _isRiderAssigned,
              onTap: () => _handleViewRiderDetails(context),
            ),
          ],
        ),
      ),
    );
  }
}
