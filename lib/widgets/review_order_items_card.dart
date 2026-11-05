import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';

class ReviewOrderItemsCard extends StatelessWidget {
  final Restaurant restaurant;
  final Map<String, int> cartQuantities;
  final ValueChanged<String> onIncrement;
  final ValueChanged<String> onDecrement;
  final VoidCallback? onAddMore;

  const ReviewOrderItemsCard({
    super.key,
    required this.restaurant,
    required this.cartQuantities,
    required this.onIncrement,
    required this.onDecrement,
    this.onAddMore,
  });

  @override
  Widget build(BuildContext context) {
    // Filter active items with qty > 0
    final activeItems = restaurant.menuItems
        .where((item) => (cartQuantities[item.id] ?? 0) > 0)
        .toList();

    final totalCount = activeItems.fold<int>(
      0,
      (sum, item) => sum + (cartQuantities[item.id] ?? 0),
    );

    return Container(
      decoration: BoxDecoration(
        color: ThekaaColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThekaaColors.border,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Restaurant info header
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4E8D4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(
                    Icons.restaurant_rounded,
                    color: ThekaaColors.terracotta,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: const TextStyle(
                        fontFamily: 'Playfair Display',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${restaurant.locality} · $totalCount ${totalCount == 1 ? 'item' : 'items'}',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: ThekaaColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(color: ThekaaColors.border, height: 1, thickness: 1),
          const SizedBox(height: 12),

          // Items list
          for (int index = 0; index < activeItems.length; index++) ...[
            if (index > 0) ...[
              const SizedBox(height: 12),
              const Divider(color: ThekaaColors.border, height: 1, thickness: 1),
              const SizedBox(height: 12),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Item thumbnail image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 52,
                    height: 52,
                    color: ThekaaColors.mapBackground,
                    child: Image.asset(
                      activeItems[index].imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.lunch_dining_rounded,
                        size: 28,
                        color: ThekaaColors.terracotta,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Middle details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (activeItems[index].isBestseller) ...[
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: const Color(0xFF9E4B28),
                                borderRadius: BorderRadius.circular(1.5),
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'BESTSELLER',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF9E4B28),
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                      ],
                      Text(
                        activeItems[index].name,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: ThekaaColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        activeItems[index].description.isNotEmpty
                            ? activeItems[index].description
                            : (activeItems[index].isVegetarian
                                ? 'Vegetarian · serves 1'
                                : 'Dum cooked · serves 1'),
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11.5,
                          color: ThekaaColors.secondaryText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹${activeItems[index].price.toInt()}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: ThekaaColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),

                // Quantity stepper: [ - 1 + ]
                Container(
                  height: 28,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: ThekaaColors.mainBackground.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: ThekaaColors.border,
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => onDecrement(activeItems[index].id),
                        behavior: HitTestBehavior.opaque,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Icon(
                            Icons.remove,
                            size: 14,
                            color: ThekaaColors.terracotta,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Text(
                          '${cartQuantities[activeItems[index].id] ?? 0}',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: ThekaaColors.primaryText,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => onIncrement(activeItems[index].id),
                        behavior: HitTestBehavior.opaque,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Icon(
                            Icons.add,
                            size: 14,
                            color: ThekaaColors.terracotta,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(height: 12),
          const Divider(color: ThekaaColors.border, height: 1, thickness: 1),
          const SizedBox(height: 12),

          // Add more items row
          GestureDetector(
            onTap: onAddMore,
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4E8D4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add_rounded,
                      color: ThekaaColors.terracotta,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Add more items',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: ThekaaColors.primaryText,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: ThekaaColors.secondaryText,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
