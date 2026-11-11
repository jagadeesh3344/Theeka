import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../models/social_models.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import 'tell_food_story_screen.dart';

class CompletedOrderDetailsScreen extends StatelessWidget {
  final OrderConfirmation order;
  final VoidCallback? onBack;
  final ValueChanged<int>? onNavTap;
  final bool showBottomNav;

  const CompletedOrderDetailsScreen({
    super.key,
    required this.order,
    this.onBack,
    this.onNavTap,
    this.showBottomNav = true,
  });

  double get _itemTotal =>
      order.items.fold(0.0, (sum, i) => sum + (i.price * i.quantity));

  void _handleBack(BuildContext context) {
    if (onBack != null) {
      onBack!();
      return;
    }
    Navigator.of(context).maybePop();
  }

  void _handleShareReview(BuildContext context) {
    final eligibleOrder = EligibleOrder.fromOrderConfirmation(order);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TellFoodStoryScreen(
          eligibleOrders: [eligibleOrder],
          post: SocialPost.defaultPost.copyWith(
            restaurantName: order.restaurantName,
            restaurantLocality: order.restaurantArea,
            orderId: order.orderId,
            dishName: order.items.isNotEmpty
                ? order.items.first.name
                : 'Chicken Dum Biryani',
            dishPrice: order.items.isNotEmpty
                ? order.items.first.price
                : 280.0,
            rating: order.userRating > 0 ? order.userRating.toDouble() : 4.0,
          ),
          onBack: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deliveredDateStr = order.deliveredDate ?? order.date;
    final deliveredTimeStr = order.deliveredTime ?? order.arrivalAroundTime;

    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      bottomNavigationBar: showBottomNav
          ? ThekaaBottomNavBar(
              currentIndex: 3, // Orders active
              onTap: (index) {
                if (onNavTap != null) {
                  onNavTap!(index);
                } else if (index == 0) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              },
            )
          : null,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header: < Order details
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              color: ThekaaColors.mainBackground,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _handleBack(context),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: ThekaaColors.cardBackground,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ThekaaColors.border,
                          width: 1.0,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 16,
                          color: ThekaaColors.primaryText,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    'Order details',
                    style: ThekaaTypography.sectionHeading.copyWith(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Delivered Status Banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F7F3),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFFC8E6C9),
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                              color: Color(0xFF2E7D32),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.check,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Order Delivered',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1B5E20),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Delivered on $deliveredDateStr at $deliveredTimeStr',
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF4C6A4E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Restaurant & Ordered Items Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: ThekaaColors.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: ThekaaColors.border,
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF4E8D8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.restaurant_outlined,
                                    size: 20,
                                    color: ThekaaColors.terracotta,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order.restaurantName,
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: ThekaaColors.primaryText,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${order.restaurantArea} · ${order.orderId}',
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF8F7D6D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Divider(
                              color: Color(0xFFEADBCE),
                              height: 1.0,
                              thickness: 1.0,
                            ),
                          ),

                          // Items List
                          ...order.items.map(
                            (item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${item.quantity} × ${item.name}',
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w500,
                                      color: ThekaaColors.primaryText,
                                    ),
                                  ),
                                  Text(
                                    '₹${(item.price * item.quantity).toInt()}',
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w600,
                                      color: ThekaaColors.primaryText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Bill Details Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: ThekaaColors.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: ThekaaColors.border,
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bill details',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: ThekaaColors.primaryText,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildBillRow('Item total', '₹${_itemTotal.toInt()}'),
                          const SizedBox(height: 8),
                          _buildBillRow('Delivery fee', '₹30'),
                          const SizedBox(height: 8),
                          _buildBillRow('Platform fee', '₹5'),
                          if (order.coinsRedeemed > 0) ...[
                            const SizedBox(height: 8),
                            _buildBillRow(
                              'Coins redeemed (${order.coinsRedeemed} TKC)',
                              '-₹${(order.coinsRedeemed * 0.25).toInt()}',
                              valueColor: const Color(0xFF2E7D32),
                            ),
                          ],
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Divider(
                              color: Color(0xFFEADBCE),
                              height: 1.0,
                              thickness: 1.0,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Final amount paid',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: ThekaaColors.primaryText,
                                ),
                              ),
                              Text(
                                '₹${order.totalPayable.toInt()}',
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: ThekaaColors.terracotta,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Delivery Address Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: ThekaaColors.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: ThekaaColors.border,
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Delivery address',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: ThekaaColors.primaryText,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.home_outlined,
                                size: 20,
                                color: ThekaaColors.terracotta,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order.deliveryAddress?.typeLabel ?? 'Home',
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w600,
                                        color: ThekaaColors.primaryText,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      order.deliveryAddress?.singleLineAddress ??
                                          'Flat 302, Vertex Heights, Gachibowli, Hyderabad 500032',
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF8F7D6D),
                                        height: 1.35,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Order Information Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: ThekaaColors.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: ThekaaColors.border,
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Order information',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: ThekaaColors.primaryText,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow('Order ID', order.orderId),
                          const SizedBox(height: 8),
                          _buildInfoRow('Order placed', '${order.date} · ${order.time}'),
                          const SizedBox(height: 8),
                          _buildInfoRow('Delivered at', '$deliveredDateStr · $deliveredTimeStr'),
                          const SizedBox(height: 8),
                          _buildInfoRow('Payment method', '${order.paymentMethodName} · Paid'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Action: Share food review
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton.icon(
                        onPressed: () => _handleShareReview(context),
                        icon: const Icon(Icons.edit_note_rounded, size: 20, color: ThekaaColors.terracotta),
                        label: const Text(
                          'Share food review',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600,
                            color: ThekaaColors.terracotta,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: ThekaaColors.cardBackground,
                          side: const BorderSide(
                            color: Color(0xFFDFC8B4),
                            width: 1.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
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

  Widget _buildBillRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6E5D4F),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: valueColor ?? ThekaaColors.primaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12.5,
            fontWeight: FontWeight.w400,
            color: Color(0xFF8F7D6D),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: ThekaaColors.primaryText,
          ),
        ),
      ],
    );
  }
}

