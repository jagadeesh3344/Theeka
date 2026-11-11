import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

class ViewOrderDetailsButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;
  final bool isEnabled;
  final EdgeInsetsGeometry? padding;

  const ViewOrderDetailsButton({
    super.key,
    required this.onTap,
    this.label = 'View order details',
    this.isEnabled = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.fromLTRB(16, 6, 16, 10),
      color: ThekaaColors.mainBackground,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: OutlinedButton(
          onPressed: isEnabled ? onTap : null,
          style: OutlinedButton.styleFrom(
            backgroundColor: isEnabled ? ThekaaColors.cardBackground : const Color(0xFFEDE6DC),
            foregroundColor: isEnabled ? ThekaaColors.terracotta : const Color(0xFFA69888),
            disabledForegroundColor: const Color(0xFFA69888),
            disabledBackgroundColor: const Color(0xFFEDE6DC),
            side: BorderSide(
              color: isEnabled ? const Color(0xFFDFC8B4) : const Color(0xFFDFC8B4).withValues(alpha: 0.5),
              width: 1.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: isEnabled ? ThekaaColors.terracotta : const Color(0xFFA69888),
            ),
          ),
        ),
      ),
    );
  }
}
