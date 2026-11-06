import 'address.dart';
import 'payment_method.dart';
import 'restaurant.dart';
import 'rider.dart';

enum OrderTrackingStatus {
  orderConfirmed,
  preparingFood,
  riderAssigned,
  outForDelivery,
  delivered,
}

enum StageProgressState {
  completed,
  inProgress,
  pending,
}

class OrderItemDetail {
  final String name;
  final int quantity;
  final double price;

  const OrderItemDetail({
    required this.name,
    required this.quantity,
    required this.price,
  });

  String get formattedRow => '$quantity × $name · ₹${price.toInt()}';
}

class OrderConfirmation {
  final String orderId;
  final String date;
  final String time;
  final String deliveryEtaDuration;
  final String deliveryEtaWindow;
  final String restaurantId;
  final String restaurantName;
  final String restaurantArea;
  final List<OrderItemDetail> items;
  final double totalPayable;
  final int coinsRedeemed;
  final String paymentMethodName;
  final DeliveryAddress? deliveryAddress;
  final String restaurantImagePath;
  final OrderTrackingStatus trackingStatus;
  final String? customStatusMessage;
  final Rider? assignedRider;

  const OrderConfirmation({
    required this.orderId,
    required this.date,
    required this.time,
    required this.deliveryEtaDuration,
    required this.deliveryEtaWindow,
    required this.restaurantId,
    required this.restaurantName,
    required this.restaurantArea,
    required this.items,
    required this.totalPayable,
    this.coinsRedeemed = 0,
    required this.paymentMethodName,
    this.deliveryAddress,
    this.restaurantImagePath = 'assets/images/biryani.png',
    this.trackingStatus = OrderTrackingStatus.preparingFood,
    this.customStatusMessage,
    this.assignedRider,
  });

  Rider get rider =>
      assignedRider ??
      (restaurantId == 'chutneys' ? Rider.chutneysRider : Rider.defaultRider);

  int get totalItemCount =>
      items.fold(0, (sum, item) => sum + item.quantity);

  String get coinSummaryText =>
      coinsRedeemed > 0 ? '$coinsRedeemed TKC redeemed' : 'No coins redeemed';

  String get paymentSummaryText =>
      'Paid ₹${totalPayable.toInt()} via $paymentMethodName · $coinSummaryText';

  String get statusMessage {
    if (customStatusMessage != null) return customStatusMessage!;
    final lowerNames = items.map((i) => i.name.toLowerCase()).toList();
    if (lowerNames.any((n) => n.contains('biryani')) || restaurantId == 'shadab') {
      return 'Your biryani is getting its finishing touch.';
    } else if (lowerNames.any((n) => n.contains('dosa')) || restaurantId == 'chutneys') {
      return 'Your dosa is getting its finishing touch.';
    } else {
      return 'Your meal is getting its finishing touch.';
    }
  }

  String get estimatedTimeFormatted =>
      deliveryEtaWindow.replaceAll('Estimated delivery · ', 'Estimated ');

  StageProgressState getStageState(OrderTrackingStatus stage) {
    if (trackingStatus == OrderTrackingStatus.delivered) {
      return StageProgressState.completed;
    }
    final currentIndex = trackingStatus.index;
    final stageIndex = stage.index;

    if (stageIndex < currentIndex) {
      return StageProgressState.completed;
    } else if (stageIndex == currentIndex) {
      return StageProgressState.inProgress;
    } else {
      return StageProgressState.pending;
    }
  }

  OrderConfirmation copyWith({
    String? orderId,
    String? date,
    String? time,
    String? deliveryEtaDuration,
    String? deliveryEtaWindow,
    String? restaurantId,
    String? restaurantName,
    String? restaurantArea,
    List<OrderItemDetail>? items,
    double? totalPayable,
    int? coinsRedeemed,
    String? paymentMethodName,
    DeliveryAddress? deliveryAddress,
    String? restaurantImagePath,
    OrderTrackingStatus? trackingStatus,
    String? customStatusMessage,
    Rider? assignedRider,
  }) {
    return OrderConfirmation(
      orderId: orderId ?? this.orderId,
      date: date ?? this.date,
      time: time ?? this.time,
      deliveryEtaDuration: deliveryEtaDuration ?? this.deliveryEtaDuration,
      deliveryEtaWindow: deliveryEtaWindow ?? this.deliveryEtaWindow,
      restaurantId: restaurantId ?? this.restaurantId,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantArea: restaurantArea ?? this.restaurantArea,
      items: items ?? this.items,
      totalPayable: totalPayable ?? this.totalPayable,
      coinsRedeemed: coinsRedeemed ?? this.coinsRedeemed,
      paymentMethodName: paymentMethodName ?? this.paymentMethodName,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      restaurantImagePath: restaurantImagePath ?? this.restaurantImagePath,
      trackingStatus: trackingStatus ?? this.trackingStatus,
      customStatusMessage: customStatusMessage ?? this.customStatusMessage,
      assignedRider: assignedRider ?? this.assignedRider,
    );
  }

  factory OrderConfirmation.fromCheckout({
    required Restaurant restaurant,
    Map<String, int> cartQuantities = const {},
    DeliveryAddress? deliveryAddress,
    required double payableAmount,
    int coinsRedeemed = 0,
    PaymentMethodType paymentMethod = PaymentMethodType.upi,
    String? customOrderId,
    OrderTrackingStatus trackingStatus = OrderTrackingStatus.preparingFood,
    String? customStatusMessage,
    Rider? assignedRider,
  }) {
    final orderId = customOrderId ??
        (restaurant.id == 'chutneys' ? '#THK62180' : '#THK84291');

    String methodName;
    switch (paymentMethod) {
      case PaymentMethodType.upi:
        methodName = 'UPI';
        break;
      case PaymentMethodType.card:
        methodName = 'Debit / credit card';
        break;
      case PaymentMethodType.netBanking:
        methodName = 'Net banking';
        break;
      case PaymentMethodType.cashOnDelivery:
        methodName = 'Cash on delivery';
        break;
    }

    final List<OrderItemDetail> items = [];
    if (cartQuantities.isNotEmpty) {
      cartQuantities.forEach((itemId, qty) {
        if (qty > 0) {
          final knownPrices = <String, double>{
            'chicken_dum_biryani': 280,
            'mutton_biryani': 340,
            'ghee_karam_dosa': 180,
            'babai_idli': 120,
            'filter_coffee': 70,
          };
          final dish = restaurant.bestsellers.firstWhere(
            (d) => d.id == itemId,
            orElse: () => MenuItem(
              id: itemId,
              name: itemId.replaceAll('_', ' ').split(' ').map((w) {
                if (w.isEmpty) return '';
                return w[0].toUpperCase() + w.substring(1);
              }).join(' '),
              price: knownPrices[itemId] ?? 250,
              description: '',
              imagePath: '',
            ),
          );
          items.add(
            OrderItemDetail(
              name: dish.name,
              quantity: qty,
              price: dish.price,
            ),
          );
        }
      });
    }

    if (items.isEmpty) {
      if (restaurant.id == 'chutneys') {
        items.addAll([
          const OrderItemDetail(
            name: 'Ghee Karam Dosa',
            quantity: 2,
            price: 180,
          ),
          const OrderItemDetail(
            name: 'Filter Coffee',
            quantity: 1,
            price: 70,
          ),
        ]);
      } else {
        items.addAll([
          const OrderItemDetail(
            name: 'Chicken Dum Biryani',
            quantity: 1,
            price: 280,
          ),
          const OrderItemDetail(
            name: 'Mutton Biryani',
            quantity: 1,
            price: 340,
          ),
        ]);
      }
    }

    final etaDuration = restaurant.id == 'chutneys' ? '20–25 min' : '24–28 min';
    final etaWindow = restaurant.id == 'chutneys' ? '2:05–2:10 PM' : '2:09–2:13 PM';

    return OrderConfirmation(
      orderId: orderId,
      date: '01 Nov 2026',
      time: '1:45 PM',
      deliveryEtaDuration: etaDuration,
      deliveryEtaWindow: 'Estimated delivery · $etaWindow',
      restaurantId: restaurant.id,
      restaurantName: restaurant.name,
      restaurantArea: restaurant.locality,
      items: items,
      totalPayable: payableAmount,
      coinsRedeemed: coinsRedeemed,
      paymentMethodName: methodName,
      deliveryAddress: deliveryAddress ?? DeliveryAddress.defaultHome,
      restaurantImagePath: restaurant.imagePath.isNotEmpty ? restaurant.imagePath : 'assets/images/biryani.png',
      trackingStatus: trackingStatus,
      customStatusMessage: customStatusMessage,
      assignedRider: assignedRider ??
          (restaurant.id == 'chutneys' ? Rider.chutneysRider : Rider.defaultRider),
    );
  }
}
