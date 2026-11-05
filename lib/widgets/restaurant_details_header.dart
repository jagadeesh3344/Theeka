import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class RestaurantDetailsHeader extends StatefulWidget {
  final String restaurantName;
  final VoidCallback onBack;
  final VoidCallback? onFavouriteTap;

  const RestaurantDetailsHeader({
    super.key,
    required this.restaurantName,
    required this.onBack,
    this.onFavouriteTap,
  });

  @override
  State<RestaurantDetailsHeader> createState() => _RestaurantDetailsHeaderState();
}

class _RestaurantDetailsHeaderState extends State<RestaurantDetailsHeader> {
  bool _isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Eyebrow
        Text(
          '01 / FOOD DISCOVERY & ORDERING',
          style: ThekaaTypography.eyebrow,
        ),
        const SizedBox(height: 6),

        // Back Chevron, Dynamic Name, and Favourite Icon
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: widget.onBack,
                  behavior: HitTestBehavior.opaque,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 8, top: 4, bottom: 4),
                    child: Icon(
                      Icons.chevron_left_rounded,
                      size: 26,
                      color: ThekaaColors.primaryText,
                    ),
                  ),
                ),
                Text(
                  widget.restaurantName,
                  style: ThekaaTypography.sectionHeading.copyWith(
                    fontSize: 22,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isFavourite = !_isFavourite;
                });
                widget.onFavouriteTap?.call();
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  _isFavourite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  size: 22,
                  color: _isFavourite ? ThekaaColors.terracotta : ThekaaColors.secondaryText,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

