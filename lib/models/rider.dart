class Rider {
  final String id;
  final String name;
  final double rating;
  final int deliveryCount;
  final int tenureYears;
  final String role;
  final String imagePath;
  final String phoneNumber;
  final String assignedTime;
  final String? customStatusHeading;
  final String? customStatusBody;

  const Rider({
    required this.id,
    required this.name,
    required this.rating,
    required this.deliveryCount,
    required this.tenureYears,
    this.role = 'Your delivery partner',
    this.imagePath = 'assets/images/rider_ravi.png',
    this.phoneNumber = '+91 98765 43210',
    this.assignedTime = '1:53 PM',
    this.customStatusHeading,
    this.customStatusBody,
  });

  String get firstName => name.split(' ').first;

  String get formattedDeliveries {
    if (deliveryCount >= 1000) {
      final thousands = deliveryCount ~/ 1000;
      final remainder = (deliveryCount % 1000).toString().padLeft(3, '0');
      return '$thousands,$remainder deliveries';
    }
    return '$deliveryCount deliveries';
  }

  String get formattedTenure => '$tenureYears years with THEKAA';

  String get formattedRating => rating.toStringAsFixed(1);

  String get statusHeading =>
      customStatusHeading ?? '$firstName is heading to the restaurant';

  String get statusBody =>
      customStatusBody ??
      "Your food has not been picked up yet. We'll update the status when he's on his way to you.";

  Rider copyWith({
    String? id,
    String? name,
    double? rating,
    int? deliveryCount,
    int? tenureYears,
    String? role,
    String? imagePath,
    String? phoneNumber,
    String? assignedTime,
    String? customStatusHeading,
    String? customStatusBody,
  }) {
    return Rider(
      id: id ?? this.id,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      deliveryCount: deliveryCount ?? this.deliveryCount,
      tenureYears: tenureYears ?? this.tenureYears,
      role: role ?? this.role,
      imagePath: imagePath ?? this.imagePath,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      assignedTime: assignedTime ?? this.assignedTime,
      customStatusHeading: customStatusHeading ?? this.customStatusHeading,
      customStatusBody: customStatusBody ?? this.customStatusBody,
    );
  }

  static const Rider defaultRider = Rider(
    id: 'rider_ravi_k',
    name: 'Ravi K.',
    rating: 4.8,
    deliveryCount: 1240,
    tenureYears: 2,
    role: 'Your delivery partner',
    imagePath: 'assets/images/rider_ravi.png',
    phoneNumber: '+91 98765 43210',
    assignedTime: '1:53 PM',
  );

  static const Rider chutneysRider = Rider(
    id: 'rider_arjun_m',
    name: 'Arjun M.',
    rating: 4.9,
    deliveryCount: 890,
    tenureYears: 1,
    role: 'Your delivery partner',
    imagePath: 'assets/images/rider_ravi.png',
    phoneNumber: '+91 98765 43211',
    assignedTime: '1:58 PM',
  );
}
