import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

class AddressFormFields extends StatelessWidget {
  final TextEditingController flatBuildingController;
  final TextEditingController localityController;
  final TextEditingController streetAreaController;
  final TextEditingController landmarkController;
  final TextEditingController instructionsController;
  final String locationSummary;

  const AddressFormFields({
    super.key,
    required this.flatBuildingController,
    required this.localityController,
    required this.streetAreaController,
    required this.landmarkController,
    required this.instructionsController,
    this.locationSummary = 'Hyderabad, Telangana · 500032',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row 1: Flat / building & Locality
        Row(
          children: [
            Expanded(
              child: _buildField(
                label: 'Flat / building',
                controller: flatBuildingController,
                hintText: '302, Vertex Heights',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildField(
                label: 'Locality',
                controller: localityController,
                hintText: 'Gachibowli',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Row 2: Street / area
        _buildField(
          label: 'Street / area',
          controller: streetAreaController,
          hintText: 'Vertex Heights, Gachibowli',
        ),
        const SizedBox(height: 12),

        // Row 3: Landmark (optional) & Delivery instructions
        Row(
          children: [
            Expanded(
              child: _buildField(
                label: 'Landmark (optional)',
                controller: landmarkController,
                hintText: 'Near main gate',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildField(
                label: 'Delivery instructions',
                controller: instructionsController,
                hintText: 'Call at the gate',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Section H: Location Information summary
        Text(
          locationSummary,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 11.5,
            color: ThekaaColors.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
            color: ThekaaColors.primaryText,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: ThekaaColors.cardBackground,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: ThekaaColors.border,
              width: 1.0,
            ),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              color: ThekaaColors.primaryText,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                color: ThekaaColors.secondaryText.withValues(alpha: 0.6),
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

