import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

class RelatedReviewButton extends StatelessWidget {
  final VoidCallback? onTap;

  const RelatedReviewButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: ThekaaColors.cardBackground,
          side: const BorderSide(
            color: ThekaaColors.border,
            width: 1.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'View related review',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: ThekaaColors.terracotta,
              ),
            ),
            SizedBox(width: 6),
            Icon(
              Icons.north_east_rounded,
              size: 14,
              color: ThekaaColors.terracotta,
            ),
          ],
        ),
      ),
    );
  }
}

