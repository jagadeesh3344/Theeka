import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../models/support_info.dart';
import '../services/order_repository.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import 'thekaa_coins_screen.dart';

class HelpSupportScreen extends StatefulWidget {
  final SupportRecentOrder recentOrder;
  final FaqItem faqItem;
  final VoidCallback? onBack;
  final VoidCallback? onChatTap;
  final VoidCallback? onCallTap;
  final VoidCallback? onEmailTap;
  final VoidCallback? onOrderCategoryTap;
  final VoidCallback? onPaymentsCategoryTap;
  final VoidCallback? onAccountCategoryTap;
  final VoidCallback? onCoinsCategoryTap;
  final VoidCallback? onAllFaqsTap;
  final ValueChanged<int>? onNavTap;

  const HelpSupportScreen({
    super.key,
    this.recentOrder = const SupportRecentOrder(),
    this.faqItem = FaqItem.defaultFaq,
    this.onBack,
    this.onChatTap,
    this.onCallTap,
    this.onEmailTap,
    this.onOrderCategoryTap,
    this.onPaymentsCategoryTap,
    this.onAccountCategoryTap,
    this.onCoinsCategoryTap,
    this.onAllFaqsTap,
    this.onNavTap,
  });

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isFaqExpanded = true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleChat(BuildContext context) {
    widget.onChatTap?.call();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('We are currently unavailable.'),
        duration: Duration(seconds: 2),
        backgroundColor: ThekaaColors.terracotta,
      ),
    );
  }

  void _handleOrderCategory(BuildContext context) {
    if (widget.onOrderCategoryTap != null) {
      widget.onOrderCategoryTap!();
      return;
    }
    _showOrderHelpSheet(context);
  }

  void _showOrderHelpSheet(BuildContext context) {
    final order = OrderRepository.instance.orders.isNotEmpty
        ? OrderRepository.instance.orders.first
        : OrderConfirmation.sampleShadabOrder;
    final issueController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFFFDF8),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order help',
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 20),
                      onPressed: () => Navigator.pop(sheetContext),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Selected order card showing Restaurant, Order ID, and Status
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF6EE),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFEADBCE), width: 1.0),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3ECE0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.receipt_long_outlined,
                          size: 22,
                          color: ThekaaColors.terracotta,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.restaurantName,
                              style: ThekaaTypography.sectionHeading.copyWith(
                                fontFamily: 'Inter',
                                fontSize: 14.5,
                                fontWeight: FontWeight.bold,
                                color: ThekaaColors.primaryText,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${order.orderId} · ${order.statusDescription}',
                              style: ThekaaTypography.deliveryInfo.copyWith(
                                fontSize: 12,
                                color: ThekaaColors.secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Question heading
                Text(
                  'What help do you need with this order?',
                  style: ThekaaTypography.sectionHeading.copyWith(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ThekaaColors.primaryText,
                  ),
                ),
                const SizedBox(height: 10),

                // Label and typing box
                Text(
                  'What help do you need?',
                  style: ThekaaTypography.captionText.copyWith(
                    fontSize: 12,
                    color: ThekaaColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF6EE),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFEADBCE), width: 1.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: TextField(
                    controller: issueController,
                    maxLines: 3,
                    style: ThekaaTypography.searchInput.copyWith(fontSize: 13.5),
                    decoration: const InputDecoration(
                      hintText: 'Type your issue...',
                      hintStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Color(0xFF9E8E80),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Submit button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Help request submitted. We’ll get back to you shortly.'),
                          duration: Duration(seconds: 3),
                          backgroundColor: ThekaaColors.terracotta,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThekaaColors.terracotta,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'Submit issue',
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontFamily: 'Inter',
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handlePayments(BuildContext context) {
    widget.onPaymentsCategoryTap?.call();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Payment help: UPI and card refunds are processed within 2–4 business days.'),
        duration: Duration(seconds: 3),
        backgroundColor: ThekaaColors.terracotta,
      ),
    );
  }

  void _handleAccount(BuildContext context) {
    widget.onAccountCategoryTap?.call();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account help: You can update your profile details under Profile → Account details.'),
        duration: Duration(seconds: 3),
        backgroundColor: ThekaaColors.terracotta,
      ),
    );
  }

  void _handleCoins(BuildContext context) {
    if (widget.onCoinsCategoryTap != null) {
      widget.onCoinsCategoryTap!();
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ThekaaCoinsScreen(
          onBack: () => Navigator.of(context).maybePop(),
        ),
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDF8),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFEADBCE),
                width: 1.0,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: ThekaaColors.terracotta,
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: ThekaaTypography.sectionHeading.copyWith(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: ThekaaColors.primaryText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryRow({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback? onTap,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.vertical(
          top: isFirst ? const Radius.circular(16) : Radius.zero,
          bottom: isLast ? const Radius.circular(16) : Radius.zero,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3ECE0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 19,
                    color: ThekaaColors.terracotta,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: ThekaaTypography.deliveryInfo.copyWith(
                          fontSize: 11.5,
                          color: ThekaaColors.secondaryText,
                        ),
                      ),
                    ],
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      bottomNavigationBar: ThekaaBottomNavBar(
        currentIndex: 4,
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
                    'Bhaiyya, we’re listening',
                    style: ThekaaTypography.sectionHeading.copyWith(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: ThekaaColors.primaryText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

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
                          hintText: 'Search help articles',
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

              // 3 Contact options
              Row(
                children: [
                  _buildContactOption(
                    icon: Icons.chat_bubble_outline_rounded,
                    label: 'Chat',
                    onTap: () => _handleChat(context),
                  ),
                  const SizedBox(width: 10),
                  _buildContactOption(
                    icon: Icons.phone_outlined,
                    label: 'Call',
                    onTap: widget.onCallTap,
                  ),
                  const SizedBox(width: 10),
                  _buildContactOption(
                    icon: Icons.mail_outline_rounded,
                    label: 'Email',
                    onTap: widget.onEmailTap,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Notice text
              Text(
                'Contact options are shown as a design preview. Availability is confirmed when you request support.',
                style: ThekaaTypography.deliveryInfo.copyWith(
                  fontSize: 11,
                  height: 1.3,
                  color: ThekaaColors.secondaryText,
                ),
              ),
              const SizedBox(height: 20),

              // Section: What can we help with?
              Text(
                'What can we help with?',
                style: ThekaaTypography.sectionHeading.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ThekaaColors.primaryText,
                ),
              ),
              const SizedBox(height: 12),

              // Support Categories Card
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
                    _buildCategoryRow(
                      icon: Icons.receipt_long_outlined,
                      title: 'An order',
                      subtitle: widget.recentOrder.summary,
                      onTap: () => _handleOrderCategory(context),
                      isFirst: true,
                    ),
                    const Divider(
                      height: 1,
                      thickness: 0.8,
                      color: Color(0xFFEADBCE),
                      indent: 14,
                      endIndent: 14,
                    ),
                    _buildCategoryRow(
                      icon: Icons.credit_card_outlined,
                      title: 'Payments',
                      onTap: () => _handlePayments(context),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 0.8,
                      color: Color(0xFFEADBCE),
                      indent: 14,
                      endIndent: 14,
                    ),
                    _buildCategoryRow(
                      icon: Icons.person_outline_rounded,
                      title: 'Account & privacy',
                      onTap: () => _handleAccount(context),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 0.8,
                      color: Color(0xFFEADBCE),
                      indent: 14,
                      endIndent: 14,
                    ),
                    _buildCategoryRow(
                      icon: Icons.toll_outlined,
                      title: 'THEKAA Coins',
                      onTap: () => _handleCoins(context),
                      isLast: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Section: Common questions & All FAQs
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Common questions',
                    style: ThekaaTypography.sectionHeading.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ThekaaColors.primaryText,
                    ),
                  ),
                  InkWell(
                    onTap: widget.onAllFaqsTap,
                    child: Text(
                      'All FAQs',
                      style: ThekaaTypography.captionText.copyWith(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: ThekaaColors.terracotta,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // FAQ Card
              Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isFaqExpanded = !_isFaqExpanded;
                        });
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.faqItem.question,
                              style: ThekaaTypography.sectionHeading.copyWith(
                                fontFamily: 'Inter',
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: ThekaaColors.primaryText,
                              ),
                            ),
                          ),
                          Icon(
                            _isFaqExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            size: 20,
                            color: const Color(0xFF8F7D6D),
                          ),
                        ],
                      ),
                    ),
                    if (_isFaqExpanded) ...[
                      const SizedBox(height: 8),
                      Text(
                        widget.faqItem.answer,
                        style: ThekaaTypography.deliveryInfo.copyWith(
                          fontSize: 11.5,
                          height: 1.35,
                          color: ThekaaColors.secondaryText,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

