import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

class RestaurantHeroImage extends StatelessWidget {
  final String imagePath;
  final double height;

  const RestaurantHeroImage({
    super.key,
    required this.imagePath,
    this.height = 195,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: ThekaaColors.border.withValues(alpha: 0.5),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: height,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: ThekaaColors.border.withValues(alpha: 0.3),
              child: const Center(
                child: Icon(
                  Icons.restaurant,
                  color: ThekaaColors.secondaryText,
                  size: 48,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

