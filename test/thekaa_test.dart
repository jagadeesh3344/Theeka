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
import 'package:thekaa/screens/order_details_screen.dart';
import 'package:thekaa/screens/order_tracking_screen.dart';
import 'package:thekaa/screens/rider_details_screen.dart';
import 'package:thekaa/screens/on_the_way_screen.dart';
import 'package:thekaa/screens/delivered_order_screen.dart';
import 'package:thekaa/screens/profile_screen.dart';
import 'package:thekaa/models/user_profile.dart';
import 'package:thekaa/widgets/profile_header.dart';
import 'package:thekaa/widgets/profile_avatar_section.dart';
import 'package:thekaa/widgets/profile_stats_row.dart';
import 'package:thekaa/widgets/edit_profile_button.dart';
import 'package:thekaa/widgets/profile_coins_card.dart';
import 'package:thekaa/widgets/profile_menu_container.dart';
import 'package:thekaa/widgets/live_delivery_map.dart';
import 'package:thekaa/models/order_confirmation.dart';
import 'package:thekaa/widgets/map_list_selector.dart';
import 'package:thekaa/widgets/explore_restaurant_card.dart';
import 'package:thekaa/widgets/rider_delivery_map.dart';

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
      // Verify exactly ONE bottom navigation bar exists (no duplicate)
      expect(find.byType(ThekaaBottomNavBar), findsOneWidget);

      // Tap Orders tab
      await tester.tap(find.text('Orders').first);
      await tester.pumpAndSettle();
      expect(find.text('Your Orders'), findsOneWidget);

      // Tap Profile tab
      await tester.tap(find.text('Profile').first);
      await tester.pumpAndSettle();
      expect(find.text('My THEKAA'), findsOneWidget);
      expect(find.text('hero M.'), findsOneWidget);

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

  group('THEKAA Order Details / Order Confirmed Screen Suite', () {
    testWidgets('Renders all authoritative elements matching reference screenshot', (tester) async {
      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderDetailsScreen(order: order),
        ),
      );
      await tester.pumpAndSettle();

      // Top Header
      expect(find.text('Order confirmed'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);

      // Cursive script message
      expect(find.text('The kitchen has your order.'), findsOneWidget);

      // Order ID & Today Row
      expect(find.text('#THK84291'), findsWidgets);
      expect(find.text('Today, 1:45 PM'), findsOneWidget);

      // Card 1: Kitchen Acceptance (Green Card)
      expect(find.text('Confirmed by Shadab Biryani'), findsOneWidget);
      expect(
        find.text("Your order is accepted. We'll let you know when preparation begins."),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.check_circle_outline_rounded), findsOneWidget);

      // Card 2: Delivery ETA Card
      expect(find.text('Arriving in 24–28 min'), findsOneWidget);
      expect(find.text('Estimated 2:09–2:13 PM'), findsOneWidget);
      expect(find.byIcon(Icons.access_time_rounded), findsOneWidget);

      // Card 3: Restaurant & Dishes Order Summary Card
      expect(find.text('Shadab Biryani'), findsWidgets);
      expect(find.text('Gachibowli · #THK84291'), findsOneWidget);
      expect(find.text('1 × Chicken Dum Biryani · ₹280'), findsOneWidget);
      expect(find.text('1 × Mutton Biryani · ₹340'), findsOneWidget);
      expect(find.text('2 items · No coins redeemed'), findsOneWidget);
      expect(find.text('₹655'), findsOneWidget);

      // Bottom Action Button: Full-width "Track your order"
      expect(find.text('Track your order'), findsOneWidget);
      expect(find.byIcon(Icons.alt_route_rounded), findsOneWidget);

      // Bottom Navigation Bar with Orders tab active (index 3)
      final bottomNavBarFinder = find.byType(ThekaaBottomNavBar);
      expect(bottomNavBarFinder, findsOneWidget);
      final ThekaaBottomNavBar navBar = tester.widget(bottomNavBarFinder);
      expect(navBar.currentIndex, equals(3));
    });

    testWidgets('Dynamic screen reusability with Chutneys and TKC coins applied', (tester) async {
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
          home: OrderDetailsScreen(order: order),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Order confirmed'), findsOneWidget);
      expect(find.text('The kitchen has your order.'), findsOneWidget);
      expect(find.text('#THK62180'), findsWidgets);
      expect(find.text('Confirmed by Chutneys'), findsOneWidget);
      expect(find.text('Arriving in 20–25 min'), findsOneWidget);
      expect(find.text('Estimated 2:05–2:10 PM'), findsOneWidget);
      expect(find.text('Chutneys'), findsWidgets);
      expect(find.text('Gachibowli · #THK62180'), findsOneWidget);
      expect(find.text('2 × Ghee Karam Dosa · ₹180'), findsOneWidget);
      expect(find.text('1 × Filter Coffee · ₹70'), findsOneWidget);
      expect(find.text('3 items · 100 TKC redeemed'), findsOneWidget);
      expect(find.text('₹430'), findsOneWidget);
    });

    testWidgets('Interactive callbacks work (onBack, onTrackOrder, onNavTap)', (tester) async {
      bool backed = false;
      bool tracked = false;
      int? tappedIndex;

      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderDetailsScreen(
            order: order,
            onBack: () => backed = true,
            onTrackOrder: () => tracked = true,
            onNavTap: (i) => tappedIndex = i,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Back
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();
      expect(backed, isTrue);

      // Tap Track your order
      await tester.tap(find.text('Track your order'));
      await tester.pumpAndSettle();
      expect(tracked, isTrue);

      // Tap Profile tab (index 4)
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(tappedIndex, equals(4));
    });

    testWidgets('End-to-End: Order Placed -> View order details navigates to Order Details screen', (tester) async {
      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderPlacedScreen(order: order),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Order placed, bhaiyya.'), findsOneWidget);
      expect(find.byType(OrderDetailsScreen), findsNothing);

      // Tap View order details
      await tester.tap(find.text('View order details'));
      await tester.pumpAndSettle();

      // Should have navigated to OrderDetailsScreen
      expect(find.byType(OrderDetailsScreen), findsOneWidget);
      expect(find.text('Order confirmed'), findsOneWidget);
      expect(find.text('The kitchen has your order.'), findsOneWidget);
      expect(find.text('Track your order'), findsOneWidget);

      // Tap Back on Order Details Screen
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      // Should be back at OrderPlacedScreen
      expect(find.text('Order placed, bhaiyya.'), findsOneWidget);
      expect(find.byType(OrderDetailsScreen), findsNothing);
    });
  });

  group('THEKAA Order Tracking Screen Suite', () {
    testWidgets('Renders all authoritative elements matching reference screenshot', (tester) async {
      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderTrackingScreen(order: order),
        ),
      );
      await tester.pumpAndSettle();

      // Top Header
      expect(find.text('A little dum, a little time'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);

      // Order ID & Estimated Time
      expect(find.text('#THK84291'), findsOneWidget);
      expect(find.text('Estimated 2:09–2:13 PM'), findsOneWidget);

      // 5-Stage Timeline
      expect(find.text('Order confirmed'), findsOneWidget);
      expect(find.text('Completed'), findsOneWidget);

      expect(find.text('Restaurant preparing food'), findsOneWidget);
      expect(find.text('In progress'), findsOneWidget);

      expect(find.text('Rider assigned'), findsOneWidget);
      expect(find.text('Out for delivery'), findsOneWidget);
      expect(find.text('Delivered'), findsOneWidget);
      expect(find.text('Pending'), findsNWidgets(3));

      // Restaurant Status Card
      expect(find.text('Shadab Biryani is preparing your meal.'), findsOneWidget);
      expect(find.text('Your biryani is getting its finishing touch.'), findsOneWidget);

      // Order Summary Card
      expect(find.text('2 items · ₹655 paid'), findsOneWidget);
      expect(find.text('Shadab Biryani, Gachibowli'), findsOneWidget);
      expect(find.byIcon(Icons.receipt_long_outlined), findsOneWidget);

      // Action Button: View order details
      expect(find.text('View order details'), findsOneWidget);

      // Bottom Navigation Bar with Orders tab active (index 3)
      final bottomNavBarFinder = find.byType(ThekaaBottomNavBar);
      expect(bottomNavBarFinder, findsOneWidget);
      final ThekaaBottomNavBar navBar = tester.widget(bottomNavBarFinder);
      expect(navBar.currentIndex, equals(3));
    });

    testWidgets('Dynamic screen reusability with Chutneys and Coins applied updates dynamically', (tester) async {
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
          home: OrderTrackingScreen(order: order),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('A little dum, a little time'), findsOneWidget);
      expect(find.text('#THK62180'), findsOneWidget);
      expect(find.text('Estimated 2:05–2:10 PM'), findsOneWidget);
      expect(find.text('Chutneys is preparing your meal.'), findsOneWidget);
      expect(find.text('Your dosa is getting its finishing touch.'), findsOneWidget);
      expect(find.text('3 items · ₹430 paid'), findsOneWidget);
      expect(find.text('Chutneys, Gachibowli'), findsOneWidget);
    });

    testWidgets('Lifecycle progression of OrderTrackingStatus updates timeline states', (tester) async {
      final baseOrder = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      // Test Rider Assigned stage
      final riderOrder = baseOrder.copyWith(
        trackingStatus: OrderTrackingStatus.riderAssigned,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderTrackingScreen(order: riderOrder),
        ),
      );
      await tester.pumpAndSettle();

      // Stages 1 & 2 completed, stage 3 in progress, stages 4 & 5 pending
      expect(find.text('Completed'), findsNWidgets(2));
      expect(find.text('In progress'), findsOneWidget);
      expect(find.text('Pending'), findsNWidgets(2));

      // Test Out for Delivery stage
      final deliveryOrder = baseOrder.copyWith(
        trackingStatus: OrderTrackingStatus.outForDelivery,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderTrackingScreen(order: deliveryOrder),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Completed'), findsNWidgets(3));
      expect(find.text('In progress'), findsOneWidget);
      expect(find.text('Pending'), findsNWidgets(1));

      // Test Delivered stage
      final deliveredOrder = baseOrder.copyWith(
        trackingStatus: OrderTrackingStatus.delivered,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderTrackingScreen(order: deliveredOrder),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Completed'), findsNWidgets(5));
      expect(find.text('In progress'), findsNothing);
      expect(find.text('Pending'), findsNothing);
    });

    testWidgets('Interactive callbacks work (onBack, onViewOrderDetails, onNavTap)', (tester) async {
      bool backed = false;
      bool detailsViewed = false;
      int? tappedIndex;

      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderTrackingScreen(
            order: order,
            onBack: () => backed = true,
            onViewOrderDetails: () => detailsViewed = true,
            onNavTap: (i) => tappedIndex = i,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Back
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();
      expect(backed, isTrue);

      // Tap View order details
      await tester.tap(find.text('View order details'));
      await tester.pumpAndSettle();
      expect(detailsViewed, isTrue);

      // Tap Home tab (index 0)
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(tappedIndex, equals(0));
    });

    testWidgets('End-to-End: Order Details -> Track your order navigates to Order Tracking and back', (tester) async {
      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderDetailsScreen(order: order),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Order confirmed'), findsOneWidget);
      expect(find.byType(OrderTrackingScreen), findsNothing);

      // Tap Track your order
      await tester.tap(find.text('Track your order'));
      await tester.pumpAndSettle();

      // Should be on OrderTrackingScreen
      expect(find.byType(OrderTrackingScreen), findsOneWidget);
      expect(find.text('A little dum, a little time'), findsOneWidget);
      expect(find.text('Restaurant preparing food'), findsOneWidget);
      expect(find.text('View order details'), findsOneWidget);

      // Tap View order details to navigate to RiderDetailsScreen
      await tester.tap(find.text('View order details'));
      await tester.pumpAndSettle();

      // Should be on RiderDetailsScreen
      expect(find.byType(RiderDetailsScreen), findsOneWidget);
      expect(find.text('Meet your bhaiyya'), findsOneWidget);

      // Tap Back on RiderDetailsScreen
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      // Back on OrderTrackingScreen
      expect(find.byType(OrderTrackingScreen), findsOneWidget);
      expect(find.text('A little dum, a little time'), findsOneWidget);

      // Tap Back on OrderTrackingScreen
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      // Back on OrderDetailsScreen
      expect(find.byType(OrderDetailsScreen), findsOneWidget);
      expect(find.text('Order confirmed'), findsOneWidget);
    });
  });

  group('THEKAA Rider & Delivery Details ("Meet your bhaiyya") Screen Suite', () {
    testWidgets('Renders all authoritative elements matching reference screenshot', (tester) async {
      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: RiderDetailsScreen(order: order),
        ),
      );
      await tester.pumpAndSettle();

      // Top Header
      expect(find.text('Meet your bhaiyya'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);

      // Order ID · RIDER ASSIGNED · 1:53 PM
      expect(find.text('#THK84291 · RIDER ASSIGNED · 1:53 PM'), findsOneWidget);

      // Rider Profile Card
      expect(find.text('Ravi K.'), findsOneWidget);
      expect(find.text('4.8'), findsOneWidget);
      expect(find.text('Your delivery partner'), findsOneWidget);
      expect(find.byIcon(Icons.shield_outlined), findsOneWidget);
      expect(find.text('Call'), findsOneWidget);
      expect(find.byIcon(Icons.phone_outlined), findsOneWidget);
      expect(find.text('Chat'), findsOneWidget);
      expect(find.byIcon(Icons.chat_bubble_outline_rounded), findsOneWidget);

      // Delivery statistics row
      expect(find.text('1,240 deliveries'), findsOneWidget);
      expect(find.text('2 years with THEKAA'), findsOneWidget);

      // Rider status message card
      expect(find.text('Ravi is heading to the restaurant'), findsOneWidget);
      expect(
        find.text("Your food has not been picked up yet. We'll update the status when he's on his way to you."),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.info_outline_rounded), findsOneWidget);

      // Pickup and Dropoff Address Card
      expect(find.text('Pickup · Shadab Biryani'), findsOneWidget);
      expect(find.text('Gachibowli, Hyderabad'), findsOneWidget);
      expect(find.text('Drop-off · Home'), findsOneWidget);
      expect(
        find.text('Flat 302, Vertex Heights, Gachibowli, Hyderabad 500032'),
        findsOneWidget,
      );

      // Estimated Arrival Row
      expect(find.text('Estimated arrival: 2:09–2:13 PM'), findsOneWidget);

      // Contained Map Preview
      expect(find.byType(RiderDeliveryMap), findsOneWidget);

      // Action Button: View order details
      expect(find.text('View order details'), findsOneWidget);

      // Bottom Navigation Bar with Orders tab active (index 3)
      final bottomNavBarFinder = find.byType(ThekaaBottomNavBar);
      expect(bottomNavBarFinder, findsOneWidget);
      final ThekaaBottomNavBar navBar = tester.widget(bottomNavBarFinder);
      expect(navBar.currentIndex, equals(3));
    });

    testWidgets('Dynamic screen reusability with Chutneys, Work address, and Arjun M. rider', (tester) async {
      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.chutneys,
        deliveryAddress: DeliveryAddress.defaultWork,
        payableAmount: 430.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: RiderDetailsScreen(order: order),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Meet your bhaiyya'), findsOneWidget);
      expect(find.text('#THK62180 · RIDER ASSIGNED · 1:58 PM'), findsOneWidget);
      expect(find.text('Arjun M.'), findsOneWidget);
      expect(find.text('4.9'), findsOneWidget);
      expect(find.text('890 deliveries'), findsOneWidget);
      expect(find.text('1 years with THEKAA'), findsOneWidget);
      expect(find.text('Arjun is heading to the restaurant'), findsOneWidget);
      expect(find.text('Pickup · Chutneys'), findsOneWidget);
      expect(find.text('Drop-off · Work'), findsOneWidget);
      expect(
        find.text('Floor 5, Building 12, Madhapur, Hyderabad 500081'),
        findsOneWidget,
      );
      expect(find.text('Estimated arrival: 2:05–2:10 PM'), findsOneWidget);
    });

    testWidgets('Interactive Call, Chat, View order details, and Back callbacks', (tester) async {
      bool backed = false;
      bool called = false;
      bool chatted = false;
      bool detailsViewed = false;
      int? tappedIndex;

      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: RiderDetailsScreen(
            order: order,
            onBack: () => backed = true,
            onCallRider: () => called = true,
            onChatRider: () => chatted = true,
            onViewOrderDetails: () => detailsViewed = true,
            onNavTap: (i) => tappedIndex = i,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Back
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();
      expect(backed, isTrue);

      // Tap Call
      await tester.tap(find.text('Call'));
      await tester.pumpAndSettle();
      expect(called, isTrue);

      // Tap Chat
      await tester.tap(find.text('Chat'));
      await tester.pumpAndSettle();
      expect(chatted, isTrue);

      // Tap View order details
      await tester.tap(find.text('View order details'));
      await tester.pumpAndSettle();
      expect(detailsViewed, isTrue);

      // Tap Profile tab (index 4)
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(tappedIndex, equals(4));
    });

    testWidgets('End-to-End: RiderDetailsScreen -> View order details navigates to OrderDetailsScreen', (tester) async {
      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: RiderDetailsScreen(order: order),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Meet your bhaiyya'), findsOneWidget);
      expect(find.byType(OrderDetailsScreen), findsNothing);

      // Tap View order details
      await tester.tap(find.text('View order details'));
      await tester.pumpAndSettle();

      // Should be on OrderDetailsScreen for the SAME order
      expect(find.byType(OrderDetailsScreen), findsOneWidget);
      expect(find.text('Order confirmed'), findsOneWidget);
      expect(find.text('#THK84291'), findsWidgets);
      expect(find.text('Confirmed by Shadab Biryani'), findsOneWidget);

      // Tap Back on OrderDetailsScreen
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      // Back on RiderDetailsScreen
      expect(find.byType(RiderDetailsScreen), findsOneWidget);
      expect(find.text('Meet your bhaiyya'), findsOneWidget);
      expect(find.byType(OrderDetailsScreen), findsNothing);
    });

    testWidgets('Tapping map on RiderDetailsScreen navigates to OnTheWayScreen and back', (tester) async {
      tester.view.physicalSize = const Size(800, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: RiderDetailsScreen(order: order),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Meet your bhaiyya'), findsOneWidget);
      expect(find.byType(OnTheWayScreen), findsNothing);

      // Tap the map area
      final mapFinder = find.byType(RiderDeliveryMap);
      await tester.scrollUntilVisible(mapFinder, 150, scrollable: find.byType(Scrollable).first);
      await tester.pumpAndSettle();
      await tester.tap(mapFinder);
      await tester.pumpAndSettle();

      // Should be on OnTheWayScreen
      expect(find.byType(OnTheWayScreen), findsOneWidget);
      expect(find.text('On the way to you'), findsOneWidget);

      // Tap Back on OnTheWayScreen
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      // Should be back on RiderDetailsScreen
      expect(find.byType(RiderDetailsScreen), findsOneWidget);
      expect(find.text('Meet your bhaiyya'), findsOneWidget);
      expect(find.byType(OnTheWayScreen), findsNothing);
    });
  });

  group('THEKAA Live Location / On The Way Screen Suite', () {
    testWidgets('Renders all authoritative elements matching reference screenshot', (tester) async {
      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OnTheWayScreen(order: order),
        ),
      );
      await tester.pumpAndSettle();

      // Top Header
      expect(find.text('On the way to you'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);

      // Subheader: #THK84291 · OUT FOR DELIVERY · 2:00 PM
      expect(find.text('#THK84291 · OUT FOR DELIVERY · 2:00 PM'), findsOneWidget);

      // Large Live Delivery Map
      expect(find.byType(LiveDeliveryMap), findsOneWidget);

      // ETA / Distance Card
      expect(find.text('12 min'), findsOneWidget);
      expect(find.text('Arriving around 2:12 PM'), findsOneWidget);
      expect(find.text('2.8 km'), findsOneWidget);
      expect(find.text('remaining'), findsOneWidget);
      expect(find.byIcon(Icons.access_time_rounded), findsOneWidget);

      // Compact Rider Card
      expect(find.text('Ravi K.'), findsOneWidget);
      expect(find.text('4.8'), findsOneWidget);
      expect(find.text('Your delivery partner'), findsOneWidget);
      expect(find.byIcon(Icons.shield_outlined), findsOneWidget);
      expect(find.text('Call'), findsOneWidget);
      expect(find.byIcon(Icons.phone_outlined), findsOneWidget);
      expect(find.text('Chat'), findsOneWidget);
      expect(find.byIcon(Icons.chat_bubble_outline_rounded), findsOneWidget);

      // Delivering to Home Section
      expect(find.text('Delivering to Home'), findsOneWidget);
      expect(
        find.text('Flat 302, Vertex Heights, Gachibowli, Hyderabad 500032'),
        findsOneWidget,
      );

      // Action Button: View order details
      expect(find.text('View order details'), findsOneWidget);

      // Bottom Navigation Bar with Orders tab active (index 3)
      final bottomNavBarFinder = find.byType(ThekaaBottomNavBar);
      expect(bottomNavBarFinder, findsOneWidget);
      final ThekaaBottomNavBar navBar = tester.widget(bottomNavBarFinder);
      expect(navBar.currentIndex, equals(3));
    });

    testWidgets('Dynamic screen reusability with Chutneys, Work address, and custom ETA/distance', (tester) async {
      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.chutneys,
        deliveryAddress: DeliveryAddress.defaultWork,
        payableAmount: 430.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OnTheWayScreen(order: order),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('On the way to you'), findsOneWidget);
      expect(find.text('#THK62180 · OUT FOR DELIVERY · 2:00 PM'), findsOneWidget);
      expect(find.text('10 min'), findsOneWidget);
      expect(find.text('Arriving around 2:10 PM'), findsOneWidget);
      expect(find.text('2.1 km'), findsOneWidget);
      expect(find.text('Arjun M.'), findsOneWidget);
      expect(find.text('Delivering to Work'), findsOneWidget);
      expect(
        find.text('Floor 5, Building 12, Madhapur, Hyderabad 500081'),
        findsOneWidget,
      );
    });

    testWidgets('Interactive Call, Chat, View order details, and Back callbacks', (tester) async {
      tester.view.physicalSize = const Size(800, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      bool backed = false;
      bool called = false;
      bool chatted = false;
      bool detailsViewed = false;
      int? tappedIndex;

      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OnTheWayScreen(
            order: order,
            onBack: () => backed = true,
            onCallRider: () => called = true,
            onChatRider: () => chatted = true,
            onViewOrderDetails: () => detailsViewed = true,
            onNavTap: (i) => tappedIndex = i,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Back
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();
      expect(backed, isTrue);

      // Tap Call
      final callFinder = find.text('Call');
      await tester.scrollUntilVisible(callFinder, 150, scrollable: find.byType(Scrollable).first);
      await tester.pumpAndSettle();
      await tester.tap(callFinder);
      await tester.pumpAndSettle();
      expect(called, isTrue);

      // Tap Chat
      final chatFinder = find.text('Chat');
      await tester.scrollUntilVisible(chatFinder, 150, scrollable: find.byType(Scrollable).first);
      await tester.pumpAndSettle();
      await tester.tap(chatFinder);
      await tester.pumpAndSettle();
      expect(chatted, isTrue);

      // Tap View order details
      await tester.tap(find.text('View order details'));
      await tester.pumpAndSettle();
      expect(detailsViewed, isTrue);

      // Tap Explore tab (index 1)
      await tester.tap(find.text('Explore'));
      await tester.pumpAndSettle();
      expect(tappedIndex, equals(1));
    });

    testWidgets('End-to-End: OnTheWayScreen -> View order details navigates to OrderDetailsScreen', (tester) async {
      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OnTheWayScreen(order: order),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('On the way to you'), findsOneWidget);
      expect(find.byType(OrderDetailsScreen), findsNothing);

      // Tap View order details
      await tester.tap(find.text('View order details'));
      await tester.pumpAndSettle();

      // Should be on OrderDetailsScreen for the SAME order
      expect(find.byType(OrderDetailsScreen), findsOneWidget);
      expect(find.text('Order confirmed'), findsOneWidget);
      expect(find.text('#THK84291'), findsWidgets);
      expect(find.text('Confirmed by Shadab Biryani'), findsOneWidget);

      // Tap Back on OrderDetailsScreen
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      // Back on OnTheWayScreen
      expect(find.byType(OnTheWayScreen), findsOneWidget);
      expect(find.text('On the way to you'), findsOneWidget);
      expect(find.byType(OrderDetailsScreen), findsNothing);
    });
  });

  group('THEKAA Delivered Order ("Khaana aa gaya!") Screen Suite', () {
    testWidgets('Renders all authoritative elements matching reference screenshot', (tester) async {
      tester.view.physicalSize = const Size(800, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: DeliveredOrderScreen(order: order),
        ),
      );
      await tester.pumpAndSettle();

      // Top Header
      expect(find.text('Khaana aa gaya!'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);

      // Delivery Success Illustration
      expect(find.text('Enjoy every last grain.'), findsOneWidget);
      expect(find.text('DELIVERED · 01 NOV 2026 · 2:12 PM'), findsOneWidget);

      // Order Summary Card
      expect(find.text('Shadab Biryani'), findsOneWidget);
      expect(find.text('Gachibowli · #THK84291'), findsOneWidget);
      expect(find.text('1 × Chicken Dum Biryani · ₹280'), findsOneWidget);
      expect(find.text('1 × Mutton Biryani · ₹340'), findsOneWidget);
      expect(find.text('2 items · No coins redeemed'), findsOneWidget);
      expect(find.text('₹655'), findsOneWidget);

      // Experience Rating Card
      expect(find.text('How was your experience?'), findsOneWidget);
      expect(find.byIcon(Icons.star_outline_rounded), findsNWidgets(5));

      // Review Reminder Card
      expect(find.text('Your honest review matters'), findsOneWidget);
      expect(
        find.text('Share on THEKAA SOCIALS. Coins stay pending until publication and eligibility checks; credited once.'),
        findsOneWidget,
      );

      // Action Buttons
      expect(find.text('Share food review'), findsOneWidget);
      expect(find.byIcon(Icons.edit_outlined), findsOneWidget);
      expect(find.text('Reorder'), findsOneWidget);
      expect(find.text('Order details'), findsOneWidget);

      // Bottom Navigation Bar with Orders active (index 3)
      final bottomNavFinder = find.byType(ThekaaBottomNavBar);
      expect(bottomNavFinder, findsOneWidget);
      final bottomNav = tester.widget<ThekaaBottomNavBar>(bottomNavFinder);
      expect(bottomNav.currentIndex, equals(3));
    });

    testWidgets('Dynamic screen reusability with Chutneys, Work address, and TKC coins applied', (tester) async {
      tester.view.physicalSize = const Size(800, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final chutneysOrder = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.chutneys,
        deliveryAddress: DeliveryAddress.defaultWork,
        payableAmount: 430.0,
        coinsRedeemed: 20,
        customOrderId: '#THK62180',
        deliveredDate: '02 Nov 2026',
        deliveredTime: '3:00 PM',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: DeliveredOrderScreen(order: chutneysOrder),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Khaana aa gaya!'), findsOneWidget);
      expect(find.text('Enjoy every last grain.'), findsOneWidget);
      expect(find.text('DELIVERED · 02 NOV 2026 · 3:00 PM'), findsOneWidget);
      expect(find.text('Chutneys'), findsOneWidget);
      expect(find.text('Gachibowli · #THK62180'), findsOneWidget);
      expect(find.text('2 × Ghee Karam Dosa · ₹180'), findsOneWidget);
      expect(find.text('1 × Filter Coffee · ₹70'), findsOneWidget);
      expect(find.text('3 items · 20 TKC redeemed'), findsOneWidget);
      expect(find.text('₹430'), findsOneWidget);
    });

    testWidgets('Interactive star rating updates selection state and invokes onRatingChanged callback', (tester) async {
      tester.view.physicalSize = const Size(800, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      int selectedRating = 0;
      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: DeliveredOrderScreen(
            order: order,
            onRatingChanged: (r) => selectedRating = r,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.star_outline_rounded), findsNWidgets(5));
      expect(find.byIcon(Icons.star_rounded), findsNothing);

      // Tap 4th star
      final starIcons = find.byIcon(Icons.star_outline_rounded);
      await tester.tap(starIcons.at(3));
      await tester.pumpAndSettle();

      expect(selectedRating, equals(4));
      expect(find.byIcon(Icons.star_rounded), findsNWidgets(4));
      expect(find.byIcon(Icons.star_outline_rounded), findsOneWidget);
    });

    testWidgets('Interactive callbacks work (onBack, onShareReview, onReorder, onOrderDetails, onNavTap)', (tester) async {
      tester.view.physicalSize = const Size(800, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      bool backed = false;
      bool reviewShared = false;
      bool reordered = false;
      bool detailsViewed = false;
      int? tappedIndex;

      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: DeliveredOrderScreen(
            order: order,
            onBack: () => backed = true,
            onShareReview: () => reviewShared = true,
            onReorder: () => reordered = true,
            onOrderDetails: () => detailsViewed = true,
            onNavTap: (i) => tappedIndex = i,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Back
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();
      expect(backed, isTrue);

      // Tap Share food review
      await tester.tap(find.text('Share food review'));
      await tester.pumpAndSettle();
      expect(reviewShared, isTrue);

      // Tap Reorder
      await tester.tap(find.text('Reorder'));
      await tester.pumpAndSettle();
      expect(reordered, isTrue);

      // Tap Order details
      await tester.tap(find.text('Order details'));
      await tester.pumpAndSettle();
      expect(detailsViewed, isTrue);

      // Tap Explore tab (index 1)
      await tester.tap(find.text('Explore'));
      await tester.pumpAndSettle();
      expect(tappedIndex, equals(1));
    });

    testWidgets('End-to-End: DeliveredOrderScreen -> Order details navigates to OrderDetailsScreen and back', (tester) async {
      tester.view.physicalSize = const Size(800, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: DeliveredOrderScreen(order: order),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Khaana aa gaya!'), findsOneWidget);
      expect(find.byType(OrderDetailsScreen), findsNothing);

      // Tap Order details button
      await tester.tap(find.text('Order details'));
      await tester.pumpAndSettle();

      // Should navigate to OrderDetailsScreen for the SAME order
      expect(find.byType(OrderDetailsScreen), findsOneWidget);
      expect(find.text('Order confirmed'), findsOneWidget);
      expect(find.text('#THK84291'), findsWidgets);
      expect(find.text('Shadab Biryani'), findsWidgets);

      // Tap Back on OrderDetailsScreen
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      // Back on DeliveredOrderScreen
      expect(find.byType(DeliveredOrderScreen), findsOneWidget);
      expect(find.text('Khaana aa gaya!'), findsOneWidget);
      expect(find.byType(OrderDetailsScreen), findsNothing);
    });

    testWidgets('End-to-End: DeliveredOrderScreen -> Reorder navigates to CartScreen and back', (tester) async {
      tester.view.physicalSize = const Size(800, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: DeliveredOrderScreen(order: order),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Khaana aa gaya!'), findsOneWidget);
      expect(find.byType(CartScreen), findsNothing);

      // Tap Reorder button
      await tester.tap(find.text('Reorder'));
      await tester.pumpAndSettle();

      // Should navigate to CartScreen with items populated
      expect(find.byType(CartScreen), findsOneWidget);
      expect(find.text('Shadab Biryani'), findsWidgets);
      expect(find.textContaining('Proceed to checkout'), findsOneWidget);

      // Tap Back on CartScreen
      await tester.tap(find.byIcon(Icons.chevron_left_rounded));
      await tester.pumpAndSettle();

      // Back on DeliveredOrderScreen
      expect(find.byType(DeliveredOrderScreen), findsOneWidget);
      expect(find.text('Khaana aa gaya!'), findsOneWidget);
      expect(find.byType(CartScreen), findsNothing);
    });

    testWidgets('Delivery State Transition: OnTheWayScreen with OrderTrackingStatus.delivered displays DeliveredOrderScreen', (tester) async {
      tester.view.physicalSize = const Size(800, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final deliveredOrder = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
        trackingStatus: OrderTrackingStatus.delivered,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OnTheWayScreen(order: deliveredOrder),
        ),
      );
      await tester.pumpAndSettle();

      // Directly renders DeliveredOrderScreen as the final state
      expect(find.byType(DeliveredOrderScreen), findsOneWidget);
      expect(find.text('Khaana aa gaya!'), findsOneWidget);
      expect(find.text('Enjoy every last grain.'), findsOneWidget);
      expect(find.text('DELIVERED · 01 NOV 2026 · 2:12 PM'), findsOneWidget);
    });
  });

  group('THEKAA Profile / My THEKAA Screen Suite', () {
    testWidgets('ProfileScreen renders all visual elements matching reference screenshot', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(showBottomNav: true),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.byType(ProfileHeader), findsOneWidget);
      expect(find.text('My THEKAA'), findsOneWidget);
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);

      // Avatar & user info
      expect(find.byType(ProfileAvatarSection), findsOneWidget);
      expect(find.text('hero M.'), findsOneWidget);
      expect(find.text('@herom'), findsOneWidget);
      expect(find.text('Hyderabad on a plate. Biryani, chai & honest stories.'), findsOneWidget);

      // Stats row
      expect(find.byType(ProfileStatsRow), findsOneWidget);
      expect(find.text('48'), findsOneWidget);
      expect(find.text('Posts'), findsOneWidget);
      expect(find.text('2.4K'), findsOneWidget);
      expect(find.text('Followers'), findsOneWidget);
      expect(find.text('312'), findsOneWidget);
      expect(find.text('Following'), findsOneWidget);

      // Edit profile button
      expect(find.byType(EditProfileButton), findsOneWidget);
      expect(find.text('Edit profile'), findsOneWidget);
      expect(find.byIcon(Icons.edit_outlined), findsOneWidget);

      // THEKAA coins card
      expect(find.byType(ProfileCoinsCard), findsOneWidget);
      expect(find.text('1,200 THEKAA Coins'), findsOneWidget);
      expect(find.text('Your good taste, appreciated'), findsOneWidget);
      expect(find.text('View wallet'), findsOneWidget);

      // Profile menu container
      expect(find.byType(ProfileMenuContainer), findsOneWidget);
      expect(find.text('Account details'), findsOneWidget);
      expect(find.text('Personal information & sign-in'), findsOneWidget);
      expect(find.byIcon(Icons.person_outline_rounded), findsOneWidget);

      expect(find.text('Saved addresses'), findsOneWidget);
      expect(find.text('Home, Work & your favourite places'), findsOneWidget);
      expect(find.byIcon(Icons.location_on_outlined), findsOneWidget);

      expect(find.text('Food preferences'), findsOneWidget);
      expect(find.text('Make discovery feel more like you'), findsOneWidget);
      expect(find.byIcon(Icons.restaurant_outlined), findsOneWidget);

      expect(find.text('Help & Support'), findsOneWidget);
      expect(find.text('Your account, your control'), findsOneWidget);
      expect(find.byIcon(Icons.verified_user_outlined), findsOneWidget);

      // Single bottom navigation bar
      expect(find.byType(ThekaaBottomNavBar), findsOneWidget);
    });

    testWidgets('ProfileScreen renders dynamic user data from UserProfile model', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      const customProfile = UserProfile(
        name: 'Aisha Rao',
        handle: '@aisharao',
        bio: 'Exploring every Haleem spot in Charminar.',
        postsCount: 112,
        followersCount: '8.9K',
        followingCount: 450,
        coinBalance: 3450,
        coinsSubtitle: 'Elite Food Connoisseur',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(
            profile: customProfile,
            showBottomNav: false,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Aisha Rao'), findsOneWidget);
      expect(find.text('@aisharao'), findsOneWidget);
      expect(find.text('Exploring every Haleem spot in Charminar.'), findsOneWidget);
      expect(find.text('112'), findsOneWidget);
      expect(find.text('8.9K'), findsOneWidget);
      expect(find.text('450'), findsOneWidget);
      expect(find.text('3,450 THEKAA Coins'), findsOneWidget);
      expect(find.text('Elite Food Connoisseur'), findsOneWidget);
      expect(find.byType(ThekaaBottomNavBar), findsNothing);
    });

    testWidgets('ProfileScreen action callbacks trigger when tapped', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      bool settingsTapped = false;
      bool editTapped = false;
      bool walletTapped = false;
      bool accountTapped = false;
      bool addressesTapped = false;
      bool foodPrefsTapped = false;
      bool helpTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ProfileScreen(
            showBottomNav: false,
            onSettingsTap: () => settingsTapped = true,
            onEditProfile: () => editTapped = true,
            onViewWallet: () => walletTapped = true,
            onAccountDetails: () => accountTapped = true,
            onSavedAddresses: () => addressesTapped = true,
            onFoodPreferences: () => foodPrefsTapped = true,
            onHelpSupport: () => helpTapped = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.settings_outlined));
      expect(settingsTapped, isTrue);

      await tester.tap(find.text('Edit profile'));
      expect(editTapped, isTrue);

      await tester.tap(find.text('View wallet'));
      expect(walletTapped, isTrue);

      await tester.tap(find.text('Account details'));
      expect(accountTapped, isTrue);

      await tester.tap(find.text('Saved addresses'));
      expect(addressesTapped, isTrue);

      await tester.tap(find.text('Food preferences'));
      expect(foodPrefsTapped, isTrue);

      await tester.tap(find.text('Help & Support'));
      expect(helpTapped, isTrue);
    });

    testWidgets('MainScaffold Profile Tab has exactly one bottom navigation bar with Profile active', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      // Navigate to Profile tab
      await tester.tap(find.text('Profile').first);
      await tester.pumpAndSettle();

      // Ensure Profile screen is displayed
      expect(find.text('My THEKAA'), findsOneWidget);
      expect(find.text('hero M.'), findsOneWidget);

      // Verify EXACTLY ONE bottom navigation bar exists across the entire app hierarchy
      expect(find.byType(ThekaaBottomNavBar), findsOneWidget);
    });
  });
}
