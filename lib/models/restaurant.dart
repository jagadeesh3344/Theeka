import 'package:flutter/material.dart';

class RestaurantStat {
  final String value;
  final String label;

  const RestaurantStat({
    required this.value,
    required this.label,
  });
}

class MenuItem {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imagePath;
  final bool isBestseller;
  final double rating;
  final String category;
  final String dietary;

  const MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
    this.isBestseller = true,
    this.rating = 4.8,
    this.category = 'Bestsellers',
    this.dietary = 'Serves 1 · Non-veg',
  });

  bool get isVegetarian => dietary.toLowerCase().contains('veg') && !dietary.toLowerCase().contains('non-veg');
}

class RestaurantReview {
  final String author;
  final double rating;
  final String date;
  final String comment;

  const RestaurantReview({
    required this.author,
    required this.rating,
    required this.date,
    required this.comment,
  });
}

class Restaurant {
  final String id;
  final String name;
  final String shortName;
  final double rating;
  final String reviewsCount;
  final String deliveryDetails;
  final double deliveryFee;
  final String distance;
  final String cuisine;
  final String priceRange;
  final String tag;
  final bool isVerified;
  final String imagePath;
  final String locality;
  final Offset mapCoordinates;
  final String description;
  final List<RestaurantStat> statistics;
  final List<String> cuisineTags;
  final List<String> menuCategories;
  final List<MenuItem> bestsellers;
  final List<RestaurantReview> reviews;
  final String about;

  const Restaurant({
    required this.id,
    required this.name,
    required this.shortName,
    required this.rating,
    required this.reviewsCount,
    required this.deliveryDetails,
    this.deliveryFee = 30.0,
    required this.distance,
    required this.cuisine,
    required this.priceRange,
    this.tag = 'Verified kitchen',
    this.isVerified = true,
    required this.imagePath,
    this.locality = 'Gachibowli',
    required this.mapCoordinates,
    required this.description,
    required this.statistics,
    required this.cuisineTags,
    required this.menuCategories,
    required this.bestsellers,
    required this.reviews,
    required this.about,
  });

  List<MenuItem> get menuItems => bestsellers;

  static const Restaurant shadabBiryani = Restaurant(
    id: 'shadab_biryani',
    name: 'Shadab Biryani',
    shortName: 'Shadab',
    rating: 4.8,
    reviewsCount: '1.2K',
    deliveryDetails: 'Gachibowli · 24–28 min · ₹30 delivery',
    deliveryFee: 30.0,
    distance: '1.4 km',
    cuisine: 'Biryani',
    priceRange: '₹₹',
    tag: 'Verified kitchen',
    isVerified: true,
    imagePath: 'assets/images/biryani.png',
    locality: 'Gachibowli',
    mapCoordinates: Offset(0.58, 0.41),
    description:
        'Slow-cooked dum, fragrant rice, and recipes that feel like home. A local favourite for a proper Hyderabadi meal.',
    statistics: [
      RestaurantStat(value: '12K+', label: 'happy diners'),
      RestaurantStat(value: '96%', label: 'loved the food'),
      RestaurantStat(value: 'Since 1990', label: 'Hyderabadi roots'),
    ],
    cuisineTags: ['Hyderabadi', 'Biryani', 'Mughlai'],
    menuCategories: [
      'Bestsellers',
      'Biryani',
      'Starters',
      'Breads',
      'Desserts',
      'Beverages',
    ],
    bestsellers: [
      MenuItem(
        id: 'chicken_dum_biryani',
        name: 'Chicken Dum Biryani',
        price: 280,
        description: 'Dum cooked · serves 1',
        imagePath: 'assets/images/biryani.png',
        isBestseller: true,
        rating: 4.9,
        category: 'Bestsellers',
        dietary: 'Serves 1 · Non-veg',
      ),
      MenuItem(
        id: 'mutton_biryani',
        name: 'Mutton Biryani',
        price: 340,
        description: 'Tender mutton · serves 1',
        imagePath: 'assets/images/mutton_biryani.png',
        isBestseller: true,
        rating: 4.8,
        category: 'Bestsellers',
        dietary: 'Serves 1 · Non-veg',
      ),
      MenuItem(
        id: 'tandoori_kebab',
        name: 'Seekh Kebab & Tandoori Platter',
        price: 320,
        description: 'Non-vegetarian · Freshly prepared',
        imagePath: 'assets/images/kebabs.png',
        isBestseller: false,
        rating: 4.7,
        category: 'Starters',
        dietary: 'Serves 2 · Non-veg',
      ),
    ],
    reviews: [
      RestaurantReview(
        author: 'Arjun K.',
        rating: 5.0,
        date: '2 days ago',
        comment: 'The authentic flavor of Old City Hyderabad right here in Gachibowli. Tender chicken and long grain rice!',
      ),
      RestaurantReview(
        author: 'Fatima Z.',
        rating: 4.8,
        date: '1 week ago',
        comment: 'Biryani aroma hits you before the packet is opened. Great portion size and delicious salan.',
      ),
    ],
    about:
        'Established with deep roots in the Old City of Hyderabad, Shadab Biryani brings four decades of dum-cooking mastery to food lovers with uncompromising tradition.',
  );

  static const Restaurant chutneys = Restaurant(
    id: 'chutneys',
    name: 'Chutneys',
    shortName: 'Chutneys',
    rating: 4.7,
    reviewsCount: '2.4K',
    deliveryDetails: 'Gachibowli · 20–25 min · ₹25 delivery',
    deliveryFee: 25.0,
    distance: '2.1 km',
    cuisine: 'South Indian',
    priceRange: '₹₹',
    tag: 'Verified kitchen',
    isVerified: true,
    imagePath: 'assets/images/dosa.png',
    locality: 'Gachibowli',
    mapCoordinates: Offset(0.74, 0.46),
    description:
        'Crispy golden dosas, signature 6-chutney platter, and pure South Indian comfort. Hyderabad’s legendary breakfast and tiffin destination.',
    statistics: [
      RestaurantStat(value: '18K+', label: 'happy diners'),
      RestaurantStat(value: '98%', label: 'loved the food'),
      RestaurantStat(value: 'Since 1995', label: 'Tiffin heritage'),
    ],
    cuisineTags: ['South Indian', 'Tiffins', 'Andhra'],
    menuCategories: [
      'Bestsellers',
      'Dosas',
      'Idlis',
      'Tiffins',
      'Desserts',
      'Beverages',
    ],
    bestsellers: [
      MenuItem(
        id: 'ghee_karam_dosa',
        name: 'Ghee Karam Dosa',
        price: 180,
        description: 'Crisp crepe roasted in rich desi ghee with spicy Andhra karam podi, accompanied by six fresh signature chutneys.',
        imagePath: 'assets/images/dosa.png',
        isBestseller: true,
        rating: 4.9,
        category: 'Bestsellers',
        dietary: 'Serves 1 · Veg',
      ),
      MenuItem(
        id: 'babai_idli',
        name: 'Babai Idli with Butter',
        price: 120,
        description: 'Melt-in-mouth steamed idlis topped with pure white makhan and freshly ground podi.',
        imagePath: 'assets/images/dosa.png',
        isBestseller: true,
        rating: 4.8,
        category: 'Bestsellers',
        dietary: 'Serves 1 · Veg',
      ),
    ],
    reviews: [
      RestaurantReview(
        author: 'Srinivas R.',
        rating: 5.0,
        date: '3 days ago',
        comment: 'The tomato and ginger chutneys are unmatched. Ghee karam dosa is always hot and crispy.',
      ),
      RestaurantReview(
        author: 'Priya N.',
        rating: 4.6,
        date: '5 days ago',
        comment: 'Best breakfast place in town. Consistent taste over the years.',
      ),
    ],
    about:
        'Pioneers of the iconic 6-chutney serving style, Chutneys has set the gold standard for vegetarian South Indian dining across Telangana and Andhra Pradesh.',
  );

  static const Restaurant cafeNiloufer = Restaurant(
    id: 'cafe_niloufer',
    name: 'Cafe Niloufer',
    shortName: 'Niloufer',
    rating: 4.9,
    reviewsCount: '3.8K',
    deliveryDetails: 'Old Mumbai Highway · 15–20 min · ₹20 delivery',
    deliveryFee: 20.0,
    distance: '0.8 km',
    cuisine: 'Irani Chai & Bakery',
    priceRange: '₹',
    tag: 'Heritage verified',
    isVerified: true,
    imagePath: 'assets/images/biryani.png',
    locality: 'Old Mumbai Highway',
    mapCoordinates: Offset(0.23, 0.82),
    description:
        'Authentic Irani chai brewed to perfection, buttery Osmania biscuits, and timeless Hyderabad cafe culture since 1978.',
    statistics: [
      RestaurantStat(value: '25K+', label: 'daily sips'),
      RestaurantStat(value: '99%', label: 'tea lovers'),
      RestaurantStat(value: 'Since 1978', label: 'Irani heritage'),
    ],
    cuisineTags: ['Irani Chai', 'Bakery', 'Tea & Snacks'],
    menuCategories: [
      'Bestsellers',
      'Irani Chai',
      'Biscuits',
      'Bun Maska',
      'Snacks',
      'Beverages',
    ],
    bestsellers: [
      MenuItem(
        id: 'niloufer_special_chai',
        name: 'Niloufer Special Irani Chai',
        price: 45,
        description: 'Signature thick cream Irani dum chai brewed with pure cow milk and premium Assam tea dust.',
        imagePath: 'assets/images/biryani.png',
        isBestseller: true,
        rating: 5.0,
        category: 'Bestsellers',
        dietary: 'Serves 1 · Veg',
      ),
      MenuItem(
        id: 'osmania_biscuits_pack',
        name: 'Classic Osmania Biscuits (Box of 20)',
        price: 150,
        description: 'Crisp, sweet, and lightly salted melt-in-mouth heritage biscuits.',
        imagePath: 'assets/images/biryani.png',
        isBestseller: true,
        rating: 4.9,
        category: 'Biscuits',
        dietary: 'Box of 20 · Veg',
      ),
    ],
    reviews: [
      RestaurantReview(
        author: 'Mohd. Imran',
        rating: 5.0,
        date: 'Yesterday',
        comment: 'Nothing beats Niloufer chai on a rainy evening with Osmania biscuits.',
      ),
    ],
    about:
        'Founded by Shri A. Babu Rao in 1978, Niloufer is an institution of Hyderabadi hospitality, serving millions of cups of beloved Irani chai.',
  );

  static const List<Restaurant> allRestaurants = [
    shadabBiryani,
    chutneys,
    cafeNiloufer,
  ];

  static List<Restaurant> getNearbyGems(String currentId) {
    return allRestaurants.where((r) => r.id != currentId).toList();
  }
}
