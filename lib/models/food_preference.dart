enum DietaryType {
  veg,
  nonVeg,
  eggetarian;

  String get label {
    switch (this) {
      case DietaryType.veg:
        return 'Veg';
      case DietaryType.nonVeg:
        return 'Non-veg';
      case DietaryType.eggetarian:
        return 'Eggetarian';
    }
  }
}

class FoodPreference {
  final DietaryType dietaryType;
  final List<String> selectedCuisines;
  final String allergies;
  final String dietaryRestrictions;

  const FoodPreference({
    this.dietaryType = DietaryType.nonVeg,
    this.selectedCuisines = const ['Biryani', 'South Indian', 'Desserts'],
    this.allergies = 'Peanuts',
    this.dietaryRestrictions = 'Less spicy, where available',
  });

  static const List<String> availableCuisines = [
    'Biryani',
    'South Indian',
    'North Indian',
    'Chinese',
    'Continental',
    'Desserts',
  ];

  FoodPreference copyWith({
    DietaryType? dietaryType,
    List<String>? selectedCuisines,
    String? allergies,
    String? dietaryRestrictions,
  }) {
    return FoodPreference(
      dietaryType: dietaryType ?? this.dietaryType,
      selectedCuisines: selectedCuisines ?? this.selectedCuisines,
      allergies: allergies ?? this.allergies,
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
    );
  }

  static const defaultPreference = FoodPreference();
}

