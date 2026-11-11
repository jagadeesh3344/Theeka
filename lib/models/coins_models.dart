enum CoinTransactionType {
  reviewValidated,
  orderCompleted,
  coinsRedeemed,
  photoValidated,
}

class CoinTransaction {
  final String id;
  final String title;
  final String orderOrContext;
  final String dateTime;
  final int amount; // positive for earned, negative for redeemed
  final bool isEarned;
  final CoinTransactionType type;

  const CoinTransaction({
    required this.id,
    required this.title,
    required this.orderOrContext,
    required this.dateTime,
    required this.amount,
    required this.isEarned,
    this.type = CoinTransactionType.reviewValidated,
  });

  String get formattedAmount => isEarned ? '+$amount TKC' : '−${amount.abs()} TKC';

  static const List<CoinTransaction> defaultTransactions = [
    CoinTransaction(
      id: 'tx_1',
      title: 'Food review validated',
      orderOrContext: 'Shadab Biryani · #THK84291',
      dateTime: '01 Nov 2026 · 2:35 PM',
      amount: 25,
      isEarned: true,
      type: CoinTransactionType.reviewValidated,
    ),
    CoinTransaction(
      id: 'tx_2',
      title: 'Eligible order completed',
      orderOrContext: 'Shadab Biryani · #THK84291',
      dateTime: '01 Nov 2026 · 2:20 PM',
      amount: 75,
      isEarned: true,
      type: CoinTransactionType.orderCompleted,
    ),
    CoinTransaction(
      id: 'tx_3',
      title: 'Coins redeemed',
      orderOrContext: 'Earlier order · #THK83980',
      dateTime: '29 Oct 2026 · 8:10 PM',
      amount: -50,
      isEarned: false,
      type: CoinTransactionType.coinsRedeemed,
    ),
    CoinTransaction(
      id: 'tx_4',
      title: 'Original food photo validated',
      orderOrContext: 'Taaza Kitchen · Contribution checked',
      dateTime: '28 Oct 2026 · 11:22 AM',
      amount: 50,
      isEarned: true,
      type: CoinTransactionType.photoValidated,
    ),
  ];
}

class CoinsHistorySummary {
  final String openingDate;
  final int openingBalance;
  final int earnedAmount;
  final int redeemedAmount;
  final int closingBalance;

  const CoinsHistorySummary({
    this.openingDate = '01 Oct 2026',
    this.openingBalance = 1100,
    this.earnedAmount = 150,
    this.redeemedAmount = 50,
    this.closingBalance = 1200,
  });

  String _format(int val) => val.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );

  String get line1 => 'Opening balance · $openingDate: ${_format(openingBalance)} TKC';
  String get line2 =>
      'Earned +$earnedAmount · Redeemed −$redeemedAmount · Closing ${_format(closingBalance)} TKC';
}

enum MilestoneType {
  foodie,
  reviewer,
  explorer,
}

class DiscoveryMilestone {
  final String id;
  final String title;
  final String subtitle;
  final String statusText;
  final int currentCount;
  final int targetCount;
  final bool isCompleted;
  final MilestoneType type;

  const DiscoveryMilestone({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.statusText,
    required this.currentCount,
    required this.targetCount,
    this.isCompleted = false,
    required this.type,
  });

  double get progressRatio => targetCount > 0 ? (currentCount / targetCount).clamp(0.0, 1.0) : 0.0;

  static const List<DiscoveryMilestone> defaultMilestones = [
    DiscoveryMilestone(
      id: 'm_foodie',
      title: 'THEKAA Foodie',
      subtitle: '10 validated food stories',
      statusText: 'Earned · 28 Oct 2026',
      currentCount: 10,
      targetCount: 10,
      isCompleted: true,
      type: MilestoneType.foodie,
    ),
    DiscoveryMilestone(
      id: 'm_reviewer',
      title: 'Top Reviewer',
      subtitle: '12 of 20 helpful, validated reviews',
      statusText: '8 more eligible reviews to go',
      currentCount: 12,
      targetCount: 20,
      isCompleted: false,
      type: MilestoneType.reviewer,
    ),
    DiscoveryMilestone(
      id: 'm_explorer',
      title: 'Food Explorer',
      subtitle: '7 of 10 different kitchens explored',
      statusText: 'Discover 3 more verified kitchens',
      currentCount: 7,
      targetCount: 10,
      isCompleted: false,
      type: MilestoneType.explorer,
    ),
  ];
}

class CoinRewardDetail {
  final String transactionId;
  final String dateTime;
  final String type;
  final String source;
  final String relatedOrder;
  final int balanceBefore;
  final int balanceAfter;
  final int rewardAmount;
  final String statusLabel;
  final String restaurantName;
  final String dishName;
  final double rating;
  final String reviewQuote;
  final String dishImage;
  final String validationTitle;
  final String validationMessage;

  const CoinRewardDetail({
    this.transactionId = 'TKC-RV84291-01',
    this.dateTime = '01 Nov 2026 · 2:35 PM',
    this.type = 'Food review reward',
    this.source = 'Review #RV84291',
    this.relatedOrder = '#THK84291',
    this.balanceBefore = 1175,
    this.balanceAfter = 1200,
    this.rewardAmount = 25,
    this.statusLabel = 'COMPLETED · VALIDATED REVIEW',
    this.restaurantName = 'Shadab Biryani',
    this.dishName = 'Chicken Dum Biryani',
    this.rating = 4.0,
    this.reviewQuote = '“That unmistakable dum aroma.”',
    this.dishImage = 'assets/images/biryani.png',
    this.validationTitle = 'Credited once, after checks',
    this.validationMessage =
        'Publication and purchase eligibility were successfully validated. This review cannot receive a duplicate reward.',
  });

  String _format(int val) => val.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );

  String get formattedBalanceBefore => '${_format(balanceBefore)} TKC';
  String get formattedBalanceAfter => '${_format(balanceAfter)} TKC';
  String get formattedRewardAmount => '+$rewardAmount TKC';

  static const defaultDetail = CoinRewardDetail();
}

class ThekaaCoinsWallet {
  final int balance;
  final List<CoinTransaction> transactions;
  final CoinsHistorySummary historySummary;
  final List<DiscoveryMilestone> milestones;
  final CoinRewardDetail recentReward;

  const ThekaaCoinsWallet({
    this.balance = 1200,
    this.transactions = CoinTransaction.defaultTransactions,
    this.historySummary = const CoinsHistorySummary(),
    this.milestones = DiscoveryMilestone.defaultMilestones,
    this.recentReward = CoinRewardDetail.defaultDetail,
  });

  String get formattedBalance => balance.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );

  ThekaaCoinsWallet copyWith({
    int? balance,
    List<CoinTransaction>? transactions,
    CoinsHistorySummary? historySummary,
    List<DiscoveryMilestone>? milestones,
    CoinRewardDetail? recentReward,
  }) {
    return ThekaaCoinsWallet(
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
      historySummary: historySummary ?? this.historySummary,
      milestones: milestones ?? this.milestones,
      recentReward: recentReward ?? this.recentReward,
    );
  }

  static const defaultWallet = ThekaaCoinsWallet();
}

