import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import 'food_map_painter.dart';

class FoodMapSection extends StatelessWidget {
  final VoidCallback? onExploreTap;
  final VoidCallback? onLocationControlTap;

  const FoodMapSection({
    super.key,
    this.onExploreTap,
    this.onLocationControlTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              "Today's Food Map",
              style: ThekaaTypography.sectionHeading,
            ),
            GestureDetector(
              onTap: onExploreTap,
              child: Text(
                'Explore map ↗',
                style: ThekaaTypography.sectionAction,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Rounded Rectangular Map Preview
        Container(
          height: 124,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: ThekaaColors.border.withValues(alpha: 0.4),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: Stack(
              children: [
                // Custom Map Painter
                Positioned.fill(
                  child: CustomPaint(
                    painter: FoodMapPainter(),
                  ),
                ),

                // Bottom-right Circular Map Control Button
                Positioned(
                  right: 12,
                  bottom: 10,
                  child: GestureDetector(
                    onTap: onLocationControlTap,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFDF8),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ThekaaColors.border.withValues(alpha: 0.5),
                          width: 0.8,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.gps_fixed,
                          size: 16,
                          color: ThekaaColors.terracotta,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
