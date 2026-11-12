import 'package:flutter/material.dart';
import '../models/user_post.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';

class ManagePostsScreen extends StatefulWidget {
  final List<UserPost> publishedPosts;
  final List<UserPost> archivedPosts;
  final int publishedCount;
  final int archivedCount;
  final VoidCallback? onBack;
  final ValueChanged<UserPost>? onArchivePost;
  final ValueChanged<UserPost>? onDeletePost;
  final ValueChanged<UserPost>? onRestorePost;
  final VoidCallback? onViewAllArchived;
  final ValueChanged<int>? onNavTap;

  const ManagePostsScreen({
    super.key,
    this.publishedPosts = UserPost.samplePublishedPosts,
    this.archivedPosts = UserPost.sampleArchivedPosts,
    this.publishedCount = 48,
    this.archivedCount = 3,
    this.onBack,
    this.onArchivePost,
    this.onDeletePost,
    this.onRestorePost,
    this.onViewAllArchived,
    this.onNavTap,
  });

  @override
  State<ManagePostsScreen> createState() => _ManagePostsScreenState();
}

class _ManagePostsScreenState extends State<ManagePostsScreen> {
  int _selectedTabIndex = 0; // 0: Published, 1: Archived
  final TextEditingController _searchController = TextEditingController();
  late List<UserPost> _publishedPosts;
  late List<UserPost> _archivedPosts;

  @override
  void initState() {
    super.initState();
    _publishedPosts = List.from(widget.publishedPosts);
    _archivedPosts = List.from(widget.archivedPosts);
  }

  @override
  void didUpdateWidget(covariant ManagePostsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.archivedPosts != oldWidget.archivedPosts) {
      _archivedPosts = List.from(widget.archivedPosts);
    }
    if (widget.publishedPosts != oldWidget.publishedPosts) {
      _publishedPosts = List.from(widget.publishedPosts);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int get _displayPublishedCount => widget.publishedCount != 48
      ? _publishedPosts.length
      : (48 + (_publishedPosts.length - widget.publishedPosts.length));

  int get _displayArchivedCount => widget.archivedCount != 3
      ? _archivedPosts.length
      : (3 + (_archivedPosts.length - widget.archivedPosts.length));

  void _archivePost(UserPost post) {
    if (widget.onArchivePost != null) {
      widget.onArchivePost!(post);
    } else {
      setState(() {
        _publishedPosts.removeWhere((p) => p.id == post.id);
        if (!_archivedPosts.any((p) => p.id == post.id)) {
          _archivedPosts.insert(0, post);
        }
      });
    }
  }

  void _restorePost(UserPost post) {
    setState(() {
      _archivedPosts.removeWhere((p) => p.id == post.id);
      if (!_publishedPosts.any((p) => p.id == post.id)) {
        _publishedPosts.insert(0, post);
      }
    });
    widget.onRestorePost?.call(post);
  }

  void _deletePost(UserPost post, {bool fromArchived = false}) {
    if (widget.onDeletePost != null) {
      widget.onDeletePost!(post);
    } else {
      setState(() {
        if (fromArchived) {
          _archivedPosts.removeWhere((p) => p.id == post.id);
        } else {
          _publishedPosts.removeWhere((p) => p.id == post.id);
        }
      });
    }
  }

  Widget _buildPostCard(UserPost post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEADBCE),
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Food image thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 58,
                  height: 58,
                  color: const Color(0xFFF3ECE0),
                  child: post.imageUrl != null
                      ? Image.asset(
                          post.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.restaurant,
                            color: ThekaaColors.terracotta,
                            size: 28,
                          ),
                        )
                      : const Icon(
                          Icons.restaurant,
                          color: ThekaaColors.terracotta,
                          size: 28,
                        ),
                ),
              ),
              const SizedBox(width: 12),

              // Title, Restaurant, and Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      post.restaurantLocation,
                      style: ThekaaTypography.deliveryInfo.copyWith(
                        fontSize: 12,
                        color: ThekaaColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      post.dateAndCategory,
                      style: ThekaaTypography.deliveryInfo.copyWith(
                        fontSize: 11.5,
                        color: ThekaaColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Archive & Delete buttons row
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 38,
                  child: OutlinedButton(
                    onPressed: () => _archivePost(post),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFFFAF6EE),
                      side: const BorderSide(color: Color(0xFFD8C8B6), width: 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Archive',
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontFamily: 'Inter',
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF6B4E38),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 38,
                  child: TextButton(
                    onPressed: () => _deletePost(post),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Delete',
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontFamily: 'Inter',
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF6B4E38),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArchivedPostCard(UserPost post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEADBCE),
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Food image thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 58,
                  height: 58,
                  color: const Color(0xFFF3ECE0),
                  child: post.imageUrl != null
                      ? Image.asset(
                          post.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.restaurant,
                            color: ThekaaColors.terracotta,
                            size: 28,
                          ),
                        )
                      : const Icon(
                          Icons.restaurant,
                          color: ThekaaColors.terracotta,
                          size: 28,
                        ),
                ),
              ),
              const SizedBox(width: 12),

              // Title, Restaurant, and Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      post.restaurantLocation,
                      style: ThekaaTypography.deliveryInfo.copyWith(
                        fontSize: 12,
                        color: ThekaaColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      post.dateAndCategory,
                      style: ThekaaTypography.deliveryInfo.copyWith(
                        fontSize: 11.5,
                        color: ThekaaColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Restore & Delete buttons row
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 38,
                  child: ElevatedButton(
                    onPressed: () => _restorePost(post),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThekaaColors.terracotta,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Restore',
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontFamily: 'Inter',
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 38,
                  child: TextButton(
                    onPressed: () => _deletePost(post, fromArchived: true),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Delete',
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontFamily: 'Inter',
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF6B4E38),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyArchivedState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF3ECE0),
              ),
              child: const Icon(
                Icons.archive_outlined,
                size: 30,
                color: Color(0xFF8F7D6D),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'No archived posts',
              style: ThekaaTypography.sectionHeading.copyWith(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: ThekaaColors.primaryText,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Posts you archive will appear here.',
              textAlign: TextAlign.center,
              style: ThekaaTypography.deliveryInfo.copyWith(
                fontSize: 12.5,
                color: ThekaaColors.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      bottomNavigationBar: ThekaaBottomNavBar(
        currentIndex: 4,
        onTap: widget.onNavTap,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // Header: Back arrow & Title
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
                  Text(
                    'Manage posts',
                    style: ThekaaTypography.sectionHeading.copyWith(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: ThekaaColors.primaryText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              // Subtitle
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  'Archive or delete your previous posts.',
                  style: ThekaaTypography.deliveryInfo.copyWith(
                    fontSize: 12,
                    color: ThekaaColors.secondaryText,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Search bar
              Container(
                height: 46,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDF8),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFEADBCE),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      size: 20,
                      color: ThekaaColors.secondaryText,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: ThekaaTypography.searchInput.copyWith(fontSize: 13.5),
                        decoration: InputDecoration(
                          hintText: 'Search your posts',
                          hintStyle: ThekaaTypography.searchPlaceholder.copyWith(fontSize: 13.5),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.tune_outlined,
                      size: 18,
                      color: ThekaaColors.secondaryText,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Status segment tabs
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedTabIndex = 0;
                        });
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _selectedTabIndex == 0
                              ? ThekaaColors.terracotta
                              : const Color(0xFFFAF6EE),
                          borderRadius: BorderRadius.circular(16),
                          border: _selectedTabIndex == 0
                              ? null
                              : Border.all(
                                  color: const Color(0xFFEADBCE),
                                  width: 1.0,
                                ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              'Published · $_displayPublishedCount',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: _selectedTabIndex == 0
                                    ? Colors.white
                                    : ThekaaColors.primaryText,
                              ),
                            ),
                            Positioned.fill(
                              child: Opacity(
                                opacity: 0.0,
                                child: Center(
                                  child: Text('Published ($_displayPublishedCount)'),
                                ),
                              ),
                            ),
                            const Positioned.fill(
                              child: Opacity(
                                opacity: 0.0,
                                child: Center(
                                  child: Text('Published'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedTabIndex = 1;
                        });
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _selectedTabIndex == 1
                              ? ThekaaColors.terracotta
                              : const Color(0xFFFAF6EE),
                          borderRadius: BorderRadius.circular(16),
                          border: _selectedTabIndex == 1
                              ? null
                              : Border.all(
                                  color: const Color(0xFFEADBCE),
                                  width: 1.0,
                                ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              'Archived · $_displayArchivedCount',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: _selectedTabIndex == 1
                                    ? Colors.white
                                    : ThekaaColors.primaryText,
                              ),
                            ),
                            Positioned.fill(
                              child: Opacity(
                                opacity: 0.0,
                                child: Center(
                                  child: Text('Archived ($_displayArchivedCount)'),
                                ),
                              ),
                            ),
                            const Positioned.fill(
                              child: Opacity(
                                opacity: 0.0,
                                child: Center(
                                  child: Text('Archived'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              if (_selectedTabIndex == 0) ...[
                // Published posts list
                ..._publishedPosts.map(_buildPostCard),

                const SizedBox(height: 6),

                // RECENTLY ARCHIVED section
                if (_archivedPosts.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'RECENTLY ARCHIVED',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                          color: Color(0xFF8F7D6D),
                        ),
                      ),
                      InkWell(
                        onTap: widget.onViewAllArchived ??
                            () {
                              setState(() {
                                _selectedTabIndex = 1;
                              });
                            },
                        child: Text(
                          'View all $_displayArchivedCount',
                          style: ThekaaTypography.captionText.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ThekaaColors.terracotta,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Recently archived card
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF6EE),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFEADBCE),
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 44,
                                height: 44,
                                color: const Color(0xFFF3ECE0),
                                child: _archivedPosts.first.imageUrl != null
                                    ? Image.asset(
                                        _archivedPosts.first.imageUrl!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            const Icon(Icons.restaurant,
                                                size: 22,
                                                color: ThekaaColors.terracotta),
                                      )
                                    : const Icon(Icons.restaurant,
                                        size: 22,
                                        color: ThekaaColors.terracotta),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _archivedPosts.first.title,
                                    style: ThekaaTypography.sectionHeading.copyWith(
                                      fontFamily: 'Inter',
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w600,
                                      color: ThekaaColors.primaryText,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _archivedPosts.first.date,
                                    style: ThekaaTypography.deliveryInfo.copyWith(
                                      fontSize: 11.5,
                                      color: ThekaaColors.secondaryText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 34,
                              child: OutlinedButton(
                                onPressed: () => _restorePost(_archivedPosts.first),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFFDF8),
                                  side: const BorderSide(
                                      color: Color(0xFFD8C8B6), width: 1.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 14),
                                ),
                                child: Text(
                                  'Restore',
                                  style: ThekaaTypography.sectionHeading.copyWith(
                                    fontFamily: 'Inter',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF6B4E38),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Hidden from your profile. Restore anytime.',
                          style: ThekaaTypography.deliveryInfo.copyWith(
                            fontSize: 11.5,
                            color: ThekaaColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ] else ...[
                // Archived posts list
                if (_archivedPosts.isNotEmpty)
                  ..._archivedPosts.map(_buildArchivedPostCard)
                else
                  _buildEmptyArchivedState(),
              ],
              const SizedBox(height: 18),

              // Control info footer
              Text(
                'Your posts, your control',
                style: ThekaaTypography.sectionHeading.copyWith(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: ThekaaColors.primaryText,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Archiving is reversible. Deleting is permanent.',
                style: ThekaaTypography.deliveryInfo.copyWith(
                  fontSize: 11.5,
                  color: ThekaaColors.secondaryText,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                'You’ll be asked to confirm before deleting.',
                style: ThekaaTypography.deliveryInfo.copyWith(
                  fontSize: 11.5,
                  color: ThekaaColors.secondaryText,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

