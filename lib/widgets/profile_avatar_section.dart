import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class ProfileAvatarSection extends StatelessWidget {
  final UserProfile profile;

  const ProfileAvatarSection({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Avatar circle with border
        Container(
          width: 82,
          height: 82,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFEADBCE),
              width: 1.5,
            ),
          ),
          child: ClipOval(
            child: profile.avatarImagePath != null
                ? Image.asset(
                    profile.avatarImagePath!,
                    width: 82,
                    height: 82,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFFF0E5D8),
                      child: const Icon(
                        Icons.person,
                        size: 42,
                        color: ThekaaColors.terracotta,
                      ),
                    ),
                  )
                : Container(
                    color: const Color(0xFFF0E5D8),
                    child: const Icon(
                      Icons.person,
                      size: 42,
                      color: ThekaaColors.terracotta,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 12),

        // User Name
        Text(
          profile.name,
          textAlign: TextAlign.center,
          style: ThekaaTypography.sectionHeading.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: ThekaaColors.primaryText,
          ),
        ),
        const SizedBox(height: 3),

        // User Handle
        Text(
          profile.handle,
          textAlign: TextAlign.center,
          style: ThekaaTypography.captionText.copyWith(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: ThekaaColors.terracotta,
          ),
        ),
        const SizedBox(height: 8),

        // User Bio
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            profile.bio,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: ThekaaTypography.deliveryInfo.copyWith(
              fontSize: 12.5,
              height: 1.35,
              color: ThekaaColors.secondaryText,
            ),
          ),
        ),
      ],
    );
  }
}

