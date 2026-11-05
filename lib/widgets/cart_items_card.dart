import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class CartItemsCard extends StatelessWidget {
  final Restaurant restaurant;
  final Map<String, int> cartQuantities;
  final Function(String id) onIncrement;
  final Function(String id) onDecrement;
  final Function(String id) onDelete;
  final VoidCallback onAddMore;

  const CartItemsCard({
    super.key,
    required this.restaurant,
    required this.cartQuantities,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
    required this.onAddMore,
  });

  @override
  Widget build(BuildContext context) {
    // Get all items in cart with quantity > 0
    final itemsInCart = restaurant.bestsellers.where((item) {
      return (cartQuantities[item.id] ?? 0) > 0;
    }).toList();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThekaaColors.cardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: ThekaaColors.border,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          // Items list
          if (itemsInCart.isEmpty)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Text(
                  'Your cart is empty',
                  style: ThekaaTypography.deliveryInfo.copyWith(fontSize: 13),
                ),
              ),
            )
          else
            for (int i = 0; i < itemsInCart.length; i++) ...[
              _buildCartItem(itemsInCart[i]),
              const Divider(
                color: ThekaaColors.border,
                height: 1.0,
                thickness: 1.0,
              ),
            ],

          // Add more from [Restaurant]
          GestureDetector(
            onTap: onAddMore,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3E7D3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 16,
                          color: ThekaaColors.terracotta,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Add more from ${restaurant.shortName}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: ThekaaColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 20,
                    color: ThekaaColors.secondaryText,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(MenuItem item) {
    final qty = cartQuantities[item.id] ?? 0;
    final subtotal = (item.price * qty).toInt();

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 58,
              height: 58,
              child: Image.asset(
                item.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: ThekaaColors.border.withValues(alpha: 0.3),
                    child: const Icon(
                      Icons.restaurant,
                      color: ThekaaColors.secondaryText,
                      size: 24,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Details + Quantity Selector
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: ThekaaColors.primaryText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.dietary,
                  style: ThekaaTypography.deliveryInfo.copyWith(fontSize: 11),
                ),
                const SizedBox(height: 8),

                // Quantity selector: [ - qty + ]
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: ThekaaColors.cardBackground,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: ThekaaColors.border,
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => onDecrement(item.id),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(Icons.remove, size: 14, color: ThekaaColors.primaryText),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          qty.toString(),
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: ThekaaColors.primaryText,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => onIncrement(item.id),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(Icons.add, size: 14, color: ThekaaColors.terracotta),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Price & Delete Icon
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹$subtotal',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: ThekaaColors.primaryText,
                ),
              ),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: () => onDelete(item.id),
                behavior: HitTestBehavior.opaque,
                child: const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.delete_outline_rounded,
                    size: 18,
                    color: ThekaaColors.secondaryText,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

