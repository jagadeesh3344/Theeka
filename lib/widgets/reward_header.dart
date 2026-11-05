import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class RewardHeader extends StatelessWidget {
  final VoidCallback? onBack;

  const RewardHeader({
    super.key,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onBack,
          behavior: HitTestBehavior.opaque,
          child: const Padding(
            padding: EdgeInsets.only(right: 10.0, top: 4.0, bottom: 4.0),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: ThekaaColors.primaryText,
            ),
          ),
        ),
        Text(
          'A story, appreciated',
          style: ThekaaTypography.brandTitle.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
}

