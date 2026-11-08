import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

class DeliveredHeader extends StatelessWidget {
  final VoidCallback onBack;

  const DeliveredHeader({
    super.key,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThekaaColors.mainBackground,
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 16.0,
        top: 8.0,
        bottom: 4.0,
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: ThekaaColors.primaryText,
              size: 20,
            ),
            onPressed: onBack,
            splashRadius: 22,
          ),
          const SizedBox(width: 4),
          const Text(
            'Khaana aa gaya!',
            style: TextStyle(
              fontFamily: 'Playfair Display',
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: ThekaaColors.primaryText,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }
}

