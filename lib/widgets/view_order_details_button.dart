import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

class ViewOrderDetailsButton extends StatelessWidget {
  final VoidCallback onTap;

  const ViewOrderDetailsButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      color: ThekaaColors.mainBackground,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            backgroundColor: ThekaaColors.cardBackground,
            foregroundColor: ThekaaColors.terracotta,
            side: const BorderSide(
              color: Color(0xFFDFC8B4),
              width: 1.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
          child: const Text(
            'View order details',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: ThekaaColors.terracotta,
            ),
          ),
        ),
      ),
    );
  }
}
