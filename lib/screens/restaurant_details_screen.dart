import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/restaurant_details_header.dart';
import '../widgets/restaurant_hero_image.dart';
import '../widgets/restaurant_info_section.dart';
import '../widgets/restaurant_statistics.dart';
import '../widgets/restaurant_description_and_tags.dart';
import '../widgets/restaurant_tabs.dart';
import '../widgets/bestseller_section.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import 'restaurant_menu_screen.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final Restaurant restaurant;
  final VoidCallback onBack;
  final ValueChanged<int>? onBottomNavTap;

  const RestaurantDetailsScreen({
    super.key,
    required this.restaurant,
    required this.onBack,
    this.onBottomNavTap,
  });

  @override
  State<RestaurantDetailsScreen> createState() => _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  RestaurantDetailTab _activeTab = RestaurantDetailTab.menu;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _openFullMenu() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RestaurantMenuScreen(
          restaurant: widget.restaurant,
          onBack: () => Navigator.of(context).pop(),
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
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // A. TOP HEADER
                    RestaurantDetailsHeader(
                      restaurantName: restaurant.name,
                      onBack: widget.onBack,
                      onFavouriteTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Updated favourites for ${restaurant.name}'),
                            duration: const Duration(seconds: 1),
                            backgroundColor: ThekaaColors.terracotta,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 14),

                    // B. RESTAURANT HERO IMAGE
                    RestaurantHeroImage(
                      imagePath: restaurant.imagePath,
                    ),
                    const SizedBox(height: 14),

                    // C. RESTAURANT INFORMATION
                    RestaurantInfoSection(
                      restaurant: restaurant,
                    ),
                    const SizedBox(height: 14),

                    // D. RESTAURANT STATISTICS
                    RestaurantStatistics(
                      statistics: restaurant.statistics,
                    ),
                    const SizedBox(height: 14),

                    // E. RESTAURANT DESCRIPTION & F. CUISINE TAGS
                    RestaurantDescriptionAndTags(
                      description: restaurant.description,
                      tags: restaurant.cuisineTags,
                    ),
                    const SizedBox(height: 16),

                    // G. RESTAURANT CONTENT TABS
                    RestaurantTabs(
                      activeTab: _activeTab,
                      onTabChanged: (tab) {
                        setState(() {
                          _activeTab = tab;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // TAB CONTENT
                    if (_activeTab == RestaurantDetailTab.menu) ...[
                      // H. BESTSELLERS SECTION
                      BestsellerSection(
                        items: restaurant.bestsellers,
                        onItemTap: (item) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added ${item.name} to order'),
                              duration: const Duration(seconds: 1),
                              backgroundColor: ThekaaColors.terracotta,
                            ),
                          );
                        },
                      ),
                    ] else if (_activeTab == RestaurantDetailTab.reviews) ...[
                      // REVIEWS TAB CONTENT
                      Text(
                        'Customer Reviews',
                        style: ThekaaTypography.sectionHeading.copyWith(fontSize: 19),
                      ),
                      const SizedBox(height: 12),
                      ...restaurant.reviews.map((rev) => Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: ThekaaColors.cardBackground,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: ThekaaColors.border),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      rev.author,
                                      style: ThekaaTypography.restaurantName.copyWith(fontSize: 14.5),
                                    ),
                                    Text(
                                      rev.date,
                                      style: ThekaaTypography.deliveryInfo.copyWith(fontSize: 11),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: List.generate(
                                    5,
                                    (i) => Icon(
                                      i < rev.rating.floor()
                                          ? Icons.star_rounded
                                          : Icons.star_half_rounded,
                                      size: 14,
                                      color: const Color(0xFFD49A32),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  rev.comment,
                                  style: ThekaaTypography.deliveryInfo.copyWith(
                                    fontSize: 12,
                                    color: ThekaaColors.primaryText,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ] else ...[
                      // ABOUT TAB CONTENT
                      Text(
                        'About ${restaurant.name}',
                        style: ThekaaTypography.sectionHeading.copyWith(fontSize: 19),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: ThekaaColors.cardBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: ThekaaColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant.about,
                              style: ThekaaTypography.deliveryInfo.copyWith(
                                fontSize: 13,
                                height: 1.45,
                                color: const Color(0xFF6B584B),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, size: 16, color: ThekaaColors.terracotta),
                                const SizedBox(width: 6),
                                Text(
                                  'Locality: ${restaurant.locality}',
                                  style: ThekaaTypography.deliveryInfo.copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.timer_outlined, size: 16, color: ThekaaColors.terracotta),
                                const SizedBox(width: 6),
                                Text(
                                  'Delivery: 24–28 mins',
                                  style: ThekaaTypography.deliveryInfo.copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // I. FIXED BOTTOM ACTION BUTTON
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: ThekaaColors.mainBackground,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _openFullMenu,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThekaaColors.terracotta,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Explore the menu',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward_rounded, size: 16),
                    ],
                  ),
                ),
              ),
            ),

            // J. BOTTOM NAVIGATION (Explore is active item)
            ThekaaBottomNavBar(
              currentIndex: 1, // Explore is active
              onTap: (index) {
                widget.onBottomNavTap?.call(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}

