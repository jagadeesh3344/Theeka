class UserProfile {
  final String name;
  final String handle;
  final String bio;
  final int postsCount;
  final String followersCount;
  final int followingCount;
  final int coinBalance;
  final String coinsSubtitle;
  final String? avatarImagePath;
  final String phone;
  final String dateOfBirth;
  final String email;
  final String gender;
  final int archivedPostsCount;

  const UserProfile({
    this.name = 'hero M.',
    this.handle = '@herom',
    this.bio = 'Hyderabad on a plate. Biryani, chai & honest stories.',
    this.postsCount = 48,
    this.followersCount = '2.4K',
    this.followingCount = 312,
    this.coinBalance = 1200,
    this.coinsSubtitle = 'Your good taste, appreciated',
    this.avatarImagePath = 'assets/images/user_avatar.png',
    this.phone = '+91 00000 00000',
    this.dateOfBirth = '18 Aug 1998',
    this.email = 'hero@example.com',
    this.gender = 'Prefer not to say',
    this.archivedPostsCount = 3,
  });

  String get formattedCoins {
    final balanceStr = coinBalance.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return '$balanceStr THEKAA Coins';
  }

  UserProfile copyWith({
    String? name,
    String? handle,
    String? bio,
    int? postsCount,
    String? followersCount,
    int? followingCount,
    int? coinBalance,
    String? coinsSubtitle,
    String? avatarImagePath,
    String? phone,
    String? dateOfBirth,
    String? email,
    String? gender,
    int? archivedPostsCount,
  }) {
    return UserProfile(
      name: name ?? this.name,
      handle: handle ?? this.handle,
      bio: bio ?? this.bio,
      postsCount: postsCount ?? this.postsCount,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      coinBalance: coinBalance ?? this.coinBalance,
      coinsSubtitle: coinsSubtitle ?? this.coinsSubtitle,
      avatarImagePath: avatarImagePath ?? this.avatarImagePath,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      archivedPostsCount: archivedPostsCount ?? this.archivedPostsCount,
    );
  }

  static const defaultProfile = UserProfile();
}
