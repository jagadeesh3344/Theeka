import 'package:flutter/material.dart';
import '../models/reward_transaction.dart';
import '../theme/thekaa_colors.dart';

class TransactionDetailsCard extends StatelessWidget {
  final RewardTransaction transaction;

  const TransactionDetailsCard({
    super.key,
    required this.transaction,
  });

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThekaaColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThekaaColors.border,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        children: [
          _buildRow('Transaction ID', transaction.transactionId),
          const SizedBox(height: 8),
          _buildRow('Date & time', transaction.dateTime),
          const SizedBox(height: 8),
          _buildRow('Type', transaction.type),
          const SizedBox(height: 8),
          _buildRow('Source', transaction.source),
          const SizedBox(height: 8),
          _buildRow('Related order', transaction.relatedOrder),
          const SizedBox(height: 8),
          _buildRow('Balance before', '${_formatNumber(transaction.balanceBefore)} TKC'),
          const SizedBox(height: 8),
          _buildRow('Balance after', '${_formatNumber(transaction.balanceAfter)} TKC'),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            color: ThekaaColors.secondaryText,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: ThekaaColors.primaryText,
          ),
        ),
      ],
    );
  }
}

