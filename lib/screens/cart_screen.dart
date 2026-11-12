import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';
import '../widgets/cart_header.dart';
import '../widgets/cart_restaurant_info.dart';
import '../widgets/cart_items_card.dart';
import '../widgets/thekaa_coins_card.dart';
import '../widgets/bill_details_card.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import 'review_order_screen.dart';

class CartScreen extends StatefulWidget {
  final Restaurant restaurant;
  final Map<String, int> initialQuantities;
  final VoidCallback onBack;
  final VoidCallback? onAddMore;
  final VoidCallback? onProceedToCheckout;
  final ValueChanged<int>? onBottomNavTap;
  final bool showBottomNav;

  const CartScreen({
    super.key,
    required this.restaurant,
    required this.initialQuantities,
    required this.onBack,
    this.onAddMore,
    this.onProceedToCheckout,
    this.onBottomNavTap,
    this.showBottomNav = true,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Map<String, int> _cartQuantities;
  bool _isCoinsApplied = false;

  @override
  void initState() {
    super.initState();
    _cartQuantities = Map<String, int>.from(widget.initialQuantities);
  }

  int get _totalItems => _cartQuantities.values.fold(0, (sum, q) => sum + q);

  double get _itemTotal {
    double total = 0;
    for (final entry in _cartQuantities.entries) {
      if (entry.value > 0) {
        final item = widget.restaurant.bestsellers.firstWhere(
          (it) => it.id == entry.key,
          orElse: () => widget.restaurant.bestsellers.first,
        );
        total += item.price * entry.value;
      }
    }
    return total;
  }

  double get _deliveryFee => _totalItems > 0 ? widget.restaurant.deliveryFee : 0;
  double get _platformFee => _totalItems > 0 ? 5.0 : 0;
  double get _coinsDiscount => _isCoinsApplied && _totalItems > 0 ? 50.0 : 0;

  double get _finalPayable {
    if (_totalItems == 0) return 0;
    return _itemTotal + _deliveryFee + _platformFee - _coinsDiscount;
  }

  void _increment(String id) {
    setState(() {
      _cartQuantities[id] = (_cartQuantities[id] ?? 0) + 1;
    });
  }

  void _decrement(String id) {
    setState(() {
      final current = _cartQuantities[id] ?? 0;
      if (current > 1) {
        _cartQuantities[id] = current - 1;
      } else {
        _cartQuantities.remove(id);
      }
    });
  }

  void _delete(String id) {
    setState(() {
      _cartQuantities.remove(id);
    });
  }

  void _toggleCoins() {
    setState(() {
      _isCoinsApplied = !_isCoinsApplied;
    });
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = widget.restaurant;

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

                    // SECTION A — TOP HEADER
                    CartHeader(
                      onBack: widget.onBack,
                    ),
                    const SizedBox(height: 16),

                    // SECTION B — RESTAURANT IDENTIFICATION
                    CartRestaurantInfo(
                      restaurant: restaurant,
                    ),
                    const SizedBox(height: 16),

                    // SECTION C & D — SELECTED CART ITEMS & ADD MORE
                    CartItemsCard(
                      restaurant: restaurant,
                      cartQuantities: _cartQuantities,
                      onIncrement: _increment,
                      onDecrement: _decrement,
                      onDelete: _delete,
                      onAddMore: widget.onAddMore ?? widget.onBack,
                    ),
                    const SizedBox(height: 14),

                    // SECTION E — THEKAA COINS CARD
                    ThekaaCoinsCard(
                      isCoinsApplied: _isCoinsApplied,
                      onToggleCoins: _toggleCoins,
                    ),
                    const SizedBox(height: 14),

                    // SECTION F — BILL DETAILS CARD
                    BillDetailsCard(
                      itemTotal: _itemTotal,
                      deliveryFee: _deliveryFee,
                      platformFee: _platformFee,
                      isCoinsApplied: _isCoinsApplied,
                      finalPayable: _finalPayable,
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // SECTION G — FIXED CHECKOUT BUTTON
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: ThekaaColors.mainBackground,
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _totalItems > 0
                      ? () {
                          if (widget.onProceedToCheckout != null) {
                            widget.onProceedToCheckout!();
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ReviewOrderScreen(
                                  restaurant: restaurant,
                                  initialCartQuantities: _cartQuantities,
                                  isCoinsApplied: _isCoinsApplied,
                                  onBack: () => Navigator.of(context).pop(),
                                  onAddMore: () {
                                    Navigator.of(context).pop();
                                    if (widget.onAddMore != null) {
                                      widget.onAddMore!();
                                    } else {
                                      widget.onBack();
                                    }
                                  },
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
                            ? 'Proceed to checkout · ₹${_finalPayable.toInt()}'
                            : 'Your cart is empty',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
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
              currentIndex: 2, // DABBA is active on Cart Screen
              onTap: widget.onBottomNavTap,
            )
          : null,
    );
  }
}

