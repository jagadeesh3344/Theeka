import 'dart:async';
import 'package:flutter/material.dart';
import '../models/address.dart';
import '../models/loyalty.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';
import '../widgets/coins_header.dart';
import '../widgets/thekaa_coins_balance_card.dart';
import '../widgets/coins_redeem_selector_card.dart';
import '../widgets/coins_notice_card.dart';
import '../widgets/coins_order_summary_card.dart';
import 'review_reward_screen.dart';

class CoinsRedemptionScreen extends StatefulWidget {
  final Restaurant restaurant;
  final Map<String, int> cartQuantities;
  final DeliveryAddress? deliveryAddress;
  final double originalOrderValue;
  final int initialCoinBalance;
  final LoyaltyQuoteStatus? initialQuoteStatus;
  final VoidCallback? onBack;
  final ValueChanged<double>? onContinueToPay;

  const CoinsRedemptionScreen({
    super.key,
    required this.restaurant,
    required this.cartQuantities,
    this.deliveryAddress,
    this.originalOrderValue = 655.0,
    this.initialCoinBalance = 1200,
    this.initialQuoteStatus,
    this.onBack,
    this.onContinueToPay,
  });

  @override
  State<CoinsRedemptionScreen> createState() => _CoinsRedemptionScreenState();
}

class _CoinsRedemptionScreenState extends State<CoinsRedemptionScreen> {
  late ThekaaLoyaltyQuote _quote;
  Timer? _quoteTimer;
  int _selectedCoins = 0;
  int _appliedCoins = 0;
  double _coinDiscount = 0.0;

  @override
  void initState() {
    super.initState();
    final status = widget.initialQuoteStatus ?? LoyaltyQuoteStatus.loading;
    _quote = ThekaaLoyaltyQuote(
      coinBalance: widget.initialCoinBalance,
      status: status,
      conversionText: '4 TKC = ₹1',
      maxEligibleCoins: 200,
      discountPerCoin: 0.25,
    );

    // Fetch quotation asynchronously to transition from loading to ready
    if (status == LoyaltyQuoteStatus.loading) {
      _quoteTimer = Timer(const Duration(milliseconds: 1200), () {
        if (mounted) {
          setState(() {
            _quote = _quote.copyWith(status: LoyaltyQuoteStatus.ready);
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _quoteTimer?.cancel();
    super.dispose();
  }

  void _increment() {
    setState(() {
      // If still loading, allow user interaction to trigger ready state
      if (_quote.status == LoyaltyQuoteStatus.loading) {
        _quote = _quote.copyWith(status: LoyaltyQuoteStatus.ready);
      }
      final maxEligible = _quote.maxEligibleCoins;
      if (_selectedCoins + 50 <= maxEligible && _selectedCoins + 50 <= _quote.coinBalance) {
        _selectedCoins += 50;
      } else {
        _selectedCoins = maxEligible <= _quote.coinBalance ? maxEligible : _quote.coinBalance;
      }
    });
  }

  void _decrement() {
    setState(() {
      if (_selectedCoins - 50 >= 0) {
        _selectedCoins -= 50;
      } else {
        _selectedCoins = 0;
      }
    });
  }

  void _applyCoins() {
    if (_selectedCoins > 0 && _quote.status == LoyaltyQuoteStatus.ready) {
      setState(() {
        _appliedCoins = _selectedCoins;
        _coinDiscount = _appliedCoins * _quote.discountPerCoin;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Applied $_appliedCoins TKC discount of ₹${_coinDiscount.toInt()}'),
          duration: const Duration(seconds: 2),
          backgroundColor: ThekaaColors.terracotta,
        ),
      );
    }
  }

  double get _finalPayable {
    final payable = widget.originalOrderValue - _coinDiscount;
    return payable > 0 ? payable : 0;
  }

  @override
  Widget build(BuildContext context) {
    final isQuoteLoading = _quote.status == LoyaltyQuoteStatus.loading;
    final canApply = !isQuoteLoading && _selectedCoins > 0 && _selectedCoins != _appliedCoins;

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // SECTION A & B — HEADER & ORDER RESTAURANT LABEL
                    CoinsHeader(
                      restaurantName: widget.restaurant.name,
                      onBack: widget.onBack ?? () => Navigator.of(context).maybePop(),
                    ),
                    const SizedBox(height: 14),

                    // SECTION C — THEKAA COINS BALANCE CARD
                    ThekaaCoinsBalanceCard(
                      balance: _quote.coinBalance,
                    ),
                    const SizedBox(height: 14),

                    // SECTION D & E — COINS TO REDEEM & CONVERSION/ELIGIBILITY
                    CoinsRedeemSelectorCard(
                      selectedCoins: _selectedCoins,
                      quote: _quote,
                      onIncrement: _increment,
                      onDecrement: _decrement,
                    ),
                    const SizedBox(height: 14),

                    // SECTION F — REDEMPTION NOTICE CARD
                    CoinsNoticeCard(
                      isCoinsApplied: _appliedCoins > 0,
                    ),
                    const SizedBox(height: 14),

                    // SECTION G — APPLY COINS BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: canApply ? _applyCoins : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: canApply ? ThekaaColors.terracotta : const Color(0xFFE3D5BC),
                          foregroundColor: canApply ? Colors.white : const Color(0xFF8C7764),
                          disabledBackgroundColor: const Color(0xFFE3D5BC),
                          disabledForegroundColor: const Color(0xFF8C7764),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          isQuoteLoading
                              ? 'Apply coins · waiting for quote'
                              : (_appliedCoins > 0 && _selectedCoins == _appliedCoins
                                  ? 'Coins applied · $_appliedCoins TKC'
                                  : (_selectedCoins > 0
                                      ? 'Apply coins · $_selectedCoins TKC'
                                      : 'Apply coins')),
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: canApply ? Colors.white : const Color(0xFF8C7764),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // SECTION H — ORDER VALUE SUMMARY CARD
                    CoinsOrderSummaryCard(
                      orderValue: widget.originalOrderValue,
                      appliedCoins: _appliedCoins,
                      coinDiscount: _coinDiscount,
                      finalPayable: _finalPayable,
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // SECTION I — FIXED BOTTOM CONTINUE BUTTON
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: ThekaaColors.mainBackground,
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.onContinueToPay != null) {
                      widget.onContinueToPay!(_finalPayable);
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ReviewRewardScreen(
                            restaurant: widget.restaurant,
                            onBack: () => Navigator.of(context).pop(),
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThekaaColors.terracotta,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _appliedCoins > 0
                            ? 'Continue with coins · ₹${_finalPayable.toInt()}'
                            : 'Continue without coins · ₹${widget.originalOrderValue.toInt()}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.arrow_forward_rounded, size: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
