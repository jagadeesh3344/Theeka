import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

class ConfirmPayButton extends StatelessWidget {
  final double payableAmount;
  final int coinsRedeemed;
  final bool isProcessing;
  final VoidCallback onPressed;

  const ConfirmPayButton({
    super.key,
    required this.payableAmount,
    this.coinsRedeemed = 0,
    this.isProcessing = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final noteText = coinsRedeemed > 0
        ? 'Secure payment · $coinsRedeemed TKC redeemed'
        : 'Secure payment · No coins redeemed';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      color: ThekaaColors.mainBackground,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            noteText,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 11.5,
              fontWeight: FontWeight.w400,
              color: Color(0xFF8F7D6D),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: isProcessing ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: ThekaaColors.terracotta,
                disabledBackgroundColor: ThekaaColors.terracotta.withValues(alpha: 0.65),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: isProcessing
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Confirm & pay ₹${payableAmount.toInt()}',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.lock_rounded,
                          size: 16,
                          color: Colors.white,
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

