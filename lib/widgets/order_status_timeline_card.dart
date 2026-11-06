import 'package:flutter/material.dart';
import '../models/order_confirmation.dart';
import '../theme/thekaa_colors.dart';

class OrderStatusTimelineCard extends StatelessWidget {
  final OrderConfirmation order;

  const OrderStatusTimelineCard({
    super.key,
    required this.order,
  });

  static const List<_TimelineStageConfig> _stages = [
    _TimelineStageConfig(
      stage: OrderTrackingStatus.orderConfirmed,
      title: 'Order confirmed',
    ),
    _TimelineStageConfig(
      stage: OrderTrackingStatus.preparingFood,
      title: 'Restaurant preparing food',
    ),
    _TimelineStageConfig(
      stage: OrderTrackingStatus.riderAssigned,
      title: 'Rider assigned',
    ),
    _TimelineStageConfig(
      stage: OrderTrackingStatus.outForDelivery,
      title: 'Out for delivery',
    ),
    _TimelineStageConfig(
      stage: OrderTrackingStatus.delivered,
      title: 'Delivered',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22.0),
      decoration: BoxDecoration(
        color: ThekaaColors.cardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: ThekaaColors.border,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < _stages.length; i++)
            _buildStageItem(
              config: _stages[i],
              state: order.getStageState(_stages[i].stage),
              isLast: i == _stages.length - 1,
            ),
        ],
      ),
    );
  }

  Widget _buildStageItem({
    required _TimelineStageConfig config,
    required StageProgressState state,
    required bool isLast,
  }) {
    String subtitle;
    Color subtitleColor;
    FontWeight subtitleWeight = FontWeight.w400;

    switch (state) {
      case StageProgressState.completed:
        subtitle = 'Completed';
        subtitleColor = const Color(0xFF8F7D6D);
        break;
      case StageProgressState.inProgress:
        subtitle = 'In progress';
        subtitleColor = ThekaaColors.terracotta;
        subtitleWeight = FontWeight.w500;
        break;
      case StageProgressState.pending:
        subtitle = 'Pending';
        subtitleColor = const Color(0xFFAFA396);
        break;
    }

    final isHighlighted = state == StageProgressState.completed ||
        state == StageProgressState.inProgress;

    // Line below is green if this stage is completed, otherwise sand/beige
    final connectorColor = state == StageProgressState.completed
        ? const Color(0xFF4A6B53)
        : const Color(0xFFE5D9CB);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Circle indicator and vertical connecting line
        Column(
          children: [
            _buildIndicator(state),
            if (!isLast)
              Container(
                width: 2.0,
                height: 38.0,
                color: connectorColor,
              ),
          ],
        ),
        const SizedBox(width: 16),

        // Right Column: Title and Subtitle
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  config.title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.0,
                    fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w500,
                    color: isHighlighted
                        ? const Color(0xFF3B2E24)
                        : const Color(0xFF6E5D4F),
                    letterSpacing: -0.1,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.0,
                    fontWeight: subtitleWeight,
                    color: subtitleColor,
                  ),
                ),
                if (!isLast) const SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIndicator(StageProgressState state) {
    switch (state) {
      case StageProgressState.completed:
        return Container(
          width: 26,
          height: 26,
          decoration: const BoxDecoration(
            color: Color(0xFF4A6B53),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.check_rounded,
              size: 16,
              color: Colors.white,
            ),
          ),
        );

      case StageProgressState.inProgress:
        return Container(
          width: 26,
          height: 26,
          decoration: const BoxDecoration(
            color: ThekaaColors.terracotta,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );

      case StageProgressState.pending:
        return Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFDFC8B4),
              width: 1.5,
            ),
          ),
          child: Center(
            child: Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                color: Color(0xFFC4B29F),
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
    }
  }
}

class _TimelineStageConfig {
  final OrderTrackingStatus stage;
  final String title;

  const _TimelineStageConfig({
    required this.stage,
    required this.title,
  });
}
