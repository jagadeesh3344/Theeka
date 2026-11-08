import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

class DeliveredExperienceRatingCard extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onRatingChanged;

  const DeliveredExperienceRatingCard({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: ThekaaColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThekaaColors.border,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          const Text(
            'How was your experience?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Playfair Display',
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: ThekaaColors.primaryText,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final starValue = index + 1;
              final isFilled = starValue <= rating;
              return GestureDetector(
                onTap: () => onRatingChanged(starValue),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Icon(
                    isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
                    size: 34,
                    color: isFilled
                        ? const Color(0xFFD49B45)
                        : const Color(0xFFC4A482),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

