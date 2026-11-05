enum LoyaltyQuoteStatus {
  loading,
  ready,
  error,
}

class ThekaaLoyaltyQuote {
  final int coinBalance;
  final LoyaltyQuoteStatus status;
  final String conversionText;
  final int maxEligibleCoins;
  final double discountPerCoin; // e.g. 0.25 (4 TKC = ₹1) or 0.1

  const ThekaaLoyaltyQuote({
    this.coinBalance = 1200,
    this.status = LoyaltyQuoteStatus.loading,
    this.conversionText = '4 TKC = ₹1',
    this.maxEligibleCoins = 200,
    this.discountPerCoin = 0.25,
  });

  ThekaaLoyaltyQuote copyWith({
    int? coinBalance,
    LoyaltyQuoteStatus? status,
    String? conversionText,
    int? maxEligibleCoins,
    double? discountPerCoin,
  }) {
    return ThekaaLoyaltyQuote(
      coinBalance: coinBalance ?? this.coinBalance,
      status: status ?? this.status,
      conversionText: conversionText ?? this.conversionText,
      maxEligibleCoins: maxEligibleCoins ?? this.maxEligibleCoins,
      discountPerCoin: discountPerCoin ?? this.discountPerCoin,
    );
  }
}

