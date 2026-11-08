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
    );
  }

  static const defaultProfile = UserProfile();
}

