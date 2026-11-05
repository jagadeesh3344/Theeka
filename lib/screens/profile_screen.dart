import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      appBar: AppBar(
        backgroundColor: ThekaaColors.mainBackground,
        elevation: 0,
        centerTitle: false,
        title: Text('Profile', style: ThekaaTypography.sectionHeading),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_outline, size: 54, color: ThekaaColors.terracotta),
            const SizedBox(height: 12),
            Text('Hyderabad Foodie', style: ThekaaTypography.restaurantName),
            const SizedBox(height: 6),
            Text('Khaana. Samjh Ke.', style: ThekaaTypography.deliveryInfo),
          ],
        ),
      ),
    );
  }
}

