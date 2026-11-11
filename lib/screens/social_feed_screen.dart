import 'package:flutter/material.dart';
import '../models/social_models.dart';
import '../models/user_profile.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/post_comments_sheet.dart';
import '../widgets/story_viewer_dialog.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import '../widgets/thekaa_image.dart';
import 'food_story_detail_screen.dart';
import 'my_food_journal_screen.dart';
import 'tell_food_story_screen.dart';

class SocialFeedScreen extends StatefulWidget {
  final List<SocialStory> stories;
  final List<SocialPost> posts;
  final bool showBottomNav;
  final VoidCallback? onNotificationTap;
  final ValueChanged<SocialStory>? onStoryTap;
  final VoidCallback? onCreateReview;
  final ValueChanged<SocialPost>? onPostTap;
  final ValueChanged<SocialPost>? onAuthorTap;
  final ValueChanged<SocialPost>? onLikePost;
  final ValueChanged<SocialPost>? onCommentPost;
  final ValueChanged<SocialPost>? onSharePost;
  final ValueChanged<SocialPost>? onBookmarkPost;
  final ValueChanged<int>? onNavTap;
  final VoidCallback? onBack;

  const SocialFeedScreen({
    super.key,
    this.stories = SocialStory.sampleStories,
    this.posts = const [SocialPost.defaultPost],
    this.showBottomNav = true,
    this.onNotificationTap,
    this.onStoryTap,
    this.onCreateReview,
    this.onPostTap,
    this.onAuthorTap,
    this.onLikePost,
    this.onCommentPost,
    this.onSharePost,
    this.onBookmarkPost,
    this.onNavTap,
    this.onBack,
  });

  @override
  State<SocialFeedScreen> createState() => _SocialFeedScreenState();
}

class _SocialFeedScreenState extends State<SocialFeedScreen> {
  int _selectedTabIndex = 0; // 0: For You, 1: Following, 2: Nearby, 3: Trending
  final List<String> _tabs = ['For You', 'Following', 'Nearby', 'Trending'];
  late List<SocialPost> _posts;

  @override
  void initState() {
    super.initState();
    _posts = List.from(widget.posts);
  }

  void _handleLike(SocialPost post) {
    setState(() {
      _posts = _posts.map((p) {
        if (p.id == post.id) {
          final isLiked = !p.isLiked;
          return p.copyWith(
            isLiked: isLiked,
            likesCount: isLiked ? p.likesCount + 1 : p.likesCount - 1,
          );
        }
        return p;
      }).toList();
    });
    widget.onLikePost?.call(post);
  }

  void _handleBookmark(SocialPost post) {
    setState(() {
      _posts = _posts.map((p) {
        if (p.id == post.id) {
          return p.copyWith(isSaved: !p.isSaved);
        }
        return p;
      }).toList();
    });
    widget.onBookmarkPost?.call(post);
  }

  void _openAuthorJournal(SocialPost post) {
    if (widget.onAuthorTap != null) {
      widget.onAuthorTap!(post);
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => MyFoodJournalScreen(
            profile: UserProfile(
              name: post.authorName,
              handle: post.authorHandle,
              bio: 'Hyderabad on a plate. Biryani, chai & honest stories.',
              avatarImagePath: post.authorAvatar,
            ),
            onBack: () => Navigator.of(context).maybePop(),
          ),
        ),
      );
    }
  }

  void _openStory(SocialStory story) {
    if (widget.onStoryTap != null) {
      widget.onStoryTap!(story);
    } else {
      StoryViewerDialog.show(context, story);
    }
  }

  void _openComments(SocialPost post) {
    PostCommentsSheet.show(
      context: context,
      post: post,
      onCommentAdded: (newComment) {
        setState(() {
          _posts = _posts.map((p) {
            if (p.id == post.id) {
              final updatedComments = List<SocialComment>.from(p.comments)..add(newComment);
              return p.copyWith(
                comments: updatedComments,
                commentsCount: updatedComments.length,
              );
            }
            return p;
          }).toList();
        });
        widget.onCommentPost?.call(post);
      },
    );
  }

  void _openCreateReview() {
    if (widget.onCreateReview != null) {
      widget.onCreateReview!();
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => TellFoodStoryScreen(
            onBack: () => Navigator.of(context).maybePop(),
            onPublishReview: (newPost) {
              setState(() {
                _posts.insert(0, newPost);
              });
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => FoodStoryDetailScreen(
                    post: newPost,
                    isPreparation: true,
                    onBack: () => Navigator.of(context).maybePop(),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }

  void _openPostDetail(SocialPost post) {
    if (widget.onPostTap != null) {
      widget.onPostTap!(post);
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => FoodStoryDetailScreen(
            post: post,
            onBack: () => Navigator.of(context).maybePop(),
          ),
        ),
      );
    }
  }

  Widget _buildStoryItem(SocialStory story) {
    return GestureDetector(
      onTap: () => _openStory(story),
      child: Padding(
        padding: const EdgeInsets.only(right: 18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 58,
              height: 58,
              padding: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFD8C8B6),
                  width: 1.5,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  story.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFFF3ECE0),
                    child: const Icon(
                      Icons.person,
                      size: 30,
                      color: ThekaaColors.terracotta,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              story.label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
                color: ThekaaColors.primaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostCard(SocialPost post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEADBCE),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header: User avatar, Name, Restaurant, Timestamp, Options
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => _openAuthorJournal(post),
                  child: CircleAvatar(
                    radius: 19,
                    backgroundColor: const Color(0xFFF3ECE0),
                    backgroundImage: AssetImage(post.authorAvatar),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _openAuthorJournal(post),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.authorName,
                          style: ThekaaTypography.sectionHeading.copyWith(
                            fontFamily: 'Inter',
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: ThekaaColors.primaryText,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          post.restaurantWithLocality,
                          style: ThekaaTypography.deliveryInfo.copyWith(
                            fontSize: 11.5,
                            color: ThekaaColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  post.timestamp,
                  style: ThekaaTypography.deliveryInfo.copyWith(
                    fontSize: 11.5,
                    color: ThekaaColors.secondaryText,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.more_horiz,
                  size: 18,
                  color: ThekaaColors.secondaryText,
                ),
              ],
            ),
          ),

          // Food Image with 1/3 Carousel Count badge
          GestureDetector(
            onTap: () => _openPostDetail(post),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: 1.35,
                      child: thekaaImage(
                        post.imageUrls.isNotEmpty
                            ? post.imageUrls.first
                            : 'assets/images/biryani.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        post.imageCountText,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Actions row: Like, Comment, Send, Bookmark
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () => _handleLike(post),
                  child: Row(
                    children: [
                      Icon(
                        post.isLiked ? Icons.favorite : Icons.favorite_border,
                        size: 20,
                        color: post.isLiked
                            ? ThekaaColors.terracotta
                            : const Color(0xFF6B4E38),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${post.likesCount}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6B4E38),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                InkWell(
                  onTap: () => _openComments(post),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chat_bubble_outline_rounded,
                        size: 19,
                        color: Color(0xFF6B4E38),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${post.commentsCount}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6B4E38),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                InkWell(
                  onTap: () => widget.onSharePost?.call(post),
                  child: const Icon(
                    Icons.near_me_outlined,
                    size: 20,
                    color: Color(0xFF6B4E38),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => _handleBookmark(post),
                  child: Icon(
                    post.isSaved ? Icons.bookmark : Icons.bookmark_border,
                    size: 21,
                    color: const Color(0xFF6B4E38),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Verified purchase & Rating
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              children: [
                if (post.isVerifiedPurchase) ...[
                  const Icon(
                    Icons.verified_user_outlined,
                    size: 14,
                    color: Color(0xFF386641),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Verified purchase',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF386641),
                    ),
                  ),
                ],
                const Spacer(),
                const Icon(
                  Icons.star_outline_rounded,
                  size: 15,
                  color: Color(0xFF6B4E38),
                ),
                const SizedBox(width: 3),
                Text(
                  post.rating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ThekaaColors.primaryText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),

          // Post Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Text(
              post.title,
              style: ThekaaTypography.sectionHeading.copyWith(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: ThekaaColors.primaryText,
              ),
            ),
          ),
          const SizedBox(height: 3),

          // Post Description snippet
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Text(
              '${post.description.split('.').first}.',
              style: ThekaaTypography.deliveryInfo.copyWith(
                fontSize: 12,
                color: const Color(0xFF6B4E38),
              ),
            ),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      bottomNavigationBar: widget.showBottomNav
          ? ThekaaBottomNavBar(
              currentIndex: 2, // DABBA active
              onTap: widget.onNavTap ?? (_) {},
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // Top Header: Title & Bell Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'THEKAA SOCIALS',
                          style: ThekaaTypography.sectionHeading.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            color: ThekaaColors.primaryText,
                          ),
                        ),
                        InkWell(
                          onTap: widget.onNotificationTap,
                          borderRadius: BorderRadius.circular(20),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.notifications_none_outlined,
                              size: 22,
                              color: ThekaaColors.primaryText,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),

                    // Subtitle
                    Text(
                      'Hyderabad eats. Hyderabad tells.',
                      style: ThekaaTypography.deliveryInfo.copyWith(
                        fontSize: 12,
                        color: ThekaaColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // 4 Social Tabs Pill
                    Container(
                      height: 40,
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECE4D8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: List.generate(_tabs.length, (index) {
                          final isSelected = _selectedTabIndex == index;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedTabIndex = index;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFFFFFDF8)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(13),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.05),
                                            blurRadius: 4,
                                            offset: const Offset(0, 1),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Text(
                                  _tabs[index],
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? const Color(0xFF6B4E38)
                                        : ThekaaColors.secondaryText,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Story / Journal Circles Row
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: widget.stories.map(_buildStoryItem).toList(),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Social Post Card(s)
                    ..._posts.map(_buildPostCard),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            // Fixed Bottom Action Button: Create a food review
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _openCreateReview,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThekaaColors.terracotta,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Create a food review',
                        style: ThekaaTypography.sectionHeading.copyWith(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.edit_outlined,
                        size: 18,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
