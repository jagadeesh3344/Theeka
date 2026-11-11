import 'package:flutter/foundation.dart';
import '../models/address.dart';
import '../models/food_preference.dart';
import '../models/user_profile.dart';

/// Single source of truth for the user's profile state.
/// Ensures profile details (name, phone, dob, email, gender),
/// saved addresses, and food preferences persist across navigation.
class ProfileRepository extends ChangeNotifier {
  static final ProfileRepository instance = ProfileRepository._internal();

  ProfileRepository._internal();

  UserProfile _profile = UserProfile.defaultProfile;
  List<DeliveryAddress> _savedAddresses = List.from(DeliveryAddress.savedProfileAddresses);
  FoodPreference _foodPreference = FoodPreference.defaultPreference;

  UserProfile get profile => _profile;
  List<DeliveryAddress> get savedAddresses => List.unmodifiable(_savedAddresses);
  FoodPreference get foodPreference => _foodPreference;

  void updateProfile(UserProfile newProfile) {
    _profile = newProfile;
    notifyListeners();
  }

  void updateFoodPreference(FoodPreference pref) {
    _foodPreference = pref;
    notifyListeners();
  }

  void updateAddress(DeliveryAddress address) {
    final index = _savedAddresses.indexWhere((a) => a.id == address.id);
    if (index >= 0) {
      _savedAddresses[index] = address;
    } else {
      _savedAddresses.add(address);
    }
    notifyListeners();
  }

  void deleteAddress(String id) {
    _savedAddresses.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  void setDefaultAddress(String id) {
    _savedAddresses = _savedAddresses.map((a) {
      return a.copyWith(isDefault: a.id == id);
    }).toList();
    notifyListeners();
  }

  void reset() {
    _profile = UserProfile.defaultProfile;
    _savedAddresses = List.from(DeliveryAddress.savedProfileAddresses);
    _foodPreference = FoodPreference.defaultPreference;
    notifyListeners();
  }
}

