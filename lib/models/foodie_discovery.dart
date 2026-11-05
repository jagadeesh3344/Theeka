import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

/// Individual achievement milestone model
class FoodieAchievement {
  final String id;
  final String title;
  final String description;
  final int currentCount;
  final int targetCount;
  final bool isEarned;
  final String? earnedDate;
  final String progressSubtitle;
  final Color accentColor;

  const FoodieAchievement({
    required this.id,
    required this.title,
    required this.description,
    required this.currentCount,
    required this.targetCount,
    this.isEarned = false,
    this.earnedDate,
    required this.progressSubtitle,
    required this.accentColor,
  });

  /// Clamped progress ratio between 0.0 and 1.0
  double get progressRatio {
    if (isEarned || targetCount <= 0) return 1.0;
    final ratio = currentCount / targetCount;
    return ratio.clamp(0.0, 1.0);
  }

  /// Remaining count to target
  int get remainingCount {
    final remaining = targetCount - currentCount;
    return remaining < 0 ? 0 : remaining;
  }
}

/// Domain model representing the customer's food discovery profile & achievements
class UserDiscoveryProfile {
  final FoodieAchievement thekaaFoodie;
  final FoodieAchievement topReviewer;
  final FoodieAchievement foodExplorer;
  final String badgeHeading;
  final String badgeDescription;
  final String badgeRecognitionNotice;
  final String validationNoticeTitle;
  final String validationNoticeBody;

  const UserDiscoveryProfile({
    required this.thekaaFoodie,
    required this.topReviewer,
    required this.foodExplorer,
    this.badgeHeading = 'Your Foodie badge',
    this.badgeDescription =
        'A mark of ten genuine food stories, each published and checked. This badge lives on your food journal.',
    this.badgeRecognitionNotice =
        'Recognition only · No automatic coin credit',
    this.validationNoticeTitle = 'Made for genuine discovery',
    this.validationNoticeBody =
        'Eligible reviews and original photos count toward milestones. Duplicate content and engagement do not.',
  });

  /// Default profile matching the reference screenshot values accurately
  factory UserDiscoveryProfile.defaultProfile() {
    return const UserDiscoveryProfile(
      thekaaFoodie: FoodieAchievement(
        id: 'thekaa_foodie',
        title: 'THEKAA Foodie',
        description: '10 validated food stories',
        currentCount: 10,
        targetCount: 10,
        isEarned: true,
        earnedDate: '28 Oct 2026',
        progressSubtitle: 'Earned · 28 Oct 2026',
        accentColor: Color(0xFF3F5E4D),
      ),
      topReviewer: FoodieAchievement(
        id: 'top_reviewer',
        title: 'Top Reviewer',
        description: '12 of 20 helpful, validated reviews',
        currentCount: 12,
        targetCount: 20,
        isEarned: false,
        progressSubtitle: '8 more eligible reviews to go',
        accentColor: ThekaaColors.terracotta,
      ),
      foodExplorer: FoodieAchievement(
        id: 'food_explorer',
        title: 'Food Explorer',
        description: '7 of 10 different kitchens explored',
        currentCount: 7,
        targetCount: 10,
        isEarned: false,
        progressSubtitle: 'Discover 3 more verified kitchens',
        accentColor: ThekaaColors.terracotta,
      ),
    );
  }

  /// Factory for dynamic custom profiles (e.g. testing different counts)
  factory UserDiscoveryProfile.forUser({
    int validatedStories = 10,
    int totalStoriesTarget = 10,
    String? earnedDate = '28 Oct 2026',
    int helpfulReviews = 12,
    int reviewTarget = 20,
    int kitchensExplored = 7,
    int kitchensTarget = 10,
  }) {
    final foodieEarned = validatedStories >= totalStoriesTarget;
    final topReviewerEarned = helpfulReviews >= reviewTarget;
    final explorerEarned = kitchensExplored >= kitchensTarget;

    final reviewRemaining = (reviewTarget - helpfulReviews).clamp(0, 9999);
    final kitchenRemaining = (kitchensTarget - kitchensExplored).clamp(0, 9999);

    return UserDiscoveryProfile(
      thekaaFoodie: FoodieAchievement(
        id: 'thekaa_foodie',
        title: 'THEKAA Foodie',
        description: '$validatedStories validated food stories',
        currentCount: validatedStories,
        targetCount: totalStoriesTarget,
        isEarned: foodieEarned,
        earnedDate: earnedDate,
        progressSubtitle: foodieEarned
            ? 'Earned · ${earnedDate ?? 'Recently'}'
            : '$validatedStories of $totalStoriesTarget completed',
        accentColor: foodieEarned ? const Color(0xFF3F5E4D) : ThekaaColors.terracotta,
      ),
      topReviewer: FoodieAchievement(
        id: 'top_reviewer',
        title: 'Top Reviewer',
        description: '$helpfulReviews of $reviewTarget helpful, validated reviews',
        currentCount: helpfulReviews,
        targetCount: reviewTarget,
        isEarned: topReviewerEarned,
        progressSubtitle: topReviewerEarned
            ? 'Earned'
            : '$reviewRemaining more eligible reviews to go',
        accentColor: topReviewerEarned ? const Color(0xFF3F5E4D) : ThekaaColors.terracotta,
      ),
      foodExplorer: FoodieAchievement(
        id: 'food_explorer',
        title: 'Food Explorer',
        description: '$kitchensExplored of $kitchensTarget different kitchens explored',
        currentCount: kitchensExplored,
        targetCount: kitchensTarget,
        isEarned: explorerEarned,
        progressSubtitle: explorerEarned
            ? 'Earned'
            : 'Discover $kitchenRemaining more verified kitchens',
        accentColor: explorerEarned ? const Color(0xFF3F5E4D) : ThekaaColors.terracotta,
      ),
    );
  }
}

