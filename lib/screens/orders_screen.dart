import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      appBar: AppBar(
        backgroundColor: ThekaaColors.mainBackground,
        elevation: 0,
        centerTitle: false,
        title: Text('Your Orders', style: ThekaaTypography.sectionHeading),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.receipt_long_outlined, size: 54, color: ThekaaColors.terracotta),
            const SizedBox(height: 12),
            Text('No active orders right now', style: ThekaaTypography.restaurantName),
            const SizedBox(height: 6),
            Text('Craving Shadab Biryani? Order from home!', style: ThekaaTypography.deliveryInfo),
          ],
        ),
      ),
    );
  }
}

