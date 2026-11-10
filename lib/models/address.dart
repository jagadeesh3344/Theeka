import 'package:flutter/material.dart';

enum AddressType { home, work, other }

class DeliveryAddress {
  final String id;
  final AddressType type;
  final String flatBuilding;
  final String locality;
  final String streetArea;
  final String? landmark;
  final String? deliveryInstructions;
  final String city;
  final String state;
  final String pincode;
  final bool isDefault;
  final Offset? mapCoordinates;

  const DeliveryAddress({
    required this.id,
    required this.type,
    required this.flatBuilding,
    required this.locality,
    required this.streetArea,
    this.landmark,
    this.deliveryInstructions,
    this.city = 'Hyderabad',
    this.state = 'Telangana',
    this.pincode = '500032',
    this.isDefault = false,
    this.mapCoordinates,
  });

  String get typeLabel {
    switch (type) {
      case AddressType.home:
        return 'Home';
      case AddressType.work:
        return 'Work';
      case AddressType.other:
        return 'Other';
    }
  }

  String get formattedAddress =>
      'Flat $flatBuilding, $streetArea,\n$city $pincode';

  String get singleLineAddress {
    final flatStr = flatBuilding.startsWith('Flat') ||
            flatBuilding.startsWith('Floor') ||
            flatBuilding.startsWith('Villa') ||
            flatBuilding.startsWith('Level')
        ? flatBuilding
        : 'Flat $flatBuilding';
    return '$flatStr, $locality, $city $pincode';
  }

  String get locationSummary => '$city, $state · $pincode';

  DeliveryAddress copyWith({
    String? id,
    AddressType? type,
    String? flatBuilding,
    String? locality,
    String? streetArea,
    String? landmark,
    String? deliveryInstructions,
    String? city,
    String? state,
    String? pincode,
    bool? isDefault,
    Offset? mapCoordinates,
  }) {
    return DeliveryAddress(
      id: id ?? this.id,
      type: type ?? this.type,
      flatBuilding: flatBuilding ?? this.flatBuilding,
      locality: locality ?? this.locality,
      streetArea: streetArea ?? this.streetArea,
      landmark: landmark ?? this.landmark,
      deliveryInstructions: deliveryInstructions ?? this.deliveryInstructions,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
      isDefault: isDefault ?? this.isDefault,
      mapCoordinates: mapCoordinates ?? this.mapCoordinates,
    );
  }

  // Sample default addresses
  static const DeliveryAddress defaultHome = DeliveryAddress(
    id: 'addr_home_1',
    type: AddressType.home,
    flatBuilding: '302, Vertex Heights',
    locality: 'Gachibowli',
    streetArea: 'Vertex Heights, Gachibowli',
    landmark: 'Near main gate',
    deliveryInstructions: 'Call at the gate',
    city: 'Hyderabad',
    state: 'Telangana',
    pincode: '500032',
    isDefault: true,
    mapCoordinates: Offset(0.76, 0.38),
  );

  static const DeliveryAddress defaultWork = DeliveryAddress(
    id: 'addr_work_1',
    type: AddressType.work,
    flatBuilding: 'Floor 5, Building 12',
    locality: 'Madhapur',
    streetArea: 'Mindspace IT Park, Hitec City',
    landmark: 'Near Building 12 lobby',
    deliveryInstructions: 'Leave with reception',
    city: 'Hyderabad',
    state: 'Telangana',
    pincode: '500081',
    isDefault: false,
    mapCoordinates: Offset(0.65, 0.45),
  );

  static const DeliveryAddress defaultOther = DeliveryAddress(
    id: 'addr_other_1',
    type: AddressType.other,
    flatBuilding: 'Villa 14',
    locality: 'Jubilee Hills',
    streetArea: 'Road No. 36, Jubilee Hills',
    landmark: 'Opposite Metro Pillar 18',
    deliveryInstructions: 'Ring doorbell',
    city: 'Hyderabad',
    state: 'Telangana',
    pincode: '500033',
    isDefault: false,
    mapCoordinates: Offset(0.50, 0.50),
  );

  static const DeliveryAddress savedHome = DeliveryAddress(
    id: 'addr_saved_home',
    type: AddressType.home,
    flatBuilding: 'Flat 302, Vertex Heights',
    locality: 'Gachibowli',
    streetArea: 'Vertex Heights, Gachibowli',
    city: 'Hyderabad',
    state: 'Telangana',
    pincode: '500032',
    isDefault: true,
  );

  static const DeliveryAddress savedWork = DeliveryAddress(
    id: 'addr_saved_work',
    type: AddressType.work,
    flatBuilding: 'THEKAA Studio, Financial District',
    locality: 'Nanakramguda',
    streetArea: 'Financial District, Nanakramguda',
    city: 'Hyderabad',
    state: 'Telangana',
    pincode: '500032',
    isDefault: false,
  );

  static const DeliveryAddress savedOther = DeliveryAddress(
    id: 'addr_saved_other',
    type: AddressType.other,
    flatBuilding: 'Family home',
    locality: 'Kondapur',
    streetArea: 'Kondapur',
    city: 'Hyderabad',
    state: 'Telangana',
    pincode: '500084',
    isDefault: false,
  );

  static const List<DeliveryAddress> savedProfileAddresses = [
    savedHome,
    savedWork,
    savedOther,
  ];

  static const List<DeliveryAddress> defaultAddresses = [
    defaultHome,
    defaultWork,
    defaultOther,
  ];
}

