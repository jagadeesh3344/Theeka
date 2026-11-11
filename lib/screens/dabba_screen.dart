import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import 'social_feed_screen.dart';

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
    return SocialFeedScreen(
      showBottomNav: false,
      onNavTap: onBottomNavTap,
    );
  }
}
