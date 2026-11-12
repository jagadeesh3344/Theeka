import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/profile_repository.dart';
import '../theme/thekaa_colors.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_avatar_section.dart';
import '../widgets/profile_stats_row.dart';
import '../widgets/edit_profile_button.dart';
import '../widgets/profile_coins_card.dart';
import '../widgets/profile_menu_container.dart';
import 'edit_profile_screen.dart';
import 'food_preferences_screen.dart';
import 'help_support_screen.dart';
import 'manage_posts_screen.dart';
import 'saved_addresses_screen.dart';
import 'thekaa_coins_screen.dart';

class ProfileScreen extends StatelessWidget {
  final UserProfile? profile;
  final bool showBottomNav;
  final ValueChanged<int>? onBottomNavTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onEditProfile;
  final VoidCallback? onEditPosts;
  final VoidCallback? onViewWallet;
  final VoidCallback? onAccountDetails;
  final VoidCallback? onSavedAddresses;
  final VoidCallback? onFoodPreferences;
  final VoidCallback? onHelpSupport;

  const ProfileScreen({
    super.key,
    this.profile,
    this.showBottomNav = true,
    this.onBottomNavTap,
    this.onSettingsTap,
    this.onEditProfile,
    this.onEditPosts,
    this.onViewWallet,
    this.onAccountDetails,
    this.onSavedAddresses,
    this.onFoodPreferences,
    this.onHelpSupport,
  });

  void _handleAccountDetails(BuildContext context) {
    if (onAccountDetails != null) {
      onAccountDetails!();
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EditProfileScreen(
          profile: ProfileRepository.instance.profile,
          onSaveProfile: (updated) {
            ProfileRepository.instance.updateProfile(updated);
          },
          onBack: () => Navigator.of(context).maybePop(),
        ),
      ),
    );
  }

  void _handleSavedAddresses(BuildContext context) {
    if (onSavedAddresses != null) {
      onSavedAddresses!();
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SavedAddressesScreen(
          addresses: ProfileRepository.instance.savedAddresses,
          onBack: () => Navigator.of(context).maybePop(),
        ),
      ),
    );
  }

  void _handleFoodPreferences(BuildContext context) {
    if (onFoodPreferences != null) {
      onFoodPreferences!();
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FoodPreferencesScreen(
          initialPreference: ProfileRepository.instance.foodPreference,
          onBack: () => Navigator.of(context).maybePop(),
        ),
      ),
    );
  }

  void _handleHelpSupport(BuildContext context) {
    if (onHelpSupport != null) {
      onHelpSupport!();
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => HelpSupportScreen(
          onBack: () => Navigator.of(context).maybePop(),
        ),
      ),
    );
  }

  void _handleEditPosts(BuildContext context) {
    if (onEditPosts != null) {
      onEditPosts!();
      return;
    }
    if (onEditProfile != null) {
      onEditProfile!();
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ManagePostsScreen(
          onBack: () => Navigator.of(context).maybePop(),
        ),
      ),
    );
  }

  void _handleViewWallet(BuildContext context) {
    if (onViewWallet != null) {
      onViewWallet!();
      return;
    }
    final activeProfile = profile ?? ProfileRepository.instance.profile;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ThekaaCoinsScreen(
          profile: activeProfile,
          onBack: () => Navigator.of(context).maybePop(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ProfileRepository.instance,
      builder: (context, _) {
        final activeProfile = profile ?? ProfileRepository.instance.profile;
        return Scaffold(
          backgroundColor: ThekaaColors.mainBackground,
          bottomNavigationBar: showBottomNav
              ? ThekaaBottomNavBar(
                  currentIndex: 4,
                  onTap: onBottomNavTap,
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
                    onSettingsTap: onSettingsTap ?? () => _handleAccountDetails(context),
                  ),
                  const SizedBox(height: 12),

                  // Avatar, Name, Handle, Bio
                  ProfileAvatarSection(profile: activeProfile),
                  const SizedBox(height: 18),

                  // Stats Row: Posts | Followers | Following
                  ProfileStatsRow(profile: activeProfile),
                  const SizedBox(height: 18),

                  // Edit Profile / Edit Posts Button
                  EditProfileButton(
                    onEditProfile: () => _handleEditPosts(context),
                  ),
                  const SizedBox(height: 14),

                  // THEKAA Coins Card
                  ProfileCoinsCard(
                    profile: activeProfile,
                    onViewWallet: () => _handleViewWallet(context),
                  ),
                  const SizedBox(height: 14),

                  // Menu Container (Account details, Addresses, Food prefs, Help)
                  ProfileMenuContainer(
                    onAccountDetails: () => _handleAccountDetails(context),
                    onSavedAddresses: () => _handleSavedAddresses(context),
                    onFoodPreferences: () => _handleFoodPreferences(context),
                    onHelpSupport: () => _handleHelpSupport(context),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
