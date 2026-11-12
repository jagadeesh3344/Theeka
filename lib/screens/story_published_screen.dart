import 'package:flutter/material.dart';
import '../models/social_models.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/dabba_icon.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import '../widgets/thekaa_image.dart';
import 'story_appreciated_screen.dart';

class StoryPublishedScreen extends StatelessWidget {
  final SocialPost post;
  final VoidCallback? onBack;
  final VoidCallback? onViewCoins;
  final VoidCallback? onBackToSocials;
  final ValueChanged<int>? onNavTap;

  const StoryPublishedScreen({
    super.key,
    this.post = SocialPost.defaultPost,
    this.onBack,
    this.onViewCoins,
    this.onBackToSocials,
    this.onNavTap,
  });

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      bottomNavigationBar: ThekaaBottomNavBar(
        currentIndex: 2, // DABBA active
        onTap: onNavTap,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),

                    // Header row: Back arrow & Title
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: onBack ?? () => Navigator.of(context).maybePop(),
                          borderRadius: BorderRadius.circular(20),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 18,
                              color: ThekaaColors.terracotta,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Your story is out there',
                          style: ThekaaTypography.sectionHeading.copyWith(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: ThekaaColors.primaryText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Centered Circular Dabba Container Badge with Checkmark
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 82,
                            height: 82,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFF0E5D8),
                            ),
                            child: const Center(
                              child: DabbaIcon(
                                size: 44,
                                color: ThekaaColors.terracotta,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 2,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF386641),
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Cursive Subtitle
                    Text(
                      'Shukriya, for keeping it real.',
                      style: ThekaaTypography.heroSubtitle.copyWith(
                        fontSize: 18,
                        color: ThekaaColors.terracotta,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Main Heading
                    Text(
                      'Published. And appreciated.',
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Restaurant & Dish Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFDF8),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFEADBCE),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: 58,
                                  height: 58,
                                  color: const Color(0xFFF3ECE0),
                                  child: post.imageUrls.isNotEmpty
                                      ? thekaaImage(
                                          post.imageUrls.first,
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(Icons.restaurant,
                                          color: ThekaaColors.terracotta),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post.restaurantName,
                                      style: ThekaaTypography.sectionHeading.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: ThekaaColors.primaryText,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      post.dishName,
                                      style: ThekaaTypography.deliveryInfo.copyWith(
                                        fontSize: 12,
                                        color: ThekaaColors.secondaryText,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star_outline_rounded,
                                          size: 14,
                                          color: Color(0xFF6B4E38),
                                        ),
                                        const SizedBox(width: 2),
                                        Text(
                                          post.rating.toStringAsFixed(1),
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.bold,
                                            color: ThekaaColors.primaryText,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          '·',
                                          style: TextStyle(color: ThekaaColors.secondaryText),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(
                                          Icons.verified_user_outlined,
                                          size: 13,
                                          color: Color(0xFF386641),
                                        ),
                                        const SizedBox(width: 3),
                                        const Text(
                                          'Verified purchase',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF386641),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '“${post.title}”',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12.5,
                              fontStyle: FontStyle.italic,
                              color: ThekaaColors.primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Eligibility Successfully Checked Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F1E6),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFFD1E2CB),
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            size: 18,
                            color: Color(0xFF2D5A27),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Eligibility successfully checked',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2D5A27),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Your review is published, your purchase is verified, and the original contribution passed validation.',
                                  style: ThekaaTypography.deliveryInfo.copyWith(
                                    fontSize: 11.5,
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
                    const SizedBox(height: 12),

                    // Coin Reward Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFDF8),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFEADBCE),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '+${post.rewardCoins} TKC',
                                style: ThekaaTypography.sectionHeading.copyWith(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: ThekaaColors.terracotta,
                                ),
                              ),
                              const Row(
                                children: [
                                  Text(
                                    'CREDITED ONCE',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                      color: Color(0xFF2D5A27),
                                    ),
                                  ),
                                  SizedBox(width: 3),
                                  Icon(
                                    Icons.check,
                                    size: 14,
                                    color: Color(0xFF2D5A27),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${post.rewardTimestamp} · TKC-RV84291-01',
                            style: ThekaaTypography.deliveryInfo.copyWith(
                              fontSize: 11.5,
                              color: ThekaaColors.secondaryText,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Wallet balance is now ${_formatNumber(post.walletBalance)} TKC. No duplicate credit.',
                            style: ThekaaTypography.deliveryInfo.copyWith(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: ThekaaColors.primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Bottom Buttons: View my coins & Back to Socials
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: onViewCoins ??
                          () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => StoryAppreciatedScreen(
                                  onBack: () => Navigator.of(context).maybePop(),
                                ),
                              ),
                            );
                          },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThekaaColors.terracotta,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'View my coins',
                            style: ThekaaTypography.sectionHeading.copyWith(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.toll_outlined,
                            size: 18,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: onBackToSocials ?? () => Navigator.of(context).maybePop(),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFFDF8),
                        side: const BorderSide(color: Color(0xFFD8C8B6), width: 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'Back to Socials',
                        style: ThekaaTypography.sectionHeading.copyWith(
                          fontFamily: 'Inter',
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF6B4E38),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
