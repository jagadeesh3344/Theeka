import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/order_confirmation.dart';

/// Single source of truth for all orders throughout their lifecycle.
/// Maintains active orders, background lifecycle timers, and completed/historical orders.
class OrderRepository extends ChangeNotifier {
  static final OrderRepository instance = OrderRepository._internal();

  OrderRepository._internal();

  final List<OrderConfirmation> _orders = [];
  final Map<String, Timer> _lifecycleTimers = {};
  final Map<String, Duration> _stepDurations = {};

  List<OrderConfirmation> get orders => List.unmodifiable(_orders);

  List<OrderConfirmation> get deliveredOrders => List.unmodifiable(
        _orders.where((o) => o.trackingStatus == OrderTrackingStatus.delivered),
      );

  List<OrderConfirmation> get activeOrders => List.unmodifiable(
        _orders.where((o) => o.trackingStatus != OrderTrackingStatus.delivered),
      );

  String _normalizeId(String orderId) => orderId.trim().toLowerCase();

  void _safeNotifyListeners() {
    scheduleMicrotask(() {
      notifyListeners();
    });
  }

  /// Starts or resumes the order progression lifecycle for [order].
  /// Timers belong to the order, NOT individual screens, and continue across navigation.
  /// Never resets an existing order to an earlier stage.
  void startOrderLifecycle(
    OrderConfirmation order, {
    Duration? stepDuration,
    bool enableSimulation = true,
  }) {
    final key = _normalizeId(order.orderId);
    final index = _orders.indexWhere((o) => _normalizeId(o.orderId) == key);

    late OrderConfirmation current;
    if (index >= 0) {
      current = _orders[index];
      // Only move forward if passed order has a more advanced state
      if (order.trackingStatus.index > current.trackingStatus.index) {
        current = current.copyWith(
          trackingStatus: order.trackingStatus,
          assignedRider: order.assignedRider ?? current.assignedRider,
        );
        _orders[index] = current;
        _safeNotifyListeners();
      }
    } else {
      current = order;
      _orders.insert(0, current);
      _safeNotifyListeners();
    }

    if (stepDuration != null) {
      _stepDurations[key] = stepDuration;
    }

    if (!enableSimulation || current.trackingStatus == OrderTrackingStatus.delivered) {
      return;
    }

    // If timer is already running for this order, do NOT restart it!
    if (_lifecycleTimers[key]?.isActive ?? false) {
      return;
    }

    // Schedule the next transition based on current state
    _scheduleNextStep(key);
  }

  void _scheduleNextStep(String key) {
    _lifecycleTimers[key]?.cancel();

    final order = getOrderById(key);
    if (order == null || order.trackingStatus == OrderTrackingStatus.delivered) {
      _lifecycleTimers.remove(key);
      return;
    }

    final duration = _stepDurations[key] ?? const Duration(seconds: 10);
    _lifecycleTimers[key] = Timer(duration, () => _advanceOrderState(key));
  }

  void _advanceOrderState(String key) {
    final order = getOrderById(key);
    if (order == null) return;

    switch (order.trackingStatus) {
      case OrderTrackingStatus.orderConfirmed:
      case OrderTrackingStatus.preparingFood:
        final next = order.copyWith(
          trackingStatus: OrderTrackingStatus.riderAssigned,
          assignedRider: order.assignedRider ?? order.rider,
        );
        _updateOrderInList(next);
        _scheduleNextStep(key);
        break;

      case OrderTrackingStatus.riderAssigned:
        final next = order.copyWith(
          trackingStatus: OrderTrackingStatus.outForDelivery,
          assignedRider: order.assignedRider ?? order.rider,
        );
        _updateOrderInList(next);
        _scheduleNextStep(key);
        break;

      case OrderTrackingStatus.outForDelivery:
        final next = order.copyWith(
          trackingStatus: OrderTrackingStatus.delivered,
          deliveredDate: order.deliveredDate ?? order.date,
          deliveredTime: order.deliveredTime ?? order.arrivalAroundTime,
          assignedRider: order.assignedRider ?? order.rider,
        );
        _updateOrderInList(next);
        _lifecycleTimers.remove(key)?.cancel();
        break;

      case OrderTrackingStatus.delivered:
        _lifecycleTimers.remove(key)?.cancel();
        break;
    }
  }

  void _updateOrderInList(OrderConfirmation updated) {
    final key = _normalizeId(updated.orderId);
    final index = _orders.indexWhere((o) => _normalizeId(o.orderId) == key);
    if (index >= 0) {
      _orders[index] = updated;
    } else {
      _orders.insert(0, updated);
    }
    notifyListeners();
  }

  /// Saves or updates the order in order history.
  /// Forward-only transitions: never moves order backward.
  void addOrUpdateOrder(OrderConfirmation order) {
    final key = _normalizeId(order.orderId);
    final index = _orders.indexWhere((o) => _normalizeId(o.orderId) == key);

    if (index >= 0) {
      final existing = _orders[index];
      final effectiveStatus = order.trackingStatus.index > existing.trackingStatus.index
          ? order.trackingStatus
          : existing.trackingStatus;
      final effectiveRider = order.assignedRider ?? existing.assignedRider ?? existing.rider;
      _orders[index] = order.copyWith(
        trackingStatus: effectiveStatus,
        assignedRider: effectiveRider,
      );
    } else {
      _orders.insert(0, order);
    }
    notifyListeners();
  }

  OrderConfirmation? getOrderById(String orderId) {
    final key = _normalizeId(orderId);
    try {
      return _orders.firstWhere((o) => _normalizeId(o.orderId) == key);
    } catch (_) {
      return null;
    }
  }

  void stopOrderLifecycle(String orderId) {
    final key = _normalizeId(orderId);
    _lifecycleTimers.remove(key)?.cancel();
  }

  void clear() {
    for (final timer in _lifecycleTimers.values) {
      timer.cancel();
    }
    _lifecycleTimers.clear();
    _stepDurations.clear();
    _orders.clear();
    notifyListeners();
  }

  void resetWith(List<OrderConfirmation> initialOrders) {
    for (final timer in _lifecycleTimers.values) {
      timer.cancel();
    }
    _lifecycleTimers.clear();
    _stepDurations.clear();
    _orders.clear();
    _orders.addAll(initialOrders);
    notifyListeners();
  }
}
