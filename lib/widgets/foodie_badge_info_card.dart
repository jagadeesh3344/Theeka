import 'package:flutter/material.dart';
import '../models/foodie_discovery.dart';
import '../theme/thekaa_colors.dart';

class FoodieBadgeInfoCard extends StatelessWidget {
  final UserDiscoveryProfile profile;

  const FoodieBadgeInfoCard({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          profile.badgeHeading,
          style: const TextStyle(
            fontFamily: 'Playfair Display',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ThekaaColors.primaryText,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
          decoration: BoxDecoration(
            color: ThekaaColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: ThekaaColors.border,
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.badgeDescription,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                  color: ThekaaColors.primaryText,
                  height: 1.45,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Divider(
                  color: Color(0xFFEADBCE),
                  height: 1.0,
                  thickness: 1.0,
                ),
              ),
              Text(
                profile.badgeRecognitionNotice,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w400,
                  color: ThekaaColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

