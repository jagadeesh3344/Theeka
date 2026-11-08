import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class ProfileMenuContainer extends StatelessWidget {
  final VoidCallback? onAccountDetails;
  final VoidCallback? onSavedAddresses;
  final VoidCallback? onFoodPreferences;
  final VoidCallback? onHelpSupport;

  const ProfileMenuContainer({
    super.key,
    this.onAccountDetails,
    this.onSavedAddresses,
    this.onFoodPreferences,
    this.onHelpSupport,
  });

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.vertical(
          top: isFirst ? const Radius.circular(18) : Radius.zero,
          bottom: isLast ? const Radius.circular(18) : Radius.zero,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 13.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon rounded square
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3ECE0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 20,
                    color: ThekaaColors.terracotta,
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Title and Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontFamily: 'Inter',
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: ThekaaTypography.deliveryInfo.copyWith(
                        fontSize: 11.5,
                        color: ThekaaColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),

              // Chevron right
              const Icon(
                Icons.chevron_right,
                size: 18,
                color: Color(0xFFB8A99B),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFAF6EE),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFEADBCE),
            width: 1.0,
          ),
        ),
        child: Column(
          children: [
            _buildMenuItem(
              icon: Icons.person_outline_rounded,
              title: 'Account details',
              subtitle: 'Personal information & sign-in',
              onTap: onAccountDetails,
              isFirst: true,
            ),
            const Divider(
              height: 1,
              thickness: 0.8,
              color: Color(0xFFEADBCE),
              indent: 16,
              endIndent: 16,
            ),
            _buildMenuItem(
              icon: Icons.location_on_outlined,
              title: 'Saved addresses',
              subtitle: 'Home, Work & your favourite places',
              onTap: onSavedAddresses,
            ),
            const Divider(
              height: 1,
              thickness: 0.8,
              color: Color(0xFFEADBCE),
              indent: 16,
              endIndent: 16,
            ),
            _buildMenuItem(
              icon: Icons.restaurant_outlined,
              title: 'Food preferences',
              subtitle: 'Make discovery feel more like you',
              onTap: onFoodPreferences,
            ),
            const Divider(
              height: 1,
              thickness: 0.8,
              color: Color(0xFFEADBCE),
              indent: 16,
              endIndent: 16,
            ),
            _buildMenuItem(
              icon: Icons.verified_user_outlined,
              title: 'Help & Support',
              subtitle: 'Your account, your control',
              onTap: onHelpSupport,
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }
}

