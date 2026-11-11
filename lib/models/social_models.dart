import '../models/restaurant.dart';
import 'order_confirmation.dart';

class SocialComment {
  final String id;
  final String authorName;
  final String authorAvatar;
  final String text;
  final String timestamp;

  const SocialComment({
    required this.id,
    required this.authorName,
    required this.authorAvatar,
    required this.text,
    required this.timestamp,
  });

  static const List<SocialComment> defaultComments = [
    SocialComment(
      id: 'c_1',
      authorName: 'Sana',
      authorAvatar: 'assets/images/rider_ravi.png',
      text: 'That unmistakable dum aroma reaches through the screen!',
      timestamp: '1h ago',
    ),
    SocialComment(
      id: 'c_2',
      authorName: 'Ravi',
      authorAvatar: 'assets/images/rider_ravi.png',
      text: 'Shadab never misses on the long grains.',
      timestamp: '35m ago',
    ),
  ];
}

class SocialStory {
  final String id;
  final String label;
  final String imageUrl;
  final bool isUser;
  final String timestamp;
  final bool viewed;
  final List<String> storyMedia;
  final String? caption;

  const SocialStory({
    required this.id,
    required this.label,
    required this.imageUrl,
    this.isUser = false,
    this.timestamp = '2h ago',
    this.viewed = false,
    this.storyMedia = const ['assets/images/biryani_hd.jpg'],
    this.caption,
  });

  static const sampleStories = [
    SocialStory(
      id: 'story_1',
      label: 'Your journal',
      imageUrl: 'assets/images/user_avatar.png',
      isUser: true,
      timestamp: 'Just now',
      storyMedia: ['assets/images/biryani_hd.jpg'],
      caption: 'Today’s handpicked dum biryani at Shadab',
    ),
    SocialStory(
      id: 'story_2',
      label: 'Sana',
      imageUrl: 'assets/images/rider_ravi.png',
      timestamp: '2h ago',
      storyMedia: ['assets/images/kebabs.png'],
      caption: 'Crisp Seekh kebabs from Old City',
    ),
    SocialStory(
      id: 'story_3',
      label: "Ravi's eats",
      imageUrl: 'assets/images/rider_ravi.png',
      timestamp: '4h ago',
      storyMedia: ['assets/images/mutton_biryani.png'],
      caption: 'Finishing touches before heading out',
    ),
    SocialStory(
      id: 'story_4',
      label: 'Chai trails',
      imageUrl: 'assets/images/biryani.png',
      timestamp: '5h ago',
      storyMedia: ['assets/images/dosa.png'],
      caption: 'Evening chai & ghee karam dosa trail',
    ),
  ];
}

class SocialPost {
  final String id;
  final String authorName;
  final String authorHandle;
  final String authorAvatar;
  final String restaurantName;
  final String restaurantLocality;
  final String restaurantCity;
  final String timestamp;
  final String dishName;
  final double dishPrice;
  final String orderId;
  final String reviewId;
  final double rating;
  final String title;
  final String description;
  final List<String> imageUrls;
  final int totalImages;
  final int currentImageIndex;
  final int likesCount;
  final int commentsCount;
  final List<SocialComment> comments;
  final bool isLiked;
  final bool isSaved;
  final bool isVerifiedPurchase;
  final int rewardCoins;
  final String rewardDate;
  final String rewardTimestamp;
  final bool isRewardValidated;
  final int walletBalance;

  const SocialPost({
    this.id = 'post_sp_1',
    this.authorName = 'Vatsa K.',
    this.authorHandle = '@vatsax',
    this.authorAvatar = 'assets/images/user_avatar.png',
    this.restaurantName = 'Shadab Biryani',
    this.restaurantLocality = 'Gachibowli',
    this.restaurantCity = 'Hyderabad',
    this.timestamp = '2:35 PM',
    this.dishName = 'Chicken Dum Biryani',
    this.dishPrice = 280,
    this.orderId = '#THK84291',
    this.reviewId = '#RV84291',
    this.rating = 4.0,
    this.title = 'That unmistakable dum aroma.',
    this.description =
        "Long grains, tender chicken, and a proper hit of spice. Shadab still knows the way to a Hyderabadi heart. The raita brings it all together — I'd happily order this again.",
    this.imageUrls = const [
      'assets/images/biryani_hd.jpg',
      'assets/images/biryani.png',
      'assets/images/mutton_biryani.png',
    ],
    this.totalImages = 3,
    this.currentImageIndex = 1,
    this.likesCount = 128,
    this.commentsCount = 12,
    this.comments = SocialComment.defaultComments,
    this.isLiked = false,
    this.isSaved = false,
    this.isVerifiedPurchase = true,
    this.rewardCoins = 25,
    this.rewardDate = '01 Nov, 2:35 PM',
    this.rewardTimestamp = '01 Nov 2026 · 2:35 PM',
    this.isRewardValidated = true,
    this.walletBalance = 1200,
  });

  String get restaurantWithLocality => '$restaurantName · $restaurantLocality';
  String get fullRestaurantAddress =>
      '$restaurantName · $restaurantLocality, $restaurantCity';
  String get dishWithPrice => '$dishName · ₹${dishPrice.toInt()}';
  String get verifiedOrderText => 'Verified THEKAA order $orderId';
  String get imageCountText => '$currentImageIndex/$totalImages';

  SocialPost copyWith({
    String? id,
    String? authorName,
    String? authorHandle,
    String? authorAvatar,
    String? restaurantName,
    String? restaurantLocality,
    String? restaurantCity,
    String? timestamp,
    String? dishName,
    double? dishPrice,
    String? orderId,
    String? reviewId,
    double? rating,
    String? title,
    String? description,
    List<String>? imageUrls,
    int? totalImages,
    int? currentImageIndex,
    int? likesCount,
    int? commentsCount,
    List<SocialComment>? comments,
    bool? isLiked,
    bool? isSaved,
    bool? isVerifiedPurchase,
    int? rewardCoins,
    String? rewardDate,
    String? rewardTimestamp,
    bool? isRewardValidated,
    int? walletBalance,
  }) {
    return SocialPost(
      id: id ?? this.id,
      authorName: authorName ?? this.authorName,
      authorHandle: authorHandle ?? this.authorHandle,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantLocality: restaurantLocality ?? this.restaurantLocality,
      restaurantCity: restaurantCity ?? this.restaurantCity,
      timestamp: timestamp ?? this.timestamp,
      dishName: dishName ?? this.dishName,
      dishPrice: dishPrice ?? this.dishPrice,
      orderId: orderId ?? this.orderId,
      reviewId: reviewId ?? this.reviewId,
      rating: rating ?? this.rating,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrls: imageUrls ?? this.imageUrls,
      totalImages: totalImages ?? this.totalImages,
      currentImageIndex: currentImageIndex ?? this.currentImageIndex,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      comments: comments ?? this.comments,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
      isVerifiedPurchase: isVerifiedPurchase ?? this.isVerifiedPurchase,
      rewardCoins: rewardCoins ?? this.rewardCoins,
      rewardDate: rewardDate ?? this.rewardDate,
      rewardTimestamp: rewardTimestamp ?? this.rewardTimestamp,
      isRewardValidated: isRewardValidated ?? this.isRewardValidated,
      walletBalance: walletBalance ?? this.walletBalance,
    );
  }

  static const defaultPost = SocialPost();

  static SocialPost fromRestaurant(Restaurant r) {
    return SocialPost(
      restaurantName: r.name,
      restaurantLocality: r.locality,
      dishName: r.bestsellers.isNotEmpty ? r.bestsellers.first.name : 'Dum Biryani',
      dishPrice: r.bestsellers.isNotEmpty ? r.bestsellers.first.price : 280,
    );
  }
}

class JournalTile {
  final String id;
  final String imageUrl;
  final double rating;

  const JournalTile({
    required this.id,
    required this.imageUrl,
    required this.rating,
  });

  static const sampleTiles = [
    JournalTile(
      id: 'jt_1',
      imageUrl: 'assets/images/biryani.png',
      rating: 4.0,
    ),
    JournalTile(
      id: 'jt_2',
      imageUrl: 'assets/images/kebabs.png',
      rating: 4.8,
    ),
    JournalTile(
      id: 'jt_3',
      imageUrl: 'assets/images/biryani_hd.jpg',
      rating: 4.8,
    ),
    JournalTile(
      id: 'jt_4',
      imageUrl: 'assets/images/dosa.png',
      rating: 4.8,
    ),
    JournalTile(
      id: 'jt_5',
      imageUrl: 'assets/images/mutton_biryani.png',
      rating: 4.8,
    ),
    JournalTile(
      id: 'jt_6',
      imageUrl: 'assets/images/biryani_hd.jpg',
      rating: 4.8,
    ),
  ];
}

class EligibleOrder {
  final String orderId;
  final String restaurantName;
  final String restaurantLocality;
  final String restaurantCity;
  final String restaurantImage;
  final List<String> orderedDishes;
  final Map<String, double> dishPrices;
  final String orderDate;

  const EligibleOrder({
    required this.orderId,
    required this.restaurantName,
    required this.restaurantLocality,
    required this.restaurantCity,
    required this.restaurantImage,
    required this.orderedDishes,
    required this.dishPrices,
    required this.orderDate,
  });

  factory EligibleOrder.fromOrderConfirmation(OrderConfirmation order) {
    final Map<String, double> prices = {};
    final List<String> dishes = [];
    for (final item in order.items) {
      dishes.add(item.name);
      prices[item.name] = item.price;
    }
    return EligibleOrder(
      orderId: order.orderId,
      restaurantName: order.restaurantName,
      restaurantLocality: order.restaurantArea,
      restaurantCity: 'Hyderabad',
      restaurantImage: order.restaurantImagePath.isNotEmpty
          ? order.restaurantImagePath
          : 'assets/images/biryani.png',
      orderedDishes: dishes.isNotEmpty ? dishes : ['Chicken Dum Biryani'],
      dishPrices: prices.isNotEmpty ? prices : {'Chicken Dum Biryani': 280.0},
      orderDate: order.date,
    );
  }

  static const List<EligibleOrder> defaultEligibleOrders = [
    EligibleOrder(
      orderId: '#THK84291',
      restaurantName: 'Shadab Biryani',
      restaurantLocality: 'Gachibowli',
      restaurantCity: 'Hyderabad',
      restaurantImage: 'assets/images/biryani.png',
      orderedDishes: ['Chicken Dum Biryani', 'Mutton Biryani'],
      dishPrices: {
        'Chicken Dum Biryani': 280.0,
        'Mutton Biryani': 340.0,
      },
      orderDate: '01 Nov 2026',
    ),
    EligibleOrder(
      orderId: '#THK83980',
      restaurantName: 'Chutneys',
      restaurantLocality: 'Banjara Hills',
      restaurantCity: 'Hyderabad',
      restaurantImage: 'assets/images/biryani.png',
      orderedDishes: ['Ghee Karam Dosa', 'Filter Coffee'],
      dishPrices: {
        'Ghee Karam Dosa': 180.0,
        'Filter Coffee': 70.0,
      },
      orderDate: '29 Oct 2026',
    ),
  ];
}
