import 'package:flutter/material.dart';
import '../models/address.dart';
import '../theme/thekaa_colors.dart';

class AddressTypeSelector extends StatelessWidget {
  final AddressType selectedType;
  final ValueChanged<AddressType> onTypeChanged;

  const AddressTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEBE0CD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildOption(AddressType.home, 'Home'),
          _buildOption(AddressType.work, 'Work'),
          _buildOption(AddressType.other, 'Other'),
        ],
      ),
    );
  }

  Widget _buildOption(AddressType type, String label) {
    final isSelected = selectedType == type;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTypeChanged(type),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isSelected ? ThekaaColors.cardBackground : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? ThekaaColors.primaryText : ThekaaColors.secondaryText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

