import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

class DiscoveryHeader extends StatelessWidget {
  final VoidCallback? onBack;

  const DiscoveryHeader({
    super.key,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onBack ?? () => Navigator.of(context).maybePop(),
                behavior: HitTestBehavior.opaque,
                child: const Padding(
                  padding: EdgeInsets.only(right: 12.0, top: 2.0, bottom: 2.0),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 19,
                    color: ThekaaColors.primaryText,
                  ),
                ),
              ),
              const Expanded(
                child: Text(
                  'A taste for discovery',
                  style: TextStyle(
                    fontFamily: 'Playfair Display',
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: ThekaaColors.primaryText,
                    letterSpacing: -0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Padding(
            padding: EdgeInsets.only(left: 31.0),
            child: Text(
              'Your curiosity, celebrated. Not your like count.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: ThekaaColors.secondaryText,
                letterSpacing: -0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

