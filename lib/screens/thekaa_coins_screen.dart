import 'package:flutter/material.dart';
import '../models/coins_models.dart';
import '../models/user_profile.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import '../widgets/thekaa_coins_balance_card.dart';
import 'coin_history_screen.dart';
import 'taste_for_discovery_screen.dart';

class ThekaaCoinsScreen extends StatelessWidget {
  final ThekaaCoinsWallet wallet;
  final UserProfile profile;
  final VoidCallback? onBack;
  final VoidCallback? onInfoTap;
  final VoidCallback? onEarnTap;
  final VoidCallback? onRedeemTap;
  final VoidCallback? onHistoryTap;
  final VoidCallback? onRewardsTap;
  final VoidCallback? onReviewHelpTap;
  final VoidCallback? onPhotosTap;
  final VoidCallback? onValidatedReviewTap;
  final ValueChanged<int>? onNavTap;

  const ThekaaCoinsScreen({
    super.key,
    this.wallet = ThekaaCoinsWallet.defaultWallet,
    this.profile = UserProfile.defaultProfile,
    this.onBack,
    this.onInfoTap,
    this.onEarnTap,
    this.onRedeemTap,
    this.onHistoryTap,
    this.onRewardsTap,
    this.onReviewHelpTap,
    this.onPhotosTap,
    this.onValidatedReviewTap,
    this.onNavTap,
  });

  void _handleEarn(BuildContext context) {
    onEarnTap?.call();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Order something and review it to earn coins.',
          style: ThekaaTypography.sectionHeading.copyWith(
            fontFamily: 'Inter',
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: ThekaaColors.terracotta,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _handleRedeem(BuildContext context) {
    onRedeemTap?.call();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Redeem on your order after you have something to redeem.',
          style: ThekaaTypography.sectionHeading.copyWith(
            fontFamily: 'Inter',
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: ThekaaColors.terracotta,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _handleHistory(BuildContext context) {
    if (onHistoryTap != null) {
      onHistoryTap!();
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CoinHistoryScreen(
          wallet: wallet,
          onBack: () => Navigator.of(context).maybePop(),
        ),
      ),
    );
  }

  void _handleRewards(BuildContext context) {
    if (onRewardsTap != null) {
      onRewardsTap!();
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TasteForDiscoveryScreen(
          onBack: () => Navigator.of(context).maybePop(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBalance = profile.coinBalance != 1200 ? profile.coinBalance : wallet.balance;

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
              // Header Row: Back button, Title, Info Icon
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
                      'THEKAA Coins',
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onInfoTap,
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.info_outline_rounded,
                        size: 20,
                        color: ThekaaColors.terracotta,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // Subtitle
              Text(
                'Good food stories deserve a little something.',
                style: ThekaaTypography.deliveryInfo.copyWith(
                  fontSize: 12.5,
                  color: ThekaaColors.secondaryText,
                ),
              ),
              const SizedBox(height: 16),

              // Main Coins Card
              ThekaaCoinsBalanceCard(
                balance: effectiveBalance,
                subtitle: 'A little appreciation. For real food stories.',
              ),
              const SizedBox(height: 14),

              // Coins Action Grid (Earn, Redeem, History, Rewards)
              Row(
                children: [
                  Expanded(
                    child: _ActionCard(
                      icon: Icons.edit_outlined,
                      label: 'Earn',
                      onTap: () => _handleEarn(context),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _ActionCard(
                      customIcon: const _InterlockingCoinsSmall(),
                      label: 'Redeem',
                      onTap: () => _handleRedeem(context),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _ActionCard(
                      icon: Icons.history_rounded,
                      label: 'History',
                      onTap: () => _handleHistory(context),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _ActionCard(
                      icon: Icons.military_tech_outlined,
                      label: 'Rewards',
                      onTap: () => _handleRewards(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Heading: Earn it, honestly
              Text(
                'Earn it, honestly',
                style: ThekaaTypography.sectionHeading.copyWith(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: ThekaaColors.primaryText,
                ),
              ),
              const SizedBox(height: 12),

              // Reward Explanation Card (2 rows: A review..., Your food...)
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
                child: Column(
                  children: [
                    InkWell(
                      onTap: onReviewHelpTap,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                        child: Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5EBD7),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.edit_note_rounded,
                                size: 20,
                                color: Color(0xFF8D5B34),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'A review that helps someone choose',
                                    style: ThekaaTypography.sectionHeading.copyWith(
                                      fontFamily: 'Inter',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: ThekaaColors.primaryText,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Share your own experience from an eligible order.',
                                    style: ThekaaTypography.deliveryInfo.copyWith(
                                      fontSize: 11,
                                      color: ThekaaColors.secondaryText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right_rounded,
                              size: 18,
                              color: Color(0xFF8D6444),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 1, thickness: 1, color: Color(0xFFF0E6D8)),
                    InkWell(
                      onTap: onPhotosTap,
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                        child: Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5EBD7),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.image_outlined,
                                size: 20,
                                color: Color(0xFF8D5B34),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Your food, through your lens',
                                    style: ThekaaTypography.sectionHeading.copyWith(
                                      fontFamily: 'Inter',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: ThekaaColors.primaryText,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Original food photos, checked for eligibility.',
                                    style: ThekaaTypography.deliveryInfo.copyWith(
                                      fontSize: 11,
                                      color: ThekaaColors.secondaryText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right_rounded,
                              size: 18,
                              color: Color(0xFF8D6444),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Validation / Fairness Card
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
                          'Real stories. Fair rewards.',
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
                      'Rewards follow successful publication and eligibility validation. Each eligible contribution is credited once. Likes and engagement never earn coins.',
                      style: ThekaaTypography.deliveryInfo.copyWith(
                        fontSize: 11.5,
                        height: 1.35,
                        color: const Color(0xFF6B4E38),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Additional Content: Lower Review Validated Card
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
                  onTap: onValidatedReviewTap,
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                    child: Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5EBD7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.check_circle_outline,
                            size: 20,
                            color: Color(0xFF2D5A27),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Review validated',
                                style: ThekaaTypography.sectionHeading.copyWith(
                                  fontFamily: 'Inter',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: ThekaaColors.primaryText,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Original contribution passed validation · Credited once.',
                                style: ThekaaTypography.deliveryInfo.copyWith(
                                  fontSize: 11,
                                  color: ThekaaColors.secondaryText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          '+25 TKC',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2D5A27),
                          ),
                        ),
                      ],
                    ),
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

class _ActionCard extends StatelessWidget {
  final IconData? icon;
  final Widget? customIcon;
  final String label;
  final VoidCallback? onTap;

  const _ActionCard({
    this.icon,
    this.customIcon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDF8),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFEADBCE),
              width: 1.0,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (customIcon != null)
                customIcon!
              else if (icon != null)
                Icon(
                  icon,
                  size: 22,
                  color: const Color(0xFF8D5B34),
                ),
              const SizedBox(height: 6),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF3A2312),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InterlockingCoinsSmall extends StatelessWidget {
  const _InterlockingCoinsSmall();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      height: 22,
      child: CustomPaint(
        painter: _CoinsPainter(color: const Color(0xFF8D5B34)),
      ),
    );
  }
}

class _CoinsPainter extends CustomPainter {
  final Color color;

  const _CoinsPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    // Top-right coin
    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.35), size.width * 0.3, paint);

    // Bottom-left coin
    canvas.drawCircle(Offset(size.width * 0.35, size.height * 0.65), size.width * 0.3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

