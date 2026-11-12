import 'package:flutter/material.dart';
import '../models/coins_models.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import '../widgets/thekaa_image.dart';
import 'social_feed_screen.dart';

class StoryAppreciatedScreen extends StatelessWidget {
  final CoinRewardDetail rewardDetail;
  final VoidCallback? onBack;
  final VoidCallback? onViewRelatedReview;
  final ValueChanged<int>? onNavTap;

  const StoryAppreciatedScreen({
    super.key,
    this.rewardDetail = CoinRewardDetail.defaultDetail,
    this.onBack,
    this.onViewRelatedReview,
    this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final detail = rewardDetail;

    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      bottomNavigationBar: ThekaaBottomNavBar(
        currentIndex: 4,
        onTap: onNavTap,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      'A story, appreciated',
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Success Icon Ring
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFEFF5EE),
                  border: Border.all(
                    color: const Color(0xFF799874),
                    width: 1.5,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    size: 22,
                    color: Color(0xFF4A6B48),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Large Reward Text (+25 TKC)
              Text(
                detail.formattedRewardAmount,
                style: const TextStyle(
                  fontFamily: 'Playfair Display',
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8D5B34),
                ),
              ),
              const SizedBox(height: 4),

              // Subtitle
              Text(
                detail.statusLabel,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: Color(0xFF386641),
                ),
              ),
              const SizedBox(height: 20),

              // Transaction Details Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDF8),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFEADBCE),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    _DetailRow(label: 'Transaction ID', value: detail.transactionId),
                    const SizedBox(height: 10),
                    _DetailRow(label: 'Date & time', value: detail.dateTime),
                    const SizedBox(height: 10),
                    _DetailRow(label: 'Type', value: detail.type),
                    const SizedBox(height: 10),
                    _DetailRow(label: 'Source', value: detail.source),
                    const SizedBox(height: 10),
                    _DetailRow(label: 'Related order', value: detail.relatedOrder),
                    const SizedBox(height: 10),
                    _DetailRow(label: 'Balance before', value: detail.formattedBalanceBefore),
                    const SizedBox(height: 10),
                    _DetailRow(label: 'Balance after', value: detail.formattedBalanceAfter),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Restaurant & Review Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDF8),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFEADBCE),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 52,
                        height: 52,
                        child: thekaaImage(
                          detail.dishImage,
                          width: 52,
                          height: 52,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail.restaurantName,
                            style: ThekaaTypography.sectionHeading.copyWith(
                              fontFamily: 'Inter',
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: ThekaaColors.primaryText,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Text(
                                detail.dishName,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 11.5,
                                  color: ThekaaColors.secondaryText,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                '·',
                                style: TextStyle(color: ThekaaColors.secondaryText),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.star,
                                size: 12,
                                color: Color(0xFF8D5B34),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                detail.rating.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: ThekaaColors.primaryText,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            detail.reviewQuote,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11.5,
                              fontStyle: FontStyle.italic,
                              color: Color(0xFF4A2E18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Validation Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE9F2E6),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFD1E2CB),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2.0),
                      child: Icon(
                        Icons.check_circle_outline,
                        size: 16,
                        color: Color(0xFF2D5A27),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail.validationTitle,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2D5A27),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            detail.validationMessage,
                            style: ThekaaTypography.deliveryInfo.copyWith(
                              fontSize: 11,
                              height: 1.35,
                              color: const Color(0xFF556B4E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Outlined Button: View related review ↗
              SizedBox(
                width: double.infinity,
                height: 46,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFFDF8),
                    side: const BorderSide(
                      color: Color(0xFFD4C2B0),
                      width: 1.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: onViewRelatedReview ??
                      () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SocialFeedScreen(
                              onBack: () => Navigator.of(context).maybePop(),
                            ),
                          ),
                        );
                      },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'View related review',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8D5B34),
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.north_east_rounded,
                        size: 16,
                        color: Color(0xFF8D5B34),
                      ),
                    ],
                  ),
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

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            color: Color(0xFF7A6658),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C1810),
          ),
        ),
      ],
    );
  }
}

