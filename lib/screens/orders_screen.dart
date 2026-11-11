import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../services/order_repository.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import 'completed_order_details_screen.dart';
import 'order_tracking_screen.dart';

class OrdersScreen extends StatelessWidget {
  final bool showBottomNav;
  final ValueChanged<int>? onNavTap;
  final VoidCallback? onBack;

  const OrdersScreen({
    super.key,
    this.showBottomNav = false,
    this.onNavTap,
    this.onBack,
  });

  void _navigateToOrder(BuildContext context, OrderConfirmation order) {
    if (order.trackingStatus == OrderTrackingStatus.delivered) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CompletedOrderDetailsScreen(
            order: order,
          ),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OrderTrackingScreen(
            order: order,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      appBar: AppBar(
        backgroundColor: ThekaaColors.mainBackground,
        elevation: 0,
        centerTitle: false,
        title: Text('Your Orders', style: ThekaaTypography.sectionHeading),
      ),
      bottomNavigationBar: showBottomNav
          ? ThekaaBottomNavBar(
              currentIndex: 3,
              onTap: (index) {
                if (onNavTap != null) {
                  onNavTap!(index);
                } else if (index == 0) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              },
            )
          : null,
      body: ListenableBuilder(
        listenable: OrderRepository.instance,
        builder: (context, _) {
          final orders = OrderRepository.instance.orders;

          if (orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.receipt_long_outlined,
                    size: 54,
                    color: ThekaaColors.terracotta,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No active orders right now',
                    style: ThekaaTypography.restaurantName,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Craving Shadab Biryani? Order from home!',
                    style: ThekaaTypography.deliveryInfo,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 8.0, bottom: 24.0),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final isDelivered = order.trackingStatus == OrderTrackingStatus.delivered;

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: ThekaaColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: ThekaaColors.border,
                    width: 1.0,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => _navigateToOrder(context, order),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Restaurant and Status Header Row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 42,
                                height: 42,
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
                              // Status Pill
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isDelivered
                                      ? const Color(0xFFE8F5E9)
                                      : const Color(0xFFFDEFE9),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isDelivered
                                        ? const Color(0xFFC8E6C9)
                                        : const Color(0xFFDFC8B4),
                                    width: 1.0,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      isDelivered
                                          ? Icons.check_circle_outline_rounded
                                          : Icons.access_time_rounded,
                                      size: 13,
                                      color: isDelivered
                                          ? const Color(0xFF2E7D32)
                                          : ThekaaColors.terracotta,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      isDelivered ? 'Delivered' : 'In progress',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w600,
                                        color: isDelivered
                                            ? const Color(0xFF2E7D32)
                                            : ThekaaColors.terracotta,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Divider(
                              color: Color(0xFFEADBCE),
                              height: 1.0,
                              thickness: 1.0,
                            ),
                          ),

                          // Items List Summary
                          ...order.items.map(
                            (item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2.0),
                              child: Text(
                                '${item.quantity} × ${item.name}',
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: ThekaaColors.primaryText,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),
                          Text(
                            '${order.date} · ${order.time}',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11.5,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF8F7D6D),
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Divider(
                              color: Color(0xFFEADBCE),
                              height: 1.0,
                              thickness: 1.0,
                            ),
                          ),

                          // Bottom Row: Total and Action
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₹${order.totalPayable.toInt()}',
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.w700,
                                  color: ThekaaColors.primaryText,
                                ),
                              ),
                              isDelivered
                                  ? OutlinedButton.icon(
                                      onPressed: () => _navigateToOrder(context, order),
                                      icon: const Icon(
                                        Icons.receipt_outlined,
                                        size: 16,
                                        color: ThekaaColors.terracotta,
                                      ),
                                      label: const Text(
                                        'Order details',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w600,
                                          color: ThekaaColors.terracotta,
                                        ),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        side: const BorderSide(
                                          color: Color(0xFFDFC8B4),
                                          width: 1.0,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    )
                                  : ElevatedButton.icon(
                                      onPressed: () => _navigateToOrder(context, order),
                                      icon: const Icon(
                                        Icons.alt_route_rounded,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      label: const Text(
                                        'Track order',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        backgroundColor: ThekaaColors.terracotta,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
