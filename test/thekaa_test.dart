import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:thekaa/main.dart';
import 'package:thekaa/models/restaurant.dart';
import 'package:thekaa/models/address.dart';
import 'package:thekaa/widgets/hero_introduction.dart';
import 'package:thekaa/widgets/food_map_section.dart';
import 'package:thekaa/widgets/thekaa_bottom_nav_bar.dart';
import 'package:thekaa/screens/home_screen.dart';
import 'package:thekaa/screens/explore_screen.dart';
import 'package:thekaa/screens/restaurant_details_screen.dart';
import 'package:thekaa/screens/restaurant_menu_screen.dart';
import 'package:thekaa/screens/cart_screen.dart';
import 'package:thekaa/screens/review_order_screen.dart';
import 'package:thekaa/screens/address_selection_screen.dart';
import 'package:thekaa/screens/coins_redemption_screen.dart';
import 'package:thekaa/screens/payment_screen.dart';
import 'package:thekaa/screens/order_placed_screen.dart';
import 'package:thekaa/models/payment_method.dart';
import 'package:thekaa/models/order_confirmation.dart';
import 'package:thekaa/widgets/map_list_selector.dart';
import 'package:thekaa/widgets/explore_restaurant_card.dart';

void main() {
  group('THEKAA Home Screen & Components Test Suite', () {
    testWidgets('Header displays eyebrow, brand title, tagline, and location', (tester) async {
      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      expect(find.text('01 / FOOD DISCOVERY & ORDERING'), findsWidgets);
      expect(find.text('THEKAA'), findsOneWidget);
      expect(find.text('KHAANA. SAMJH KE.'), findsOneWidget);
      expect(find.text('Gachibowli'), findsWidgets);
      expect(find.byIcon(Icons.notifications_none_outlined), findsOneWidget);
    });

    testWidgets('Search bar accepts text and has filter icon', (tester) async {
      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      final searchField = find.byType(TextField);
      expect(searchField, findsWidgets);
      expect(find.text('Search dishes, places, cravings'), findsOneWidget);

      await tester.enterText(searchField.first, 'Dum Biryani');
      await tester.pump();
      expect(find.text('Dum Biryani'), findsOneWidget);

      expect(find.byIcon(Icons.tune), findsWidgets);
    });

    testWidgets('Hero section displays Urdu/Hindi heading, cursive tagline, and monument', (tester) async {
      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      expect(find.text('Aaj kya mangoge\nbhaiyya?'), findsOneWidget);
      expect(find.text('Hyderabad, one plate at a time.'), findsOneWidget);
      expect(find.byType(HeroIntroduction), findsOneWidget);
    });

    testWidgets('Today\'s Food Map section renders title, action, and map canvas', (tester) async {
      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      expect(find.text("Today's Food Map"), findsOneWidget);
      expect(find.text('Explore map ↗'), findsOneWidget);
      expect(find.byType(FoodMapSection), findsOneWidget);
    });

    testWidgets('Handpicked section displays Shadab Biryani and Chutneys', (tester) async {
      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      expect(find.text('Handpicked for you'), findsOneWidget);
      expect(find.text('See all'), findsOneWidget);
      expect(find.descendant(of: find.byType(HomeScreen), matching: find.text('Shadab Biryani')), findsOneWidget);
      expect(find.descendant(of: find.byType(HomeScreen), matching: find.text('Chutneys')), findsOneWidget);
    });

    testWidgets('Fixed bottom navigation displays 5 items and switches tabs correctly', (tester) async {
      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      expect(find.byType(ThekaaBottomNavBar), findsWidgets);
      expect(find.text('Home'), findsWidgets);
      expect(find.text('Explore'), findsWidgets);
      expect(find.text('DABBA'), findsWidgets);
      expect(find.text('Orders'), findsWidgets);
      expect(find.text('Profile'), findsWidgets);

      // Tap Explore tab
      await tester.tap(find.text('Explore').first);
      await tester.pumpAndSettle();
      expect(find.text('Explore Hyderabad'), findsOneWidget);

      // Tap DABBA tab -> opens Cart
      await tester.tap(find.text('DABBA').first);
      await tester.pumpAndSettle();
      expect(find.text('Your dabba awaits'), findsOneWidget);

      // Tap Orders tab
      await tester.tap(find.text('Orders').first);
      await tester.pumpAndSettle();
      expect(find.text('Your Orders'), findsOneWidget);

      // Tap Profile tab
      await tester.tap(find.text('Profile').first);
      await tester.pumpAndSettle();
      expect(find.text('Hyderabad Foodie'), findsOneWidget);

      // Return to Home tab
      await tester.tap(find.text('Home').first);
      await tester.pumpAndSettle();
      expect(find.text('THEKAA'), findsOneWidget);
    });
  });

  group('THEKAA Explore Hyderabad & Contextual Navigation Suite', () {
    testWidgets('Direct Explore screen renders all sections from reference screenshot', (tester) async {
      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      // Tap Explore tab on bottom bar
      await tester.tap(find.text('Explore').first);
      await tester.pumpAndSettle();

      expect(find.byType(ExploreScreen), findsOneWidget);
      expect(find.text('Explore Hyderabad'), findsOneWidget);
      expect(find.text('Find your next hidden gem'), findsOneWidget);
      expect(find.text('Around Gachibowli'), findsOneWidget);
      expect(find.text('Map'), findsOneWidget);
      expect(find.text('List'), findsOneWidget);
      expect(find.text('Within 3 km'), findsOneWidget);
      expect(find.text('Nearby hidden gems'), findsOneWidget);
      expect(find.text('View all'), findsOneWidget);
    });

    testWidgets('CRITICAL: Tapping Chutneys on Home navigates to Explore with Chutneys context', (tester) async {
      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      final homeChutneys = find.descendant(of: find.byType(HomeScreen), matching: find.text('Chutneys'));
      expect(homeChutneys, findsOneWidget);
      await tester.scrollUntilVisible(homeChutneys, 200, scrollable: find.byType(Scrollable).first);
      await tester.pumpAndSettle();

      await tester.tap(homeChutneys);
      await tester.pumpAndSettle();

      // Verify we navigated to Explore Hyderabad
      expect(find.text('Explore Hyderabad'), findsOneWidget);

      // Verify the result card dynamically displays Chutneys
      final exploreCards = find.byType(ExploreRestaurantCard);
      expect(exploreCards, findsOneWidget);
      expect(find.descendant(of: exploreCards, matching: find.text('Chutneys')), findsOneWidget);
      expect(find.text('2.1 km · South Indian · ₹₹'), findsOneWidget);

      // Verify Nearby Hidden Gems displays Shadab Biryani instead of Chutneys
      expect(find.text('Nearby hidden gems'), findsOneWidget);
      expect(find.descendant(of: find.byType(ExploreScreen), matching: find.text('Shadab Biryani')), findsOneWidget);
    });

    testWidgets('CRITICAL: Tapping Shadab Biryani on Home navigates to Explore with Shadab Biryani context', (tester) async {
      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      final homeShadab = find.descendant(of: find.byType(HomeScreen), matching: find.text('Shadab Biryani'));
      expect(homeShadab, findsOneWidget);
      await tester.scrollUntilVisible(homeShadab, 150, scrollable: find.byType(Scrollable).first);
      await tester.pumpAndSettle();

      await tester.tap(homeShadab);
      await tester.pumpAndSettle();

      // Verify we navigated to Explore Hyderabad
      expect(find.text('Explore Hyderabad'), findsOneWidget);

      // Verify the result card dynamically displays Shadab Biryani
      final exploreCards = find.byType(ExploreRestaurantCard);
      expect(exploreCards, findsOneWidget);
      expect(find.descendant(of: exploreCards, matching: find.text('Shadab Biryani')), findsOneWidget);
      expect(find.text('1.4 km · Biryani · ₹₹'), findsOneWidget);
    });

    testWidgets('Map / List selector toggles between Map preview and List view', (tester) async {
      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      // Navigate to Explore
      await tester.tap(find.text('Explore').first);
      await tester.pumpAndSettle();

      expect(find.byType(MapListSelector), findsOneWidget);

      // Tap List view
      await tester.tap(find.text('List'));
      await tester.pumpAndSettle();

      expect(find.text('All Recommendations in Gachibowli'), findsOneWidget);

      // Tap Map view
      await tester.tap(find.text('Map'));
      await tester.pumpAndSettle();

      expect(find.text('Nearby hidden gems'), findsOneWidget);
    });
  });

  group('THEKAA Restaurant Details & Menu Test Suite', () {
    testWidgets('Renders all sections for Shadab Biryani accurately', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RestaurantDetailsScreen(
            restaurant: Restaurant.shadabBiryani,
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('01 / FOOD DISCOVERY & ORDERING'), findsOneWidget);
      expect(find.text('Shadab Biryani'), findsWidgets);
      expect(find.byIcon(Icons.chevron_left_rounded), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border_rounded), findsOneWidget);

      // Rating & Info
      expect(find.text('4.8'), findsWidgets);
      expect(find.text(' (1.2K)'), findsOneWidget);
      expect(find.text('THEKAA verified'), findsOneWidget);
      expect(find.text('Gachibowli · 24–28 min · ₹30 delivery'), findsOneWidget);

      // Statistics
      expect(find.text('12K+'), findsOneWidget);
      expect(find.text('happy diners'), findsOneWidget);
      expect(find.text('96%'), findsOneWidget);
      expect(find.text('loved the food'), findsOneWidget);
      expect(find.text('Since 1990'), findsOneWidget);
      expect(find.text('Hyderabadi roots'), findsOneWidget);

      // Description & Tags
      expect(find.text('Slow-cooked dum, fragrant rice, and recipes that feel like home. A local favourite for a proper Hyderabadi meal.'), findsOneWidget);
      expect(find.text('Hyderabadi'), findsOneWidget);
      expect(find.text('Biryani'), findsWidgets);
      expect(find.text('Mughlai'), findsOneWidget);

      // Tabs
      expect(find.text('Menu'), findsOneWidget);
      expect(find.text('Reviews'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);

      // Bestsellers under Menu
      expect(find.text('Bestsellers'), findsOneWidget);
      expect(find.text('Chicken Dum Biryani'), findsOneWidget);

      // Fixed button
      expect(find.text('Explore the menu'), findsOneWidget);
    });

    testWidgets('CRITICAL: Screen reusability with Chutneys displays Chutneys data exclusively', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RestaurantDetailsScreen(
            restaurant: Restaurant.chutneys,
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Chutneys dynamic data
      expect(find.text('Chutneys'), findsWidgets);
      expect(find.text('4.7'), findsWidgets);
      expect(find.text(' (2.4K)'), findsOneWidget);

      // Chutneys statistics
      expect(find.text('18K+'), findsOneWidget);
      expect(find.text('98%'), findsOneWidget);
      expect(find.text('Since 1995'), findsOneWidget);
      expect(find.text('Tiffin heritage'), findsOneWidget);

      // Chutneys cuisine tags
      expect(find.text('South Indian'), findsOneWidget);
      expect(find.text('Tiffins'), findsOneWidget);
      expect(find.text('Andhra'), findsOneWidget);

      // Chutneys bestsellers
      expect(find.text('Ghee Karam Dosa'), findsOneWidget);
      expect(find.text('Babai Idli with Butter'), findsOneWidget);

      // Ensure NO Shadab Biryani content is leaked
      expect(find.text('Shadab Biryani'), findsNothing);
      expect(find.text('Hyderabadi roots'), findsNothing);
    });

    testWidgets('Tabs switch between Menu, Reviews, and About correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RestaurantDetailsScreen(
            restaurant: Restaurant.shadabBiryani,
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Ensure Reviews tab is visible before tapping
      final reviewsTab = find.text('Reviews');
      await tester.scrollUntilVisible(reviewsTab, 150);
      await tester.pumpAndSettle();

      // Switch to Reviews tab
      await tester.tap(reviewsTab);
      await tester.pumpAndSettle();
      expect(find.text('Customer Reviews'), findsOneWidget);
      expect(find.text('Arjun K.'), findsOneWidget);

      // Switch to About tab
      final aboutTab = find.text('About');
      await tester.tap(aboutTab);
      await tester.pumpAndSettle();
      expect(find.text('About Shadab Biryani'), findsOneWidget);

      // Switch back to Menu tab
      final menuTab = find.text('Menu');
      await tester.tap(menuTab);
      await tester.pumpAndSettle();
      expect(find.text('Bestsellers'), findsOneWidget);
    });
  });

  group('THEKAA Cart Screen Test Suite', () {
    testWidgets('Renders Cart screen for Shadab Biryani matching reference screenshot', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CartScreen(
            restaurant: Restaurant.shadabBiryani,
            initialQuantities: {
              'chicken_dum_biryani': 1,
              'mutton_biryani': 1,
            },
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Section A: Header
      expect(find.text('01 / FOOD DISCOVERY & ORDERING'), findsOneWidget);
      expect(find.text('Your dabba awaits'), findsOneWidget);

      // Section B: Restaurant Identification
      expect(find.text('Shadab Biryani'), findsOneWidget);
      expect(find.text('Gachibowli · 24–28 min'), findsOneWidget);

      // Section C: Selected items
      expect(find.text('Chicken Dum Biryani'), findsOneWidget);
      expect(find.text('Serves 1 · Non-veg'), findsWidgets);
      expect(find.text('₹280'), findsOneWidget);

      expect(find.text('Mutton Biryani'), findsOneWidget);
      expect(find.text('₹340'), findsOneWidget);

      // Section D: Add more
      expect(find.text('Add more from Shadab'), findsOneWidget);

      // Section E: Coins
      expect(find.text('Your 1,200 THEKAA Coins'), findsOneWidget);
      expect(find.text('Rate and limit confirmed at checkout'), findsOneWidget);
      expect(find.text('Use coins'), findsOneWidget);

      // Section F: Bill details
      expect(find.text('Bill details'), findsOneWidget);
      expect(find.text('Item total'), findsOneWidget);
      expect(find.text('₹620'), findsOneWidget);
      expect(find.text('Delivery fee'), findsOneWidget);
      expect(find.text('₹30'), findsOneWidget);
      expect(find.text('Platform fee'), findsOneWidget);
      expect(find.text('₹5'), findsOneWidget);
      expect(find.text('To pay · no coins applied'), findsOneWidget);
      expect(find.text('₹655'), findsWidgets);

      // Section G: Fixed Checkout Button
      expect(find.text('Proceed to checkout · ₹655'), findsOneWidget);

      // Section H: Bottom navigation has DABBA
      expect(find.text('DABBA'), findsOneWidget);
    });

    testWidgets('CRITICAL: Cart reusability with Chutneys calculates correct totals', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CartScreen(
            restaurant: Restaurant.chutneys,
            initialQuantities: {
              'ghee_karam_dosa': 1,
              'babai_idli': 1,
            },
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Restaurant
      expect(find.text('Chutneys'), findsOneWidget);
      expect(find.text('Add more from Chutneys'), findsOneWidget);

      // Items
      expect(find.text('Ghee Karam Dosa'), findsOneWidget);
      expect(find.text('Babai Idli with Butter'), findsOneWidget);
      expect(find.text('₹180'), findsOneWidget);
      expect(find.text('₹120'), findsOneWidget);

      // Calculations: 180 + 120 = 300 item total + 25 delivery + 5 platform = 330
      expect(find.text('₹300'), findsOneWidget);
      expect(find.text('₹25'), findsOneWidget);
      expect(find.text('₹330'), findsWidgets);
      expect(find.text('Proceed to checkout · ₹330'), findsOneWidget);

      // Ensure no Shadab Biryani content
      expect(find.text('Shadab Biryani'), findsNothing);
      expect(find.text('Add more from Shadab'), findsNothing);
    });

    testWidgets('Interactive quantity changes update bill and checkout button immediately', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CartScreen(
            restaurant: Restaurant.shadabBiryani,
            initialQuantities: {
              'chicken_dum_biryani': 1,
              'mutton_biryani': 1,
            },
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Proceed to checkout · ₹655'), findsOneWidget);

      // Tap plus on first item (Chicken Dum Biryani: 280 -> 560)
      final plusButtons = find.byIcon(Icons.add);
      await tester.tap(plusButtons.first);
      await tester.pumpAndSettle();

      // New item total: 560 + 340 = 900. Total payable: 900 + 30 + 5 = 935
      expect(find.text('₹560'), findsOneWidget);
      expect(find.text('₹900'), findsOneWidget);
      expect(find.text('Proceed to checkout · ₹935'), findsOneWidget);

      // Tap delete on second item (Mutton Biryani removed)
      final deleteButtons = find.byIcon(Icons.delete_outline_rounded);
      await tester.tap(deleteButtons.last);
      await tester.pumpAndSettle();

      // Now only Chicken Biryani (2 qty = 560). Total payable: 560 + 30 + 5 = 595
      expect(find.text('₹560'), findsNWidgets(2));
      expect(find.text('Mutton Biryani'), findsNothing);
      expect(find.text('Proceed to checkout · ₹595'), findsOneWidget);
    });

    testWidgets('Toggling THEKAA coins updates payable amount', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CartScreen(
            restaurant: Restaurant.shadabBiryani,
            initialQuantities: {
              'chicken_dum_biryani': 1,
              'mutton_biryani': 1,
            },
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Proceed to checkout · ₹655'), findsOneWidget);

      // Tap Use coins
      await tester.tap(find.text('Use coins'));
      await tester.pumpAndSettle();

      expect(find.text('Coins used'), findsOneWidget);
      expect(find.text('To pay · coins applied'), findsOneWidget);
      // 655 - 50 = 605
      expect(find.text('Proceed to checkout · ₹605'), findsOneWidget);
    });

    testWidgets('End-to-end: Menu -> View cart -> Cart Screen -> Add more returns to Menu', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RestaurantMenuScreen(
            restaurant: Restaurant.shadabBiryani,
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Find View cart button and tap it
      expect(find.text('View cart'), findsOneWidget);
      await tester.tap(find.text('View cart'));
      await tester.pumpAndSettle();

      // Cart screen is open
      expect(find.byType(CartScreen), findsOneWidget);
      expect(find.text('Your dabba awaits'), findsOneWidget);
      expect(find.text('Add more from Shadab'), findsOneWidget);

      // Tap Add more from Shadab
      await tester.tap(find.text('Add more from Shadab'));
      await tester.pumpAndSettle();

      // Returned to Menu screen
      expect(find.byType(RestaurantMenuScreen), findsOneWidget);
      expect(find.text('The menu'), findsOneWidget);
    });
  });

  group('THEKAA Review Your Order / Checkout Test Suite', () {
    testWidgets('Renders Review your order screen matching reference screenshot', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ReviewOrderScreen(
            restaurant: Restaurant.shadabBiryani,
            initialCartQuantities: const {
              'chicken_dum_biryani': 1,
              'mutton_biryani': 1,
            },
            isCoinsApplied: false,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Eyebrow and heading
      expect(find.text('02 / CHECKOUT & PAYMENT'), findsOneWidget);
      expect(find.text('Review your order'), findsOneWidget);

      // Breadcrumb steps
      expect(find.text('REVIEW'), findsOneWidget);
      expect(find.text('ADDRESS'), findsOneWidget);
      expect(find.text('COINS'), findsOneWidget);
      expect(find.text('PAY'), findsOneWidget);

      // Restaurant info
      expect(find.text('Shadab Biryani'), findsOneWidget);
      expect(find.text('Gachibowli · 2 items'), findsOneWidget);

      // Dishes
      expect(find.text('Chicken Dum Biryani'), findsOneWidget);
      expect(find.text('Mutton Biryani'), findsOneWidget);
      expect(find.text('BESTSELLER'), findsNWidgets(2));
      expect(find.text('Add more items'), findsOneWidget);

      // Bill details
      expect(find.text('Bill details'), findsOneWidget);
      expect(find.text('Item total'), findsOneWidget);
      expect(find.text('Delivery fee'), findsOneWidget);
      expect(find.text('Platform fee'), findsOneWidget);
      expect(find.text('Coins redeemed'), findsOneWidget);
      expect(find.text('0 TKC'), findsOneWidget);
      expect(find.text('To pay'), findsOneWidget);

      // Values
      expect(find.text('₹620'), findsOneWidget);
      expect(find.text('₹30'), findsOneWidget);
      expect(find.text('₹5'), findsOneWidget);
      expect(find.text('₹655'), findsOneWidget); // to pay

      // Sticky CTA
      expect(find.text('Continue · ₹655'), findsOneWidget);
    });

    testWidgets('CRITICAL: Screen reusability with Chutneys calculates correct totals', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ReviewOrderScreen(
            restaurant: Restaurant.chutneys,
            initialCartQuantities: const {
              'ghee_karam_dosa': 1,
              'babai_idli': 1,
            },
            isCoinsApplied: false,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Chutneys'), findsOneWidget);
      expect(find.text('Gachibowli · 2 items'), findsOneWidget);
      expect(find.text('Ghee Karam Dosa'), findsOneWidget);
      expect(find.text('Babai Idli with Butter'), findsOneWidget);

      // Item total 180 + 120 = 300, Delivery fee = 25, Platform = 5 -> To pay = 330
      expect(find.text('₹300'), findsOneWidget);
      expect(find.text('₹25'), findsOneWidget);
      expect(find.text('₹330'), findsOneWidget);
      expect(find.text('Continue · ₹330'), findsOneWidget);
    });

    testWidgets('Interactive quantity changes update bill and Continue button in real time', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ReviewOrderScreen(
            restaurant: Restaurant.shadabBiryani,
            initialCartQuantities: const {
              'chicken_dum_biryani': 1,
              'mutton_biryani': 1,
            },
            isCoinsApplied: false,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Continue · ₹655'), findsOneWidget);

      // Increment Chicken Biryani (+1)
      final plusIcons = find.byIcon(Icons.add);
      await tester.tap(plusIcons.first);
      await tester.pumpAndSettle();

      // Total becomes 280*2 + 340 + 30 + 5 = 560 + 340 + 35 = 935
      expect(find.text('Continue · ₹935'), findsOneWidget);
    });

    testWidgets('End-to-end: Cart screen Proceed to checkout navigates to Review your order', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CartScreen(
            restaurant: Restaurant.shadabBiryani,
            initialQuantities: const {
              'chicken_dum_biryani': 1,
              'mutton_biryani': 1,
            },
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Proceed to checkout · ₹655
      await tester.tap(find.text('Proceed to checkout · ₹655'));
      await tester.pumpAndSettle();

      // Should be on ReviewOrderScreen
      expect(find.byType(ReviewOrderScreen), findsOneWidget);
      expect(find.text('Review your order'), findsOneWidget);
      expect(find.text('Continue · ₹655'), findsOneWidget);

      // Tap back button
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      // Back on CartScreen
      expect(find.byType(CartScreen), findsOneWidget);
      expect(find.text('Your dabba awaits'), findsOneWidget);
    });
  });

  group('THEKAA Address Selection Screen Test Suite', () {
    testWidgets('Renders Address Selection screen matching reference screenshot', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AddressSelectionScreen(
            restaurant: Restaurant.shadabBiryani,
            cartQuantities: const {
              'chicken_dum_biryani': 1,
              'mutton_biryani': 1,
            },
            isCoinsApplied: false,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Section A: Header
      expect(find.text("Where's your table?"), findsOneWidget);

      // Section B: Delivery Map
      expect(find.byType(CustomPaint), findsWidgets);

      // Section C: Use current location
      expect(find.text('Use current location'), findsOneWidget);
      expect(find.text('Gachibowli, Hyderabad'), findsOneWidget);

      // Section D: Address type selector
      expect(find.text('Home'), findsWidgets);
      expect(find.text('Work'), findsOneWidget);
      expect(find.text('Other'), findsOneWidget);

      // Section E: Saved address card
      expect(find.text('Home · Default'), findsOneWidget);
      expect(find.textContaining('302, Vertex Heights'), findsWidgets);

      // Section F: Add / edit actions
      expect(find.text('+ Add a new address'), findsOneWidget);
      expect(find.text('Edit saved'), findsOneWidget);

      // Section G: Form fields labels
      expect(find.text('Flat / building'), findsOneWidget);
      expect(find.text('Locality'), findsOneWidget);
      expect(find.text('Street / area'), findsOneWidget);
      expect(find.text('Landmark (optional)'), findsOneWidget);
      expect(find.text('Delivery instructions'), findsOneWidget);

      // Section H: Location summary
      expect(find.text('Hyderabad, Telangana · 500032'), findsOneWidget);

      // Section I: Dynamic confirmation button
      expect(find.text('Confirm Home address'), findsOneWidget);
    });

    testWidgets('Switching address type updates card, form, and button dynamically', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AddressSelectionScreen(
            restaurant: Restaurant.shadabBiryani,
            cartQuantities: const {
              'chicken_dum_biryani': 1,
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Confirm Home address'), findsOneWidget);

      // Tap Work
      await tester.tap(find.text('Work'));
      await tester.pumpAndSettle();

      expect(find.text('Work'), findsWidgets);
      expect(find.text('Confirm Work address'), findsOneWidget);
      expect(find.textContaining('Mindspace IT Park'), findsWidgets);

      // Tap Other
      await tester.tap(find.text('Other'));
      await tester.pumpAndSettle();

      expect(find.text('Other'), findsWidgets);
      expect(find.text('Confirm Other address'), findsOneWidget);
      expect(find.textContaining('Jubilee Hills'), findsWidgets);
    });

    testWidgets('Tapping + Add a new address clears fields for input', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AddressSelectionScreen(
            restaurant: Restaurant.shadabBiryani,
            cartQuantities: const {
              'chicken_dum_biryani': 1,
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap + Add a new address
      await tester.tap(find.text('+ Add a new address'));
      await tester.pumpAndSettle();

      expect(find.text('Enter new address details below'), findsOneWidget);
    });

    testWidgets('End-to-end: Review your order -> Continue -> Address Selection -> Back returns to Review', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ReviewOrderScreen(
            restaurant: Restaurant.shadabBiryani,
            initialCartQuantities: const {
              'chicken_dum_biryani': 1,
              'mutton_biryani': 1,
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Continue · ₹655
      expect(find.text('Continue · ₹655'), findsOneWidget);
      await tester.tap(find.text('Continue · ₹655'));
      await tester.pumpAndSettle();

      // Should be on AddressSelectionScreen
      expect(find.byType(AddressSelectionScreen), findsOneWidget);
      expect(find.text("Where's your table?"), findsOneWidget);
      expect(find.text('Confirm Home address'), findsOneWidget);

      // Tap back button
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      // Back on ReviewOrderScreen
      expect(find.byType(ReviewOrderScreen), findsOneWidget);
      expect(find.text('Review your order'), findsOneWidget);
    });
  });

  group('THEKAA Coins Redemption Screen Test Suite', () {
    testWidgets('Renders Coins Redemption screen matching reference screenshot', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CoinsRedemptionScreen(
            restaurant: Restaurant.shadabBiryani,
            cartQuantities: const {
              'chicken_dum_biryani': 1,
              'mutton_biryani': 1,
            },
            originalOrderValue: 655.0,
            initialCoinBalance: 1200,
          ),
        ),
      );
      await tester.pump(); // Frame 1 before timer settles

      // Section A: Header
      expect(find.text('02 / CHECKOUT & PAYMENT'), findsOneWidget);
      expect(find.text('A little give-back'), findsOneWidget);

      // Section B: Order Identification
      expect(find.text('YOUR ORDER · SHADAB BIRYANI'), findsOneWidget);

      // Section C: Coins Balance Card
      expect(find.text('YOUR THEKAA COINS'), findsOneWidget);
      expect(find.text('1,200 TKC'), findsOneWidget);

      // Section D & E: Coins to redeem card
      expect(find.text('Coins to redeem'), findsOneWidget);
      expect(find.text('0 TKC'), findsWidgets);
      expect(find.text('Current conversion'), findsOneWidget);
      expect(find.text('Fetching quote...'), findsOneWidget);
      expect(find.text('Maximum eligible'), findsOneWidget);
      expect(find.text('Checking limit...'), findsOneWidget);

      // Section F: Notice card
      expect(find.text('Rate and limit confirmed at checkout'), findsOneWidget);
      expect(
        find.text("Your current order has no coins applied. We'll enable redemption after the checkout quote loads."),
        findsOneWidget,
      );

      // Section G: Apply coins button (disabled initially)
      expect(find.text('Apply coins · waiting for quote'), findsOneWidget);

      // Section H: Order Value Summary Card
      expect(find.text('Order value'), findsOneWidget);
      expect(find.text('Coins applied'), findsOneWidget);
      expect(find.text('Payable, unchanged'), findsOneWidget);
      expect(find.text('₹655'), findsNWidgets(2)); // summary and button

      // Section I: Fixed Bottom Continue button
      expect(find.text('Continue without coins · ₹655'), findsOneWidget);

      // Let timer complete cleanly
      await tester.pump(const Duration(milliseconds: 1500));
    });

    testWidgets('CRITICAL: Screen reusability with Chutneys reflects restaurant and order value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CoinsRedemptionScreen(
            restaurant: Restaurant.chutneys,
            cartQuantities: const {
              'ghee_karam_dosa': 1,
              'babai_idli': 1,
            },
            originalOrderValue: 330.0,
            initialCoinBalance: 1200,
          ),
        ),
      );
      await tester.pump();

      expect(find.text('YOUR ORDER · CHUTNEYS'), findsOneWidget);
      expect(find.text('1,200 TKC'), findsOneWidget);
      expect(find.text('₹330'), findsNWidgets(2));
      expect(find.text('Continue without coins · ₹330'), findsOneWidget);

      // Let timer complete cleanly
      await tester.pump(const Duration(milliseconds: 1500));
    });

    testWidgets('Interactive coin selection and application updates payable amount', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CoinsRedemptionScreen(
            restaurant: Restaurant.shadabBiryani,
            cartQuantities: const {
              'chicken_dum_biryani': 1,
              'mutton_biryani': 1,
            },
            originalOrderValue: 655.0,
            initialCoinBalance: 1200,
          ),
        ),
      );
      // Wait for quotation to finish loading
      await tester.pump(const Duration(milliseconds: 1500));

      expect(find.text('4 TKC = ₹1'), findsOneWidget);
      expect(find.text('200 TKC'), findsOneWidget);

      // Increment coins by tapping plus icon 4 times (4 x 50 = 200 TKC max eligible)
      final plusFinder = find.byIcon(Icons.add);
      await tester.tap(plusFinder);
      await tester.pump();
      await tester.tap(plusFinder);
      await tester.pump();
      await tester.tap(plusFinder);
      await tester.pump();
      await tester.tap(plusFinder);
      await tester.pump();

      // Selected coins is now 200 TKC
      expect(find.text('200 TKC'), findsWidgets);
      expect(find.text('Apply coins · 200 TKC'), findsOneWidget);

      // Tap apply coins button
      await tester.tap(find.text('Apply coins · 200 TKC'));
      await tester.pump();

      // Discount: 200 * 0.25 = ₹50
      // Payable: 655 - 50 = 605
      expect(find.text('Payable, coins applied'), findsOneWidget);
      expect(find.text('Continue with coins · ₹605'), findsOneWidget);
    });

    testWidgets('End-to-end: Address Selection -> Confirm Address -> Coins Redemption -> Back', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AddressSelectionScreen(
            restaurant: Restaurant.shadabBiryani,
            cartQuantities: const {
              'chicken_dum_biryani': 1,
              'mutton_biryani': 1,
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Confirm Home address button
      expect(find.text('Confirm Home address'), findsOneWidget);
      await tester.tap(find.text('Confirm Home address'));
      await tester.pumpAndSettle();

      // Now on CoinsRedemptionScreen
      expect(find.byType(CoinsRedemptionScreen), findsOneWidget);
      expect(find.text('A little give-back'), findsOneWidget);
      expect(find.text('YOUR ORDER · SHADAB BIRYANI'), findsOneWidget);

      // Tap back button
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      // Back on AddressSelectionScreen
      expect(find.byType(AddressSelectionScreen), findsOneWidget);
      expect(find.text("Where's your table?"), findsOneWidget);
    });

    testWidgets('Tapping Continue without coins triggers onContinueToPay callback with correct amount', (tester) async {
      double? payableReceived;

      await tester.pumpWidget(
        MaterialApp(
          home: CoinsRedemptionScreen(
            restaurant: Restaurant.shadabBiryani,
            cartQuantities: const {
              'chicken_dum_biryani': 1,
            },
            originalOrderValue: 655.0,
            onContinueToPay: (val) => payableReceived = val,
          ),
        ),
      );
      // Wait for quotation to finish loading
      await tester.pump(const Duration(milliseconds: 1500));

      expect(find.textContaining('Continue without coins'), findsOneWidget);
      await tester.tap(find.textContaining('Continue without coins'));
      await tester.pumpAndSettle();

      expect(payableReceived, 655.0);
    });
  });

  group('THEKAA Payment Method Screen Test Suite', () {
    testWidgets('Renders Payment screen matching reference screenshot accurately', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PaymentScreen(
            restaurant: Restaurant.shadabBiryani,
            cartQuantities: const {
              'chicken_dum_biryani': 1,
              'mutton_biryani': 1,
            },
            payableAmount: 655.0,
            coinsRedeemed: 0,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('One last thing'), findsOneWidget);

      // Amount payable card
      expect(find.text('Amount payable'), findsOneWidget);
      expect(find.text('₹655'), findsOneWidget);
      expect(find.byIcon(Icons.verified_user_outlined), findsOneWidget);
      expect(find.text('Shadab Biryani · 2 items · Delivery to Home'), findsOneWidget);

      // Choose how to pay
      expect(find.text('Choose how to pay'), findsOneWidget);

      // UPI Card
      expect(find.text('UPI'), findsOneWidget);
      expect(find.text('Fast, secure bank-to-bank payment'), findsOneWidget);
      expect(find.text('Google Pay'), findsOneWidget);
      expect(find.text('PhonePe'), findsOneWidget);
      expect(find.text('Paytm'), findsOneWidget);
      expect(find.text('UPI ID'), findsOneWidget);
      expect(find.text('vatsa@sample'), findsOneWidget);
      expect(find.text('Sample payment details — design preview'), findsOneWidget);

      // Other methods
      expect(find.text('Debit / credit card'), findsOneWidget);
      expect(find.text('Visa, Mastercard, RuPay'), findsOneWidget);
      expect(find.text('Net banking'), findsOneWidget);
      expect(find.text('Choose your bank'), findsOneWidget);
      expect(find.text('Cash on delivery'), findsOneWidget);
      expect(find.text('Available for this order'), findsOneWidget);

      // Note & Fixed Action Button
      expect(find.text('Secure payment · No coins redeemed'), findsOneWidget);
      expect(find.text('Confirm & pay ₹655'), findsOneWidget);
      expect(find.byIcon(Icons.lock_rounded), findsOneWidget);

      // NO Bottom Navigation Bar
      expect(find.byType(ThekaaBottomNavBar), findsNothing);
    });

    testWidgets('Switching UPI provider chips updates selection state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PaymentScreen(
            restaurant: Restaurant.shadabBiryani,
            payableAmount: 655.0,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap PhonePe
      await tester.tap(find.text('PhonePe'));
      await tester.pumpAndSettle();

      // Tap Paytm
      await tester.tap(find.text('Paytm'));
      await tester.pumpAndSettle();

      // Edit UPI ID
      final upiField = find.byType(TextField);
      expect(upiField, findsOneWidget);
      await tester.enterText(upiField, 'user@okaxis');
      await tester.pump();
      expect(find.text('user@okaxis'), findsOneWidget);
    });

    testWidgets('CRITICAL: Screen reusability with Chutneys and Work address updates dynamically', (tester) async {
      const workAddress = DeliveryAddress.defaultWork; // Work address

      await tester.pumpWidget(
        MaterialApp(
          home: PaymentScreen(
            restaurant: Restaurant.chutneys,
            cartQuantities: const {
              'ghee_karam_dosa': 2,
              'filter_coffee': 1,
            },
            deliveryAddress: workAddress,
            payableAmount: 430.0,
            coinsRedeemed: 100,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('₹430'), findsOneWidget);
      expect(find.text('Chutneys · 3 items · Delivery to Work'), findsOneWidget);
      expect(find.text('Secure payment · 100 TKC redeemed'), findsOneWidget);
      expect(find.text('Confirm & pay ₹430'), findsOneWidget);
    });

    testWidgets('End-to-end: Coins Redemption -> Continue without coins -> Payment Screen -> Back', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CoinsRedemptionScreen(
            restaurant: Restaurant.shadabBiryani,
            cartQuantities: const {
              'chicken_dum_biryani': 1,
              'mutton_biryani': 1,
            },
            originalOrderValue: 655.0,
          ),
        ),
      );
      // Wait for quotation
      await tester.pump(const Duration(milliseconds: 1500));

      // Tap Continue without coins · ₹655
      expect(find.textContaining('Continue without coins'), findsOneWidget);
      await tester.tap(find.textContaining('Continue without coins'));
      await tester.pumpAndSettle();

      // Now directly on PaymentScreen
      expect(find.byType(PaymentScreen), findsOneWidget);
      expect(find.text('One last thing'), findsOneWidget);
      expect(find.text('Confirm & pay ₹655'), findsOneWidget);

      // Tap back button on PaymentScreen
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      // Back on CoinsRedemptionScreen
      expect(find.byType(CoinsRedemptionScreen), findsOneWidget);
      expect(find.text('A little give-back'), findsOneWidget);
    });

    testWidgets('End-to-end: Payment Screen -> Confirm & pay -> Order Placed Screen', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PaymentScreen(
            restaurant: Restaurant.shadabBiryani,
            cartQuantities: const {
              'chicken_dum_biryani': 1,
              'mutton_biryani': 1,
            },
            payableAmount: 655.0,
            coinsRedeemed: 0,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Confirm & pay ₹655
      expect(find.text('Confirm & pay ₹655'), findsOneWidget);
      await tester.tap(find.text('Confirm & pay ₹655'));
      await tester.pump(const Duration(milliseconds: 700));
      await tester.pumpAndSettle();

      // Now directly on OrderPlacedScreen!
      expect(find.byType(OrderPlacedScreen), findsOneWidget);
      expect(find.text("You're all set"), findsOneWidget);
      expect(find.text('Order placed, bhaiyya.'), findsOneWidget);
    });
  });

  group('THEKAA Order Placed Confirmation Screen Suite', () {
    testWidgets('Renders Order Placed screen matching reference screenshot accurately', (tester) async {
      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        cartQuantities: const {
          'chicken_dum_biryani': 1,
          'mutton_biryani': 1,
        },
        payableAmount: 655.0,
        coinsRedeemed: 0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderPlacedScreen(order: order),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text("You're all set"), findsOneWidget);

      // Cursive script & Title
      expect(find.text('Acha khaana, on its way.'), findsOneWidget);
      expect(find.text('Order placed, bhaiyya.'), findsOneWidget);
      expect(find.text('#THK84291 · 01 Nov 2026 · 1:45 PM'), findsOneWidget);

      // Delivery ETA Card
      expect(find.text('24–28 min'), findsOneWidget);
      expect(find.text('Estimated delivery · 2:09–2:13 PM'), findsOneWidget);
      expect(find.byIcon(Icons.access_time_rounded), findsOneWidget);

      // Restaurant & Items Card
      expect(find.text('Shadab Biryani'), findsOneWidget);
      expect(find.text('Gachibowli · #THK84291'), findsOneWidget);
      expect(find.text('1 × Chicken Dum Biryani · ₹280'), findsOneWidget);
      expect(find.text('1 × Mutton Biryani · ₹340'), findsOneWidget);
      expect(find.text('2 items · No coins redeemed'), findsOneWidget);
      expect(find.text('₹655'), findsOneWidget);

      // Payment Summary Note
      expect(find.text('Paid ₹655 via UPI · No coins redeemed'), findsOneWidget);

      // Buttons
      expect(find.text('Track order'), findsOneWidget);
      expect(find.byIcon(Icons.alt_route_rounded), findsOneWidget);
      expect(find.text('View order details'), findsOneWidget);

      // NO Bottom Navigation Bar
      expect(find.byType(ThekaaBottomNavBar), findsNothing);
    });

    testWidgets('CRITICAL: Screen reusability with Chutneys and Coins applied updates dynamically', (tester) async {
      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.chutneys,
        cartQuantities: const {
          'ghee_karam_dosa': 2,
          'filter_coffee': 1,
        },
        payableAmount: 430.0,
        coinsRedeemed: 100,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderPlacedScreen(order: order),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Order placed, bhaiyya.'), findsOneWidget);
      expect(find.text('#THK62180 · 01 Nov 2026 · 1:45 PM'), findsOneWidget);
      expect(find.text('20–25 min'), findsOneWidget);
      expect(find.text('Chutneys'), findsOneWidget);
      expect(find.text('2 × Ghee Karam Dosa · ₹180'), findsOneWidget);
      expect(find.text('1 × Filter Coffee · ₹70'), findsOneWidget);
      expect(find.text('3 items · 100 TKC redeemed'), findsOneWidget);
      expect(find.text('₹430'), findsOneWidget);
      expect(find.text('Paid ₹430 via UPI · 100 TKC redeemed'), findsOneWidget);
    });

    testWidgets('Interactive Track order and View order details invoke handlers', (tester) async {
      bool tracked = false;
      bool detailsViewed = false;

      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderPlacedScreen(
            order: order,
            onTrackOrder: () => tracked = true,
            onViewOrderDetails: () => detailsViewed = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Track order
      await tester.tap(find.text('Track order'));
      await tester.pumpAndSettle();
      expect(tracked, isTrue);

      // Tap View order details
      await tester.tap(find.text('View order details'));
      await tester.pumpAndSettle();
      expect(detailsViewed, isTrue);
    });
  });
}
