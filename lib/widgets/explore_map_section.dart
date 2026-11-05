import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';
import 'food_map_painter.dart';

class ExploreMapSection extends StatelessWidget {
  final Restaurant? selectedRestaurant;
  final ValueChanged<Restaurant>? onMarkerTap;
  final VoidCallback? onMapControlTap;

  const ExploreMapSection({
    super.key,
    this.selectedRestaurant,
    this.onMarkerTap,
    this.onMapControlTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 138,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: ThekaaColors.border.withValues(alpha: 0.45),
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
            // Underlying Map Painter with dynamic selection
            Positioned.fill(
              child: CustomPaint(
                painter: FoodMapPainter(
                  selectedCoordinates: selectedRestaurant?.mapCoordinates,
                ),
              ),
            ),

            // Bottom-right Circular Map Control Button (layers/diamond icon in screenshot)
            Positioned(
              right: 12,
              bottom: 10,
              child: GestureDetector(
                onTap: onMapControlTap,
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
                      Icons.layers_outlined,
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
    );
  }
}
