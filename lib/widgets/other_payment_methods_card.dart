import 'package:flutter/material.dart';
import '../models/payment_method.dart';
import '../theme/thekaa_colors.dart';

class OtherPaymentMethodsCard extends StatelessWidget {
  final PaymentMethodType selectedMethod;
  final bool isCodAvailable;
  final ValueChanged<PaymentMethodType> onSelectMethod;

  const OtherPaymentMethodsCard({
    super.key,
    required this.selectedMethod,
    this.isCodAvailable = true,
    required this.onSelectMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: ThekaaColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThekaaColors.border,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          // 1. Debit / credit card
          _buildMethodTile(
            icon: Icons.credit_card_outlined,
            title: 'Debit / credit card',
            subtitle: 'Visa, Mastercard, RuPay',
            method: PaymentMethodType.card,
            isSelected: selectedMethod == PaymentMethodType.card,
            onTap: () => onSelectMethod(PaymentMethodType.card),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              color: Color(0xFFEADBCE),
              height: 1.0,
              thickness: 1.0,
            ),
          ),
          // 2. Net banking
          _buildMethodTile(
            icon: Icons.account_balance_outlined,
            title: 'Net banking',
            subtitle: 'Choose your bank',
            method: PaymentMethodType.netBanking,
            isSelected: selectedMethod == PaymentMethodType.netBanking,
            onTap: () => onSelectMethod(PaymentMethodType.netBanking),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              color: Color(0xFFEADBCE),
              height: 1.0,
              thickness: 1.0,
            ),
          ),
          // 3. Cash on delivery
          _buildMethodTile(
            icon: Icons.payments_outlined,
            title: 'Cash on delivery',
            subtitle: isCodAvailable ? 'Available for this order' : 'Unavailable for this order',
            method: PaymentMethodType.cashOnDelivery,
            isSelected: selectedMethod == PaymentMethodType.cashOnDelivery,
            enabled: isCodAvailable,
            onTap: isCodAvailable
                ? () => onSelectMethod(PaymentMethodType.cashOnDelivery)
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildMethodTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required PaymentMethodType method,
    required bool isSelected,
    bool enabled = true,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFF4E8D8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 22,
                  color: enabled ? ThekaaColors.terracotta : const Color(0xFFC7B6A4),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: enabled ? ThekaaColors.primaryText : const Color(0xFFA18B76),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF8F7D6D),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 22,
              color: Color(0xFFA75B2E),
            ),
          ],
        ),
      ),
    );
  }
}

