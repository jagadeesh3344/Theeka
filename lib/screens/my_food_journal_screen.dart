import 'package:flutter/material.dart';
import '../models/social_models.dart';
import '../models/user_profile.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import '../widgets/thekaa_image.dart';

class MyFoodJournalScreen extends StatefulWidget {
  final UserProfile profile;
  final List<JournalTile> tiles;
  final VoidCallback? onBack;
  final VoidCallback? onShare;
  final VoidCallback? onEditProfile;
  final ValueChanged<JournalTile>? onTileTap;
  final ValueChanged<int>? onNavTap;

  const MyFoodJournalScreen({
    super.key,
    this.profile = UserProfile.defaultProfile,
    this.tiles = JournalTile.sampleTiles,
    this.onBack,
    this.onShare,
    this.onEditProfile,
    this.onTileTap,
    this.onNavTap,
  });

  @override
  State<MyFoodJournalScreen> createState() => _MyFoodJournalScreenState();
}

class _MyFoodJournalScreenState extends State<MyFoodJournalScreen> {
  int _selectedTabIndex = 0; // 0: Posts, 1: Reviews, 2: Saved
  final List<String> _tabs = ['Posts', 'Reviews', 'Saved'];

  Widget _buildStatColumn(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: ThekaaTypography.sectionHeading.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ThekaaColors.primaryText,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: ThekaaTypography.deliveryInfo.copyWith(
            fontSize: 12,
            color: ThekaaColors.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildGridTile(JournalTile tile) {
    return GestureDetector(
      onTap: () => widget.onTileTap?.call(tile),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFEADBCE),
            width: 0.8,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            thekaaImage(
              tile.imageUrl,
              fit: BoxFit.cover,
            ),
            Positioned(
              left: 6,
              bottom: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.88),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFEADBCE),
                    width: 0.8,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star_outline_rounded,
                      size: 13,
                      color: Color(0xFF6B4E38),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      tile.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                  ],
                ),
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
        currentIndex: 2, // DABBA active
        onTap: widget.onNavTap,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),

              // Header row: Back arrow, Title, Share
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Text(
                    'My food journal',
                    style: ThekaaTypography.sectionHeading.copyWith(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: ThekaaColors.primaryText,
                    ),
                  ),
                  InkWell(
                    onTap: widget.onShare,
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.share_outlined,
                        size: 20,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Decorative Header Art + Avatar Stack
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Subtle architectural line art
                    Positioned(
                      top: 0,
                      child: Opacity(
                        opacity: 0.22,
                        child: Image.asset(
                          'assets/images/monument.png',
                          width: 240,
                          height: 70,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const SizedBox.shrink(),
                        ),
                      ),
                    ),
                    // Centered circular avatar
                    Positioned(
                      bottom: 4,
                      child: Container(
                        width: 78,
                        height: 78,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFEADBCE),
                            width: 1.5,
                          ),
                        ),
                        child: ClipOval(
                          child: widget.profile.avatarImagePath != null
                              ? thekaaImage(
                                  widget.profile.avatarImagePath!,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: const Color(0xFFF3ECE0),
                                  child: const Icon(
                                    Icons.person,
                                    size: 38,
                                    color: ThekaaColors.terracotta,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // User Name
              Text(
                widget.profile.name,
                style: ThekaaTypography.sectionHeading.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: ThekaaColors.primaryText,
                ),
              ),
              const SizedBox(height: 2),

              // User Handle
              Text(
                widget.profile.handle,
                style: ThekaaTypography.captionText.copyWith(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: ThekaaColors.terracotta,
                ),
              ),
              const SizedBox(height: 6),

              // Bio
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  widget.profile.bio,
                  textAlign: TextAlign.center,
                  style: ThekaaTypography.deliveryInfo.copyWith(
                    fontSize: 12.5,
                    height: 1.35,
                    color: ThekaaColors.secondaryText,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Statistics Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: _buildStatColumn(
                      '${widget.profile.postsCount}',
                      'Posts',
                    ),
                  ),
                  Expanded(
                    child: _buildStatColumn(
                      widget.profile.followersCount,
                      'Followers',
                    ),
                  ),
                  Expanded(
                    child: _buildStatColumn(
                      '${widget.profile.followingCount}',
                      'Following',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Edit profile outlined button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onEditProfile,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: double.infinity,
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF6EE),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFD8C8B6),
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Edit profile',
                          style: ThekaaTypography.sectionHeading.copyWith(
                            fontFamily: 'Inter',
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600,
                            color: ThekaaColors.terracotta,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.edit_outlined,
                          size: 17,
                          color: ThekaaColors.terracotta,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Journal Tabs Pill (Posts, Reviews, Saved)
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
                              fontSize: 12.5,
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
              const SizedBox(height: 14),

              // 3-Column Food Post Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.0,
                ),
                itemCount: widget.tiles.length,
                itemBuilder: (context, index) {
                  return _buildGridTile(widget.tiles[index]);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

