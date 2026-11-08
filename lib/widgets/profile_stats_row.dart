import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class ProfileStatsRow extends StatelessWidget {
  final UserProfile profile;

  const ProfileStatsRow({
    super.key,
    required this.profile,
  });

  Widget _buildStatColumn({
    required String value,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: ThekaaTypography.sectionHeading.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ThekaaColors.primaryText,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: ThekaaTypography.deliveryInfo.copyWith(
            fontSize: 12,
            color: ThekaaColors.secondaryText,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: _buildStatColumn(
              value: '${profile.postsCount}',
              label: 'Posts',
            ),
          ),
          Expanded(
            child: _buildStatColumn(
              value: profile.followersCount,
              label: 'Followers',
            ),
          ),
          Expanded(
            child: _buildStatColumn(
              value: '${profile.followingCount}',
              label: 'Following',
            ),
          ),
        ],
      ),
    );
  }
}

