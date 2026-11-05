enum PaymentMethodType {
  upi,
  card,
  netBanking,
  cashOnDelivery,
}

enum UpiProvider {
  googlePay,
  phonePe,
  paytm,
}

extension UpiProviderExtension on UpiProvider {
  String get displayName {
    switch (this) {
      case UpiProvider.googlePay:
        return 'Google Pay';
      case UpiProvider.phonePe:
        return 'PhonePe';
      case UpiProvider.paytm:
        return 'Paytm';
    }
  }
}

class PaymentDetails {
  final PaymentMethodType method;
  final UpiProvider upiProvider;
  final String upiId;
  final bool isCodAvailable;

  const PaymentDetails({
    this.method = PaymentMethodType.upi,
    this.upiProvider = UpiProvider.googlePay,
    this.upiId = 'vatsa@sample',
    this.isCodAvailable = true,
  });

  PaymentDetails copyWith({
    PaymentMethodType? method,
    UpiProvider? upiProvider,
    String? upiId,
    bool? isCodAvailable,
  }) {
    return PaymentDetails(
      method: method ?? this.method,
      upiProvider: upiProvider ?? this.upiProvider,
      upiId: upiId ?? this.upiId,
      isCodAvailable: isCodAvailable ?? this.isCodAvailable,
    );
  }
}

