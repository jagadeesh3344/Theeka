import 'dart:async';
import 'package:flutter/material.dart';
import '../models/address.dart';
import '../models/foodie_discovery.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';
import '../widgets/achievement_badge_icon.dart';
import '../widgets/achievement_card.dart';
import '../widgets/discovery_header.dart';
import '../widgets/discovery_validation_card.dart';
import '../widgets/foodie_badge_info_card.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import 'review_reward_screen.dart';

class FoodieDiscoveryScreen extends StatefulWidget {
  final Restaurant restaurant;
  final Map<String, int> cartQuantities;
  final DeliveryAddress? deliveryAddress;
  final double originalOrderValue;
  final double finalPayableAmount;
  final int coinsRedeemed;
  final int coinBalance;
  final UserDiscoveryProfile? userProfile;
  final VoidCallback? onBack;
  final VoidCallback? onProceedToReward;
  final bool autoAdvance;
  final Duration autoAdvanceDuration;

  const FoodieDiscoveryScreen({
    super.key,
    required this.restaurant,
    this.cartQuantities = const {},
    this.deliveryAddress,
    this.originalOrderValue = 655.0,
    this.finalPayableAmount = 655.0,
    this.coinsRedeemed = 0,
    this.coinBalance = 1200,
    this.userProfile,
    this.onBack,
    this.onProceedToReward,
    this.autoAdvance = false,
    this.autoAdvanceDuration = const Duration(seconds: 3),
  });

  @override
  State<FoodieDiscoveryScreen> createState() => _FoodieDiscoveryScreenState();
}

class _FoodieDiscoveryScreenState extends State<FoodieDiscoveryScreen> {
  Timer? _advanceTimer;
  late final UserDiscoveryProfile _profile;

  @override
  void initState() {
    super.initState();
    _profile = widget.userProfile ?? UserDiscoveryProfile.defaultProfile();

    if (widget.autoAdvance) {
      _advanceTimer = Timer(widget.autoAdvanceDuration, () {
        if (mounted) {
          _proceedToNextScreen();
        }
      });
    }
  }

  @override
  void dispose() {
    _advanceTimer?.cancel();
    super.dispose();
  }

  void _proceedToNextScreen() {
    _advanceTimer?.cancel();
    if (widget.onProceedToReward != null) {
      widget.onProceedToReward!();
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ReviewRewardScreen(
            restaurant: widget.restaurant,
            onBack: () => Navigator.of(context).pop(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _proceedToNextScreen,
          child: Column(
            children: [
              DiscoveryHeader(
                onBack: () {
                  _advanceTimer?.cancel();
                  if (widget.onBack != null) {
                    widget.onBack!();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Card 1: THEKAA Foodie
                      AchievementCard(
                        achievement: _profile.thekaaFoodie,
                        iconType: AchievementIconType.foodie,
                      ),
                      // Card 2: Top Reviewer
                      AchievementCard(
                        achievement: _profile.topReviewer,
                        iconType: AchievementIconType.topReviewer,
                      ),
                      // Card 3: Food Explorer
                      AchievementCard(
                        achievement: _profile.foodExplorer,
                        iconType: AchievementIconType.foodExplorer,
                      ),
                      // Foodie badge info card
                      FoodieBadgeInfoCard(profile: _profile),
                      // Discovery validation notice card
                      DiscoveryValidationCard(profile: _profile),
                    ],
                  ),
                ),
              ),
              // Fixed Bottom Navigation with Profile active (index 4)
              ThekaaBottomNavBar(
                currentIndex: 4,
                onTap: (index) {
                  _advanceTimer?.cancel();
                  // Standard bottom navigation behavior
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

