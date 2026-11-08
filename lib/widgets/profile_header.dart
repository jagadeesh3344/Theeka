import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class ProfileHeader extends StatelessWidget {
  final VoidCallback? onSettingsTap;

  const ProfileHeader({
    super.key,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'My THEKAA',
            style: ThekaaTypography.sectionHeading.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: ThekaaColors.primaryText,
            ),
          ),
          IconButton(
            onPressed: onSettingsTap,
            icon: const Icon(
              Icons.settings_outlined,
              size: 22,
              color: ThekaaColors.terracotta,
            ),
            splashRadius: 22,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            tooltip: 'Settings',
          ),
        ],
      ),
    );
  }
}

