import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import 'cart_screen.dart';

class RestaurantMenuScreen extends StatefulWidget {
  final Restaurant restaurant;
  final VoidCallback onBack;
  final ValueChanged<int>? onBottomNavTap;

  const RestaurantMenuScreen({
    super.key,
    required this.restaurant,
    required this.onBack,
    this.onBottomNavTap,
  });

  @override
  State<RestaurantMenuScreen> createState() => _RestaurantMenuScreenState();
}

class _RestaurantMenuScreenState extends State<RestaurantMenuScreen> {
  late String _selectedCategory;
  final TextEditingController _searchController = TextEditingController();
  final Map<String, int> _cartQuantities = {};

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.restaurant.menuCategories.isNotEmpty
        ? widget.restaurant.menuCategories.first
        : 'Bestsellers';

    // Initialize with default items from screenshot (1 Chicken Biryani, 1 Mutton Biryani)
    if (widget.restaurant.bestsellers.isNotEmpty) {
      _cartQuantities[widget.restaurant.bestsellers[0].id] = 1;
    }
    if (widget.restaurant.bestsellers.length > 1) {
      _cartQuantities[widget.restaurant.bestsellers[1].id] = 1;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int get _totalItems => _cartQuantities.values.fold(0, (sum, q) => sum + q);

  double get _totalPrice {
    double total = 0;
    for (final entry in _cartQuantities.entries) {
      final item = widget.restaurant.bestsellers.firstWhere(
        (it) => it.id == entry.key,
        orElse: () => widget.restaurant.bestsellers.first,
      );
      total += item.price * entry.value;
    }
    return total;
  }

  void _increment(String id) {
    setState(() {
      _cartQuantities[id] = (_cartQuantities[id] ?? 0) + 1;
    });
  }

  void _decrement(String id) {
    setState(() {
      final current = _cartQuantities[id] ?? 0;
      if (current > 0) {
        _cartQuantities[id] = current - 1;
      }
    });
  }

  void _openCart() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CartScreen(
          restaurant: widget.restaurant,
          initialQuantities: _cartQuantities,
          onBack: () => Navigator.of(context).pop(),
          onAddMore: () => Navigator.of(context).pop(),
          onBottomNavTap: widget.onBottomNavTap,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = widget.restaurant;

    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable Menu Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // Eyebrow
                    Text(
                      '01 / FOOD DISCOVERY & ORDERING',
                      style: ThekaaTypography.eyebrow,
                    ),
                    const SizedBox(height: 6),

                    // Header: "< The menu"
                    Row(
                      children: [
                        GestureDetector(
                          onTap: widget.onBack,
                          behavior: HitTestBehavior.opaque,
                          child: const Padding(
                            padding: EdgeInsets.only(right: 8, top: 4, bottom: 4),
                            child: Icon(
                              Icons.chevron_left_rounded,
                              size: 26,
                              color: ThekaaColors.primaryText,
                            ),
                          ),
                        ),
                        Text(
                          'The menu',
                          style: ThekaaTypography.sectionHeading.copyWith(
                            fontSize: 24,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Compact Restaurant Info Banner
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: 52,
                            height: 52,
                            child: Image.asset(
                              restaurant.imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                restaurant.name,
                                style: ThekaaTypography.restaurantName.copyWith(
                                  fontSize: 16.5,
                                ),
                              ),
                              const SizedBox(height: 2),
                              if (restaurant.isVerified)
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle_outline,
                                      size: 13,
                                      color: ThekaaColors.verifiedGreen,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'THEKAA verified',
                                      style: ThekaaTypography.verifiedText.copyWith(
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_outline_rounded,
                                    size: 14,
                                    color: ThekaaColors.terracotta,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    restaurant.rating.toString(),
                                    style: ThekaaTypography.ratingText.copyWith(
                                      fontSize: 11.5,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '24–28 min',
                                    style: ThekaaTypography.deliveryInfo.copyWith(
                                      fontSize: 11.5,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Search Restaurant Menu Bar
                    Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: ThekaaColors.cardBackground,
                        borderRadius: BorderRadius.circular(23),
                        border: Border.all(
                          color: ThekaaColors.border,
                          width: 1.0,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            size: 19,
                            color: ThekaaColors.secondaryText,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: ThekaaTypography.searchInput.copyWith(fontSize: 13),
                              cursorColor: ThekaaColors.terracotta,
                              decoration: InputDecoration(
                                hintText: "Search ${restaurant.name}'s menu",
                                hintStyle: ThekaaTypography.searchPlaceholder.copyWith(fontSize: 13),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.tune,
                            size: 19,
                            color: ThekaaColors.mutedBrown,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Two-Column Layout: Sidebar Categories & Menu Items
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column: Category Sidebar
                        SizedBox(
                          width: 76,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: restaurant.menuCategories.map((cat) {
                              final isActive = _selectedCategory == cat;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedCategory = cat;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? ThekaaColors.cardBackground
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: isActive
                                        ? Border.all(color: ThekaaColors.border, width: 1.0)
                                        : null,
                                  ),
                                  child: Text(
                                    cat,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 11.5,
                                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                                      color: isActive
                                          ? ThekaaColors.primaryText
                                          : ThekaaColors.secondaryText,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Right Column: Dishes List
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selectedCategory,
                                style: ThekaaTypography.sectionHeading.copyWith(
                                  fontSize: 19,
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Bestseller Dish 1: Chicken Dum Biryani
                              if (restaurant.bestsellers.isNotEmpty) ...[
                                _buildDishItem(restaurant.bestsellers[0]),
                                const Divider(color: ThekaaColors.border, height: 24),
                              ],

                              // Bestseller Dish 2: Mutton Biryani
                              if (restaurant.bestsellers.length > 1) ...[
                                _buildDishItem(restaurant.bestsellers[1]),
                                const Divider(color: ThekaaColors.border, height: 24),
                              ],

                              // Non-vegetarian tagline & From the tandoor section
                              Text(
                                'Non-vegetarian · Freshly prepared',
                                style: ThekaaTypography.deliveryInfo.copyWith(fontSize: 11),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'From the tandoor',
                                style: ThekaaTypography.sectionHeading.copyWith(fontSize: 18),
                              ),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.asset(
                                  'assets/images/kebabs.png',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 105,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 105,
                                      color: ThekaaColors.border.withValues(alpha: 0.3),
                                      child: const Center(
                                        child: Icon(Icons.restaurant, color: ThekaaColors.secondaryText),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Fixed Bottom Cart Bar
            if (_totalItems > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                color: ThekaaColors.mainBackground,
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _openCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThekaaColors.terracotta,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$_totalItems items · ₹${_totalPrice.toInt()}',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          children: const [
                            Text(
                              'View cart',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward_rounded, size: 15),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Fixed Bottom Navigation (Explore is active)
            ThekaaBottomNavBar(
              currentIndex: 1,
              onTap: (index) {
                widget.onBottomNavTap?.call(index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDishItem(MenuItem dish) {
    final qty = _cartQuantities[dish.id] ?? 0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dish Thumbnail
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 66,
            height: 66,
            child: Image.asset(
              dish.imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Dish details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bestseller indicator
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC04B32),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'BESTSELLER',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: Color(0xFFC04B32),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),

              // Name
              Text(
                dish.name,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: ThekaaColors.primaryText,
                ),
              ),
              const SizedBox(height: 1),

              // Description
              Text(
                dish.description,
                style: ThekaaTypography.deliveryInfo.copyWith(fontSize: 11),
              ),
              const SizedBox(height: 4),

              // Price & Quantity Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₹${dish.price.toInt()}',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: ThekaaColors.primaryText,
                    ),
                  ),

                  // Quantity Selector pill: [ - qty + ]
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: ThekaaColors.cardBackground,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: ThekaaColors.border,
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => _decrement(dish.id),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Icon(Icons.remove, size: 14, color: ThekaaColors.primaryText),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            qty.toString(),
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: ThekaaColors.primaryText,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _increment(dish.id),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Icon(Icons.add, size: 14, color: ThekaaColors.terracotta),
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
      ],
    );
  }
}

