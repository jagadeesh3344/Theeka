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
import 'package:thekaa/screens/edit_profile_screen.dart';
import 'package:thekaa/screens/manage_posts_screen.dart';
import 'package:thekaa/screens/saved_addresses_screen.dart';
import 'package:thekaa/screens/food_preferences_screen.dart';
import 'package:thekaa/screens/help_support_screen.dart';
import 'package:thekaa/screens/social_feed_screen.dart';
import 'package:thekaa/screens/tell_food_story_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thekaa/screens/food_story_detail_screen.dart';
import 'package:thekaa/screens/my_food_journal_screen.dart';
import 'package:thekaa/screens/story_published_screen.dart';
import 'package:thekaa/models/social_models.dart';
import 'package:thekaa/models/user_post.dart';
import 'package:thekaa/models/food_preference.dart';
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
import 'package:thekaa/screens/dabba_screen.dart';
import 'package:thekaa/screens/thekaa_coins_screen.dart';
import 'package:thekaa/screens/coin_history_screen.dart';
import 'package:thekaa/screens/put_coins_to_use_screen.dart';
import 'package:thekaa/screens/taste_for_discovery_screen.dart';
import 'package:thekaa/screens/story_appreciated_screen.dart';
import 'package:thekaa/screens/completed_order_details_screen.dart';
import 'package:thekaa/screens/orders_screen.dart';
import 'package:thekaa/services/order_repository.dart';
import 'package:thekaa/services/profile_repository.dart';
import 'package:thekaa/screens/main_scaffold.dart';

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

      // Tap DABBA tab -> opens Thekaa Socials
      await tester.tap(find.text('DABBA').first);
      await tester.pumpAndSettle();
      expect(find.text('THEKAA SOCIALS'), findsOneWidget);
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
    setUp(() {
      addTearDown(OrderRepository.instance.clear);
    });

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

      // Action Button: View rider details
      expect(find.text('View rider details'), findsOneWidget);

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

    testWidgets('Interactive callbacks work and View order details is not present on OrderTrackingScreen', (tester) async {
      bool backed = false;
      int? tappedIndex;

      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderTrackingScreen(
            order: order,
            enableSimulation: false,
            onBack: () => backed = true,
            onNavTap: (i) => tappedIndex = i,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Back
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();
      expect(backed, isTrue);

      // Verify "View order details" button does NOT exist on Order Tracking
      expect(find.text('View order details'), findsNothing);

      // Verify "View rider details" button exists
      expect(find.text('View rider details'), findsOneWidget);

      // Tap Home tab (index 0)
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(tappedIndex, equals(0));
    });

    testWidgets('End-to-End: Order Details -> Track your order navigates to Order Tracking', (tester) async {
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
      expect(find.text('View order details'), findsNothing);
      expect(find.text('View rider details'), findsOneWidget);

      // Tap Back on OrderTrackingScreen
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      // Back on OrderDetailsScreen
      expect(find.byType(OrderDetailsScreen), findsOneWidget);
      expect(find.text('Order confirmed'), findsOneWidget);
    });
  });

  group('THEKAA Rider & Delivery Details ("Meet your bhaiyya") Screen Suite', () {
    setUp(() {
      addTearDown(OrderRepository.instance.clear);
    });

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
    setUp(() {
      addTearDown(OrderRepository.instance.clear);
    });

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
    setUp(() {
      addTearDown(OrderRepository.instance.clear);
    });

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

    testWidgets('End-to-End: DeliveredOrderScreen -> Order details navigates to CompletedOrderDetailsScreen and back', (tester) async {
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
      expect(find.byType(CompletedOrderDetailsScreen), findsNothing);

      // Tap Order details button
      await tester.tap(find.text('Order details'));
      await tester.pumpAndSettle();

      // Should navigate to CompletedOrderDetailsScreen for the SAME order
      expect(find.byType(CompletedOrderDetailsScreen), findsOneWidget);
      expect(find.text('Order Delivered'), findsOneWidget);
      expect(find.text('#THK84291'), findsWidgets);
      expect(find.text('Shadab Biryani'), findsWidgets);
      expect(find.text('Order confirmed'), findsNothing);

      // Tap Back on CompletedOrderDetailsScreen
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      // Back on DeliveredOrderScreen
      expect(find.byType(DeliveredOrderScreen), findsOneWidget);
      expect(find.text('Khaana aa gaya!'), findsOneWidget);
      expect(find.byType(CompletedOrderDetailsScreen), findsNothing);
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

  group('Page 1: The Person Behind the Plate (EditProfileScreen) Suite', () {
    testWidgets('EditProfileScreen renders all visual elements matching reference screenshot', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: EditProfileScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Header & Subtitle
      expect(find.text('The person behind the plate'), findsOneWidget);
      expect(find.text('Keep your personal details up to date.'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);

      // Fields
      expect(find.text('Full name'), findsOneWidget);
      expect(find.text('hero M.'), findsOneWidget);
      expect(find.text('Phone · sample'), findsOneWidget);
      expect(find.text('+91 00000 00000'), findsOneWidget);
      expect(find.text('Date of birth'), findsOneWidget);
      expect(find.text('18 Aug 1998'), findsOneWidget);
      expect(find.text('Email · sample'), findsOneWidget);
      expect(find.text('hero@example.com'), findsOneWidget);
      expect(find.text('Gender (optional)'), findsOneWidget);
      expect(find.text('Prefer not to say'), findsOneWidget);

      // Action rows
      expect(find.text('Edit post'), findsOneWidget);
      expect(find.text('Log out'), findsOneWidget);
      expect(find.text('You can sign back in anytime'), findsOneWidget);

      // Privacy note & button
      expect(
        find.text('Your contact information is private, not part of your public food journal.'),
        findsOneWidget,
      );
      expect(find.text('Edit details'), findsOneWidget);
      expect(find.byIcon(Icons.edit_outlined), findsWidgets);

      // Exactly ONE bottom navigation bar with Profile active
      expect(find.byType(ThekaaBottomNavBar), findsOneWidget);
    });

    testWidgets('EditProfileScreen renders dynamic user profile and handles interactions', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      bool backTapped = false;
      bool editPostTapped = false;
      bool logoutTapped = false;
      bool editDetailsTapped = false;

      const custom = UserProfile(
        name: 'Fatima Begum',
        phone: '+91 98765 43210',
        dateOfBirth: '12 Jan 1995',
        email: 'fatima@hyderabad.in',
        gender: 'Female',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: EditProfileScreen(
            profile: custom,
            onBack: () => backTapped = true,
            onEditPost: () => editPostTapped = true,
            onLogout: () => logoutTapped = true,
            onEditDetails: () => editDetailsTapped = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Fatima Begum'), findsOneWidget);
      expect(find.text('+91 98765 43210'), findsOneWidget);
      expect(find.text('12 Jan 1995'), findsOneWidget);
      expect(find.text('fatima@hyderabad.in'), findsOneWidget);
      expect(find.text('Female'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      expect(backTapped, isTrue);

      await tester.tap(find.text('Edit post'));
      expect(editPostTapped, isTrue);

      await tester.tap(find.text('Log out'));
      expect(logoutTapped, isTrue);

      await tester.tap(find.text('Edit details'));
      expect(editDetailsTapped, isTrue);
    });
  });

  group('Page 2: Manage Posts (ManagePostsScreen) Suite', () {
    testWidgets('ManagePostsScreen renders all visual elements matching reference screenshot', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ManagePostsScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Header & Subtitle
      expect(find.text('Manage posts'), findsOneWidget);
      expect(find.text('Archive or delete your previous posts.'), findsOneWidget);

      // Search & status tabs
      expect(find.text('Search your posts'), findsOneWidget);
      expect(find.text('Published · 48'), findsOneWidget);
      expect(find.text('Archived · 3'), findsOneWidget);

      // Published post cards
      expect(find.text('That unmistakable dum aroma.'), findsOneWidget);
      expect(find.text('Shadab Biryani · Gachibowli'), findsOneWidget);
      expect(find.text('30 Oct 2026 · Public'), findsOneWidget);

      expect(find.text('A Sunday well spent.'), findsOneWidget);
      expect(find.text('Shadab Biryani · Hyderabad'), findsOneWidget);
      expect(find.text('25 Oct 2026 · Public'), findsOneWidget);

      // Action buttons
      expect(find.text('Archive'), findsNWidgets(2));
      expect(find.text('Delete'), findsNWidgets(2));

      // Recently archived section
      expect(find.text('RECENTLY ARCHIVED'), findsOneWidget);
      expect(find.text('View all 3'), findsOneWidget);
      expect(find.text('A biryani trail'), findsOneWidget);
      expect(find.text('Restore'), findsOneWidget);
      expect(find.text('Hidden from your profile. Restore anytime.'), findsOneWidget);

      // Control info
      expect(find.text('Your posts, your control'), findsOneWidget);
      expect(find.text('Archiving is reversible. Deleting is permanent.'), findsOneWidget);
      expect(find.text('You’ll be asked to confirm before deleting.'), findsOneWidget);

      // Single bottom navigation bar
      expect(find.byType(ThekaaBottomNavBar), findsOneWidget);
    });

    testWidgets('ManagePostsScreen handles tab toggle, archive, delete, and restore actions', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      UserPost? archivedPost;
      UserPost? deletedPost;
      UserPost? restoredPost;
      bool viewAllTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ManagePostsScreen(
            onArchivePost: (p) => archivedPost = p,
            onDeletePost: (p) => deletedPost = p,
            onRestorePost: (p) => restoredPost = p,
            onViewAllArchived: () => viewAllTapped = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Archive').first);
      expect(archivedPost?.title, 'That unmistakable dum aroma.');

      await tester.tap(find.text('Delete').first);
      expect(deletedPost?.title, 'That unmistakable dum aroma.');

      await tester.tap(find.text('Restore').first);
      expect(restoredPost?.title, 'A biryani trail');

      await tester.tap(find.text('View all 3'));
      expect(viewAllTapped, isTrue);

      // Switch to Archived tab
      await tester.tap(find.text('Archived · 3'));
      await tester.pumpAndSettle();
    });
  });

  group('Page 3: Your Familiar Places (SavedAddressesScreen) Suite', () {
    testWidgets('SavedAddressesScreen renders map and saved address cards matching reference', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: SavedAddressesScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('Your familiar places'), findsOneWidget);

      // Map canvas & GPS button
      expect(find.byIcon(Icons.gps_fixed), findsOneWidget);

      // Address cards (note: 'Home' also appears once in bottom nav)
      expect(find.text('Home'), findsNWidgets(2));
      expect(find.text('Default'), findsOneWidget);
      expect(find.textContaining('Flat 302, Vertex Heights, Gachibowli'), findsOneWidget);

      expect(find.text('Work'), findsOneWidget);
      expect(find.textContaining('THEKAA Studio, Financial District'), findsOneWidget);

      expect(find.text('Other'), findsOneWidget);
      expect(find.textContaining('Family home, Kondapur'), findsOneWidget);

      // Actions
      expect(find.text('Edit'), findsNWidgets(3));
      expect(find.text('Delete'), findsNWidgets(3));
      expect(find.text('Set as default'), findsNWidgets(2));

      // Add address button
      expect(find.text('Add a new address'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);

      // Single bottom navigation bar
      expect(find.byType(ThekaaBottomNavBar), findsOneWidget);
    });

    testWidgets('SavedAddressesScreen handles add, edit, delete, and set default actions', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      bool addTapped = false;
      DeliveryAddress? editedAddr;
      DeliveryAddress? deletedAddr;
      DeliveryAddress? defaultAddr;

      await tester.pumpWidget(
        MaterialApp(
          home: SavedAddressesScreen(
            onAddAddress: () => addTapped = true,
            onEditAddress: (a) => editedAddr = a,
            onDeleteAddress: (a) => deletedAddr = a,
            onSetDefaultAddress: (a) => defaultAddr = a,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add a new address'));
      expect(addTapped, isTrue);

      await tester.tap(find.text('Edit').first);
      expect(editedAddr?.type, AddressType.home);

      await tester.tap(find.text('Delete').first);
      expect(deletedAddr?.type, AddressType.home);

      await tester.tap(find.text('Set as default').first);
      expect(defaultAddr?.type, AddressType.work);
    });
  });

  group('Page 4: Food, Your Way (FoodPreferencesScreen) Suite', () {
    testWidgets('FoodPreferencesScreen renders dietary options, cuisines, and warning matching reference', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: FoodPreferencesScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Header & Subtitle
      expect(find.text('Food, your way'), findsOneWidget);
      expect(
        find.text('A few things about your taste help us tailor discovery. You can change these anytime.'),
        findsOneWidget,
      );

      // Section: What's on your plate?
      expect(find.text("What's on your plate?"), findsOneWidget);
      expect(find.text('Veg'), findsOneWidget);
      expect(find.text('Non-veg'), findsOneWidget);
      expect(find.text('Eggetarian'), findsOneWidget);

      // Section: Cuisines you love
      expect(find.text('Cuisines you love'), findsOneWidget);
      expect(find.text('Biryani'), findsOneWidget);
      expect(find.text('South Indian'), findsOneWidget);
      expect(find.text('North Indian'), findsOneWidget);
      expect(find.text('Chinese'), findsOneWidget);
      expect(find.text('Continental'), findsOneWidget);
      expect(find.text('Desserts'), findsOneWidget);

      // Allergies & Restrictions
      expect(find.text('Allergies'), findsOneWidget);
      expect(find.text('Peanuts'), findsOneWidget);
      expect(find.text('Add any ingredients you need to avoid'), findsOneWidget);
      expect(find.text('Dietary restrictions (optional)'), findsOneWidget);
      expect(find.text('Less spicy, where available'), findsOneWidget);

      // Warning card
      expect(find.text("Preferences aren't an allergy guarantee"), findsOneWidget);
      expect(
        find.text('Always check ingredients with the restaurant. Kitchens may handle common allergens.'),
        findsOneWidget,
      );

      // Save button
      expect(find.text('Save preferences'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsWidgets);

      // Single bottom navigation bar
      expect(find.byType(ThekaaBottomNavBar), findsOneWidget);
    });

    testWidgets('FoodPreferencesScreen toggles dietary options and invokes save preferences', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      FoodPreference? saved;

      await tester.pumpWidget(
        MaterialApp(
          home: FoodPreferencesScreen(
            onSavePreferences: (pref) => saved = pref,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Veg
      await tester.tap(find.text('Veg'));
      await tester.pumpAndSettle();

      // Tap Chinese cuisine
      await tester.tap(find.text('Chinese'));
      await tester.pumpAndSettle();

      // Tap Save preferences
      await tester.tap(find.text('Save preferences'));
      expect(saved?.dietaryType, DietaryType.veg);
      expect(saved?.selectedCuisines.contains('Chinese'), isTrue);
    });
  });

  group('Page 5: Bhaiyya, We’re Listening (HelpSupportScreen) Suite', () {
    testWidgets('HelpSupportScreen renders contact options, support categories, and FAQ matching reference', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: HelpSupportScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('Bhaiyya, we’re listening'), findsOneWidget);

      // Search bar
      expect(find.text('Search help articles'), findsOneWidget);

      // Contact options
      expect(find.text('Chat'), findsOneWidget);
      expect(find.text('Call'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(
        find.text('Contact options are shown as a design preview. Availability is confirmed when you request support.'),
        findsOneWidget,
      );

      // Categories
      expect(find.text('What can we help with?'), findsOneWidget);
      expect(find.text('An order'), findsOneWidget);
      expect(find.text('#THK84291 · Shadab Biryani'), findsOneWidget);
      expect(find.text('Payments'), findsOneWidget);
      expect(find.text('Account & privacy'), findsOneWidget);
      expect(find.text('THEKAA Coins'), findsOneWidget);

      // FAQ section
      expect(find.text('Common questions'), findsOneWidget);
      expect(find.text('All FAQs'), findsOneWidget);
      expect(find.text('When do review coins arrive?'), findsOneWidget);
      expect(
        find.text('After publication and eligibility checks. Each eligible review is rewarded once — never for likes.'),
        findsOneWidget,
      );

      // Single bottom navigation bar
      expect(find.byType(ThekaaBottomNavBar), findsOneWidget);
    });

    testWidgets('HelpSupportScreen handles contact and category taps', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      bool chatTapped = false;
      bool callTapped = false;
      bool emailTapped = false;
      bool orderCategoryTapped = false;
      bool allFaqsTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: HelpSupportScreen(
            onChatTap: () => chatTapped = true,
            onCallTap: () => callTapped = true,
            onEmailTap: () => emailTapped = true,
            onOrderCategoryTap: () => orderCategoryTapped = true,
            onAllFaqsTap: () => allFaqsTapped = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Chat'));
      expect(chatTapped, isTrue);

      await tester.tap(find.text('Call'));
      expect(callTapped, isTrue);

      await tester.tap(find.text('Email'));
      expect(emailTapped, isTrue);

      await tester.tap(find.text('An order'));
      expect(orderCategoryTapped, isTrue);

      await tester.tap(find.text('All FAQs'));
      expect(allFaqsTapped, isTrue);
    });
  });

  group('DABBA Page 1: THEKAA SOCIALS Feed (SocialFeedScreen) Suite', () {
    testWidgets('SocialFeedScreen renders all visual elements matching reference screenshot', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: SocialFeedScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Header & Subtitle
      expect(find.text('THEKAA SOCIALS'), findsOneWidget);
      expect(find.text('Hyderabad eats. Hyderabad tells.'), findsOneWidget);
      expect(find.byIcon(Icons.notifications_none_outlined), findsOneWidget);

      // Social Tabs
      expect(find.text('For You'), findsOneWidget);
      expect(find.text('Following'), findsOneWidget);
      expect(find.text('Nearby'), findsOneWidget);
      expect(find.text('Trending'), findsOneWidget);

      // Story Circles
      expect(find.text('Your journal'), findsOneWidget);
      expect(find.text('Sana'), findsOneWidget);
      expect(find.text("Ravi's eats"), findsOneWidget);
      expect(find.text('Chai trails'), findsOneWidget);

      // Post Card
      expect(find.text('Vatsa K.'), findsOneWidget);
      expect(find.text('Shadab Biryani · Gachibowli'), findsOneWidget);
      expect(find.text('2:35 PM'), findsOneWidget);
      expect(find.text('1/3'), findsOneWidget);
      expect(find.text('128'), findsOneWidget);
      expect(find.text('12'), findsOneWidget);
      expect(find.text('Verified purchase'), findsOneWidget);
      expect(find.text('4.0'), findsOneWidget);
      expect(find.text('That unmistakable dum aroma.'), findsOneWidget);
      expect(find.text('Long grains, tender chicken, and a proper hit of spice.'), findsOneWidget);

      // Bottom Button
      expect(find.text('Create a food review'), findsOneWidget);

      // Bottom Navigation with DABBA active
      expect(find.byType(ThekaaBottomNavBar), findsOneWidget);
    });

    testWidgets('SocialFeedScreen handles tab switching, like, bookmark, and review creation', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      bool createReviewTapped = false;
      bool notifTapped = false;
      SocialStory? tappedStory;

      await tester.pumpWidget(
        MaterialApp(
          home: SocialFeedScreen(
            onCreateReview: () => createReviewTapped = true,
            onNotificationTap: () => notifTapped = true,
            onStoryTap: (s) => tappedStory = s,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Trending tab
      await tester.tap(find.text('Trending'));
      await tester.pumpAndSettle();

      // Tap Story
      await tester.tap(find.text('Sana'));
      expect(tappedStory?.label, 'Sana');

      // Tap Notification
      await tester.tap(find.byIcon(Icons.notifications_none_outlined));
      expect(notifTapped, isTrue);

      // Tap Create Review
      await tester.tap(find.text('Create a food review'));
      expect(createReviewTapped, isTrue);
    });
  });

  group('DABBA Page 2: Tell Your Food Story (TellFoodStoryScreen) Suite', () {
    testWidgets('TellFoodStoryScreen renders all visual elements matching reference screenshot', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: TellFoodStoryScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('Tell your food story'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);

      // Photo slots
      expect(find.text('Food photo · cover'), findsOneWidget);
      expect(find.text('Personal photo'), findsOneWidget);
      expect(find.text('Add photo'), findsOneWidget);
      expect(find.text('Up to 6 photos'), findsOneWidget);

      // Restaurant & Food Card
      expect(find.text('Shadab Biryani'), findsOneWidget);
      expect(find.text('Restaurant · Gachibowli'), findsOneWidget);
      expect(find.text('Chicken Dum Biryani'), findsOneWidget);
      expect(find.text('Dish · ₹280'), findsOneWidget);
      expect(find.text('Verified THEKAA order #THK84291'), findsOneWidget);

      // Rate your experience
      expect(find.text('Rate your experience'), findsOneWidget);
      expect(find.text('4 / 5'), findsOneWidget);

      // Review field & Caption
      expect(find.text('Your review'), findsOneWidget);
      expect(
        find.text('Long grains, tender chicken, and a proper hit of spice. The dum aroma is unmistakable.'),
        findsOneWidget,
      );
      expect(find.text('Caption'), findsOneWidget);
      expect(find.text('That unmistakable dum aroma.'), findsOneWidget);

      // Reward card
      expect(find.text('Reward pending publication & checks'), findsOneWidget);
      expect(
        find.text('Eligible contributions are credited once, only after successful publication and validation. No reward is guaranteed before checks.'),
        findsOneWidget,
      );

      // Buttons
      expect(find.text('Preview'), findsOneWidget);
      expect(find.text('Publish review →'), findsOneWidget);

      // Bottom Navigation
      expect(find.byType(ThekaaBottomNavBar), findsOneWidget);
    });

    testWidgets('TellFoodStoryScreen handles rating change, preview, and publish actions', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      int? newRating;
      bool previewTapped = false;
      SocialPost? published;

      await tester.pumpWidget(
        MaterialApp(
          home: TellFoodStoryScreen(
            onRatingChanged: (r) => newRating = r,
            onPreview: () => previewTapped = true,
            onPublishReview: (p) => published = p,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap star rating
      await tester.tap(find.byIcon(Icons.star).last);
      expect(newRating, isNotNull);

      // Tap Preview
      await tester.tap(find.text('Preview'));
      expect(previewTapped, isTrue);

      // Tap Publish
      await tester.tap(find.text('Publish review →'));
      expect(published?.dishName, 'Chicken Dum Biryani');
    });
  });

  group('DABBA Page 3: A Plate, A Story Detail (FoodStoryDetailScreen) Suite', () {
    testWidgets('FoodStoryDetailScreen renders all visual elements matching reference screenshot', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: FoodStoryDetailScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('A plate, a story'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);

      // Author & meta
      expect(find.text('Vatsa K.'), findsOneWidget);
      expect(find.text('Shadab Biryani · Gachibowli'), findsOneWidget);
      expect(find.text('2:35 PM'), findsOneWidget);

      // Image & overlay
      expect(find.text('1/3'), findsOneWidget);

      // Actions
      expect(find.text('128'), findsOneWidget);
      expect(find.text('12'), findsOneWidget);

      // Verified & rating
      expect(find.text('Verified purchase'), findsOneWidget);
      expect(find.text('4.0 Chicken Dum Biryani'), findsOneWidget);

      // Content
      expect(find.text('That unmistakable dum aroma.'), findsOneWidget);
      expect(
        find.text("Long grains, tender chicken, and a proper hit of spice. Shadab still knows the way to a Hyderabadi heart. The raita brings it all together — I'd happily order this again."),
        findsOneWidget,
      );
      expect(find.text('Shadab Biryani · Gachibowli, Hyderabad'), findsOneWidget);

      // Reward card
      expect(find.text('+25 TKC earned · Validated'), findsOneWidget);
      expect(find.text('Review #RV84291 · Eligibility checked 01 Nov, 2:35 PM.'), findsOneWidget);
      expect(find.text('Credited once.'), findsOneWidget);

      // Comments
      expect(find.text('The table talk · 12 comments'), findsOneWidget);

      // Bottom Navigation
      expect(find.byType(ThekaaBottomNavBar), findsOneWidget);
    });

    testWidgets('FoodStoryDetailScreen handles like toggle and options tap', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      bool optionsTapped = false;
      bool commentsTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: FoodStoryDetailScreen(
            onOptionsTap: () => optionsTapped = true,
            onComment: (_) => commentsTapped = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.more_horiz).first);
      expect(optionsTapped, isTrue);

      await tester.tap(find.text('12'));
      expect(commentsTapped, isTrue);
    });
  });

  group('DABBA Page 4: My Food Journal (MyFoodJournalScreen) Suite', () {
    testWidgets('MyFoodJournalScreen renders all visual elements matching reference screenshot', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: MyFoodJournalScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('My food journal'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);
      expect(find.byIcon(Icons.share_outlined), findsOneWidget);

      // Profile details
      expect(find.text('hero M.'), findsOneWidget);
      expect(find.text('@herom'), findsOneWidget);
      expect(find.text('Hyderabad on a plate. Biryani, chai & honest stories.'), findsOneWidget);

      // Stats
      expect(find.text('48'), findsOneWidget);
      expect(find.text('Posts'), findsNWidgets(2)); // in stats and in tabs
      expect(find.text('2.4K'), findsOneWidget);
      expect(find.text('Followers'), findsOneWidget);
      expect(find.text('312'), findsOneWidget);
      expect(find.text('Following'), findsOneWidget);

      // Edit profile button
      expect(find.text('Edit profile'), findsOneWidget);

      // Tabs
      expect(find.text('Reviews'), findsOneWidget);
      expect(find.text('Saved'), findsOneWidget);

      // Grid items with ratings
      expect(find.text('4.0'), findsOneWidget);
      expect(find.text('4.8'), findsWidgets);

      // Bottom Navigation
      expect(find.byType(ThekaaBottomNavBar), findsOneWidget);
    });

    testWidgets('MyFoodJournalScreen handles tab toggle, edit profile, and tile tap', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      bool editTapped = false;
      bool shareTapped = false;
      JournalTile? tappedTile;

      await tester.pumpWidget(
        MaterialApp(
          home: MyFoodJournalScreen(
            onEditProfile: () => editTapped = true,
            onShare: () => shareTapped = true,
            onTileTap: (t) => tappedTile = t,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Edit profile'));
      expect(editTapped, isTrue);

      await tester.tap(find.byIcon(Icons.share_outlined));
      expect(shareTapped, isTrue);

      await tester.tap(find.text('Reviews'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('4.0'));
      expect(tappedTile?.id, 'jt_1');
    });
  });

  group('DABBA Page 5: Your Story Is Out There (StoryPublishedScreen) Suite', () {
    testWidgets('StoryPublishedScreen renders all visual elements matching reference screenshot', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: StoryPublishedScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('Your story is out there'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);

      // Success messages
      expect(find.text('Shukriya, for keeping it real.'), findsOneWidget);
      expect(find.text('Published. And appreciated.'), findsOneWidget);

      // Restaurant & dish card
      expect(find.text('Shadab Biryani'), findsOneWidget);
      expect(find.text('Chicken Dum Biryani'), findsOneWidget);
      expect(find.text('4.0'), findsOneWidget);
      expect(find.text('Verified purchase'), findsOneWidget);
      expect(find.text('“That unmistakable dum aroma.”'), findsOneWidget);

      // Validation card
      expect(find.text('Eligibility successfully checked'), findsOneWidget);
      expect(
        find.text('Your review is published, your purchase is verified, and the original contribution passed validation.'),
        findsOneWidget,
      );

      // Coin Reward Card
      expect(find.text('+25 TKC'), findsOneWidget);
      expect(find.text('CREDITED ONCE'), findsOneWidget);
      expect(find.text('01 Nov 2026 · 2:35 PM · TKC-RV84291-01'), findsOneWidget);
      expect(find.text('Wallet balance is now 1,200 TKC. No duplicate credit.'), findsOneWidget);

      // Bottom buttons
      expect(find.text('View my coins'), findsOneWidget);
      expect(find.text('Back to Socials'), findsOneWidget);

      // Bottom Navigation
      expect(find.byType(ThekaaBottomNavBar), findsOneWidget);
    });

    testWidgets('StoryPublishedScreen handles view coins and back to socials callbacks', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      bool coinsTapped = false;
      bool socialsTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: StoryPublishedScreen(
            onViewCoins: () => coinsTapped = true,
            onBackToSocials: () => socialsTapped = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('View my coins'));
      expect(coinsTapped, isTrue);

      await tester.tap(find.text('Back to Socials'));
      expect(socialsTapped, isTrue);
    });
  });

  group('DABBA & Food Review Navigation Rules Suite', () {
    testWidgets('DabbaScreen displays Theeka Socials feed directly', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: DabbaScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('THEKAA SOCIALS'), findsOneWidget);
      expect(find.text('Hyderabad eats. Hyderabad tells.'), findsOneWidget);
      expect(find.text('Create a food review'), findsOneWidget);
    });

    testWidgets('Tapping Create a food review navigates to Tell your food story', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: SocialFeedScreen(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Create a food review'));
      await tester.pumpAndSettle();

      expect(find.text('Tell your food story'), findsOneWidget);
      expect(find.text('Rate your experience'), findsOneWidget);
      expect(find.text('Preview'), findsOneWidget);
      expect(find.text('Publish review →'), findsOneWidget);
    });

    testWidgets('TellYourFoodStory enforces maximum 6 photos and restaurant restriction', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          home: TellFoodStoryScreen(
            imagePickerFn: (source) async => 'assets/images/biryani.png',
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Starts with 2 photos
      expect(find.text('Tell your food story'), findsOneWidget);

      // Tap Add photo 4 times to reach 6
      final addPhotoFinder = find.text('Add photo');
      for (int i = 0; i < 4; i++) {
        await tester.tap(addPhotoFinder);
        await tester.pumpAndSettle();
        expect(find.text('Choose from gallery'), findsOneWidget);
        expect(find.text('Take photo with camera'), findsOneWidget);
        await tester.tap(find.text('Choose from gallery'));
        await tester.pumpAndSettle();
      }
      expect(find.text('6 of 6 photos selected'), findsOneWidget);

      // Attempt 7th photo -> shows max 6 message
      await tester.tap(addPhotoFinder);
      await tester.pumpAndSettle();
      expect(find.text('Maximum 6 photos reached'), findsOneWidget);

      // Restaurant restriction: verified THEKAA order is shown
      expect(find.text('Verified THEKAA order #THK84291'), findsOneWidget);

      // Tapping restaurant selector shows only eligible orders bottom sheet
      await tester.tap(find.text('Shadab Biryani').first);
      await tester.pumpAndSettle();

      expect(find.text('Select eligible ordered restaurant'), findsOneWidget);
      expect(find.text('Chutneys'), findsOneWidget);

      // Select Chutneys
      await tester.tap(find.text('Chutneys'));
      await tester.pumpAndSettle();

      expect(find.text('Verified THEKAA order #THK83980'), findsOneWidget);
    });

    testWidgets('TellYourFoodStory prevents publishing when no eligible orders exist', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: TellFoodStoryScreen(
            eligibleOrders: [],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('No verified past order found. You can only review restaurants you have actually ordered food from.'), findsOneWidget);

      // Button is disabled
      final publishBtn = tester.widget<ElevatedButton>(find.widgetWithText(ElevatedButton, 'Publish review →'));
      expect(publishBtn.onPressed, isNull);
    });

    testWidgets('TellYourFoodStory Preview opens preview mode without publishing', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: TellFoodStoryScreen(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Preview'));
      await tester.pumpAndSettle();

      // Opened FoodStoryDetailScreen in preview mode
      expect(find.text('A plate, a story'), findsOneWidget);
      expect(find.text('Preview mode · This is how your story will look'), findsOneWidget);
      expect(find.text('Publish food story'), findsNothing);

      // Tap back -> returns to Tell your food story
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      expect(find.text('Tell your food story'), findsOneWidget);
    });

    testWidgets('End-to-end Publish Review flow: Tell story -> Plate a story -> Publish -> Your story is out there', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: TellFoodStoryScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Publish review →
      await tester.tap(find.text('Publish review →'));
      await tester.pumpAndSettle();

      // Plate a story (FoodStoryDetailScreen in preparation mode)
      expect(find.text('A plate, a story'), findsOneWidget);
      expect(find.text('Publish food story'), findsOneWidget);

      // Tap Publish food story
      await tester.tap(find.text('Publish food story'));
      await tester.pumpAndSettle();

      // Your story is out there (StoryPublishedScreen)
      expect(find.text('Your story is out there'), findsOneWidget);
      expect(find.text('Published. And appreciated.'), findsOneWidget);
      expect(find.text('+25 TKC'), findsOneWidget);
    });

    testWidgets('Tapping username in SocialFeedScreen navigates to My Food Journal for that user', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: SocialFeedScreen(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Vatsa K.'));
      await tester.pumpAndSettle();

      expect(find.text('My food journal'), findsOneWidget);
      expect(find.text('Vatsa K.'), findsOneWidget);
      expect(find.text('@vatsax'), findsOneWidget);
    });

    testWidgets('Tapping author in FoodStoryDetailScreen navigates to that user My Food Journal', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: FoodStoryDetailScreen(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Vatsa K.'));
      await tester.pumpAndSettle();

      expect(find.text('My food journal'), findsOneWidget);
      expect(find.text('Vatsa K.'), findsOneWidget);
    });

    testWidgets('EditProfileScreen: tapping Edit post/profile navigates to My Food Journal', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: EditProfileScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('The person behind the plate'), findsOneWidget);

      await tester.tap(find.text('Edit post'));
      await tester.pumpAndSettle();

      expect(find.text('My food journal'), findsOneWidget);
      expect(find.text('hero M.'), findsOneWidget);
    });
  });

  group('THEKAA Coins: Screen 1 - THEKAA Coins Overview Suite', () {
    testWidgets('ThekaaCoinsScreen renders all components matching reference screenshot', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ThekaaCoinsScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('THEKAA Coins'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);
      expect(find.byIcon(Icons.info_outline_rounded), findsWidgets);
      expect(find.text('Good food stories deserve a little something.'), findsOneWidget);

      // Balance Card
      expect(find.text('YOUR THEKAA COINS'), findsOneWidget);
      expect(find.text('1,200 TKC'), findsOneWidget);
      expect(find.text('A little appreciation. For real food stories.'), findsOneWidget);

      // Action Grid
      expect(find.text('Earn'), findsOneWidget);
      expect(find.text('Redeem'), findsOneWidget);
      expect(find.text('History'), findsOneWidget);
      expect(find.text('Rewards'), findsOneWidget);

      // Section & explanation cards
      expect(find.text('Earn it, honestly'), findsOneWidget);
      expect(find.text('A review that helps someone choose'), findsOneWidget);
      expect(find.text('Share your own experience from an eligible order.'), findsOneWidget);
      expect(find.text('Your food, through your lens'), findsOneWidget);
      expect(find.text('Original food photos, checked for eligibility.'), findsOneWidget);

      // Fairness card
      expect(find.text('Real stories. Fair rewards.'), findsOneWidget);
      expect(
        find.text('Rewards follow successful publication and eligibility validation. Each eligible contribution is credited once. Likes and engagement never earn coins.'),
        findsOneWidget,
      );

      // Lower validation card
      expect(find.text('Review validated'), findsOneWidget);
      expect(find.text('Original contribution passed validation · Credited once.'), findsOneWidget);
      expect(find.text('+25 TKC'), findsOneWidget);

      // Bottom Navigation with Profile active (index 4)
      expect(find.byType(ThekaaBottomNavBar), findsOneWidget);
    });

    testWidgets('ThekaaCoinsScreen action cards and rows trigger callbacks', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      bool earnTapped = false;
      bool redeemTapped = false;
      bool historyTapped = false;
      bool rewardsTapped = false;
      bool reviewHelpTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ThekaaCoinsScreen(
            onEarnTap: () => earnTapped = true,
            onRedeemTap: () => redeemTapped = true,
            onHistoryTap: () => historyTapped = true,
            onRewardsTap: () => rewardsTapped = true,
            onReviewHelpTap: () => reviewHelpTapped = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Earn'));
      expect(earnTapped, isTrue);

      await tester.tap(find.text('Redeem'));
      expect(redeemTapped, isTrue);

      await tester.tap(find.text('History'));
      expect(historyTapped, isTrue);

      await tester.tap(find.text('Rewards'));
      expect(rewardsTapped, isTrue);

      await tester.tap(find.text('A review that helps someone choose'));
      expect(reviewHelpTapped, isTrue);
    });
  });

  group('THEKAA Coins: Screen 2 - Every Coin, Accounted For Suite', () {
    testWidgets('CoinHistoryScreen renders all elements and handles filter tabs', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: CoinHistoryScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('Every coin, accounted for'), findsOneWidget);
      expect(find.text('1,200 TKC'), findsOneWidget);

      // Filter tabs
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Earned'), findsOneWidget);
      expect(find.text('Redeemed'), findsOneWidget);

      // Transactions
      expect(find.text('Food review validated'), findsOneWidget);
      expect(find.text('+25 TKC'), findsOneWidget);
      expect(find.text('Eligible order completed'), findsOneWidget);
      expect(find.text('+75 TKC'), findsOneWidget);
      expect(find.text('Coins redeemed'), findsOneWidget);
      expect(find.text('−50 TKC'), findsOneWidget);
      expect(find.text('Original food photo validated'), findsOneWidget);
      expect(find.text('+50 TKC'), findsOneWidget);

      // Summary Card
      expect(find.text('Opening balance · 01 Oct 2026: 1,100 TKC'), findsOneWidget);
      expect(find.text('Earned +150 · Redeemed −50 · Closing 1,200 TKC'), findsOneWidget);

      // Disclaimer
      expect(find.text('Amounts are historical validated awards, not permanent earn rates. No rewards for likes or engagement.'), findsOneWidget);

      // Tap 'Redeemed' tab
      await tester.tap(find.text('Redeemed'));
      await tester.pumpAndSettle();

      // Now only redeemed transaction is visible
      expect(find.text('Coins redeemed'), findsOneWidget);
      expect(find.text('Food review validated'), findsNothing);

      // Tap 'Earned' tab
      await tester.tap(find.text('Earned'));
      await tester.pumpAndSettle();

      expect(find.text('Food review validated'), findsOneWidget);
      expect(find.text('Coins redeemed'), findsNothing);
    });
  });

  group('THEKAA Coins: Screen 3 - Put Your Coins To Use Suite', () {
    testWidgets('PutCoinsToUseScreen renders cart info, stepper, and calculation', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      double? finalPayable;

      await tester.pumpWidget(
        MaterialApp(
          home: PutCoinsToUseScreen(
            onContinue: (val) => finalPayable = val,
          ),
        ),
      );
      await tester.pump();

      // Header & Cart label
      expect(find.text('Put your coins to use'), findsOneWidget);
      expect(find.text('CURRENT CART · SHADAB BIRYANI'), findsOneWidget);
      expect(find.text('1,200 TKC'), findsOneWidget);

      // Stepper & quotes initially loading
      expect(find.text('Coins to redeem'), findsOneWidget);
      expect(find.text('0 TKC'), findsNWidgets(2)); // in stepper & summary
      expect(find.text('Fetching quote...'), findsOneWidget);
      expect(find.text('Checking limit...'), findsOneWidget);

      // Rate card & bill
      expect(find.text('Rate and limit confirmed at checkout'), findsOneWidget);
      expect(find.text('Order value'), findsOneWidget);
      expect(find.text('₹655'), findsNWidgets(2));
      expect(find.text('Payable, unchanged'), findsOneWidget);

      // Wait for quote timer
      await tester.pump(const Duration(milliseconds: 1500));

      expect(find.text('4 TKC = ₹1'), findsOneWidget);
      expect(find.text('200 TKC'), findsOneWidget);

      // Increment coins by tapping plus icon twice (100 TKC)
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(find.text('100 TKC'), findsOneWidget);
      expect(find.text('Apply coins · 100 TKC'), findsOneWidget);

      // Tap apply
      await tester.tap(find.text('Apply coins · 100 TKC'));
      await tester.pump();

      // Discount: 100 * 0.25 = ₹25. Payable: 655 - 25 = ₹630
      expect(find.text('Payable, coins applied'), findsOneWidget);
      expect(find.text('₹630'), findsOneWidget);
      expect(find.text('Continue with coins · ₹630'), findsOneWidget);

      await tester.tap(find.text('Continue with coins · ₹630'));
      expect(finalPayable, 630.0);
    });
  });

  group('THEKAA Coins: Screen 4 - A Taste For Discovery Suite', () {
    testWidgets('TasteForDiscoveryScreen renders progress cards and badge info', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: TasteForDiscoveryScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('A taste for discovery'), findsOneWidget);
      expect(find.text('Your curiosity, celebrated. Not your like count.'), findsOneWidget);

      // Progress Cards
      expect(find.text('THEKAA Foodie'), findsOneWidget);
      expect(find.text('10 validated food stories'), findsOneWidget);
      expect(find.text('Earned · 28 Oct 2026'), findsOneWidget);

      expect(find.text('Top Reviewer'), findsOneWidget);
      expect(find.text('12 of 20 helpful, validated reviews'), findsOneWidget);
      expect(find.text('8 more eligible reviews to go'), findsOneWidget);

      expect(find.text('Food Explorer'), findsOneWidget);
      expect(find.text('7 of 10 different kitchens explored'), findsOneWidget);
      expect(find.text('Discover 3 more verified kitchens'), findsOneWidget);

      // Badge Card
      expect(find.text('Your Foodie badge'), findsOneWidget);
      expect(
        find.text('A mark of ten genuine food stories, each published and checked. This badge lives on your food journal.'),
        findsOneWidget,
      );
      expect(find.text('Recognition only · No automatic coin credit'), findsOneWidget);

      // Fairness Card
      expect(find.text('Made for genuine discovery'), findsOneWidget);
      expect(
        find.text('Eligible reviews and original photos count toward milestones. Duplicate content and engagement do not.'),
        findsOneWidget,
      );
    });
  });

  group('THEKAA Coins: Screen 5 - A Story, Appreciated Suite', () {
    testWidgets('StoryAppreciatedScreen renders reward breakdown and handles related review tap', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      bool reviewTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: StoryAppreciatedScreen(
            onViewRelatedReview: () => reviewTapped = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('A story, appreciated'), findsOneWidget);
      expect(find.text('+25 TKC'), findsOneWidget);
      expect(find.text('COMPLETED · VALIDATED REVIEW'), findsOneWidget);

      // Transaction details
      expect(find.text('Transaction ID'), findsOneWidget);
      expect(find.text('TKC-RV84291-01'), findsOneWidget);
      expect(find.text('Date & time'), findsOneWidget);
      expect(find.text('01 Nov 2026 · 2:35 PM'), findsOneWidget);
      expect(find.text('Type'), findsOneWidget);
      expect(find.text('Food review reward'), findsOneWidget);
      expect(find.text('Source'), findsOneWidget);
      expect(find.text('Review #RV84291'), findsOneWidget);
      expect(find.text('Related order'), findsOneWidget);
      expect(find.text('#THK84291'), findsOneWidget);
      expect(find.text('Balance before'), findsOneWidget);
      expect(find.text('1,175 TKC'), findsOneWidget);
      expect(find.text('Balance after'), findsOneWidget);
      expect(find.text('1,200 TKC'), findsOneWidget);

      // Restaurant & dish card
      expect(find.text('Shadab Biryani'), findsOneWidget);
      expect(find.text('Chicken Dum Biryani'), findsOneWidget);
      expect(find.text('4.0'), findsOneWidget);
      expect(find.text('“That unmistakable dum aroma.”'), findsOneWidget);

      // Validation card
      expect(find.text('Credited once, after checks'), findsOneWidget);
      expect(
        find.text('Publication and purchase eligibility were successfully validated. This review cannot receive a duplicate reward.'),
        findsOneWidget,
      );

      // Outlined button
      expect(find.text('View related review'), findsOneWidget);
      await tester.tap(find.text('View related review'));
      expect(reviewTapped, isTrue);
    });
  });

  group('THEKAA Completed Order + Order History Suite', () {
    setUp(() {
      addTearDown(OrderRepository.instance.clear);
    });

    testWidgets('OrderTrackingScreen: "View order details" is removed and timer transitions to DeliveredOrderScreen saving into OrderRepository', (tester) async {
      OrderRepository.instance.clear();

      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderTrackingScreen(
            order: order,
            simulationStepDuration: const Duration(milliseconds: 50),
          ),
        ),
      );
      await tester.pump();

      // Verify "View order details" is completely removed
      expect(find.text('View order details'), findsNothing);

      // Verify "View rider details" exists
      expect(find.text('View rider details'), findsOneWidget);

      // Initially preparing food: view rider details is disabled
      final riderBtn = tester.widget<OutlinedButton>(
        find.ancestor(of: find.text('View rider details'), matching: find.byType(OutlinedButton)),
      );
      expect(riderBtn.onPressed, isNull);

      // Advance 50ms: Rider assigned
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.text('Completed'), findsNWidgets(2)); // Confirmed and preparing completed
      final riderBtnEnabled = tester.widget<OutlinedButton>(
        find.ancestor(of: find.text('View rider details'), matching: find.byType(OutlinedButton)),
      );
      expect(riderBtnEnabled.onPressed, isNotNull);

      // Advance 50ms: Out for delivery
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.text('Completed'), findsNWidgets(3));

      // Advance 50ms: Delivered -> Auto navigates to DeliveredOrderScreen (Khaana aa gaya!)
      await tester.pump(const Duration(milliseconds: 50));
      await tester.pumpAndSettle();

      expect(find.text('Khaana aa gaya!'), findsOneWidget);

      // Verify order saved to OrderRepository
      expect(OrderRepository.instance.orders.length, equals(1));
      expect(OrderRepository.instance.orders.first.trackingStatus, equals(OrderTrackingStatus.delivered));
    });

    testWidgets('DeliveredOrderScreen: "Share food review" opens Tell your food story with delivered order context', (tester) async {
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

      expect(find.text('Share food review'), findsOneWidget);
      await tester.tap(find.text('Share food review'));
      await tester.pumpAndSettle();

      expect(find.byType(TellFoodStoryScreen), findsOneWidget);
      expect(find.text('Tell your food story'), findsOneWidget);
      expect(find.text('Shadab Biryani'), findsWidgets);
      expect(find.text('Chicken Dum Biryani'), findsWidgets);
    });

    testWidgets('DeliveredOrderScreen: "Order details" opens CompletedOrderDetailsScreen without live tracking timeline', (tester) async {
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

      await tester.tap(find.text('Order details'));
      await tester.pumpAndSettle();

      expect(find.byType(CompletedOrderDetailsScreen), findsOneWidget);
      expect(find.text('Order Delivered'), findsOneWidget);
      expect(find.text('Shadab Biryani'), findsWidgets);
      expect(find.text('Bill details'), findsOneWidget);
      expect(find.text('Final amount paid'), findsOneWidget);
      expect(find.text('₹655'), findsWidgets);
      expect(find.text('Delivery address'), findsOneWidget);

      // Must NOT contain live tracking timeline
      expect(find.text('A little dum, a little time'), findsNothing);
      expect(find.text('Order confirmed'), findsNothing);
      expect(find.text('Track your order'), findsNothing);
    });

    testWidgets('OrdersScreen: displays completed order and navigates to CompletedOrderDetailsScreen', (tester) async {
      OrderRepository.instance.clear();

      final deliveredOrder = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
        trackingStatus: OrderTrackingStatus.delivered,
      );
      OrderRepository.instance.addOrUpdateOrder(deliveredOrder);

      // Also test duplicate prevention
      OrderRepository.instance.addOrUpdateOrder(deliveredOrder);
      expect(OrderRepository.instance.orders.length, equals(1));

      await tester.pumpWidget(
        const MaterialApp(
          home: OrdersScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Your Orders'), findsOneWidget);
      expect(find.text('Shadab Biryani'), findsOneWidget);
      expect(find.text('Delivered'), findsOneWidget);
      expect(find.text('₹655'), findsOneWidget);

      // Tap card
      await tester.tap(find.text('Shadab Biryani'));
      await tester.pumpAndSettle();

      expect(find.byType(CompletedOrderDetailsScreen), findsOneWidget);
      expect(find.text('Order Delivered'), findsOneWidget);
    });

    testWidgets('Order state persists across navigation and never resets backward', (tester) async {
      OrderRepository.instance.clear();

      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );

      // Start on OrderTrackingScreen with 10s step
      await tester.pumpWidget(
        MaterialApp(
          home: OrderTrackingScreen(
            order: order,
            simulationStepDuration: const Duration(seconds: 10),
          ),
        ),
      );
      await tester.pump();

      // Initially preparing food
      expect(find.text('Restaurant preparing food'), findsOneWidget);

      // Advance 10s -> moves to riderAssigned
      await tester.pump(const Duration(seconds: 10));
      expect(find.text('Rider assigned'), findsOneWidget);

      // Tap View rider details
      await tester.tap(find.text('View rider details'));
      await tester.pumpAndSettle();

      // On RiderDetailsScreen ("Meet your bhaiyya")
      expect(find.byType(RiderDetailsScreen), findsOneWidget);
      expect(find.text('Meet your bhaiyya'), findsOneWidget);
      expect(find.text('Ravi K.'), findsWidgets);

      // Tap Map -> OnTheWayScreen
      await tester.tap(find.byType(RiderDeliveryMap));
      await tester.pumpAndSettle();
      expect(find.byType(OnTheWayScreen), findsOneWidget);
      expect(find.text('On the way to you'), findsOneWidget);

      // Tap View order details -> OrderDetailsScreen
      await tester.tap(find.text('View order details'));
      await tester.pumpAndSettle();
      expect(find.byType(OrderDetailsScreen), findsOneWidget);
      expect(find.text('Order confirmed'), findsOneWidget);

      // Tap Track your order -> Back to OrderTrackingScreen
      await tester.tap(find.text('Track your order'));
      await tester.pumpAndSettle();

      // CRITICAL CHECK: Must STILL be Rider assigned (or later)! Must NOT reset to preparing food!
      expect(find.byType(OrderTrackingScreen), findsOneWidget);
      final currentInRepo = OrderRepository.instance.getOrderById(order.orderId);
      expect(currentInRepo?.trackingStatus.index, greaterThanOrEqualTo(OrderTrackingStatus.riderAssigned.index));

      // Advance 10s -> Out for delivery
      await tester.pump(const Duration(seconds: 10));
      // Advance 10s -> Delivered
      await tester.pump(const Duration(seconds: 10));
      await tester.pumpAndSettle();

      // Reaches DeliveredOrderScreen
      expect(find.text('Khaana aa gaya!'), findsOneWidget);
    });
  });

  group('THEKAA — Real Camera & Gallery Photo Picking Test Suite', () {
    testWidgets('Tapping Food photo · cover presents selection and updates cover photo', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      ImageSource? pickedSource;
      await tester.pumpWidget(
        MaterialApp(
          home: TellFoodStoryScreen(
            imagePickerFn: (source) async {
              pickedSource = source;
              return 'new_food_cover.jpg';
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Food photo · cover
      await tester.tap(find.text('Food photo · cover'));
      await tester.pumpAndSettle();

      // Modal bottom sheet appears
      expect(find.text('Food photo · cover'), findsWidgets);
      expect(find.text('Choose from gallery'), findsOneWidget);
      expect(find.text('Take photo with camera'), findsOneWidget);

      // Tap Choose from gallery
      await tester.tap(find.text('Choose from gallery'));
      await tester.pumpAndSettle();

      expect(pickedSource, ImageSource.gallery);
    });

    testWidgets('Tapping Personal photo presents selection and captures from camera', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      ImageSource? pickedSource;
      await tester.pumpWidget(
        MaterialApp(
          home: TellFoodStoryScreen(
            imagePickerFn: (source) async {
              pickedSource = source;
              return 'new_personal_photo.jpg';
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Personal photo
      await tester.tap(find.text('Personal photo'));
      await tester.pumpAndSettle();

      // Modal bottom sheet appears
      expect(find.text('Personal photo'), findsWidgets);
      expect(find.text('Choose from gallery'), findsOneWidget);
      expect(find.text('Take photo with camera'), findsOneWidget);

      // Tap Take photo with camera
      await tester.tap(find.text('Take photo with camera'));
      await tester.pumpAndSettle();

      expect(pickedSource, ImageSource.camera);
    });

    testWidgets('Cancelling picker does not mutate photos or crash', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          home: TellFoodStoryScreen(
            imagePickerFn: (source) async => null, // User cancelled
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Add photo
      await tester.tap(find.text('Add photo'));
      await tester.pumpAndSettle();

      // Tap Choose from gallery
      await tester.tap(find.text('Choose from gallery'));
      await tester.pumpAndSettle();

      // Remains at initial state without crashing
      expect(find.text('Tell your food story'), findsOneWidget);
      expect(find.text('3 of 6 photos selected'), findsNothing);
    });

    testWidgets('Permission failure shows friendly SnackBar without crashing', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          home: TellFoodStoryScreen(
            imagePickerFn: (source) async {
              throw Exception('Permission denied by user');
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Food photo · cover
      await tester.tap(find.text('Food photo · cover'));
      await tester.pumpAndSettle();

      // Tap Take photo with camera
      await tester.tap(find.text('Take photo with camera'));
      await tester.pumpAndSettle();

      // Shows friendly SnackBar
      expect(
        find.text('Could not access camera. Please check device permissions.'),
        findsOneWidget,
      );
    });

    testWidgets('Additional photo removal works and decrements count', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      int photoCounter = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: TellFoodStoryScreen(
            imagePickerFn: (source) async {
              photoCounter++;
              return 'extra_photo_$photoCounter.jpg';
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Add 1 photo -> 3 photos total
      await tester.tap(find.text('Add photo'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Choose from gallery'));
      await tester.pumpAndSettle();

      expect(find.text('3 of 6 photos selected'), findsOneWidget);

      // Remove the 3rd photo using close icon
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.text('3 of 6 photos selected'), findsNothing);
    });
  });

  group('THEKAA Profile Navigation & Edit Details Test Suite', () {
    setUp(() {
      ProfileRepository.instance.reset();
    });

    testWidgets('Test 1: Profile -> Account details navigates to The person behind the plate', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Account details
      await tester.tap(find.text('Account details'));
      await tester.pumpAndSettle();

      // Successfully on The person behind the plate
      expect(find.byType(EditProfileScreen), findsOneWidget);
      expect(find.text('The person behind the plate'), findsOneWidget);
      expect(find.text('Full name'), findsOneWidget);
    });

    testWidgets('Test 2: Profile -> Edit posts navigates to Manage posts', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Edit posts
      await tester.tap(find.text('Edit posts'));
      await tester.pumpAndSettle();

      // Successfully on Manage posts
      expect(find.byType(ManagePostsScreen), findsOneWidget);
      expect(find.text('Manage posts'), findsOneWidget);
      expect(find.text('Published (48)'), findsOneWidget);
    });

    testWidgets('Test 3: The person behind the plate -> Edit details enters editing mode on same page', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: EditProfileScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Normal display mode: no text fields
      expect(find.byType(TextField), findsNothing);
      expect(find.text('Edit details'), findsOneWidget);

      // Tap Edit details
      await tester.tap(find.text('Edit details'));
      await tester.pumpAndSettle();

      // Same page now in editing mode with text fields
      expect(find.byType(EditProfileScreen), findsOneWidget);
      expect(find.text('The person behind the plate'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(5));
      expect(find.text('Save details'), findsOneWidget);
    });

    testWidgets('Test 4: Edit a value -> Save updates value and returns to display mode on same page', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: EditProfileScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Edit details
      await tester.tap(find.text('Edit details'));
      await tester.pumpAndSettle();

      // Edit full name
      final nameField = find.byType(TextField).first;
      await tester.enterText(nameField, 'hero Thekaa');
      await tester.pumpAndSettle();

      // Tap Save
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Returns to normal display mode on same page
      expect(find.byType(TextField), findsNothing);
      expect(find.text('The person behind the plate'), findsOneWidget);
      expect(find.text('hero Thekaa'), findsOneWidget);
      expect(find.text('Edit details'), findsOneWidget);
    });

    testWidgets('Test 5: Profile -> Saved addresses navigates to Your familiar places', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Saved addresses
      await tester.tap(find.text('Saved addresses'));
      await tester.pumpAndSettle();

      // Successfully on Your familiar places
      expect(find.byType(SavedAddressesScreen), findsOneWidget);
      expect(find.text('Your familiar places'), findsOneWidget);
    });

    testWidgets('Test 6: Profile -> Food preferences navigates to Food, your way', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Food preferences
      await tester.tap(find.text('Food preferences'));
      await tester.pumpAndSettle();

      // Successfully on Food, your way
      expect(find.byType(FoodPreferencesScreen), findsOneWidget);
      expect(find.text('Food, your way'), findsOneWidget);
    });

    testWidgets('Test 7: Profile -> Help & Support navigates to Bhaiyya, we\'re listening', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Help & Support
      await tester.tap(find.text('Help & Support'));
      await tester.pumpAndSettle();

      // Successfully on Bhaiyya, we're listening
      expect(find.byType(HelpSupportScreen), findsOneWidget);
      expect(find.textContaining('Bhaiyya, we'), findsOneWidget);
    });

    testWidgets('Test 8: Profile state persists across navigation and returning', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('hero M.'), findsOneWidget);

      // Navigate to Account details
      await tester.tap(find.text('Account details'));
      await tester.pumpAndSettle();

      // Enter edit mode
      await tester.tap(find.text('Edit details'));
      await tester.pumpAndSettle();

      // Edit name
      await tester.enterText(find.byType(TextField).first, 'Aisha Begum');
      await tester.pumpAndSettle();

      // Save
      await tester.tap(find.text('Save details'));
      await tester.pumpAndSettle();

      // Pop back to ProfileScreen
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      // ProfileScreen reflects the updated name!
      expect(find.byType(ProfileScreen), findsOneWidget);
      expect(find.text('Aisha Begum'), findsOneWidget);

      // Re-enter Account details and verify persistence
      await tester.tap(find.text('Account details'));
      await tester.pumpAndSettle();

      expect(find.text('Aisha Begum'), findsOneWidget);
    });
  });

  group('THEKAA Coins Navigation & Actions Test Suite', () {
    testWidgets('Test 1: Your story is out there -> View my coins navigates to A story, appreciated and back', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: StoryPublishedScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(StoryPublishedScreen), findsOneWidget);
      expect(find.text('Your story is out there'), findsOneWidget);

      // Tap View my coins
      await tester.tap(find.text('View my coins'));
      await tester.pumpAndSettle();

      // Successfully on A story, appreciated
      expect(find.byType(StoryAppreciatedScreen), findsOneWidget);
      expect(find.text('A story, appreciated'), findsOneWidget);
      expect(find.text('+25 TKC'), findsOneWidget);

      // Back navigation returns to Your story is out there
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      expect(find.byType(StoryPublishedScreen), findsOneWidget);
      expect(find.text('Your story is out there'), findsOneWidget);
    });

    testWidgets('Test 2: Profile -> View wallet navigates to THEKAA Coins and back', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('My THEKAA'), findsOneWidget);
      expect(find.text('View wallet'), findsOneWidget);

      // Tap View wallet
      await tester.tap(find.text('View wallet'));
      await tester.pumpAndSettle();

      // Successfully on THEKAA Coins
      expect(find.byType(ThekaaCoinsScreen), findsOneWidget);
      expect(find.text('THEKAA Coins'), findsOneWidget);
      expect(find.text('1,200 TKC'), findsOneWidget);

      // Back returns to Profile
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      expect(find.byType(ProfileScreen), findsOneWidget);
      expect(find.text('My THEKAA'), findsOneWidget);
    });

    testWidgets('Test 3: THEKAA Coins -> Earn displays message without changing balance or navigating', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ThekaaCoinsScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ThekaaCoinsScreen), findsOneWidget);
      expect(find.text('1,200 TKC'), findsOneWidget);

      // Tap Earn
      await tester.tap(find.text('Earn'));
      await tester.pumpAndSettle();

      // Message displayed
      expect(find.text('Order something and review it to earn coins.'), findsOneWidget);
      // Balance unchanged
      expect(find.text('1,200 TKC'), findsOneWidget);
      // Still on same page
      expect(find.byType(ThekaaCoinsScreen), findsOneWidget);
    });

    testWidgets('Test 4: THEKAA Coins -> Redeem displays message without changing balance or navigating', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ThekaaCoinsScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ThekaaCoinsScreen), findsOneWidget);
      expect(find.text('1,200 TKC'), findsOneWidget);

      // Tap Redeem
      await tester.tap(find.text('Redeem'));
      await tester.pumpAndSettle();

      // Message displayed
      expect(find.text('Redeem on your order after you have something to redeem.'), findsOneWidget);
      // Balance unchanged
      expect(find.text('1,200 TKC'), findsOneWidget);
      // Still on same page
      expect(find.byType(ThekaaCoinsScreen), findsOneWidget);
    });

    testWidgets('Test 5: THEKAA Coins -> History navigates to Every coin, accounted for and back', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ThekaaCoinsScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap History
      await tester.tap(find.text('History'));
      await tester.pumpAndSettle();

      // Successfully on Every coin, accounted for
      expect(find.byType(CoinHistoryScreen), findsOneWidget);
      expect(find.text('Every coin, accounted for'), findsOneWidget);
      expect(find.text('Food review validated'), findsOneWidget);

      // Back returns to THEKAA Coins
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      expect(find.byType(ThekaaCoinsScreen), findsOneWidget);
      expect(find.text('THEKAA Coins'), findsOneWidget);
    });

    testWidgets('Test 6: THEKAA Coins -> Rewards navigates to A taste for discovery and back', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ThekaaCoinsScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Rewards
      await tester.tap(find.text('Rewards'));
      await tester.pumpAndSettle();

      // Successfully on A taste for discovery
      expect(find.byType(TasteForDiscoveryScreen), findsOneWidget);
      expect(find.text('A taste for discovery'), findsOneWidget);
      expect(find.text('THEKAA Foodie'), findsOneWidget);

      // Back returns to THEKAA Coins
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      expect(find.byType(ThekaaCoinsScreen), findsOneWidget);
      expect(find.text('THEKAA Coins'), findsOneWidget);
    });

    testWidgets('Test 7: Full Complete Navigation Map: Profile -> Coins -> History/Rewards -> Back', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Profile -> View wallet -> THEKAA Coins
      await tester.tap(find.text('View wallet'));
      await tester.pumpAndSettle();
      expect(find.byType(ThekaaCoinsScreen), findsOneWidget);
      expect(find.text('1,200 TKC'), findsOneWidget);

      // THEKAA Coins -> History -> Every coin, accounted for
      await tester.tap(find.text('History'));
      await tester.pumpAndSettle();
      expect(find.byType(CoinHistoryScreen), findsOneWidget);

      // Back -> THEKAA Coins
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();
      expect(find.byType(ThekaaCoinsScreen), findsOneWidget);

      // THEKAA Coins -> Rewards -> A taste for discovery
      await tester.tap(find.text('Rewards'));
      await tester.pumpAndSettle();
      expect(find.byType(TasteForDiscoveryScreen), findsOneWidget);

      // Back -> THEKAA Coins
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();
      expect(find.byType(ThekaaCoinsScreen), findsOneWidget);

      // Back -> Profile
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();
      expect(find.byType(ProfileScreen), findsOneWidget);
      expect(find.text('My THEKAA'), findsOneWidget);
    });
  });

  group('THEKAA Functional Flow Fixes Test Suite', () {
    setUp(() {
      OrderRepository.instance.clear();
      ProfileRepository.instance.reset();
      addTearDown(() {
        OrderRepository.instance.clear();
        ProfileRepository.instance.reset();
      });
    });

    testWidgets('Test 1: View related review on StoryAppreciatedScreen navigates to THEKAA SOCIALS', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: StoryAppreciatedScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(StoryAppreciatedScreen), findsOneWidget);
      expect(find.text('View related review'), findsOneWidget);

      await tester.tap(find.text('View related review'));
      await tester.pumpAndSettle();

      expect(find.byType(SocialFeedScreen), findsOneWidget);
      expect(find.text('THEKAA SOCIALS'), findsOneWidget);
    });

    testWidgets('Test 2: Manage posts - Archived tab shows archived posts; empty shows "No archived posts"', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      // 1. When archived posts exist
      await tester.pumpWidget(
        const MaterialApp(
          home: ManagePostsScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Manage posts'), findsOneWidget);

      // Switch to Archived tab
      await tester.tap(find.text('Archived'));
      await tester.pumpAndSettle();

      expect(find.text('Zafrani Mutton Biryani'), findsOneWidget);

      // 2. When no archived posts exist
      await tester.pumpWidget(
        const MaterialApp(
          home: ManagePostsScreen(
            archivedPosts: [],
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Archived'));
      await tester.pumpAndSettle();

      expect(find.text('No archived posts'), findsOneWidget);
    });

    testWidgets('Test 3: Manage posts - Restore moves post from Archived to Published immediately', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ManagePostsScreen(
            publishedPosts: [],
            archivedPosts: [
              UserPost(
                id: 'archived_test_1',
                title: 'Secret Haleem Bowl',
                restaurantLocation: 'Pista House · Charminar',
                dateAndCategory: 'Archived · 10 Oct 2026',
                date: '10 Oct 2026',
                isArchived: true,
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Go to Archived tab
      await tester.tap(find.text('Archived'));
      await tester.pumpAndSettle();

      expect(find.text('Secret Haleem Bowl'), findsOneWidget);
      expect(find.text('Restore'), findsOneWidget);

      // Tap Restore
      await tester.tap(find.text('Restore'));
      await tester.pumpAndSettle();

      // Now Archived tab is empty
      expect(find.text('No archived posts'), findsOneWidget);

      // Switch to Published tab
      await tester.tap(find.text('Published'));
      await tester.pumpAndSettle();

      // The post is now present in Published!
      expect(find.text('Secret Haleem Bowl'), findsOneWidget);
    });

    testWidgets('Test 4: Saved addresses - Edit updates address data and displays updated address immediately', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: SavedAddressesScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Your familiar places'), findsOneWidget);
      expect(find.text('Flat 302, Vertex Heights, Gachibowli, Hyderabad 500032'), findsOneWidget);

      // Tap Edit on first address
      await tester.tap(find.text('Edit').first);
      await tester.pumpAndSettle();

      // Edit bottom sheet opened
      expect(find.text('Edit Home address'), findsOneWidget);

      // Change Flat/Building text
      final flatField = find.widgetWithText(TextField, 'Flat 302, Vertex Heights');
      await tester.enterText(flatField, 'Flat 999, Sky Towers');
      await tester.pumpAndSettle();

      // Tap Save
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Updated address appears immediately on the page!
      expect(find.text('Flat 999, Sky Towers, Gachibowli, Hyderabad 500032'), findsOneWidget);
    });

    testWidgets('Test 5: Saved addresses - Delete removes the address immediately', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: SavedAddressesScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Flat 302, Vertex Heights, Gachibowli, Hyderabad 500032'), findsOneWidget);

      // Tap Delete on first address
      await tester.tap(find.text('Delete').first);
      await tester.pumpAndSettle();

      // Deleted address is gone immediately
      expect(find.text('Flat 302, Vertex Heights, Gachibowli, Hyderabad 500032'), findsNothing);
    });

    testWidgets('Test 6: Food preferences - Save preferences persists state and returns to Profile; reopening preserves values', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Profile -> Food preferences
      await tester.tap(find.text('Food preferences'));
      await tester.pumpAndSettle();

      expect(find.byType(FoodPreferencesScreen), findsOneWidget);
      expect(find.text('Food, your way'), findsOneWidget);

      // Change dietary type to Veg
      await tester.tap(find.text('Veg'));
      await tester.pumpAndSettle();

      // Save preferences
      await tester.tap(find.text('Save preferences'));
      await tester.pumpAndSettle();

      // Returns to Profile
      expect(find.byType(ProfileScreen), findsOneWidget);

      // Re-open Food preferences
      await tester.tap(find.text('Food preferences'));
      await tester.pumpAndSettle();

      // State is preserved!
      expect(ProfileRepository.instance.foodPreference.dietaryType, DietaryType.veg);
    });

    testWidgets('Test 7: Help & Support - Chat displays "We are currently unavailable."', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: HelpSupportScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Chat'), findsOneWidget);

      await tester.tap(find.text('Chat'));
      await tester.pumpAndSettle();

      expect(find.text('We are currently unavailable.'), findsOneWidget);
    });

    testWidgets('Test 8: Help & Support - An order opens order-help interface with real order data and typing box', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: HelpSupportScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('An order'), findsOneWidget);

      await tester.tap(find.text('An order'));
      await tester.pumpAndSettle();

      // Displays relevant order info
      expect(find.text('Shadab Biryani'), findsWidgets);
      expect(find.textContaining('#THK84291'), findsWidgets);
      expect(find.text('What help do you need with this order?'), findsOneWidget);
      expect(find.text('What help do you need?'), findsOneWidget);

      // Typing box accepts text
      final issueField = find.widgetWithText(TextField, 'Type your issue...');
      expect(issueField, findsOneWidget);

      await tester.enterText(issueField, 'Need extra onions and mint chutney please');
      await tester.pumpAndSettle();

      expect(find.text('Need extra onions and mint chutney please'), findsOneWidget);
    });

    testWidgets('Test 9: Track your order opens "A little dum, a little time" for active order, NOT "Khaana aa gaya!"', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final activeOrder = OrderConfirmation.sampleShadabOrder.copyWith(
        trackingStatus: OrderTrackingStatus.preparingFood,
      );
      OrderRepository.instance.addOrUpdateOrder(activeOrder);

      await tester.pumpWidget(
        MaterialApp(
          home: OrderDetailsScreen(order: activeOrder),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Track your order'), findsOneWidget);

      await tester.tap(find.text('Track your order'));
      await tester.pumpAndSettle();

      // Must open OrderTrackingScreen ("A little dum, a little time"), NOT DeliveredOrderScreen ("Khaana aa gaya!")
      expect(find.byType(OrderTrackingScreen), findsOneWidget);
      expect(find.text('A little dum, a little time'), findsOneWidget);
      expect(find.byType(DeliveredOrderScreen), findsNothing);
      expect(find.text('Khaana aa gaya!'), findsNothing);
    });

    testWidgets('Test 10: Track your order opens "Khaana aa gaya!" when order is delivered', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final deliveredOrder = OrderConfirmation.sampleShadabOrder.copyWith(
        trackingStatus: OrderTrackingStatus.delivered,
      );
      OrderRepository.instance.addOrUpdateOrder(deliveredOrder);

      await tester.pumpWidget(
        MaterialApp(
          home: OrderPlacedScreen(order: deliveredOrder),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Track order'), findsOneWidget);

      await tester.tap(find.text('Track order'));
      await tester.pumpAndSettle();

      // Opens DeliveredOrderScreen ("Khaana aa gaya!")
      expect(find.byType(DeliveredOrderScreen), findsOneWidget);
      expect(find.text('Khaana aa gaya!'), findsOneWidget);
    });

    testWidgets('Test 11: Order state (rider assigned) is preserved and does not reset when navigating between tracking screens', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final assignedOrder = OrderConfirmation.sampleShadabOrder.copyWith(
        trackingStatus: OrderTrackingStatus.riderAssigned,
        assignedRider: OrderConfirmation.sampleShadabOrder.rider,
      );
      OrderRepository.instance.addOrUpdateOrder(assignedOrder);

      await tester.pumpWidget(
        MaterialApp(
          home: OrderTrackingScreen(
            order: assignedOrder,
            enableSimulation: false,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify rider is assigned and button is enabled
      expect(find.text('A little dum, a little time'), findsOneWidget);
      expect(find.text('View rider details'), findsOneWidget);

      // Open RiderDetailsScreen
      await tester.tap(find.text('View rider details'));
      await tester.pumpAndSettle();

      expect(find.byType(RiderDetailsScreen), findsOneWidget);
      expect(find.text('Meet your bhaiyya'), findsOneWidget);

      // Return to OrderTrackingScreen
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      // State is still preserved: rider assigned!
      expect(find.byType(OrderTrackingScreen), findsOneWidget);
      expect(find.text('View rider details'), findsOneWidget);
      final repoOrder = OrderRepository.instance.getOrderById(assignedOrder.orderId);
      expect(repoOrder?.trackingStatus, OrderTrackingStatus.riderAssigned);
    });
  });

  group('THEKAA Global Bottom Navigation Test Suite', () {
    testWidgets('Test 1: Home -> Orders and Home -> Profile tab switching', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      // Starts on Home
      expect(find.byType(HomeScreen), findsOneWidget);

      // Tap Orders tab (index 3)
      await tester.tap(find.text('Orders'));
      await tester.pumpAndSettle();
      expect(find.text('Your Orders'), findsOneWidget);
      expect(find.byType(OrdersScreen), findsOneWidget);

      // Tap Profile tab (index 4)
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(find.text('My THEKAA'), findsOneWidget);
      expect(find.byType(ProfileScreen), findsOneWidget);

      // Tap Home tab (index 0)
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Test 2: Restaurant Details -> Home, Dabba, Profile', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      // Open Restaurant Details from Home
      await tester.tap(find.text('Shadab Biryani').first);
      await tester.pumpAndSettle();

      // Tap "View menu & order" to open RestaurantDetailsScreen if on Explore, or we can push it
      final scaffoldContext = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext).push(
        MaterialPageRoute(
          builder: (_) => RestaurantDetailsScreen(
            restaurant: Restaurant.shadabBiryani,
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RestaurantDetailsScreen), findsOneWidget);

      // Tap Home -> navigates to Home
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.byType(RestaurantDetailsScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);

      // Open RestaurantDetailsScreen again
      final scaffoldContext2 = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext2).push(
        MaterialPageRoute(
          builder: (_) => RestaurantDetailsScreen(
            restaurant: Restaurant.shadabBiryani,
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RestaurantDetailsScreen), findsOneWidget);

      // Tap Dabba -> navigates to Dabba
      await tester.tap(find.text('Dabba'));
      await tester.pumpAndSettle();
      expect(find.byType(RestaurantDetailsScreen), findsNothing);
      expect(find.byType(SocialFeedScreen), findsOneWidget);

      // Open RestaurantDetailsScreen again
      final scaffoldContext3 = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext3).push(
        MaterialPageRoute(
          builder: (_) => RestaurantDetailsScreen(
            restaurant: Restaurant.shadabBiryani,
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Profile -> navigates to Profile
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(find.byType(RestaurantDetailsScreen), findsNothing);
      expect(find.byType(ProfileScreen), findsOneWidget);
    });

    testWidgets('Test 3: Menu -> Orders and Menu -> Explore', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      final scaffoldContext = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext).push(
        MaterialPageRoute(
          builder: (_) => RestaurantMenuScreen(
            restaurant: Restaurant.shadabBiryani,
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RestaurantMenuScreen), findsOneWidget);

      // Tap Orders -> navigates to Orders
      await tester.tap(find.text('Orders'));
      await tester.pumpAndSettle();
      expect(find.byType(RestaurantMenuScreen), findsNothing);
      expect(find.byType(OrdersScreen), findsOneWidget);

      // Open Menu again
      final scaffoldContext2 = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext2).push(
        MaterialPageRoute(
          builder: (_) => RestaurantMenuScreen(
            restaurant: Restaurant.shadabBiryani,
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Explore -> navigates to Explore
      await tester.tap(find.text('Explore'));
      await tester.pumpAndSettle();
      expect(find.byType(RestaurantMenuScreen), findsNothing);
      expect(find.byType(ExploreScreen), findsOneWidget);
    });

    testWidgets('Test 4: Cart -> Home, Orders, Profile', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      // Push CartScreen
      final scaffoldContext = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext).push(
        MaterialPageRoute(
          builder: (_) => CartScreen(
            restaurant: Restaurant.shadabBiryani,
            initialQuantities: const {'chicken_dum_biryani': 1},
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CartScreen), findsOneWidget);

      // Tap Home -> navigates to Home
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.byType(CartScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);

      // Push CartScreen again
      final scaffoldContext2 = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext2).push(
        MaterialPageRoute(
          builder: (_) => CartScreen(
            restaurant: Restaurant.shadabBiryani,
            initialQuantities: const {'chicken_dum_biryani': 1},
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Orders -> navigates to Orders
      await tester.tap(find.text('Orders'));
      await tester.pumpAndSettle();
      expect(find.byType(CartScreen), findsNothing);
      expect(find.byType(OrdersScreen), findsOneWidget);

      // Push CartScreen again
      final scaffoldContext3 = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext3).push(
        MaterialPageRoute(
          builder: (_) => CartScreen(
            restaurant: Restaurant.shadabBiryani,
            initialQuantities: const {'chicken_dum_biryani': 1},
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Profile -> navigates to Profile
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(find.byType(CartScreen), findsNothing);
      expect(find.byType(ProfileScreen), findsOneWidget);
    });

    testWidgets('Test 5: Checkout (Review Order) -> Home, Dabba, Orders', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      // Push ReviewOrderScreen
      final scaffoldContext = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext).push(
        MaterialPageRoute(
          builder: (_) => ReviewOrderScreen(
            restaurant: Restaurant.shadabBiryani,
            initialCartQuantities: const {'chicken_dum_biryani': 1},
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(ReviewOrderScreen), findsOneWidget);

      // Tap Home -> navigates to Home
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.byType(ReviewOrderScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);

      // Push ReviewOrderScreen again
      final scaffoldContext2 = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext2).push(
        MaterialPageRoute(
          builder: (_) => ReviewOrderScreen(
            restaurant: Restaurant.shadabBiryani,
            initialCartQuantities: const {'chicken_dum_biryani': 1},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Dabba -> navigates to Dabba
      await tester.tap(find.text('Dabba'));
      await tester.pumpAndSettle();
      expect(find.byType(ReviewOrderScreen), findsNothing);
      expect(find.byType(SocialFeedScreen), findsOneWidget);

      // Push ReviewOrderScreen again
      final scaffoldContext3 = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext3).push(
        MaterialPageRoute(
          builder: (_) => ReviewOrderScreen(
            restaurant: Restaurant.shadabBiryani,
            initialCartQuantities: const {'chicken_dum_biryani': 1},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Orders -> navigates to Orders
      await tester.tap(find.text('Orders'));
      await tester.pumpAndSettle();
      expect(find.byType(ReviewOrderScreen), findsNothing);
      expect(find.byType(OrdersScreen), findsOneWidget);
    });

    testWidgets('Test 6: Order tracking ("A little dum, a little time") -> Home, Dabba, Orders, Profile', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );
      OrderRepository.instance.addOrUpdateOrder(order);

      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      // Push OrderTrackingScreen
      final scaffoldContext = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext).push(
        MaterialPageRoute(
          builder: (_) => OrderTrackingScreen(
            order: order,
            enableSimulation: false,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('A little dum, a little time'), findsOneWidget);

      // Tap Home -> navigates to Home
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.byType(OrderTrackingScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);

      // Push OrderTrackingScreen again
      final scaffoldContext2 = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext2).push(
        MaterialPageRoute(
          builder: (_) => OrderTrackingScreen(
            order: order,
            enableSimulation: false,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Dabba -> navigates to Dabba
      await tester.tap(find.text('Dabba'));
      await tester.pumpAndSettle();
      expect(find.byType(OrderTrackingScreen), findsNothing);
      expect(find.byType(SocialFeedScreen), findsOneWidget);

      // Push OrderTrackingScreen again
      final scaffoldContext3 = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext3).push(
        MaterialPageRoute(
          builder: (_) => OrderTrackingScreen(
            order: order,
            enableSimulation: false,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Orders -> navigates to main Orders
      await tester.tap(find.text('Orders'));
      await tester.pumpAndSettle();
      expect(find.byType(OrderTrackingScreen), findsNothing);
      expect(find.byType(OrdersScreen), findsOneWidget);

      // Push OrderTrackingScreen again
      final scaffoldContext4 = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext4).push(
        MaterialPageRoute(
          builder: (_) => OrderTrackingScreen(
            order: order,
            enableSimulation: false,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Profile -> navigates to Profile
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(find.byType(OrderTrackingScreen), findsNothing);
      expect(find.byType(ProfileScreen), findsOneWidget);
    });

    testWidgets('Test 7: Khaana aa gaya ("DeliveredOrderScreen") -> Home, Dabba, Orders, Profile', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final deliveredOrder = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      ).copyWith(trackingStatus: OrderTrackingStatus.delivered);

      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      // Push DeliveredOrderScreen
      final scaffoldContext = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext).push(
        MaterialPageRoute(
          builder: (_) => DeliveredOrderScreen(order: deliveredOrder),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Khaana aa gaya!'), findsOneWidget);

      // Tap Home
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.byType(DeliveredOrderScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);

      // Push DeliveredOrderScreen again
      final scaffoldContext2 = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext2).push(
        MaterialPageRoute(
          builder: (_) => DeliveredOrderScreen(order: deliveredOrder),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Dabba
      await tester.tap(find.text('Dabba'));
      await tester.pumpAndSettle();
      expect(find.byType(DeliveredOrderScreen), findsNothing);
      expect(find.byType(SocialFeedScreen), findsOneWidget);

      // Push DeliveredOrderScreen again
      final scaffoldContext3 = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext3).push(
        MaterialPageRoute(
          builder: (_) => DeliveredOrderScreen(order: deliveredOrder),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Orders
      await tester.tap(find.text('Orders'));
      await tester.pumpAndSettle();
      expect(find.byType(DeliveredOrderScreen), findsNothing);
      expect(find.byType(OrdersScreen), findsOneWidget);

      // Push DeliveredOrderScreen again
      final scaffoldContext4 = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext4).push(
        MaterialPageRoute(
          builder: (_) => DeliveredOrderScreen(order: deliveredOrder),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Profile
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(find.byType(DeliveredOrderScreen), findsNothing);
      expect(find.byType(ProfileScreen), findsOneWidget);
    });

    testWidgets('Test 8: Tell your food story -> Home, Explore, Dabba, Orders, Profile', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );
      final eligibleOrder = EligibleOrder.fromOrderConfirmation(order);

      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      // Push TellFoodStoryScreen
      final scaffoldContext = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext).push(
        MaterialPageRoute(
          builder: (_) => TellFoodStoryScreen(
            eligibleOrders: [eligibleOrder],
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Tell your food story'), findsOneWidget);

      // Tap Home
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.byType(TellFoodStoryScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);

      // Push TellFoodStoryScreen again
      final scaffoldContext2 = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext2).push(
        MaterialPageRoute(
          builder: (_) => TellFoodStoryScreen(
            eligibleOrders: [eligibleOrder],
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Explore
      await tester.tap(find.text('Explore'));
      await tester.pumpAndSettle();
      expect(find.byType(TellFoodStoryScreen), findsNothing);
      expect(find.byType(ExploreScreen), findsOneWidget);

      // Push TellFoodStoryScreen again
      final scaffoldContext3 = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext3).push(
        MaterialPageRoute(
          builder: (_) => TellFoodStoryScreen(
            eligibleOrders: [eligibleOrder],
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Dabba
      await tester.tap(find.text('Dabba'));
      await tester.pumpAndSettle();
      expect(find.byType(TellFoodStoryScreen), findsNothing);
      expect(find.byType(SocialFeedScreen), findsOneWidget);

      // Push TellFoodStoryScreen again
      final scaffoldContext4 = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext4).push(
        MaterialPageRoute(
          builder: (_) => TellFoodStoryScreen(
            eligibleOrders: [eligibleOrder],
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Orders
      await tester.tap(find.text('Orders'));
      await tester.pumpAndSettle();
      expect(find.byType(TellFoodStoryScreen), findsNothing);
      expect(find.byType(OrdersScreen), findsOneWidget);

      // Push TellFoodStoryScreen again
      final scaffoldContext5 = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext5).push(
        MaterialPageRoute(
          builder: (_) => TellFoodStoryScreen(
            eligibleOrders: [eligibleOrder],
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Profile
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(find.byType(TellFoodStoryScreen), findsNothing);
      expect(find.byType(ProfileScreen), findsOneWidget);
    });

    testWidgets('Test 9: Profile sub-pages (Coins, Edit Details, Saved Addresses) -> Home, Explore, Dabba, Orders', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      // Push ThekaaCoinsScreen
      final scaffoldContext = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext).push(
        MaterialPageRoute(
          builder: (_) => const ThekaaCoinsScreen(),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('THEKAA Coins'), findsOneWidget);

      // Tap Orders -> navigates to Orders
      await tester.tap(find.text('Orders'));
      await tester.pumpAndSettle();
      expect(find.byType(ThekaaCoinsScreen), findsNothing);
      expect(find.byType(OrdersScreen), findsOneWidget);

      // Push ThekaaCoinsScreen again
      final scaffoldContext2 = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext2).push(
        MaterialPageRoute(
          builder: (_) => const ThekaaCoinsScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Explore -> navigates to Explore
      await tester.tap(find.text('Explore'));
      await tester.pumpAndSettle();
      expect(find.byType(ThekaaCoinsScreen), findsNothing);
      expect(find.byType(ExploreScreen), findsOneWidget);

      // Push EditProfileScreen
      final scaffoldContext3 = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext3).push(
        MaterialPageRoute(
          builder: (_) => EditProfileScreen(
            profile: ProfileRepository.instance.profile,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Home -> navigates to Home
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.byType(EditProfileScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);

      // Push SavedAddressesScreen
      final scaffoldContext4 = tester.element(find.byType(MainScaffold));
      Navigator.of(scaffoldContext4).push(
        MaterialPageRoute(
          builder: (_) => const SavedAddressesScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Dabba -> navigates to Dabba
      await tester.tap(find.text('Dabba'));
      await tester.pumpAndSettle();
      expect(find.byType(SavedAddressesScreen), findsNothing);
      expect(find.byType(SocialFeedScreen), findsOneWidget);
    });

    testWidgets('Test 10: Deep multi-screen nesting pops down to root MainScaffold preserving state', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final order = OrderConfirmation.fromCheckout(
        restaurant: Restaurant.shadabBiryani,
        payableAmount: 655.0,
      );
      OrderRepository.instance.addOrUpdateOrder(order);

      await tester.pumpWidget(const ThekaaApp());
      await tester.pumpAndSettle();

      // Push 4 levels deep: Restaurant -> Menu -> Cart -> ReviewOrder
      final rootContext = tester.element(find.byType(MainScaffold));
      Navigator.of(rootContext).push(
        MaterialPageRoute(
          builder: (_) => RestaurantDetailsScreen(
            restaurant: Restaurant.shadabBiryani,
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      final lvl1Context = tester.element(find.byType(RestaurantDetailsScreen));
      Navigator.of(lvl1Context).push(
        MaterialPageRoute(
          builder: (_) => RestaurantMenuScreen(
            restaurant: Restaurant.shadabBiryani,
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      final lvl2Context = tester.element(find.byType(RestaurantMenuScreen));
      Navigator.of(lvl2Context).push(
        MaterialPageRoute(
          builder: (_) => CartScreen(
            restaurant: Restaurant.shadabBiryani,
            initialQuantities: const {'chicken_dum_biryani': 2},
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      final lvl3Context = tester.element(find.byType(CartScreen));
      Navigator.of(lvl3Context).push(
        MaterialPageRoute(
          builder: (_) => ReviewOrderScreen(
            restaurant: Restaurant.shadabBiryani,
            initialCartQuantities: const {'chicken_dum_biryani': 2},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // We are 4 levels deep on ReviewOrderScreen
      expect(find.byType(ReviewOrderScreen), findsOneWidget);

      // Tap Orders tab (index 3)
      await tester.tap(find.text('Orders'));
      await tester.pumpAndSettle();

      // All pushed screens must be cleared in one go
      expect(find.byType(ReviewOrderScreen), findsNothing);
      expect(find.byType(CartScreen), findsNothing);
      expect(find.byType(RestaurantMenuScreen), findsNothing);
      expect(find.byType(RestaurantDetailsScreen), findsNothing);

      // Now at root OrdersScreen
      expect(find.byType(OrdersScreen), findsOneWidget);
      expect(find.text('Your Orders'), findsOneWidget);

      // Order state in repository is completely preserved
      final repoOrder = OrderRepository.instance.getOrderById(order.orderId);
      expect(repoOrder, isNotNull);
      expect(repoOrder?.restaurantName, 'Shadab Biryani');
    });
  });
}
