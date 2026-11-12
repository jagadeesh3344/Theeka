import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';
import '../widgets/review_order_header.dart';
import '../widgets/review_order_items_card.dart';
import '../widgets/review_bill_details_card.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import 'address_selection_screen.dart';

class ReviewOrderScreen extends StatefulWidget {
  final Restaurant restaurant;
  final Map<String, int>? initialCartQuantities;
  final bool isCoinsApplied;
  final VoidCallback? onBack;
  final VoidCallback? onAddMore;
  final VoidCallback? onContinue;
  final bool showBottomNav;
  final ValueChanged<int>? onBottomNavTap;

  const ReviewOrderScreen({
    super.key,
    required this.restaurant,
    this.initialCartQuantities,
    this.isCoinsApplied = false,
    this.onBack,
    this.onAddMore,
    this.onContinue,
    this.showBottomNav = true,
    this.onBottomNavTap,
  });

  @override
  State<ReviewOrderScreen> createState() => _ReviewOrderScreenState();
}

class _ReviewOrderScreenState extends State<ReviewOrderScreen> {
  late Map<String, int> _cartQuantities;
  late bool _isCoinsApplied;

  @override
  void initState() {
    super.initState();
    _isCoinsApplied = widget.isCoinsApplied;

    if (widget.initialCartQuantities != null && widget.initialCartQuantities!.isNotEmpty) {
      _cartQuantities = Map<String, int>.from(widget.initialCartQuantities!);
    } else {
      // Default sample items matching screenshot if empty
      _cartQuantities = {};
      final items = widget.restaurant.menuItems;
      if (items.isNotEmpty) {
        _cartQuantities[items[0].id] = 1;
      }
      if (items.length > 1) {
        _cartQuantities[items[1].id] = 1;
      }
    }
  }

  void _increment(String itemId) {
    setState(() {
      _cartQuantities[itemId] = (_cartQuantities[itemId] ?? 0) + 1;
    });
  }

  void _decrement(String itemId) {
    setState(() {
      final current = _cartQuantities[itemId] ?? 0;
      if (current > 1) {
        _cartQuantities[itemId] = current - 1;
      } else {
        _cartQuantities.remove(itemId);
      }
    });
  }

  double get _itemTotal {
    double total = 0.0;
    _cartQuantities.forEach((itemId, qty) {
      if (qty > 0) {
        final item = widget.restaurant.menuItems.firstWhere(
          (m) => m.id == itemId,
          orElse: () => MenuItem(
            id: itemId,
            name: 'Item',
            description: '',
            price: 0,
            imagePath: '',
          ),
        );
        total += item.price * qty;
      }
    });
    return total;
  }

  double get _deliveryFee => _totalItems > 0 ? widget.restaurant.deliveryFee : 0.0;
  double get _platformFee => _totalItems > 0 ? 5.0 : 0.0;
  int get _coinsRedeemed => (_isCoinsApplied && _totalItems > 0) ? 50 : 0;

  double get _finalPayable {
    if (_totalItems == 0) return 0.0;
    final amount = _itemTotal + _deliveryFee + _platformFee - _coinsRedeemed;
    return amount > 0 ? amount : 0;
  }

  int get _totalItems => _cartQuantities.values.fold<int>(0, (sum, q) => sum + q);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // SECTION A — TOP HEADER WITH BREADCRUMBS
                    ReviewOrderHeader(
                      onBack: widget.onBack ?? () => Navigator.of(context).maybePop(),
                    ),
                    const SizedBox(height: 16),

                    // SECTION B — ORDER ITEMS CARD
                    ReviewOrderItemsCard(
                      restaurant: widget.restaurant,
                      cartQuantities: _cartQuantities,
                      onIncrement: _increment,
                      onDecrement: _decrement,
                      onAddMore: widget.onAddMore ?? widget.onBack ?? () => Navigator.of(context).maybePop(),
                    ),
                    const SizedBox(height: 14),

                    // SECTION C — BILL DETAILS CARD
                    ReviewBillDetailsCard(
                      itemTotal: _itemTotal,
                      deliveryFee: _deliveryFee,
                      platformFee: _platformFee,
                      coinsRedeemed: _coinsRedeemed,
                      finalPayable: _finalPayable,
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // SECTION D — BOTTOM STICKY BUTTON (No bottom nav)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: ThekaaColors.mainBackground,
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _totalItems > 0
                      ? () {
                          if (widget.onContinue != null) {
                            widget.onContinue!();
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AddressSelectionScreen(
                                  restaurant: widget.restaurant,
                                  cartQuantities: _cartQuantities,
                                  isCoinsApplied: _isCoinsApplied,
                                  onBack: () => Navigator.of(context).pop(),
                                ),
                              ),
                            );
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThekaaColors.terracotta,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: ThekaaColors.secondaryText.withValues(alpha: 0.4),
                    disabledForegroundColor: Colors.white.withValues(alpha: 0.6),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _totalItems > 0
                            ? 'Continue · ₹${_finalPayable.toInt()}'
                            : 'Order is empty',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (_totalItems > 0) ...[
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_forward_rounded, size: 16),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.showBottomNav
          ? ThekaaBottomNavBar(
              currentIndex: 2, // DABBA active during checkout flow
              onTap: widget.onBottomNavTap,
            )
          : null,
    );
  }
}
