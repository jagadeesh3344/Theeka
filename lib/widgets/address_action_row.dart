import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

class AddressActionRow extends StatelessWidget {
  final VoidCallback? onAddNewAddress;
  final VoidCallback? onEditSaved;

  const AddressActionRow({
    super.key,
    this.onAddNewAddress,
    this.onEditSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onAddNewAddress,
          behavior: HitTestBehavior.opaque,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              '+ Add a new address',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: ThekaaColors.terracotta,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: onEditSaved,
          behavior: HitTestBehavior.opaque,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              'Edit saved',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: ThekaaColors.terracotta,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

