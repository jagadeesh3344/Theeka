import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class RestaurantDescriptionAndTags extends StatelessWidget {
  final String description;
  final List<String> tags;

  const RestaurantDescriptionAndTags({
    super.key,
    required this.description,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description
        Text(
          description,
          style: ThekaaTypography.deliveryInfo.copyWith(
            fontSize: 13,
            height: 1.4,
            color: const Color(0xFF6B584B),
          ),
        ),
        const SizedBox(height: 14),

        // Cuisine Tags
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tags.map((tag) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6.5),
              decoration: BoxDecoration(
                color: ThekaaColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: ThekaaColors.border,
                  width: 1.0,
                ),
              ),
              child: Text(
                tag,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B584B),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

