import 'package:flutter/material.dart';
import '../models/social_models.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class PostCommentsSheet extends StatefulWidget {
  final SocialPost post;
  final ValueChanged<SocialComment> onCommentAdded;

  const PostCommentsSheet({
    super.key,
    required this.post,
    required this.onCommentAdded,
  });

  static Future<void> show({
    required BuildContext context,
    required SocialPost post,
    required ValueChanged<SocialComment> onCommentAdded,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => PostCommentsSheet(
        post: post,
        onCommentAdded: onCommentAdded,
      ),
    );
  }

  @override
  State<PostCommentsSheet> createState() => _PostCommentsSheetState();
}

class _PostCommentsSheetState extends State<PostCommentsSheet> {
  late List<SocialComment> _comments;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _comments = List<SocialComment>.from(widget.post.comments);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _submitComment() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final newComment = SocialComment(
      id: 'cmt_${DateTime.now().millisecondsSinceEpoch}',
      authorName: 'hero M.',
      authorAvatar: 'assets/images/user_avatar.png',
      text: text,
      timestamp: 'Just now',
    );

    setState(() {
      _comments.add(newComment);
      _controller.clear();
    });

    widget.onCommentAdded(newComment);

    // Scroll to bottom smoothly
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height * 0.72 + bottomInset,
      decoration: const BoxDecoration(
        color: ThekaaColors.cardBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Column(
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 6),
              width: 38,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFD8C8B6),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header: Title & Close
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'The table talk · ${_comments.length} comments',
                  style: ThekaaTypography.sectionHeading.copyWith(
                    fontSize: 16.5,
                    fontWeight: FontWeight.bold,
                    color: ThekaaColors.primaryText,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(20),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.close, size: 20, color: ThekaaColors.primaryText),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF0E6D8)),

          // Comments List
          Expanded(
            child: _comments.isEmpty
                ? Center(
                    child: Text(
                      'No comments yet. Start the table talk!',
                      style: ThekaaTypography.deliveryInfo.copyWith(
                        color: ThekaaColors.secondaryText,
                      ),
                    ),
                  )
                : ListView.separated(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
                    itemCount: _comments.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final cmt = _comments[index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: const Color(0xFFF3ECE0),
                            backgroundImage: AssetImage(cmt.authorAvatar),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      cmt.authorName,
                                      style: ThekaaTypography.sectionHeading.copyWith(
                                        fontFamily: 'Inter',
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w700,
                                        color: ThekaaColors.primaryText,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      cmt.timestamp,
                                      style: ThekaaTypography.deliveryInfo.copyWith(
                                        fontSize: 10.5,
                                        color: ThekaaColors.secondaryText,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  cmt.text,
                                  style: ThekaaTypography.deliveryInfo.copyWith(
                                    fontSize: 12.5,
                                    height: 1.35,
                                    color: ThekaaColors.primaryText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF0E6D8)),

          // Bottom Input Field
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(0xFFF3ECE0),
                    backgroundImage: AssetImage('assets/images/user_avatar.png'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFDF8),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFEADBCE),
                          width: 1.0,
                        ),
                      ),
                      child: TextField(
                        controller: _controller,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _submitComment(),
                        style: ThekaaTypography.deliveryInfo.copyWith(
                          fontSize: 13,
                          color: ThekaaColors.primaryText,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Write a comment...',
                          hintStyle: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.5,
                            color: ThekaaColors.secondaryText,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.arrow_upward_rounded, color: ThekaaColors.terracotta),
                    onPressed: _submitComment,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

