import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

class OrderSuccessHeader extends StatelessWidget {
  final VoidCallback? onBack;

  const OrderSuccessHeader({
    super.key,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onBack ?? () => Navigator.of(context).pop(),
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.only(right: 14.0, top: 4.0, bottom: 4.0),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 19,
                color: ThekaaColors.terracotta,
              ),
            ),
          ),
          const Text(
            "You're all set",
            style: TextStyle(
              fontFamily: 'Playfair Display',
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: ThekaaColors.primaryText,
              letterSpacing: -0.4,
            ),
          ),
        ],
      ),
    );
  }
}

