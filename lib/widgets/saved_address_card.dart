import 'package:flutter/material.dart';
import '../models/address.dart';
import '../theme/thekaa_colors.dart';

class SavedAddressCard extends StatelessWidget {
  final DeliveryAddress address;
  final bool isSelected;
  final VoidCallback? onTap;

  const SavedAddressCard({
    super.key,
    required this.address,
    this.isSelected = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final IconData typeIcon;
    switch (address.type) {
      case AddressType.home:
        typeIcon = Icons.home_outlined;
        break;
      case AddressType.work:
        typeIcon = Icons.work_outline_rounded;
        break;
      case AddressType.other:
        typeIcon = Icons.location_on_outlined;
        break;
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: ThekaaColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? ThekaaColors.terracotta.withValues(alpha: 0.6) : ThekaaColors.border,
            width: 1.0,
          ),
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left icon container
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFF4E8D4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  typeIcon,
                  color: ThekaaColors.terracotta,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Middle address details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${address.typeLabel}${address.isDefault ? ' · Default' : ''}',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: ThekaaColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Flat ${address.flatBuilding}, ${address.locality},\n${address.city} ${address.pincode}',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11.5,
                      color: ThekaaColors.secondaryText,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),

            // Right check indicator
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF9E5528) : ThekaaColors.border,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(
                        Icons.check,
                        size: 13,
                        color: Color(0xFF9E5528),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

