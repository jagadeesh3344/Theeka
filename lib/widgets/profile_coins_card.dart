import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class ProfileCoinsCard extends StatelessWidget {
  final UserProfile profile;
  final VoidCallback? onViewWallet;

  const ProfileCoinsCard({
    super.key,
    required this.profile,
    this.onViewWallet,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onViewWallet,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F1E6),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFEADBCE),
                width: 1.0,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Custom Interlocking coins icon
                SizedBox(
                  width: 26,
                  height: 26,
                  child: CustomPaint(
                    painter: _InterlockingCoinsPainter(
                      color: ThekaaColors.terracotta,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Coins Title and Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        profile.formattedCoins,
                        style: ThekaaTypography.sectionHeading.copyWith(
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                          color: ThekaaColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        profile.coinsSubtitle,
                        style: ThekaaTypography.deliveryInfo.copyWith(
                          fontSize: 11.5,
                          color: ThekaaColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),

                // View wallet >
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View wallet',
                      style: ThekaaTypography.captionText.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: ThekaaColors.terracotta,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: ThekaaColors.terracotta,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InterlockingCoinsPainter extends CustomPainter {
  final Color color;

  _InterlockingCoinsPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    final radius = size.width * 0.30;
    canvas.drawCircle(Offset(size.width * 0.38, size.height * 0.62), radius, paint);
    canvas.drawCircle(Offset(size.width * 0.62, size.height * 0.38), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

