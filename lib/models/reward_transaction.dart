import 'restaurant.dart';

class RewardTransaction {
  final String transactionId;
  final String dateTime;
  final String type;
  final String source;
  final String relatedOrder;
  final int balanceBefore;
  final int rewardAmount;
  final int balanceAfter;
  final String restaurantId;
  final String restaurantName;
  final String restaurantImagePath;
  final String dishName;
  final double rating;
  final String reviewText;
  final String status;

  const RewardTransaction({
    required this.transactionId,
    required this.dateTime,
    this.type = 'Food review reward',
    required this.source,
    required this.relatedOrder,
    required this.balanceBefore,
    required this.rewardAmount,
    required this.balanceAfter,
    required this.restaurantId,
    required this.restaurantName,
    required this.restaurantImagePath,
    required this.dishName,
    required this.rating,
    required this.reviewText,
    this.status = 'COMPLETED · VALIDATED REVIEW',
  });

  static RewardTransaction forRestaurant(
    Restaurant restaurant, {
    int balanceAfter = 1200,
    int rewardAmount = 25,
    String? orderId,
  }) {
    final balanceBefore = balanceAfter - rewardAmount;
    final orderRef = orderId ?? '#THK84291';
    final reviewRef = 'Review #RV84291';

    if (restaurant.id == 'chutneys') {
      return RewardTransaction(
        transactionId: 'TKC-RV62180-02',
        dateTime: '01 Nov 2026 · 2:35 PM',
        type: 'Food review reward',
        source: 'Review #RV62180',
        relatedOrder: '#THK62180',
        balanceBefore: balanceBefore,
        rewardAmount: rewardAmount,
        balanceAfter: balanceAfter,
        restaurantId: restaurant.id,
        restaurantName: restaurant.name,
        restaurantImagePath: restaurant.bestsellers.isNotEmpty
            ? restaurant.bestsellers.first.imagePath
            : 'assets/images/dosa.png',
        dishName: restaurant.bestsellers.isNotEmpty
            ? restaurant.bestsellers.first.name
            : 'Ghee Karam Dosa',
        rating: 4.5,
        reviewText: 'Crisp dosa served with six signature fresh chutneys.',
      );
    }

    // Default matching reference (Shadab Biryani)
    return RewardTransaction(
      transactionId: 'TKC-RV84291-01',
      dateTime: '01 Nov 2026 · 2:35 PM',
      type: 'Food review reward',
      source: reviewRef,
      relatedOrder: orderRef,
      balanceBefore: balanceBefore,
      rewardAmount: rewardAmount,
      balanceAfter: balanceAfter,
      restaurantId: restaurant.id,
      restaurantName: restaurant.name,
      restaurantImagePath: restaurant.bestsellers.isNotEmpty
          ? restaurant.bestsellers.first.imagePath
          : 'assets/images/biryani.png',
      dishName: restaurant.bestsellers.isNotEmpty
          ? restaurant.bestsellers.first.name
          : 'Chicken Dum Biryani',
      rating: 4.0,
      reviewText: 'That unmistakable dum aroma.',
    );
  }
}

