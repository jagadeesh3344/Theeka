import 'package:flutter/material.dart';
import '../models/support_info.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';

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
                    onTap: widget.onChatTap,
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
                      onTap: widget.onOrderCategoryTap,
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
                      onTap: widget.onPaymentsCategoryTap,
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
                      onTap: widget.onAccountCategoryTap,
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
                      onTap: widget.onCoinsCategoryTap,
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
