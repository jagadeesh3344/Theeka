import 'package:flutter/material.dart';
import '../models/payment_method.dart';
import '../theme/thekaa_colors.dart';

class UpiPaymentCard extends StatelessWidget {
  final bool isSelected;
  final UpiProvider selectedProvider;
  final TextEditingController upiController;
  final ValueChanged<UpiProvider> onProviderSelected;
  final VoidCallback onSelect;

  const UpiPaymentCard({
    super.key,
    required this.isSelected,
    required this.selectedProvider,
    required this.upiController,
    required this.onProviderSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: ThekaaColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: ThekaaColors.border,
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Icon, Title & subtitle, selection check
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4E8D8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.phone_android_rounded,
                      size: 22,
                      color: ThekaaColors.terracotta,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'UPI',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: ThekaaColors.primaryText,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Fast, secure bank-to-bank payment',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF8F7D6D),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isSelected
                      ? Icons.check_circle_outline_rounded
                      : Icons.radio_button_unchecked_rounded,
                  size: 20,
                  color: isSelected
                      ? ThekaaColors.terracotta
                      : const Color(0xFFC7B6A4),
                ),
              ],
            ),

            if (isSelected) ...[
              const SizedBox(height: 14),
              // Provider chips: Google Pay, PhonePe, Paytm
              Row(
                children: [
                  _buildProviderChip(UpiProvider.googlePay),
                  const SizedBox(width: 8),
                  _buildProviderChip(UpiProvider.phonePe),
                  const SizedBox(width: 8),
                  _buildProviderChip(UpiProvider.paytm),
                ],
              ),
              const SizedBox(height: 14),

              // UPI ID label & field
              const Text(
                'UPI ID',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: ThekaaColors.primaryText,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: ThekaaColors.cardBackground,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ThekaaColors.terracotta,
                    width: 1.2,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                child: TextField(
                  controller: upiController,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                    color: ThekaaColors.primaryText,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    hintText: 'Enter your UPI ID',
                    hintStyle: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: Color(0xFFA18B76),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Sample payment details — design preview',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF8F7D6D),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProviderChip(UpiProvider provider) {
    final active = selectedProvider == provider;
    return GestureDetector(
      onTap: () => onProviderSelected(provider),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
        decoration: BoxDecoration(
          color: active ? ThekaaColors.terracotta : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: active ? ThekaaColors.terracotta : const Color(0xFFEADBCE),
            width: 1.0,
          ),
        ),
        child: Text(
          provider.displayName,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: active ? FontWeight.w600 : FontWeight.w500,
            color: active ? Colors.white : const Color(0xFF7A6B5D),
          ),
        ),
      ),
    );
  }
}

