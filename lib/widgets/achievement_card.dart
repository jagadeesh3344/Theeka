import 'package:flutter/material.dart';
import '../models/foodie_discovery.dart';
import '../theme/thekaa_colors.dart';
import 'achievement_badge_icon.dart';

class AchievementCard extends StatelessWidget {
  final FoodieAchievement achievement;
  final AchievementIconType iconType;

  const AchievementCard({
    super.key,
    required this.achievement,
    required this.iconType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AchievementBadgeIcon(
                type: iconType,
                size: 52,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      achievement.title,
                      style: const TextStyle(
                        fontFamily: 'Playfair Display',
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: ThekaaColors.primaryText,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      achievement.description,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8F7D6D),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      achievement.progressSubtitle,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: achievement.accentColor,
                        letterSpacing: -0.1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Progress bar
          Container(
            height: 4.5,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFEADBCE),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: achievement.progressRatio,
                child: Container(
                  height: 4.5,
                  decoration: BoxDecoration(
                    color: achievement.accentColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

