import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../theme/thekaa_colors.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_avatar_section.dart';
import '../widgets/profile_stats_row.dart';
import '../widgets/edit_profile_button.dart';
import '../widgets/profile_coins_card.dart';
import '../widgets/profile_menu_container.dart';

class ProfileScreen extends StatelessWidget {
  final UserProfile profile;
  final bool showBottomNav;
  final ValueChanged<int>? onBottomNavTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onEditProfile;
  final VoidCallback? onViewWallet;
  final VoidCallback? onAccountDetails;
  final VoidCallback? onSavedAddresses;
  final VoidCallback? onFoodPreferences;
  final VoidCallback? onHelpSupport;

  const ProfileScreen({
    super.key,
    this.profile = UserProfile.defaultProfile,
    this.showBottomNav = true,
    this.onBottomNavTap,
    this.onSettingsTap,
    this.onEditProfile,
    this.onViewWallet,
    this.onAccountDetails,
    this.onSavedAddresses,
    this.onFoodPreferences,
    this.onHelpSupport,
  });

  void _showFeedback(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
        duration: const Duration(seconds: 1),
        backgroundColor: ThekaaColors.primaryText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      bottomNavigationBar: showBottomNav
          ? ThekaaBottomNavBar(
              currentIndex: 4,
              onTap: onBottomNavTap ?? (_) {},
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Header: "My THEKAA" + Settings Icon
              ProfileHeader(
                onSettingsTap: onSettingsTap ??
                    () => _showFeedback(context, 'Settings tapped'),
              ),
              const SizedBox(height: 12),

              // Avatar, Name, Handle, Bio
              ProfileAvatarSection(profile: profile),
              const SizedBox(height: 18),

              // Stats Row: Posts | Followers | Following
              ProfileStatsRow(profile: profile),
              const SizedBox(height: 18),

              // Edit Profile Button
              EditProfileButton(
                onEditProfile: onEditProfile ??
                    () => _showFeedback(context, 'Edit profile tapped'),
              ),
              const SizedBox(height: 14),

              // THEKAA Coins Card
              ProfileCoinsCard(
                profile: profile,
                onViewWallet: onViewWallet ??
                    () => _showFeedback(context, 'View wallet tapped'),
              ),
              const SizedBox(height: 14),

              // Menu Container (Account details, Addresses, Food prefs, Help)
              ProfileMenuContainer(
                onAccountDetails: onAccountDetails ??
                    () => _showFeedback(context, 'Account details tapped'),
                onSavedAddresses: onSavedAddresses ??
                    () => _showFeedback(context, 'Saved addresses tapped'),
                onFoodPreferences: onFoodPreferences ??
                    () => _showFeedback(context, 'Food preferences tapped'),
                onHelpSupport: onHelpSupport ??
                    () => _showFeedback(context, 'Help & Support tapped'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
