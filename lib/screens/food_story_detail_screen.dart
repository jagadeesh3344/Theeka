import 'package:flutter/material.dart';
import '../models/social_models.dart';
import '../models/user_profile.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import '../widgets/thekaa_image.dart';
import 'my_food_journal_screen.dart';
import 'story_published_screen.dart';

class FoodStoryDetailScreen extends StatefulWidget {
  final SocialPost post;
  final bool isPreview;
  final bool isPreparation;
  final VoidCallback? onBack;
  final VoidCallback? onOptionsTap;
  final ValueChanged<SocialPost>? onLike;
  final ValueChanged<SocialPost>? onComment;
  final ValueChanged<SocialPost>? onShare;
  final ValueChanged<SocialPost>? onBookmark;
  final ValueChanged<SocialPost>? onAuthorTap;
  final ValueChanged<SocialPost>? onPublish;
  final ValueChanged<int>? onNavTap;

  const FoodStoryDetailScreen({
    super.key,
    this.post = SocialPost.defaultPost,
    this.isPreview = false,
    this.isPreparation = false,
    this.onBack,
    this.onOptionsTap,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onBookmark,
    this.onAuthorTap,
    this.onPublish,
    this.onNavTap,
  });

  @override
  State<FoodStoryDetailScreen> createState() => _FoodStoryDetailScreenState();
}

class _FoodStoryDetailScreenState extends State<FoodStoryDetailScreen> {
  late SocialPost _post;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _post = widget.post;
  }

  void _handleLike() {
    setState(() {
      final isLiked = !_post.isLiked;
      _post = _post.copyWith(
        isLiked: isLiked,
        likesCount: isLiked ? _post.likesCount + 1 : _post.likesCount - 1,
      );
    });
    widget.onLike?.call(_post);
  }

  void _handleBookmark() {
    setState(() {
      _post = _post.copyWith(isSaved: !_post.isSaved);
    });
    widget.onBookmark?.call(_post);
  }

  void _openAuthorJournal() {
    if (widget.onAuthorTap != null) {
      widget.onAuthorTap!(_post);
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => MyFoodJournalScreen(
            profile: UserProfile(
              name: _post.authorName,
              handle: _post.authorHandle,
              bio: 'Hyderabad on a plate. Biryani, chai & honest stories.',
              avatarImagePath: _post.authorAvatar,
            ),
            onBack: () => Navigator.of(context).maybePop(),
          ),
        ),
      );
    }
  }

  void _handlePublish() {
    if (widget.onPublish != null) {
      widget.onPublish!(_post);
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => StoryPublishedScreen(
            post: _post,
            onBackToSocials: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      bottomNavigationBar: ThekaaBottomNavBar(
        currentIndex: 2, // DABBA active
        onTap: widget.onNavTap ?? (_) {},
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // Header: Back arrow, Title, and top-right options
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: widget.onBack ?? () => Navigator.of(context).maybePop(),
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: ThekaaColors.terracotta,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'A plate, a story',
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: widget.onOptionsTap,
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.more_horiz,
                        size: 20,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                  ),
                ],
              ),
              if (widget.isPreview) ...[
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5EBD7),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFEADBCE)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.visibility_outlined, size: 16, color: Color(0xFF8D5B34)),
                      SizedBox(width: 8),
                      Text(
                        'Preview mode · This is how your story will look',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4A2E18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 14),

              // Post Header: Profile, Name, Restaurant, Timestamp
              Row(
                children: [
                  GestureDetector(
                    onTap: _openAuthorJournal,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: const Color(0xFFF3ECE0),
                      backgroundImage: thekaaImageProvider(_post.authorAvatar),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: _openAuthorJournal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _post.authorName,
                            style: ThekaaTypography.sectionHeading.copyWith(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: ThekaaColors.primaryText,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            _post.restaurantWithLocality,
                            style: ThekaaTypography.deliveryInfo.copyWith(
                              fontSize: 12,
                              color: ThekaaColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    _post.timestamp,
                    style: ThekaaTypography.deliveryInfo.copyWith(
                      fontSize: 12,
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
              const SizedBox(height: 12),

              // Large Food Image with 1/3 badge
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AspectRatio(
                      aspectRatio: 1.35,
                      child: _post.imageUrls.isEmpty
                          ? thekaaImage('assets/images/biryani_hd.jpg', fit: BoxFit.cover)
                          : PageView.builder(
                              itemCount: _post.imageUrls.length,
                              onPageChanged: (idx) {
                                setState(() {
                                  _currentImageIndex = idx;
                                });
                              },
                              itemBuilder: (context, idx) {
                                return thekaaImage(
                                  _post.imageUrls[idx],
                                  fit: BoxFit.cover,
                                );
                              },
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
                        '${_currentImageIndex + 1}/${_post.imageUrls.isEmpty ? 1 : _post.imageUrls.length}',
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
              const SizedBox(height: 6),

              // Carousel indicator dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _post.imageUrls.length <= 1 ? 2 : _post.imageUrls.length,
                  (index) => Container(
                    width: index == _currentImageIndex ? 6 : 5,
                    height: index == _currentImageIndex ? 6 : 5,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == _currentImageIndex
                          ? ThekaaColors.terracotta
                          : const Color(0xFFD8C8B6),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Actions Row: Like, Comment, Send, Bookmark
              Row(
                children: [
                  InkWell(
                    onTap: _handleLike,
                    child: Row(
                      children: [
                        Icon(
                          _post.isLiked ? Icons.favorite : Icons.favorite_border,
                          size: 20,
                          color: _post.isLiked
                              ? ThekaaColors.terracotta
                              : const Color(0xFF6B4E38),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${_post.likesCount}',
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
                    onTap: () => widget.onComment?.call(_post),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.chat_bubble_outline_rounded,
                          size: 19,
                          color: Color(0xFF6B4E38),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${_post.commentsCount}',
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
                    onTap: () => widget.onShare?.call(_post),
                    child: const Icon(
                      Icons.near_me_outlined,
                      size: 20,
                      color: Color(0xFF6B4E38),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: _handleBookmark,
                    child: Icon(
                      _post.isSaved ? Icons.bookmark : Icons.bookmark_border,
                      size: 21,
                      color: const Color(0xFF6B4E38),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Verified purchase & Rating
              Row(
                children: [
                  if (_post.isVerifiedPurchase) ...[
                    const Icon(
                      Icons.verified_user_outlined,
                      size: 15,
                      color: Color(0xFF386641),
                    ),
                    const SizedBox(width: 5),
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
                    '${_post.rating.toStringAsFixed(1)} ${_post.dishName}',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: ThekaaColors.primaryText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Title
              Text(
                _post.title,
                style: ThekaaTypography.sectionHeading.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ThekaaColors.primaryText,
                ),
              ),
              const SizedBox(height: 6),

              // Description
              Text(
                _post.description,
                style: ThekaaTypography.deliveryInfo.copyWith(
                  fontSize: 12.5,
                  height: 1.45,
                  color: ThekaaColors.primaryText,
                ),
              ),
              const SizedBox(height: 8),

              // Restaurant Location
              Text(
                _post.fullRestaurantAddress,
                style: ThekaaTypography.captionText.copyWith(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: ThekaaColors.terracotta,
                ),
              ),
              const SizedBox(height: 14),

              // Coin Reward Card (+25 TKC earned · Validated)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFE9F2E6),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFD1E2CB),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          size: 17,
                          color: Color(0xFF2D5A27),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '+${_post.rewardCoins} TKC earned · Validated',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2D5A27),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Review ${_post.reviewId} · Eligibility checked ${_post.rewardDate}.',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11,
                              color: Color(0xFF556B4E),
                            ),
                          ),
                          const SizedBox(height: 1),
                          const Text(
                            'Credited once.',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF556B4E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Comments Section Header
              Text(
                'The table talk · ${_post.commentsCount} comments',
                style: ThekaaTypography.sectionHeading.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: ThekaaColors.primaryText,
                ),
              ),
              if (widget.isPreparation || widget.onPublish != null) ...[
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThekaaColors.terracotta,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: _handlePublish,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Publish food story',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded, size: 16, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

