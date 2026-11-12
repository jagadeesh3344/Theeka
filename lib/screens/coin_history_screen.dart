import 'package:flutter/material.dart';
import '../models/coins_models.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import '../widgets/thekaa_coins_balance_card.dart';

class CoinHistoryScreen extends StatefulWidget {
  final ThekaaCoinsWallet wallet;
  final VoidCallback? onBack;
  final ValueChanged<CoinTransaction>? onTransactionTap;
  final ValueChanged<int>? onNavTap;

  const CoinHistoryScreen({
    super.key,
    this.wallet = ThekaaCoinsWallet.defaultWallet,
    this.onBack,
    this.onTransactionTap,
    this.onNavTap,
  });

  @override
  State<CoinHistoryScreen> createState() => _CoinHistoryScreenState();
}

class _CoinHistoryScreenState extends State<CoinHistoryScreen> {
  int _selectedFilterIndex = 0; // 0: All, 1: Earned, 2: Redeemed

  List<CoinTransaction> get _filteredTransactions {
    final list = widget.wallet.transactions;
    if (_selectedFilterIndex == 1) {
      return list.where((t) => t.isEarned).toList();
    } else if (_selectedFilterIndex == 2) {
      return list.where((t) => !t.isEarned).toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final wallet = widget.wallet;
    final summary = wallet.historySummary;

    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      bottomNavigationBar: ThekaaBottomNavBar(
        currentIndex: 4,
        onTap: widget.onNavTap,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row: Back button, Title
              Row(
                children: [
                  InkWell(
                    onTap: widget.onBack ?? () => Navigator.maybePop(context),
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Every coin, accounted for',
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Coin Balance Card
              ThekaaCoinsBalanceCard(balance: wallet.balance),
              const SizedBox(height: 14),

              // Transaction Filter Tabs (All, Earned, Redeemed)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEADBCE).withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    _FilterTab(
                      label: 'All',
                      isSelected: _selectedFilterIndex == 0,
                      onTap: () => setState(() => _selectedFilterIndex = 0),
                    ),
                    _FilterTab(
                      label: 'Earned',
                      isSelected: _selectedFilterIndex == 1,
                      onTap: () => setState(() => _selectedFilterIndex = 1),
                    ),
                    _FilterTab(
                      label: 'Redeemed',
                      isSelected: _selectedFilterIndex == 2,
                      onTap: () => setState(() => _selectedFilterIndex = 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Transaction List Container
              Container(
                width: double.infinity,
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
                    for (int i = 0; i < _filteredTransactions.length; i++) ...[
                      if (i > 0)
                        const Divider(height: 1, thickness: 1, color: Color(0xFFF0E6D8)),
                      _TransactionTile(
                        transaction: _filteredTransactions[i],
                        onTap: () => widget.onTransactionTap?.call(_filteredTransactions[i]),
                      ),
                    ],
                    if (_filteredTransactions.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Text(
                          'No transactions in this category',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.5,
                            color: ThekaaColors.secondaryText,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Opening Balance Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7EEDA),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFEADBCE),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      summary.line1,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Color(0xFF5A4232),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      summary.line2,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5A4232),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Disclaimer
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  'Amounts are historical validated awards, not permanent earn rates. No rewards for likes or engagement.',
                  style: ThekaaTypography.deliveryInfo.copyWith(
                    fontSize: 11,
                    height: 1.35,
                    color: ThekaaColors.secondaryText,
                  ),
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

class _FilterTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFFFFDF8) : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
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
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? ThekaaColors.primaryText : const Color(0xFF7A6658),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final CoinTransaction transaction;
  final VoidCallback? onTap;

  const _TransactionTile({
    required this.transaction,
    this.onTap,
  });

  Widget _buildIcon() {
    switch (transaction.type) {
      case CoinTransactionType.reviewValidated:
        return const Icon(
          Icons.edit_note_rounded,
          size: 22,
          color: Color(0xFF8D5B34),
        );
      case CoinTransactionType.orderCompleted:
        return const Icon(
          Icons.receipt_long_outlined,
          size: 22,
          color: Color(0xFF8D5B34),
        );
      case CoinTransactionType.coinsRedeemed:
        return const SizedBox(
          width: 22,
          height: 22,
          child: CustomPaint(
            painter: _CoinsOutlinePainter(color: Color(0xFF8D5B34)),
          ),
        );
      case CoinTransactionType.photoValidated:
        return const Icon(
          Icons.image_outlined,
          size: 22,
          color: Color(0xFF8D5B34),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: _buildIcon(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: ThekaaTypography.sectionHeading.copyWith(
                      fontFamily: 'Inter',
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: ThekaaColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    transaction.orderOrContext,
                    style: ThekaaTypography.deliveryInfo.copyWith(
                      fontSize: 11.5,
                      color: ThekaaColors.secondaryText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    transaction.dateTime,
                    style: ThekaaTypography.deliveryInfo.copyWith(
                      fontSize: 11,
                      color: ThekaaColors.secondaryText.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              transaction.formattedAmount,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: transaction.isEarned ? const Color(0xFF2D5A27) : const Color(0xFF5A4232),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoinsOutlinePainter extends CustomPainter {
  final Color color;

  const _CoinsOutlinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    // Top-right coin
    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.35), size.width * 0.3, paint);

    // Bottom-left coin
    canvas.drawCircle(Offset(size.width * 0.35, size.height * 0.65), size.width * 0.3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

