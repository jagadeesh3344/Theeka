import 'package:flutter/material.dart';
import '../theme/thekaa_typography.dart';
import 'hyderabad_monument_painter.dart';

class HeroIntroduction extends StatelessWidget {
  const HeroIntroduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left text block
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Aaj kya mangoge\nbhaiyya?',
                style: ThekaaTypography.heroHeading,
              ),
              const SizedBox(height: 5),
              Text(
                'Hyderabad, one plate at a time.',
                style: ThekaaTypography.heroSubtitle,
              ),
            ],
          ),
        ),

        // Right monument illustration
        const Padding(
          padding: EdgeInsets.only(left: 8, right: 4),
          child: HyderabadMonumentIllustration(
            width: 80,
            height: 64,
            strokeColor: Color(0xFFD49A73),
          ),
        ),
      ],
    );
  }
}
