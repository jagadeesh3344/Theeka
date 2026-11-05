import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';
import '../widgets/home_header.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/hero_introduction.dart';
import '../widgets/food_map_section.dart';
import '../widgets/handpicked_section.dart';

class HomeScreen extends StatefulWidget {
  final String location;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onLocationTap;
  final VoidCallback? onExploreMapTap;
  final VoidCallback? onSeeAllTap;
  final ValueChanged<Restaurant>? onRestaurantTap;

  const HomeScreen({
    super.key,
    this.location = 'Gachibowli',
    this.onNotificationTap,
    this.onLocationTap,
    this.onExploreMapTap,
    this.onSeeAllTap,
    this.onRestaurantTap,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // SECTION 1 — TOP HEADER
              HomeHeader(
                location: widget.location,
                onNotificationTap: widget.onNotificationTap,
                onLocationTap: widget.onLocationTap,
              ),
              const SizedBox(height: 16),

              // SECTION 2 — SEARCH BAR
              SearchBarWidget(
                controller: _searchController,
                onFilterTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Filter options'),
                      duration: Duration(seconds: 1),
                      backgroundColor: ThekaaColors.terracotta,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // SECTION 3 — HERO INTRODUCTION
              const HeroIntroduction(),
              const SizedBox(height: 22),

              // SECTION 4 — TODAY'S FOOD MAP
              FoodMapSection(
                onExploreTap: widget.onExploreMapTap,
                onLocationControlTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Centering on Gachibowli, Hyderabad'),
                      duration: Duration(seconds: 1),
                      backgroundColor: ThekaaColors.terracotta,
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // SECTION 5 — HANDPICKED FOR YOU
              HandpickedSection(
                onSeeAllTap: widget.onSeeAllTap,
                onRestaurantTap: widget.onRestaurantTap,
              ),

              // Bottom spacing to ensure content clears navigation bar
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

