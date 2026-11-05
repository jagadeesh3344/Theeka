import 'package:flutter/material.dart';
import '../models/loyalty.dart';
import '../theme/thekaa_colors.dart';

class CoinsRedeemSelectorCard extends StatelessWidget {
  final int selectedCoins;
  final ThekaaLoyaltyQuote quote;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CoinsRedeemSelectorCard({
    super.key,
    required this.selectedCoins,
    required this.quote,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final isLoading = quote.status == LoyaltyQuoteStatus.loading;

    return Container(
      decoration: BoxDecoration(
        color: ThekaaColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThekaaColors.border,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section D: Heading
          const Text(
            'Coins to redeem',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: ThekaaColors.primaryText,
            ),
          ),
          const SizedBox(height: 10),

          // Selector box: [ —   0 TKC   + ]
          Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF3E8D5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onDecrement,
                  behavior: HitTestBehavior.opaque,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: Icon(
                      Icons.remove,
                      size: 16,
                      color: ThekaaColors.primaryText,
                    ),
                  ),
                ),
                Text(
                  '$selectedCoins TKC',
                  style: const TextStyle(
                    fontFamily: 'Playfair Display',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ThekaaColors.primaryText,
                  ),
                ),
                GestureDetector(
                  onTap: onIncrement,
                  behavior: HitTestBehavior.opaque,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: Icon(
                      Icons.add,
                      size: 16,
                      color: ThekaaColors.primaryText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Section E: Current conversion
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Current conversion',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11.5,
                  color: ThekaaColors.secondaryText,
                ),
              ),
              Text(
                isLoading ? 'Fetching quote...' : quote.conversionText,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11.5,
                  color: isLoading ? ThekaaColors.secondaryText : ThekaaColors.primaryText,
                  fontStyle: isLoading ? FontStyle.italic : FontStyle.normal,
                  fontWeight: isLoading ? FontWeight.normal : FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Section E: Maximum eligible
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Maximum eligible',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11.5,
                  color: ThekaaColors.secondaryText,
                ),
              ),
              Text(
                isLoading ? 'Checking limit...' : '${quote.maxEligibleCoins} TKC',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11.5,
                  color: isLoading ? ThekaaColors.secondaryText : ThekaaColors.primaryText,
                  fontStyle: isLoading ? FontStyle.italic : FontStyle.normal,
                  fontWeight: isLoading ? FontWeight.normal : FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

