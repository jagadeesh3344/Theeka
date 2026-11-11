import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../models/restaurant.dart';
import '../models/social_models.dart';
import '../theme/thekaa_colors.dart';
import '../widgets/delivered_action_buttons.dart';
import '../widgets/delivered_experience_rating_card.dart';
import '../widgets/delivered_header.dart';
import '../widgets/delivered_review_reminder_card.dart';
import '../widgets/delivered_success_illustration.dart';
import '../widgets/order_summary_card.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import 'cart_screen.dart';
import 'completed_order_details_screen.dart';
import 'tell_food_story_screen.dart';

class DeliveredOrderScreen extends StatefulWidget {
  final OrderConfirmation order;
  final VoidCallback? onBack;
  final VoidCallback? onShareReview;
  final VoidCallback? onReorder;
  final VoidCallback? onOrderDetails;
  final ValueChanged<int>? onRatingChanged;
  final ValueChanged<int>? onNavTap;

  const DeliveredOrderScreen({
    super.key,
    required this.order,
    this.onBack,
    this.onShareReview,
    this.onReorder,
    this.onOrderDetails,
    this.onRatingChanged,
    this.onNavTap,
  });

  @override
  State<DeliveredOrderScreen> createState() => _DeliveredOrderScreenState();
}

class _DeliveredOrderScreenState extends State<DeliveredOrderScreen> {
  late int _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.order.userRating;
  }

  void _handleBack(BuildContext context) {
    if (widget.onBack != null) {
      widget.onBack!();
      return;
    }
    Navigator.of(context).pop();
  }

  void _handleRatingChanged(int newRating) {
    setState(() {
      _rating = newRating;
    });
    if (widget.onRatingChanged != null) {
      widget.onRatingChanged!(newRating);
    }
  }

  void _handleShareReview(BuildContext context) {
    if (widget.onShareReview != null) {
      widget.onShareReview!();
      return;
    }

    final eligibleOrder = EligibleOrder.fromOrderConfirmation(widget.order);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TellFoodStoryScreen(
          eligibleOrders: [eligibleOrder],
          post: SocialPost.defaultPost.copyWith(
            restaurantName: widget.order.restaurantName,
            restaurantLocality: widget.order.restaurantArea,
            orderId: widget.order.orderId,
            dishName: widget.order.items.isNotEmpty
                ? widget.order.items.first.name
                : 'Chicken Dum Biryani',
            dishPrice: widget.order.items.isNotEmpty
                ? widget.order.items.first.price
                : 280.0,
            rating: _rating > 0 ? _rating.toDouble() : 4.0,
          ),
          onBack: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  void _handleReorder(BuildContext context) {
    if (widget.onReorder != null) {
      widget.onReorder!();
      return;
    }

    // Retrieve restaurant and items from completed order
    final restaurant = widget.order.restaurantId == 'chutneys'
        ? Restaurant.chutneys
        : Restaurant.shadabBiryani;

    final initialQuantities = <String, int>{};
    for (final item in widget.order.items) {
      final matchedItem = restaurant.bestsellers.firstWhere(
        (b) => b.name.toLowerCase() == item.name.toLowerCase(),
        orElse: () => restaurant.bestsellers.first,
      );
      initialQuantities[matchedItem.id] = item.quantity;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CartScreen(
          restaurant: restaurant,
          initialQuantities: initialQuantities,
          onBack: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  void _handleOrderDetails(BuildContext context) {
    if (widget.onOrderDetails != null) {
      widget.onOrderDetails!();
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CompletedOrderDetailsScreen(
          order: widget.order,
          onBack: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      bottomNavigationBar: ThekaaBottomNavBar(
        currentIndex: 3,
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
            // Top Header: "< Khaana aa gaya!"
            DeliveredHeader(
              onBack: () => _handleBack(context),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Delivery Success Illustration & Delivered Timestamp
                    DeliveredSuccessIllustration(order: widget.order),

                    // Order Summary Card (Restaurant + Items + Total + Coins)
                    OrderSummaryCard(order: widget.order),

                    // Experience Rating Card ("How was your experience?" + 5 Stars)
                    DeliveredExperienceRatingCard(
                      rating: _rating,
                      onRatingChanged: _handleRatingChanged,
                    ),

                    // Review Reminder Card ("Your honest review matters")
                    const DeliveredReviewReminderCard(),

                    // Action Buttons ("Share food review", "Reorder", "Order details")
                    DeliveredActionButtons(
                      onShareReview: () => _handleShareReview(context),
                      onReorder: () => _handleReorder(context),
                      onOrderDetails: () => _handleOrderDetails(context),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

