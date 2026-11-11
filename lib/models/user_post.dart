class UserPost {
  final String id;
  final String title;
  final String restaurant;
  final String location;
  final String date;
  final String category;
  final String? imageUrl;
  final bool isArchived;
  final String? _customRestaurantLocation;
  final String? _customDateAndCategory;

  const UserPost({
    required this.id,
    required this.title,
    this.restaurant = '',
    this.location = '',
    this.date = '',
    this.category = 'Public',
    this.imageUrl,
    this.isArchived = false,
    String? restaurantLocation,
    String? dateAndCategory,
  })  : _customRestaurantLocation = restaurantLocation,
        _customDateAndCategory = dateAndCategory;

  String get restaurantLocation {
    if (_customRestaurantLocation != null && _customRestaurantLocation!.isNotEmpty) {
      return _customRestaurantLocation!;
    }
    if (restaurant.isEmpty) return location;
    if (location.isEmpty) return restaurant;
    return '$restaurant · $location';
  }

  String get dateAndCategory {
    if (_customDateAndCategory != null && _customDateAndCategory!.isNotEmpty) {
      return _customDateAndCategory!;
    }
    if (date.isEmpty) return category;
    if (category.isEmpty) return date;
    return '$date · $category';
  }

  UserPost copyWith({
    String? id,
    String? title,
    String? restaurant,
    String? location,
    String? date,
    String? category,
    String? imageUrl,
    bool? isArchived,
    String? restaurantLocation,
    String? dateAndCategory,
  }) {
    return UserPost(
      id: id ?? this.id,
      title: title ?? this.title,
      restaurant: restaurant ?? this.restaurant,
      location: location ?? this.location,
      date: date ?? this.date,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      isArchived: isArchived ?? this.isArchived,
      restaurantLocation: restaurantLocation ?? _customRestaurantLocation,
      dateAndCategory: dateAndCategory ?? _customDateAndCategory,
    );
  }

  static const samplePublishedPosts = [
    UserPost(
      id: 'post_1',
      title: 'That unmistakable dum aroma.',
      restaurant: 'Shadab Biryani',
      location: 'Gachibowli',
      date: '30 Oct 2026',
      category: 'Public',
      imageUrl: 'assets/images/biryani.png',
      isArchived: false,
    ),
    UserPost(
      id: 'post_2',
      title: 'A Sunday well spent.',
      restaurant: 'Shadab Biryani',
      location: 'Hyderabad',
      date: '25 Oct 2026',
      category: 'Public',
      imageUrl: 'assets/images/mutton_biryani.png',
      isArchived: false,
    ),
  ];

  static const sampleArchivedPosts = [
    UserPost(
      id: 'post_archived_1',
      title: 'A biryani trail',
      restaurant: 'Biryani 21',
      location: 'Hyderabad',
      date: 'Archived 22 Oct 2026',
      category: 'Archived',
      imageUrl: 'assets/images/kebabs.png',
      isArchived: true,
    ),
    UserPost(
      id: 'post_archived_2',
      title: 'Zafrani Mutton Biryani',
      restaurant: 'Shadab Biryani',
      location: 'Old City',
      date: 'Archived 15 Oct 2026',
      category: 'Archived',
      imageUrl: 'assets/images/biryani.png',
      isArchived: true,
    ),
    UserPost(
      id: 'post_archived_3',
      title: 'Old City Kebabs',
      restaurant: 'Bawarchi',
      location: 'Nampally',
      date: 'Archived 10 Oct 2026',
      category: 'Archived',
      imageUrl: 'assets/images/kebabs.png',
      isArchived: true,
    ),
  ];
}

