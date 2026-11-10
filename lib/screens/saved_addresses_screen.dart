import 'package:flutter/material.dart';
import '../models/address.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/delivery_map_painter.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';

class SavedAddressesScreen extends StatefulWidget {
  final List<DeliveryAddress> addresses;
  final VoidCallback? onBack;
  final VoidCallback? onAddAddress;
  final ValueChanged<DeliveryAddress>? onEditAddress;
  final ValueChanged<DeliveryAddress>? onDeleteAddress;
  final ValueChanged<DeliveryAddress>? onSetDefaultAddress;
  final ValueChanged<int>? onNavTap;

  const SavedAddressesScreen({
    super.key,
    this.addresses = DeliveryAddress.savedProfileAddresses,
    this.onBack,
    this.onAddAddress,
    this.onEditAddress,
    this.onDeleteAddress,
    this.onSetDefaultAddress,
    this.onNavTap,
  });

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  late List<DeliveryAddress> _addresses;

  @override
  void initState() {
    super.initState();
    _addresses = List.from(widget.addresses);
  }

  IconData _iconForType(AddressType type) {
    switch (type) {
      case AddressType.home:
        return Icons.home_outlined;
      case AddressType.work:
        return Icons.work_outline_rounded;
      case AddressType.other:
        return Icons.place_outlined;
    }
  }

  String _formatAddress(DeliveryAddress addr) {
    return '${addr.flatBuilding}, ${addr.locality}, ${addr.city} ${addr.pincode}';
  }

  void _handleSetDefault(DeliveryAddress target) {
    setState(() {
      _addresses = _addresses.map((addr) {
        return addr.copyWith(isDefault: addr.id == target.id);
      }).toList();
    });
    widget.onSetDefaultAddress?.call(target);
  }

  Widget _buildAddressCard(DeliveryAddress address) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
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
          // Header row with icon, title, and default badge
          Row(
            children: [
              Icon(
                _iconForType(address.type),
                size: 20,
                color: const Color(0xFF6B4E38),
              ),
              const SizedBox(width: 8),
              Text(
                address.typeLabel,
                style: ThekaaTypography.sectionHeading.copyWith(
                  fontFamily: 'Inter',
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: ThekaaColors.primaryText,
                ),
              ),
              const Spacer(),
              if (address.isDefault)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: ThekaaColors.terracotta,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Default',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),

          // Address details
          Text(
            _formatAddress(address),
            style: ThekaaTypography.deliveryInfo.copyWith(
              fontSize: 12.5,
              height: 1.35,
              color: ThekaaColors.primaryText,
            ),
          ),
          const SizedBox(height: 12),

          // Actions row: Edit, Delete, Set as default
          Row(
            children: [
              InkWell(
                onTap: () => widget.onEditAddress?.call(address),
                child: Text(
                  'Edit',
                  style: ThekaaTypography.captionText.copyWith(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: ThekaaColors.terracotta,
                  ),
                ),
              ),
              const SizedBox(width: 18),
              InkWell(
                onTap: () => widget.onDeleteAddress?.call(address),
                child: Text(
                  'Delete',
                  style: ThekaaTypography.deliveryInfo.copyWith(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF8F7D6D),
                  ),
                ),
              ),
              if (!address.isDefault) ...[
                const SizedBox(width: 18),
                InkWell(
                  onTap: () => _handleSetDefault(address),
                  child: Text(
                    'Set as default',
                    style: ThekaaTypography.captionText.copyWith(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: ThekaaColors.terracotta,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Header row: Back arrow & Title
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
                          'Your familiar places',
                          style: ThekaaTypography.sectionHeading.copyWith(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: ThekaaColors.primaryText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Map Section
                    Container(
                      height: 170,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFEADBCE),
                          width: 1.0,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: CustomPaint(
                              painter: DeliveryMapPainter(
                                addressType: AddressType.home,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 12,
                            bottom: 12,
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFFEADBCE),
                                  width: 1.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.06),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.gps_fixed,
                                  size: 17,
                                  color: ThekaaColors.terracotta,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Saved Address Cards
                    ..._addresses.map(_buildAddressCard),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            // Bottom Add a new address button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: widget.onAddAddress,
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
                        'Add a new address',
                        style: ThekaaTypography.sectionHeading.copyWith(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.add,
                        size: 19,
                        color: Colors.white,
                      ),
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
