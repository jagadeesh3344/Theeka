import 'package:flutter/material.dart';
import '../models/coins_models.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';

class TasteForDiscoveryScreen extends StatelessWidget {
  final List<DiscoveryMilestone> milestones;
  final VoidCallback? onBack;
  final ValueChanged<DiscoveryMilestone>? onMilestoneTap;
  final VoidCallback? onBadgeDetailsTap;
  final ValueChanged<int>? onNavTap;

  const TasteForDiscoveryScreen({
    super.key,
    this.milestones = DiscoveryMilestone.defaultMilestones,
    this.onBack,
    this.onMilestoneTap,
    this.onBadgeDetailsTap,
    this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      bottomNavigationBar: ThekaaBottomNavBar(
        currentIndex: 4,
        onTap: onNavTap ?? (_) {},
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Back arrow, Title
              Row(
                children: [
                  InkWell(
                    onTap: onBack ?? () => Navigator.maybePop(context),
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'A taste for discovery',
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // Subtitle
              Text(
                'Your curiosity, celebrated. Not your like count.',
                style: ThekaaTypography.deliveryInfo.copyWith(
                  fontSize: 12.5,
                  color: ThekaaColors.secondaryText,
                ),
              ),
              const SizedBox(height: 16),

              // Progress Cards
              for (final milestone in milestones) ...[
                _MilestoneProgressCard(
                  milestone: milestone,
                  onTap: () => onMilestoneTap?.call(milestone),
                ),
                const SizedBox(height: 12),
              ],
              const SizedBox(height: 8),

              // Section Heading: Your Foodie badge
              Text(
                'Your Foodie badge',
                style: ThekaaTypography.sectionHeading.copyWith(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: ThekaaColors.primaryText,
                ),
              ),
              const SizedBox(height: 12),

              // Badge Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDF8),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFEADBCE),
                    width: 1.0,
                  ),
                ),
                child: InkWell(
                  onTap: onBadgeDetailsTap,
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'A mark of ten genuine food stories, each published and checked. This badge lives on your food journal.',
                          style: ThekaaTypography.deliveryInfo.copyWith(
                            fontSize: 12,
                            height: 1.4,
                            color: ThekaaColors.primaryText,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Divider(height: 1, thickness: 1, color: Color(0xFFF0E6D8)),
                        ),
                        const Text(
                          'Recognition only · No automatic coin credit',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11.5,
                            color: Color(0xFF7A6658),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Fairness Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5EBD7),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFEADBCE),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 16,
                          color: Color(0xFF8D5B34),
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Made for genuine discovery',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF4A2E18),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Eligible reviews and original photos count toward milestones. Duplicate content and engagement do not.',
                      style: ThekaaTypography.deliveryInfo.copyWith(
                        fontSize: 11.5,
                        height: 1.35,
                        color: const Color(0xFF6B4E38),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _MilestoneProgressCard extends StatelessWidget {
  final DiscoveryMilestone milestone;
  final VoidCallback? onTap;

  const _MilestoneProgressCard({
    required this.milestone,
    this.onTap,
  });

  Widget _buildBadgeIcon() {
    IconData icon;
    switch (milestone.type) {
      case MilestoneType.foodie:
        icon = Icons.restaurant_outlined;
        break;
      case MilestoneType.reviewer:
        icon = Icons.edit_note_rounded;
        break;
      case MilestoneType.explorer:
        icon = Icons.explore_outlined;
        break;
    }

    return Container(
      width: 44,
      height: 44,
      decoration: const BoxDecoration(
        color: Color(0xFFF5EBD7),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          size: 22,
          color: const Color(0xFF8D5B34),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ratio = milestone.progressRatio;
    final isCompleted = milestone.isCompleted;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEADBCE),
          width: 1.0,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildBadgeIcon(),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          milestone.title,
                          style: ThekaaTypography.sectionHeading.copyWith(
                            fontSize: 16.5,
                            fontWeight: FontWeight.bold,
                            color: ThekaaColors.primaryText,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          milestone.subtitle,
                          style: ThekaaTypography.deliveryInfo.copyWith(
                            fontSize: 11.5,
                            color: ThekaaColors.secondaryText,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          milestone.statusText,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: isCompleted
                                ? const Color(0xFF2D5A27)
                                : const Color(0xFF8D5B34),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  height: 4.5,
                  width: double.infinity,
                  color: isCompleted ? const Color(0xFF2D5A27) : const Color(0xFFEADBCE),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: ratio,
                      child: Container(
                        color: isCompleted ? const Color(0xFF2D5A27) : const Color(0xFF8D5B34),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

