import 'package:flutter/material.dart';
import '../models/food_preference.dart';
import '../services/profile_repository.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';

class FoodPreferencesScreen extends StatefulWidget {
  final FoodPreference initialPreference;
  final VoidCallback? onBack;
  final ValueChanged<FoodPreference>? onSavePreferences;
  final ValueChanged<int>? onNavTap;

  const FoodPreferencesScreen({
    super.key,
    this.initialPreference = FoodPreference.defaultPreference,
    this.onBack,
    this.onSavePreferences,
    this.onNavTap,
  });

  @override
  State<FoodPreferencesScreen> createState() => _FoodPreferencesScreenState();
}

class _FoodPreferencesScreenState extends State<FoodPreferencesScreen> {
  late DietaryType _dietaryType;
  late Set<String> _selectedCuisines;
  late TextEditingController _allergiesController;
  late TextEditingController _restrictionsController;

  @override
  void initState() {
    super.initState();
    final pref = widget.initialPreference == FoodPreference.defaultPreference
        ? ProfileRepository.instance.foodPreference
        : widget.initialPreference;
    _dietaryType = pref.dietaryType;
    _selectedCuisines = Set.from(pref.selectedCuisines);
    _allergiesController = TextEditingController(text: pref.allergies);
    _restrictionsController = TextEditingController(text: pref.dietaryRestrictions);
  }

  @override
  void dispose() {
    _allergiesController.dispose();
    _restrictionsController.dispose();
    super.dispose();
  }

  void _toggleCuisine(String cuisine) {
    setState(() {
      if (_selectedCuisines.contains(cuisine)) {
        _selectedCuisines.remove(cuisine);
      } else {
        _selectedCuisines.add(cuisine);
      }
    });
  }

  void _onSave() {
    final updated = FoodPreference(
      dietaryType: _dietaryType,
      selectedCuisines: _selectedCuisines.toList(),
      allergies: _allergiesController.text.trim(),
      dietaryRestrictions: _restrictionsController.text.trim(),
    );
    ProfileRepository.instance.updateFoodPreference(updated);
    widget.onSavePreferences?.call(updated);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Preferences saved'),
        duration: Duration(seconds: 2),
        backgroundColor: ThekaaColors.terracotta,
      ),
    );
    Navigator.of(context).maybePop();
  }

  Widget _buildDietaryCard({
    required DietaryType type,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _dietaryType == type;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _dietaryType = type;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFF5EBDD) : const Color(0xFFFFFDF8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? ThekaaColors.terracotta : const Color(0xFFEADBCE),
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 26,
                color: const Color(0xFF6B4E38),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: ThekaaTypography.sectionHeading.copyWith(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: ThekaaColors.primaryText,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? ThekaaColors.terracotta
                        : const Color(0xFFD8C8B6),
                    width: 1.5,
                  ),
                  color: isSelected ? Colors.transparent : Colors.transparent,
                ),
                child: isSelected
                    ? const Center(
                        child: Icon(
                          Icons.check,
                          size: 13,
                          color: ThekaaColors.terracotta,
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCuisineChip(String cuisine) {
    final isSelected = _selectedCuisines.contains(cuisine);

    return InkWell(
      onTap: () => _toggleCuisine(cuisine),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? ThekaaColors.terracotta : const Color(0xFFFFFDF8),
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? null
              : Border.all(
                  color: const Color(0xFFEADBCE),
                  width: 1.0,
                ),
        ),
        child: Text(
          cuisine,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : ThekaaColors.primaryText,
          ),
        ),
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
                          'Food, your way',
                          style: ThekaaTypography.sectionHeading.copyWith(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: ThekaaColors.primaryText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Description
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Text(
                        'A few things about your taste help us tailor discovery. You can change these anytime.',
                        style: ThekaaTypography.deliveryInfo.copyWith(
                          fontSize: 12,
                          color: ThekaaColors.secondaryText,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Section: What's on your plate?
                    Text(
                      "What's on your plate?",
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 3 Dietary cards
                    Row(
                      children: [
                        _buildDietaryCard(
                          type: DietaryType.veg,
                          icon: Icons.eco_outlined,
                          label: 'Veg',
                        ),
                        const SizedBox(width: 10),
                        _buildDietaryCard(
                          type: DietaryType.nonVeg,
                          icon: Icons.kebab_dining_outlined,
                          label: 'Non-veg',
                        ),
                        const SizedBox(width: 10),
                        _buildDietaryCard(
                          type: DietaryType.eggetarian,
                          icon: Icons.egg_outlined,
                          label: 'Eggetarian',
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Section: Cuisines you love
                    Text(
                      'Cuisines you love',
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Cuisines chips wrap
                    Wrap(
                      spacing: 8,
                      runSpacing: 10,
                      children: FoodPreference.availableCuisines
                          .map(_buildCuisineChip)
                          .toList(),
                    ),
                    const SizedBox(height: 18),

                    // Section: Allergies
                    Text(
                      'Allergies',
                      style: ThekaaTypography.deliveryInfo.copyWith(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFDF8),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFFEADBCE),
                          width: 1.0,
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        controller: _allergiesController,
                        style: ThekaaTypography.searchInput.copyWith(fontSize: 13.5),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Add any ingredients you need to avoid',
                      style: ThekaaTypography.deliveryInfo.copyWith(
                        fontSize: 11.5,
                        color: ThekaaColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Section: Dietary restrictions (optional)
                    Text(
                      'Dietary restrictions (optional)',
                      style: ThekaaTypography.deliveryInfo.copyWith(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFDF8),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFFEADBCE),
                          width: 1.0,
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        controller: _restrictionsController,
                        style: ThekaaTypography.searchInput.copyWith(fontSize: 13.5),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Allergy Warning Card
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6EFE3),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFFEADBCE),
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.info_outline_rounded,
                            size: 20,
                            color: ThekaaColors.terracotta,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Preferences aren't an allergy guarantee",
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF6B4E38),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Always check ingredients with the restaurant. Kitchens may handle common allergens.',
                                  style: ThekaaTypography.deliveryInfo.copyWith(
                                    fontSize: 11.5,
                                    height: 1.3,
                                    color: ThekaaColors.secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Bottom Save preferences button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _onSave,
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
                        'Save preferences',
                        style: ThekaaTypography.sectionHeading.copyWith(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.check,
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

