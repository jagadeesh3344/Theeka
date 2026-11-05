import 'package:flutter/material.dart';
import '../models/foodie_discovery.dart';
import '../theme/thekaa_colors.dart';

class DiscoveryValidationCard extends StatelessWidget {
  final UserDiscoveryProfile profile;

  const DiscoveryValidationCard({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 14.0, bottom: 20.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEFE7D5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.info_outline_rounded,
                size: 17,
                color: ThekaaColors.terracotta,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  profile.validationNoticeTitle,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: ThekaaColors.terracotta,
                    letterSpacing: -0.1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              profile.validationNoticeBody,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF7A6B5D),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

