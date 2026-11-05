# THEKAA (ठेका) — Food Discovery & Ordering Mobile App

> **"Khaana, Samajh Kar."** — Hyderabad, one plate at a time.

An editorial, premium Hyderabad food discovery and ordering mobile application built with **Flutter & Dart**, replicating handcrafted culinary editorial experiences with high fidelity, rich interactions, and full state management.

---

## 🌟 Application Journey & Features

1. **Editorial Home Screen (`01 / FOOD DISCOVERY & ORDERING`)**
   - Elegant header with Charminar architectural line art illustration.
   - Urdu / Devanagari typography with Playfair Display serifs and Caveat handwritten accents.
   - Interactive styled food map preview with local landmarks (Gachibowli, Botanical Garden, Old Mumbai Highway).
   - "Handpicked for you" culinary cards with real-time rating badges and delivery ETA.
   - Fixed 5-destination bottom navigation bar (Home, Explore, DABBA, Orders, Profile).

2. **Explore Hyderabad Screen**
   - Context-aware exploration dynamically routed from home cards (e.g., Shadab Biryani, Chutneys).
   - Map View / List View dual toggle.
   - Filter chips (`Cuisine`, `₹ Price`, `Within 3 km`).
   - Nearby hidden gems showcase.

3. **Restaurant Details Screen**
   - Reusable across any Hyderabad restaurant.
   - High-resolution hero imagery with verified kitchen indicators.
   - Social proof metrics: `12K+ happy diners`, `96% loved the food`, `Since 1990 Hyderabadi roots`.
   - Rich tabbed views: Menu, Reviews, About.
   - Floating "Explore the menu →" action button.

4. **Restaurant Menu Screen**
   - Category rail (Bestsellers, Biryani, Starters, Breads, Desserts, Beverages).
   - Dish cards with non-veg / veg badges, descriptions, and stepper quantity controls (`+` / `-`).
   - Sticky bottom cart bar displaying total item count, price, and "View cart →".

5. **Cart Screen ("Your dabba awaits")**
   - Multi-item management with increment/decrement and trash deletion.
   - Quick "Add more from [Restaurant]" navigation.
   - THEKAA Coins integration card (`Your 1,200 THEKAA Coins`).
   - Reactive bill breakdown (Item total, Delivery fee, Platform fee, To pay).

6. **Review Your Order Screen (`02 / CHECKOUT & PAYMENT`)**
   - Minimalist stepper trail: `REVIEW → ADDRESS → COINS → PAY`.
   - Compact order summary cards with inline quantity adjustments.
   - "Add more items" navigation.

7. **Address Selection Screen ("Where's your table?")**
   - Interactive stylized delivery map canvas with drop pin.
   - "Use current location" with GPS coordinates.
   - Category switcher: `Home`, `Work`, `Other`.
   - Selected address card with radio check indicator and editable delivery instructions form.

8. **Coins Redemption Screen ("A little give-back")**
   - 1,200 TKC balance showcase.
   - Stepper redemption control with real-time conversion quotes.
   - Reversible discount application with dynamic payable recalculation.
   - "Continue without coins" alternative checkout pathway.

9. **Payment Method Screen ("One last thing")**
   - Final checkout payment selection screen without bottom navigation bar.
   - Large amount payable card with verified security shield and dynamic order/address summary (`Shadab Biryani · 2 items · Delivery to Home`).
   - "Choose how to pay" section with expanded UPI method:
     - Provider chips: `Google Pay`, `PhonePe`, `Paytm`.
     - Editable UPI ID text field with terracotta active border.
   - Alternative payment methods: `Debit / credit card`, `Net banking`, `Cash on delivery`.
   - Dynamic security note (`Secure payment · No coins redeemed`).
   - Full-width fixed action button: `Confirm & pay ₹655` with lock icon.

---

## 🛠️ Tech Stack & Architecture

- **Framework**: [Flutter](https://flutter.dev) (Dart 3.x)
- **Typography**: Google Fonts (Playfair Display, Inter, Caveat)
- **Icons**: Cupertino Icons & Material Design
- **Architecture**: Domain-driven widget tree with unidirectional state flow and reusable data models:
  - `Restaurant` & `Dish`
  - `CartItem` & `Cart`
  - `Address` & `AddressType`
  - `ThekaaLoyaltyQuote`
  - `PaymentDetails` & `PaymentMethodType`

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (>= 3.0.0)
- Android Studio / Xcode / VS Code with Flutter extension
- Windows / macOS / Linux

### Installation

```bash
# 1. Clone repository
git clone https://github.com/jagadeesh3344/Theeka.git
cd Theeka

# 2. Get dependencies
flutter pub get

# 3. Run automated tests
flutter test

# 4. Launch application
flutter run
```

---

## 🧪 Automated Test Suite

THEKAA includes a comprehensive test suite covering 35 widget and end-to-end integration scenarios:

```bash
flutter test test/thekaa_test.dart
```

- ✅ `THEKAA Home Screen & Components Test Suite` (6 tests)
- ✅ `THEKAA Explore Hyderabad & Contextual Navigation Suite` (4 tests)
- ✅ `THEKAA Restaurant Details & Menu Test Suite` (3 tests)
- ✅ `THEKAA Cart Screen Test Suite` (5 tests)
- ✅ `THEKAA Review Your Order / Checkout Test Suite` (4 tests)
- ✅ `THEKAA Address Selection Screen Test Suite` (4 tests)
- ✅ `THEKAA Coins Redemption Screen Test Suite` (5 tests)
- ✅ `THEKAA Payment Method Screen Test Suite` (4 tests)

---

## 📄 License

This project is licensed under the MIT License.
