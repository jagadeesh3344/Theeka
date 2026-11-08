import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import 'cart_screen.dart';

class DabbaScreen extends StatelessWidget {
  final Restaurant? activeRestaurant;
  final ValueChanged<int>? onBottomNavTap;

  const DabbaScreen({
    super.key,
    this.activeRestaurant,
    this.onBottomNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final restaurant = activeRestaurant ?? Restaurant.shadabBiryani;

    return CartScreen(
      restaurant: restaurant,
      initialQuantities: {
        if (restaurant.bestsellers.isNotEmpty) restaurant.bestsellers[0].id: 1,
        if (restaurant.bestsellers.length > 1) restaurant.bestsellers[1].id: 1,
      },
      showBottomNav: false, // Parent MainScaffold provides the single bottom navigation bar
      onBack: () {
        onBottomNavTap?.call(0); // Return to Home
      },
      onAddMore: () {
        onBottomNavTap?.call(1); // Go to Explore
      },
      onBottomNavTap: onBottomNavTap,
    );
  }
}
