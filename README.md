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

10. **Order Placed Confirmation Screen ("Order placed, bhaiyya.")**
    - Post-payment confirmation receipt without bottom navigation bar.
    - Large circular Dabba container line-art illustration with bottom-right green checkmark badge.
    - Warm cursive message: *"Acha khaana, on its way."*
    - Main heading: *"Order placed, bhaiyya."* with dynamic order tag (`#THK84291 · 01 Nov 2026 · 1:45 PM`).
    - Delivery time estimate card with clock icon: `24–28 min` (`Estimated delivery · 2:09–2:13 PM`).
    - Restaurant order summary card detailing restaurant name, locality, itemized dish rows with quantities and prices, and final confirmed payable amount.
    - Dynamic payment summary note (`Paid ₹655 via UPI · No coins redeemed`).
    - Dual action buttons: `Track order` (with location route icon) and `View order details`.

11. **Order Confirmed / Order Details Screen ("Order confirmed")**
    - Authoritative order details screen opened via "View order details" from the Order Placed screen.
    - Top navigation header: `< Order confirmed` in Playfair Display serif.
    - Centered circular Dabba container badge with bottom-right green verified checkmark.
    - Editorial cursive script note: *"The kitchen has your order."* in Caveat.
    - Header sub-row displaying Order ID (`#THK84291`) and timestamp (`Today, 1:45 PM`).
    - Kitchen status card (pale green): `✓ Confirmed by [Restaurant]` with acceptance copy (*"Your order is accepted. We'll let you know when preparation begins."*).
    - Delivery ETA card with clock icon: `Arriving in 24–28 min` (`Estimated 2:09–2:13 PM`).
    - Itemized order summary card with dishes, item count, coin redemption state, and total price.
    - Full-width terracotta action button: `Track your order` with route icon.
    - Fixed 5-destination bottom navigation bar with **Orders tab active (`currentIndex: 3`)**.

12. **Live Order Tracking Screen ("A little dum, a little time")**
    - Real-time order tracking opened via "Track your order" from the Order Details screen.
    - Top navigation header: `< A little dum, a little time` in Playfair Display serif (`#49362B`).
    - Subheader row displaying Order ID (`#THK84291`) on left and estimated window (`Estimated 2:09–2:13 PM`) on right in terracotta.
    - 5-stage lifecycle progress timeline card:
      1. `Order confirmed` (Completed — dark green checkmark)
      2. `Restaurant preparing food` (In progress — terracotta active dot)
      3. `Rider assigned` (Pending — light beige indicator)
      4. `Out for delivery` (Pending — light beige indicator)
      5. `Delivered` (Pending — light beige indicator)
    - Vertical timeline connecting lines dynamically reflecting completion state.
    - Restaurant status card: Food thumbnail photo, dynamic preparation copy (`[Restaurant] is preparing your meal.`), and dish finishing touch copy (`Your biryani is getting its finishing touch.`).
    - Compact order summary card: Document receipt icon, item count and amount paid (`2 items · ₹655 paid`), and restaurant locality.
    - Fixed bottom action button: `View order details` with warm cream background and terracotta border.
    - Fixed 5-destination bottom navigation bar with **Orders tab active (`currentIndex: 3`)**.

13. **Rider & Delivery Details Screen ("Meet your bhaiyya")**
    - Delivery partner details opened via "View order details" from the Order Tracking screen.
    - Top navigation header: `< Meet your bhaiyya` in Playfair Display serif (`#49362B`).
    - Order meta subheader: `#[ORDER ID] · RIDER ASSIGNED · [TIME]` (e.g. `#THK84291 · RIDER ASSIGNED · 1:53 PM`).
    - Rider profile card:
      - Circular partner photo avatar (or fallback).
      - Partner name (`Ravi K.`), star rating (`4.8`), role (`Your delivery partner`), and security shield badge.
      - Dual equal-width contact buttons: **`Call`** and **`Chat`** with terracotta border and icons.
    - Rider stats row: Delivery count (`1,240 deliveries`) and platform tenure (`2 years with THEKAA`).
    - Status message card: Pale yellow info card (`Ravi is heading to the restaurant` / *"Your food has not been picked up yet. We'll update the status when he's on his way to you."*).
    - Connected Pickup & Drop-off card:
      - Restaurant pickup address (`Pickup · Shadab Biryani`, `Gachibowli, Hyderabad`).
      - Customer drop-off address (`Drop-off · Home`, `Flat 302, Vertex Heights, Gachibowli, Hyderabad 500032`).
    - Estimated arrival row: `Estimated arrival: 2:09–2:13 PM` in bold terracotta.
    - Contained delivery route map preview canvas with pickup and destination markers.
    - Fixed bottom action button: `View order details` navigating to the authoritative Order Details screen for the same order.
    - Fixed 5-destination bottom navigation bar with **Orders tab active (`currentIndex: 3`)**.

14. **Rider Live-Location / Delivery Map Screen ("On the way to you")**
    - High-fidelity live rider tracking opened by tapping the map area in "Meet your bhaiyya".
    - Top navigation header: `< On the way to you` in Playfair Display serif (`#49362B`).
    - Order meta subheader: `#[ORDER ID] · OUT FOR DELIVERY · [TIME]` (e.g. `#THK84291 · OUT FOR DELIVERY · 2:00 PM`).
    - Large live delivery route map (230px height, radius 18):
      - Visual road grid with Gachibowli, Botanical garden, and Old Mumbai Highway.
      - 3 interactive circular location markers: Pickup Restaurant, Live Rider Position, and Drop-off Destination.
      - Prominent terracotta delivery route path connecting restaurant to rider and destination.
      - GPS map control indicator button.
    - ETA & Distance summary card:
      - Left: Big minutes display (`12 min`, `Arriving around 2:12 PM`) with clock icon.
      - Right: Remaining distance (`2.8 km`, `remaining`).
    - Compact Rider profile card with avatar, rating (`⭐ 4.8`), verification shield, and **`Call`** / **`Chat`** action buttons.
    - Delivering to Address card: Customer drop-off address (`Delivering to Home`, `Flat 302, Vertex Heights, Gachibowli, Hyderabad 500032`).
    - Fixed bottom action button: `View order details` returning to `OrderDetailsScreen`.
    - Fixed 5-destination bottom navigation bar with **Orders tab active (`currentIndex: 3`)**.

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
  - `OrderConfirmation` & `OrderItemDetail`
  - `Rider`

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

THEKAA includes a comprehensive test suite covering 57 widget and end-to-end integration scenarios:

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
- ✅ `THEKAA Payment Method Screen Test Suite` (5 tests)
- ✅ `THEKAA Order Placed Confirmation Screen Suite` (3 tests)
- ✅ `THEKAA Order Details / Order Confirmed Screen Suite` (4 tests)
- ✅ `THEKAA Order Tracking Screen Suite` (5 tests)
- ✅ `THEKAA Rider & Delivery Details ("Meet your bhaiyya") Screen Suite` (5 tests)
- ✅ `THEKAA Live Location / On The Way Screen Suite` (4 tests)

---

## 📄 License

This project is licensed under the MIT License.
