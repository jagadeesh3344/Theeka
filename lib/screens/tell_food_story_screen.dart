import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/social_models.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import '../widgets/thekaa_image.dart';
import 'food_story_detail_screen.dart';
import 'story_published_screen.dart';

class TellFoodStoryScreen extends StatefulWidget {
  final SocialPost post;
  final List<EligibleOrder> eligibleOrders;
  final VoidCallback? onBack;
  final VoidCallback? onAddPhoto;
  final VoidCallback? onSelectRestaurant;
  final VoidCallback? onSelectDish;
  final ValueChanged<int>? onRatingChanged;
  final VoidCallback? onPreview;
  final ValueChanged<SocialPost>? onPublishReview;
  final ValueChanged<int>? onNavTap;
  final Future<String?> Function(ImageSource source)? imagePickerFn;

  const TellFoodStoryScreen({
    super.key,
    this.post = SocialPost.defaultPost,
    this.eligibleOrders = EligibleOrder.defaultEligibleOrders,
    this.onBack,
    this.onAddPhoto,
    this.onSelectRestaurant,
    this.onSelectDish,
    this.onRatingChanged,
    this.onPreview,
    this.onPublishReview,
    this.onNavTap,
    this.imagePickerFn,
  });

  @override
  State<TellFoodStoryScreen> createState() => _TellFoodStoryScreenState();
}

class _TellFoodStoryScreenState extends State<TellFoodStoryScreen> {
  late int _rating;
  late TextEditingController _reviewController;
  late TextEditingController _captionController;
  late List<String> _photos;
  late EligibleOrder? _selectedOrder;
  late String _restaurantName;
  late String _restaurantLocality;
  late String _orderId;
  late String _selectedDish;
  late double _selectedDishPrice;

  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _rating = widget.post.rating.toInt();
    if (_rating < 1) _rating = 4;
    _reviewController = TextEditingController(
      text:
          'Long grains, tender chicken, and a proper hit of spice. The dum aroma is unmistakable.',
    );
    _captionController = TextEditingController(text: widget.post.title);

    // Initial photo slots matching authoritative reference: Food cover photo & Personal photo
    _photos = [
      widget.post.imageUrls.isNotEmpty
          ? widget.post.imageUrls.first
          : 'assets/images/biryani_hd.jpg',
      widget.post.authorAvatar,
    ];

    if (widget.eligibleOrders.isNotEmpty) {
      _selectedOrder = widget.eligibleOrders.first;
      _restaurantName = _selectedOrder!.restaurantName;
      _restaurantLocality = _selectedOrder!.restaurantLocality;
      _orderId = _selectedOrder!.orderId;
      _selectedDish = _selectedOrder!.orderedDishes.isNotEmpty
          ? _selectedOrder!.orderedDishes.first
          : widget.post.dishName;
      _selectedDishPrice = _selectedOrder!.dishPrices[_selectedDish] ?? widget.post.dishPrice;
    } else {
      _selectedOrder = null;
      _restaurantName = widget.post.restaurantName;
      _restaurantLocality = widget.post.restaurantLocality;
      _orderId = widget.post.orderId;
      _selectedDish = widget.post.dishName;
      _selectedDishPrice = widget.post.dishPrice;
    }
  }

  @override
  void dispose() {
    _reviewController.dispose();
    _captionController.dispose();
    super.dispose();
  }

  SocialPost _buildCurrentPost() {
    return widget.post.copyWith(
      restaurantName: _restaurantName,
      restaurantLocality: _restaurantLocality,
      dishName: _selectedDish,
      dishPrice: _selectedDishPrice,
      orderId: _orderId,
      rating: _rating.toDouble(),
      description: _reviewController.text.trim(),
      title: _captionController.text.trim(),
      imageUrls: _photos,
      totalImages: _photos.length,
    );
  }

  Future<void> _pickPhoto(ImageSource source, {required int? targetIndex}) async {
    try {
      String? filePath;
      if (widget.imagePickerFn != null) {
        filePath = await widget.imagePickerFn!(source);
      } else {
        final XFile? file = await _imagePicker.pickImage(
          source: source,
          imageQuality: 85,
          maxWidth: 1920,
          maxHeight: 1920,
        );
        filePath = file?.path;
      }

      if (filePath == null || filePath.isEmpty) {
        // User cancelled picker
        return;
      }

      if (!mounted) return;

      setState(() {
        if (targetIndex != null) {
          if (targetIndex < _photos.length) {
            _photos[targetIndex] = filePath!;
          } else {
            _photos.add(filePath!);
          }
        } else {
          if (_photos.length < 6) {
            _photos.add(filePath!);
          }
        }
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not access ${source == ImageSource.camera ? 'camera' : 'gallery'}. Please check device permissions.',
          ),
          backgroundColor: ThekaaColors.terracotta,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _showImageSourceDialog({
    required int? targetIndex,
    required String title,
  }) async {
    if (targetIndex == null && _photos.length >= 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Maximum 6 photos reached'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: ThekaaColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: ThekaaTypography.sectionHeading.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ThekaaColors.primaryText,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: ThekaaColors.primaryText),
                      onPressed: () => Navigator.of(ctx).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3ECE0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.photo_library_outlined,
                      color: ThekaaColors.terracotta,
                      size: 22,
                    ),
                  ),
                  title: const Text(
                    'Choose from gallery',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: ThekaaColors.primaryText,
                    ),
                  ),
                  subtitle: const Text(
                    'Select a photo from device gallery',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: ThekaaColors.secondaryText,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _pickPhoto(ImageSource.gallery, targetIndex: targetIndex);
                  },
                ),
                const Divider(height: 1, color: Color(0xFFF0E6D8)),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3ECE0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: ThekaaColors.terracotta,
                      size: 22,
                    ),
                  ),
                  title: const Text(
                    'Take photo with camera',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: ThekaaColors.primaryText,
                    ),
                  ),
                  subtitle: const Text(
                    'Capture real food photo with device camera',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: ThekaaColors.secondaryText,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _pickPhoto(ImageSource.camera, targetIndex: targetIndex);
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onAddPhotoTap() {
    if (widget.onAddPhoto != null) {
      widget.onAddPhoto!();
      return;
    }
    if (_photos.length >= 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Maximum 6 photos reached'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    _showImageSourceDialog(targetIndex: null, title: 'Add photo');
  }

  void _openRestaurantSelector() {
    if (widget.onSelectRestaurant != null) {
      widget.onSelectRestaurant!();
      return;
    }

    if (widget.eligibleOrders.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No eligible orders found. You can only review restaurants you have ordered from.'),
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: ThekaaColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Select eligible ordered restaurant',
                        style: ThekaaTypography.sectionHeading.copyWith(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: ThekaaColors.primaryText),
                      onPressed: () => Navigator.of(ctx).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Only kitchens with verified past orders can be reviewed.',
                  style: ThekaaTypography.deliveryInfo.copyWith(fontSize: 11.5),
                ),
                const SizedBox(height: 12),
                for (final order in widget.eligibleOrders)
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFF3ECE0),
                      child: Icon(Icons.restaurant, color: ThekaaColors.terracotta, size: 20),
                    ),
                    title: Text(
                      order.restaurantName,
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${order.restaurantLocality} · ${order.orderId} · ${order.orderDate}',
                      style: ThekaaTypography.deliveryInfo.copyWith(fontSize: 11.5),
                    ),
                    trailing: _orderId == order.orderId
                        ? const Icon(Icons.check_circle, color: ThekaaColors.terracotta)
                        : null,
                    onTap: () {
                      setState(() {
                        _selectedOrder = order;
                        _restaurantName = order.restaurantName;
                        _restaurantLocality = order.restaurantLocality;
                        _orderId = order.orderId;
                        if (order.orderedDishes.isNotEmpty) {
                          _selectedDish = order.orderedDishes.first;
                          _selectedDishPrice = order.dishPrices[_selectedDish] ?? 280;
                        }
                      });
                      Navigator.of(ctx).pop();
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openDishSelector() {
    if (widget.onSelectDish != null) {
      widget.onSelectDish!();
      return;
    }

    final dishes = _selectedOrder?.orderedDishes ?? ['Chicken Dum Biryani', 'Mutton Biryani'];

    showModalBottomSheet(
      context: context,
      backgroundColor: ThekaaColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Select ordered dish',
                        style: ThekaaTypography.sectionHeading.copyWith(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: ThekaaColors.primaryText),
                      onPressed: () => Navigator.of(ctx).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                for (final dish in dishes)
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                    leading: const Icon(Icons.lunch_dining_outlined, color: ThekaaColors.terracotta),
                    title: Text(
                      dish,
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '₹${(_selectedOrder?.dishPrices[dish] ?? 280).toInt()}',
                      style: ThekaaTypography.deliveryInfo.copyWith(fontSize: 11.5),
                    ),
                    trailing: _selectedDish == dish
                        ? const Icon(Icons.check_circle, color: ThekaaColors.terracotta)
                        : null,
                    onTap: () {
                      setState(() {
                        _selectedDish = dish;
                        _selectedDishPrice = _selectedOrder?.dishPrices[dish] ?? 280;
                      });
                      Navigator.of(ctx).pop();
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handlePreview() {
    if (widget.onPreview != null) {
      widget.onPreview!();
      return;
    }

    final post = _buildCurrentPost();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FoodStoryDetailScreen(
          post: post,
          isPreview: true,
          onBack: () => Navigator.of(context).maybePop(),
        ),
      ),
    );
  }

  void _handlePublish() {
    if (widget.eligibleOrders.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot publish review: No eligible orders from THEKAA found.'),
        ),
      );
      return;
    }

    final post = _buildCurrentPost();
    if (widget.onPublishReview != null) {
      widget.onPublishReview!(post);
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => FoodStoryDetailScreen(
            post: post,
            isPreparation: true,
            onPublish: (publishedPost) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => StoryPublishedScreen(
                    post: publishedPost,
                    onBackToSocials: () =>
                        Navigator.of(context).popUntil((route) => route.isFirst),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }

  Widget _buildPhotoSlot({
    required Widget content,
    required String label,
    String? subtext,
    VoidCallback? onTap,
    bool isDashed = false,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 82,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFDF8),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFFEADBCE),
                  width: 1.0,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: content,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6B4E38),
              ),
            ),
            if (subtext != null) ...[
              const SizedBox(height: 1),
              Text(
                subtext,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  color: ThekaaColors.secondaryText,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasNoEligibleOrders = widget.eligibleOrders.isEmpty;

    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      bottomNavigationBar: ThekaaBottomNavBar(
        currentIndex: 2, // DABBA active
        onTap: widget.onNavTap ?? (_) {},
      ),
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
                    const SizedBox(height: 8),

                    // Header row: Back arrow & Title
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
                          'Tell your food story',
                          style: ThekaaTypography.sectionHeading.copyWith(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: ThekaaColors.primaryText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Photo Slots row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPhotoSlot(
                          onTap: () => _showImageSourceDialog(
                            targetIndex: 0,
                            title: 'Food photo · cover',
                          ),
                          content: thekaaImage(
                            _photos.isNotEmpty
                                ? _photos.first
                                : 'assets/images/biryani.png',
                            fit: BoxFit.cover,
                          ),
                          label: 'Food photo · cover',
                        ),
                        const SizedBox(width: 10),
                        _buildPhotoSlot(
                          onTap: () => _showImageSourceDialog(
                            targetIndex: 1,
                            title: 'Personal photo',
                          ),
                          content: thekaaImage(
                            _photos.length > 1
                                ? _photos[1]
                                : widget.post.authorAvatar,
                            fit: BoxFit.cover,
                          ),
                          label: 'Personal photo',
                        ),
                        const SizedBox(width: 10),
                        _buildPhotoSlot(
                          onTap: _onAddPhotoTap,
                          isDashed: true,
                          content: const Center(
                            child: Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 26,
                              color: Color(0xFF8F7D6D),
                            ),
                          ),
                          label: 'Add photo',
                          subtext: 'Up to 6 photos',
                        ),
                      ],
                    ),

                    if (_photos.length > 2) ...[
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_photos.length} of 6 photos selected',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF8D5B34),
                            ),
                          ),
                          if (_photos.length < 6)
                            Text(
                              '${6 - _photos.length} slots left',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 10.5,
                                color: ThekaaColors.secondaryText,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        height: 64,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _photos.length - 2,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (context, i) {
                            final photoIndex = i + 2;
                            final photoPath = _photos[photoIndex];
                            return Stack(
                              children: [
                                GestureDetector(
                                  onTap: () => _showImageSourceDialog(
                                    targetIndex: photoIndex,
                                    title: 'Photo #${photoIndex + 1}',
                                  ),
                                  child: Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: const Color(0xFFEADBCE)),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: thekaaImage(photoPath, fit: BoxFit.cover),
                                  ),
                                ),
                                Positioned(
                                  top: 2,
                                  right: 2,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _photos.removeAt(photoIndex);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],

                    const SizedBox(height: 16),

                    // Restaurant & Food Information Card
                    Container(
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
                          // Restaurant selection row
                          InkWell(
                            onTap: _openRestaurantSelector,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF3ECE0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.restaurant_outlined,
                                        size: 18,
                                        color: ThekaaColors.terracotta,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _restaurantName,
                                          style: ThekaaTypography.sectionHeading.copyWith(
                                            fontFamily: 'Inter',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: ThekaaColors.primaryText,
                                          ),
                                        ),
                                        const SizedBox(height: 1),
                                        Text(
                                          'Restaurant · $_restaurantLocality',
                                          style: ThekaaTypography.deliveryInfo.copyWith(
                                            fontSize: 11.5,
                                            color: ThekaaColors.secondaryText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    size: 18,
                                    color: Color(0xFFB8A99B),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(height: 1, thickness: 1, color: Color(0xFFF0E6D8)),

                          // Dish selection row
                          InkWell(
                            onTap: _openDishSelector,
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF3ECE0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.lunch_dining_outlined,
                                        size: 18,
                                        color: ThekaaColors.terracotta,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _selectedDish,
                                          style: ThekaaTypography.sectionHeading.copyWith(
                                            fontFamily: 'Inter',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: ThekaaColors.primaryText,
                                          ),
                                        ),
                                        const SizedBox(height: 1),
                                        Text(
                                          'Dish · ₹${_selectedDishPrice.toInt()}',
                                          style: ThekaaTypography.deliveryInfo.copyWith(
                                            fontSize: 11.5,
                                            color: ThekaaColors.secondaryText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    size: 18,
                                    color: Color(0xFFB8A99B),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Verified THEKAA order badge
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            size: 14,
                            color: Color(0xFF386641),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Verified THEKAA order $_orderId',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF386641),
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (hasNoEligibleOrders) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDF0E6),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFEADBCE)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.warning_amber_rounded, color: ThekaaColors.terracotta, size: 18),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'No verified past order found. You can only review restaurants you have actually ordered food from.',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 11.5,
                                  color: Color(0xFF8D5B34),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 14),

                    // Rate your experience row
                    Row(
                      children: [
                        Text(
                          'Rate your experience',
                          style: ThekaaTypography.sectionHeading.copyWith(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: ThekaaColors.primaryText,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: List.generate(5, (index) {
                            final starNum = index + 1;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _rating = starNum;
                                });
                                widget.onRatingChanged?.call(starNum);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Icon(
                                  starNum <= _rating ? Icons.star : Icons.star_border,
                                  size: 20,
                                  color: const Color(0xFF6B4E38),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$_rating / 5',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6B4E38),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Your review label & input box
                    Text(
                      'Your review',
                      style: ThekaaTypography.deliveryInfo.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF6B4E38),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFDF8),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFFEADBCE),
                          width: 1.0,
                        ),
                      ),
                      child: TextField(
                        controller: _reviewController,
                        maxLines: 3,
                        style: ThekaaTypography.deliveryInfo.copyWith(
                          fontSize: 13,
                          height: 1.4,
                          color: ThekaaColors.primaryText,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Reward pending publication & checks Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5EBD7),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFFEADBCE),
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 2.0),
                            child: Icon(
                              Icons.access_time_rounded,
                              size: 16,
                              color: Color(0xFF8D5B34),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Reward pending publication & checks',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF4A2E18),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Eligible contributions are credited once, only after successful publication and validation. No reward is guaranteed before checks.',
                                  style: ThekaaTypography.deliveryInfo.copyWith(
                                    fontSize: 11.5,
                                    height: 1.35,
                                    color: ThekaaColors.secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Caption label & input
                    Text(
                      'Caption',
                      style: ThekaaTypography.deliveryInfo.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF6B4E38),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFDF8),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFFEADBCE),
                          width: 1.0,
                        ),
                      ),
                      child: TextField(
                        controller: _captionController,
                        style: ThekaaTypography.searchInput.copyWith(fontSize: 13.5),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Bottom Buttons: Preview & Publish review
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Row(
                children: [
                  SizedBox(
                    height: 48,
                    width: 110,
                    child: OutlinedButton(
                      onPressed: _handlePreview,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFFDF8),
                        side: const BorderSide(color: Color(0xFFD8C8B6), width: 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'Preview',
                        style: ThekaaTypography.sectionHeading.copyWith(
                          fontFamily: 'Inter',
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF6B4E38),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: hasNoEligibleOrders ? null : _handlePublish,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: hasNoEligibleOrders
                              ? const Color(0xFFDDD4C7)
                              : ThekaaColors.terracotta,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          'Publish review →',
                          style: ThekaaTypography.sectionHeading.copyWith(
                            fontFamily: 'Inter',
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
