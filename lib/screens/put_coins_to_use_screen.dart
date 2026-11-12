import 'dart:async';
import 'package:flutter/material.dart';
import '../models/address.dart';
import '../models/loyalty.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import '../widgets/thekaa_coins_balance_card.dart';

class PutCoinsToUseScreen extends StatefulWidget {
  final Restaurant restaurant;
  final Map<String, int> cartQuantities;
  final DeliveryAddress? deliveryAddress;
  final double originalOrderValue;
  final int initialCoinBalance;
  final LoyaltyQuoteStatus? initialQuoteStatus;
  final VoidCallback? onBack;
  final ValueChanged<double>? onContinue;
  final ValueChanged<int>? onNavTap;

  const PutCoinsToUseScreen({
    super.key,
    this.restaurant = Restaurant.shadabBiryani,
    this.cartQuantities = const {
      'chicken_dum_biryani': 1,
      'mutton_biryani': 1,
    },
    this.deliveryAddress,
    this.originalOrderValue = 655.0,
    this.initialCoinBalance = 1200,
    this.initialQuoteStatus,
    this.onBack,
    this.onContinue,
    this.onNavTap,
  });

  @override
  State<PutCoinsToUseScreen> createState() => _PutCoinsToUseScreenState();
}

class _PutCoinsToUseScreenState extends State<PutCoinsToUseScreen> {
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

    if (status == LoyaltyQuoteStatus.loading) {
      _quoteTimer = Timer(const Duration(milliseconds: 1400), () {
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
    if (_quote.status != LoyaltyQuoteStatus.ready || _selectedCoins <= 0) return;
    setState(() {
      _appliedCoins = _selectedCoins;
      _coinDiscount = _appliedCoins * _quote.discountPerCoin;
    });
  }

  double get _finalPayable => (widget.originalOrderValue - _coinDiscount).clamp(0.0, double.infinity);

  @override
  Widget build(BuildContext context) {
    final isQuoteLoading = _quote.status == LoyaltyQuoteStatus.loading;
    final restaurantNameUpper = widget.restaurant.name.toUpperCase();

    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      bottomNavigationBar: ThekaaBottomNavBar(
        currentIndex: 4,
        onTap: widget.onNavTap,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Back arrow, Title
              Row(
                children: [
                  InkWell(
                    onTap: widget.onBack ?? () => Navigator.maybePop(context),
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Put your coins to use',
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // Current Cart Label
              Text(
                'CURRENT CART · $restaurantNameUpper',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: Color(0xFF8D5B34),
                ),
              ),
              const SizedBox(height: 16),

              // Coin Balance Card
              ThekaaCoinsBalanceCard(balance: widget.initialCoinBalance),
              const SizedBox(height: 14),

              // Coins To Redeem Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDF8),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFEADBCE),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Coins to redeem',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Stepper Box
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5EBD7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 20, color: Color(0xFF4A2E18)),
                            onPressed: _decrement,
                          ),
                          Text(
                            '$_selectedCoins TKC',
                            style: const TextStyle(
                              fontFamily: 'Playfair Display',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4A2E18),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 20, color: Color(0xFF4A2E18)),
                            onPressed: _increment,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Current conversion row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Current conversion',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: ThekaaColors.secondaryText,
                          ),
                        ),
                        Text(
                          isQuoteLoading ? 'Fetching quote...' : _quote.conversionText,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFA86538),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Maximum eligible row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Maximum eligible',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: ThekaaColors.secondaryText,
                          ),
                        ),
                        Text(
                          isQuoteLoading ? 'Checking limit...' : '${_quote.maxEligibleCoins} TKC',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFA86538),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Rate and Limit Info Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5EBD7),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFEADBCE),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2.0),
                      child: Icon(
                        Icons.access_time_rounded,
                        size: 16,
                        color: Color(0xFF8D5B34),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Rate and limit confirmed at checkout',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF4A2E18),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            _appliedCoins > 0
                                ? '$_appliedCoins coins applied for ₹${_coinDiscount.toInt()} discount on this order.'
                                : "Your current order has no coins applied. We'll enable redemption after the checkout quote loads.",
                            style: ThekaaTypography.deliveryInfo.copyWith(
                              fontSize: 11,
                              height: 1.35,
                              color: const Color(0xFF6B4E38),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Apply Coins Button
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isQuoteLoading
                        ? const Color(0xFFDDD4C7)
                        : (_selectedCoins > 0 ? ThekaaColors.terracotta : const Color(0xFFDDD4C7)),
                    foregroundColor: isQuoteLoading || _selectedCoins == 0
                        ? const Color(0xFF7A6B5C)
                        : Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: (!isQuoteLoading && _selectedCoins > 0) ? _applyCoins : null,
                  child: Text(
                    isQuoteLoading
                        ? 'Apply coins · waiting for quote'
                        : (_selectedCoins > 0
                            ? 'Apply coins · $_selectedCoins TKC'
                            : 'Apply coins · waiting for quote'),
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: (isQuoteLoading || _selectedCoins == 0)
                          ? const Color(0xFF7A6B5C)
                          : Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Order Value Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDF8),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFEADBCE),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Order value',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.5,
                            color: ThekaaColors.secondaryText,
                          ),
                        ),
                        Text(
                          '₹${widget.originalOrderValue.toInt()}',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: ThekaaColors.primaryText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Coins applied',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.5,
                            color: ThekaaColors.secondaryText,
                          ),
                        ),
                        Text(
                          '$_appliedCoins TKC',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: ThekaaColors.primaryText,
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(height: 1, thickness: 1, color: Color(0xFFF0E6D8)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _appliedCoins > 0 ? 'Payable, coins applied' : 'Payable, unchanged',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: ThekaaColors.primaryText,
                          ),
                        ),
                        Text(
                          '₹${_finalPayable.toInt()}',
                          style: const TextStyle(
                            fontFamily: 'Playfair Display',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ThekaaColors.primaryText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThekaaColors.terracotta,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => widget.onContinue?.call(_finalPayable),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _appliedCoins > 0
                            ? 'Continue with coins · ₹${_finalPayable.toInt()}'
                            : 'Continue without coins · ₹${_finalPayable.toInt()}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_rounded, size: 16, color: Colors.white),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

