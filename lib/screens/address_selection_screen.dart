import 'package:flutter/material.dart';
import '../models/address.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';
import '../widgets/address_header.dart';
import '../widgets/delivery_map_painter.dart';
import '../widgets/current_location_row.dart';
import '../widgets/address_type_selector.dart';
import '../widgets/saved_address_card.dart';
import '../widgets/address_action_row.dart';
import '../widgets/address_form_fields.dart';
import 'coins_redemption_screen.dart';

class AddressSelectionScreen extends StatefulWidget {
  final Restaurant restaurant;
  final Map<String, int> cartQuantities;
  final bool isCoinsApplied;
  final DeliveryAddress? initialAddress;
  final VoidCallback? onBack;
  final ValueChanged<DeliveryAddress>? onConfirmAddress;

  const AddressSelectionScreen({
    super.key,
    required this.restaurant,
    required this.cartQuantities,
    this.isCoinsApplied = false,
    this.initialAddress,
    this.onBack,
    this.onConfirmAddress,
  });

  @override
  State<AddressSelectionScreen> createState() => _AddressSelectionScreenState();
}

class _AddressSelectionScreenState extends State<AddressSelectionScreen> {
  late AddressType _selectedType;
  late DeliveryAddress _currentAddress;

  final TextEditingController _flatBuildingController = TextEditingController();
  final TextEditingController _localityController = TextEditingController();
  final TextEditingController _streetAreaController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentAddress = widget.initialAddress ?? DeliveryAddress.defaultHome;
    _selectedType = _currentAddress.type;
    _populateControllers(_currentAddress);
  }

  void _populateControllers(DeliveryAddress address) {
    _flatBuildingController.text = address.flatBuilding;
    _localityController.text = address.locality;
    _streetAreaController.text = address.streetArea;
    _landmarkController.text = address.landmark ?? '';
    _instructionsController.text = address.deliveryInstructions ?? '';
  }

  @override
  void dispose() {
    _flatBuildingController.dispose();
    _localityController.dispose();
    _streetAreaController.dispose();
    _landmarkController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _onTypeChanged(AddressType type) {
    setState(() {
      _selectedType = type;
      switch (type) {
        case AddressType.home:
          _currentAddress = DeliveryAddress.defaultHome;
          break;
        case AddressType.work:
          _currentAddress = DeliveryAddress.defaultWork;
          break;
        case AddressType.other:
          _currentAddress = DeliveryAddress.defaultOther;
          break;
      }
      _populateControllers(_currentAddress);
    });
  }

  void _onUseCurrentLocation() {
    setState(() {
      _localityController.text = 'Gachibowli';
      _streetAreaController.text = 'Vertex Heights, Gachibowli';
      _currentAddress = _currentAddress.copyWith(
        locality: 'Gachibowli',
        streetArea: 'Vertex Heights, Gachibowli',
        city: 'Hyderabad',
        state: 'Telangana',
        pincode: '500032',
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Delivery location updated to: Gachibowli, Hyderabad'),
        duration: Duration(seconds: 2),
        backgroundColor: ThekaaColors.terracotta,
      ),
    );
  }

  void _onAddNewAddress() {
    setState(() {
      _flatBuildingController.clear();
      _localityController.clear();
      _streetAreaController.clear();
      _landmarkController.clear();
      _instructionsController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Enter new address details below'),
        duration: Duration(seconds: 1),
        backgroundColor: ThekaaColors.terracotta,
      ),
    );
  }

  void _onEditSaved() {
    _populateControllers(_currentAddress);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Editing saved ${_currentAddress.typeLabel} address'),
        duration: const Duration(seconds: 1),
        backgroundColor: ThekaaColors.terracotta,
      ),
    );
  }

  void _onConfirm() {
    final finalAddress = _currentAddress.copyWith(
      type: _selectedType,
      flatBuilding: _flatBuildingController.text.trim().isNotEmpty
          ? _flatBuildingController.text.trim()
          : _currentAddress.flatBuilding,
      locality: _localityController.text.trim().isNotEmpty
          ? _localityController.text.trim()
          : _currentAddress.locality,
      streetArea: _streetAreaController.text.trim().isNotEmpty
          ? _streetAreaController.text.trim()
          : _currentAddress.streetArea,
      landmark: _landmarkController.text.trim(),
      deliveryInstructions: _instructionsController.text.trim(),
    );

    if (widget.onConfirmAddress != null) {
      widget.onConfirmAddress!(finalAddress);
    } else {
      double itemTotal = 0.0;
      widget.cartQuantities.forEach((itemId, qty) {
        if (qty > 0) {
          final item = widget.restaurant.menuItems.firstWhere(
            (m) => m.id == itemId,
            orElse: () => MenuItem(
              id: itemId,
              name: 'Item',
              description: '',
              price: 0,
              imagePath: '',
            ),
          );
          itemTotal += item.price * qty;
        }
      });
      final orderValue = itemTotal > 0 ? (itemTotal + widget.restaurant.deliveryFee + 5.0) : 655.0;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CoinsRedemptionScreen(
            restaurant: widget.restaurant,
            cartQuantities: widget.cartQuantities,
            deliveryAddress: finalAddress,
            originalOrderValue: orderValue,
            onBack: () => Navigator.of(context).pop(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // SECTION A — HEADER
                    AddressHeader(
                      onBack: widget.onBack ?? () => Navigator.of(context).maybePop(),
                    ),
                    const SizedBox(height: 14),

                    // SECTION B — DELIVERY MAP
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: ThekaaColors.border,
                          width: 1.0,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: CustomPaint(
                        painter: DeliveryMapPainter(
                          addressType: _selectedType,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // SECTION C — USE CURRENT LOCATION
                    CurrentLocationRow(
                      onTap: _onUseCurrentLocation,
                    ),
                    const SizedBox(height: 14),

                    // SECTION D — ADDRESS TYPE SELECTOR
                    AddressTypeSelector(
                      selectedType: _selectedType,
                      onTypeChanged: _onTypeChanged,
                    ),
                    const SizedBox(height: 14),

                    // SECTION E — SAVED ADDRESS CARD
                    SavedAddressCard(
                      address: _currentAddress,
                      isSelected: true,
                      onTap: () {},
                    ),
                    const SizedBox(height: 12),

                    // SECTION F — ADD NEW ADDRESS & EDIT SAVED
                    AddressActionRow(
                      onAddNewAddress: _onAddNewAddress,
                      onEditSaved: _onEditSaved,
                    ),
                    const SizedBox(height: 12),

                    // SECTION G & H — ADDRESS INPUT FIELDS & LOCATION SUMMARY
                    AddressFormFields(
                      flatBuildingController: _flatBuildingController,
                      localityController: _localityController,
                      streetAreaController: _streetAreaController,
                      landmarkController: _landmarkController,
                      instructionsController: _instructionsController,
                      locationSummary: _currentAddress.locationSummary,
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // SECTION I — FIXED CONFIRM ADDRESS BUTTON
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: ThekaaColors.mainBackground,
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThekaaColors.terracotta,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Confirm ${_currentAddress.typeLabel} address',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.arrow_forward_rounded, size: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

