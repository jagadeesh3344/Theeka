class UserPost {
  final String id;
  final String title;
  final String restaurant;
  final String location;
  final String date;
  final String category;
  final String? imageUrl;
  final bool isArchived;

  const UserPost({
    required this.id,
    required this.title,
    required this.restaurant,
    required this.location,
    required this.date,
    this.category = 'Public',
    this.imageUrl,
    this.isArchived = false,
  });

  String get restaurantLocation => '$restaurant · $location';
  String get dateAndCategory => '$date · $category';

  UserPost copyWith({
    String? id,
    String? title,
    String? restaurant,
    String? location,
    String? date,
    String? category,
    String? imageUrl,
    bool? isArchived,
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
  ];
}
