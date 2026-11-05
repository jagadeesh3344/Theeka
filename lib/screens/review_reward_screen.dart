import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../models/reward_transaction.dart';
import '../theme/thekaa_colors.dart';
import '../widgets/reward_header.dart';
import '../widgets/reward_success_badge.dart';
import '../widgets/transaction_details_card.dart';
import '../widgets/reward_restaurant_order_card.dart';
import '../widgets/reward_validation_card.dart';
import '../widgets/related_review_button.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';

class ReviewRewardScreen extends StatefulWidget {
  final Restaurant restaurant;
  final RewardTransaction? transaction;
  final VoidCallback? onBack;
  final ValueChanged<int>? onBottomNavTap;
  final VoidCallback? onViewReview;

  const ReviewRewardScreen({
    super.key,
    required this.restaurant,
    this.transaction,
    this.onBack,
    this.onBottomNavTap,
    this.onViewReview,
  });

  @override
  State<ReviewRewardScreen> createState() => _ReviewRewardScreenState();
}

class _ReviewRewardScreenState extends State<ReviewRewardScreen> {
  late RewardTransaction _transaction;

  @override
  void initState() {
    super.initState();
    _transaction = widget.transaction ??
        RewardTransaction.forRestaurant(widget.restaurant);
  }

  void _showReviewBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: ThekaaColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Related Review',
                    style: TextStyle(
                      fontFamily: 'Playfair Display',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ThekaaColors.primaryText,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: ThekaaColors.primaryText),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${_transaction.source} · ${_transaction.restaurantName}',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  color: ThekaaColors.secondaryText,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ...List.generate(
                    5,
                    (i) => Icon(
                      i < _transaction.rating.floor()
                          ? Icons.star_rounded
                          : (i < _transaction.rating
                              ? Icons.star_half_rounded
                              : Icons.star_border_rounded),
                      size: 18,
                      color: ThekaaColors.terracotta,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${_transaction.rating.toStringAsFixed(1)} / 5.0',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: ThekaaColors.primaryText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '"${_transaction.reviewText}"',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: ThekaaColors.primaryText,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),

                    // SECTION A — TOP HEADER
                    RewardHeader(
                      onBack: widget.onBack ?? () => Navigator.of(context).maybePop(),
                    ),
                    const SizedBox(height: 18),

                    // SECTION B, C, D — ICON, AMOUNT, STATUS
                    RewardSuccessBadge(
                      rewardAmount: _transaction.rewardAmount,
                      status: _transaction.status,
                    ),
                    const SizedBox(height: 18),

                    // SECTION E — TRANSACTION DETAILS CARD
                    TransactionDetailsCard(
                      transaction: _transaction,
                    ),
                    const SizedBox(height: 14),

                    // SECTION F — RESTAURANT / RELATED ORDER CARD
                    RewardRestaurantOrderCard(
                      transaction: _transaction,
                    ),
                    const SizedBox(height: 14),

                    // SECTION G — SUCCESS INFORMATION CARD
                    const RewardValidationCard(),
                    const SizedBox(height: 14),

                    // SECTION H — RELATED REVIEW BUTTON
                    RelatedReviewButton(
                      onTap: widget.onViewReview ?? _showReviewBottomSheet,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // SECTION I — FIXED BOTTOM NAVIGATION (Profile is active = index 4)
            ThekaaBottomNavBar(
              currentIndex: 4, // Profile tab is active
              onTap: (index) {
                if (widget.onBottomNavTap != null) {
                  widget.onBottomNavTap!(index);
                } else {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

