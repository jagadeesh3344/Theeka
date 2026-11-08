import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import 'home_screen.dart';
import 'explore_screen.dart';
import 'restaurant_details_screen.dart';
import 'dabba_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;
  String _selectedLocation = 'Gachibowli';
  Restaurant _selectedExploreRestaurant = Restaurant.shadabBiryani;

  final List<String> _locations = [
    'Gachibowli',
    'Jubilee Hills',
    'Banjara Hills',
    'Madhapur',
    'Hitec City',
    'Old City (Charminar)',
    'Kondapur',
  ];

  void _onNotificationTap() {
    showModalBottomSheet(
      context: context,
      backgroundColor: ThekaaColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Notifications', style: ThekaaTypography.sectionHeading),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: ThekaaColors.mainBackground,
                  child: Icon(Icons.celebration_outlined, color: ThekaaColors.terracotta),
                ),
                title: Text('Biryani Festival is Live!', style: ThekaaTypography.restaurantName.copyWith(fontSize: 16)),
                subtitle: Text('Get special dum biryani recommendations across Hyderabad.', style: ThekaaTypography.deliveryInfo),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  void _onLocationTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ThekaaColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Select Location', style: ThekaaTypography.sectionHeading),
                      IconButton(
                        icon: const Icon(Icons.close, color: ThekaaColors.primaryText),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ..._locations.map(
                    (loc) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.place_outlined,
                        color: loc == _selectedLocation
                            ? ThekaaColors.terracotta
                            : ThekaaColors.secondaryText,
                      ),
                      title: Text(
                        loc,
                        style: loc == _selectedLocation
                            ? ThekaaTypography.restaurantName.copyWith(fontSize: 16)
                            : ThekaaTypography.deliveryInfo.copyWith(
                                fontSize: 15,
                                color: ThekaaColors.primaryText,
                              ),
                      ),
                      trailing: loc == _selectedLocation
                          ? const Icon(Icons.check, color: ThekaaColors.terracotta)
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedLocation = loc;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigateToExploreWithRestaurant(Restaurant restaurant) {
    setState(() {
      _selectedExploreRestaurant = restaurant;
      _currentIndex = 1;
    });
  }

  void _openRestaurantDetails(Restaurant restaurant) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RestaurantDetailsScreen(
          restaurant: restaurant,
          onBack: () => Navigator.of(context).pop(),
          onBottomNavTap: (index) {
            Navigator.of(context).pop();
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
        location: _selectedLocation,
        onNotificationTap: _onNotificationTap,
        onLocationTap: _onLocationTap,
        onExploreMapTap: () {
          setState(() {
            _currentIndex = 1;
          });
        },
        onSeeAllTap: () {
          setState(() {
            _currentIndex = 1;
          });
        },
        onRestaurantTap: _navigateToExploreWithRestaurant,
      ),
      ExploreScreen(
        initialRestaurant: _selectedExploreRestaurant,
        location: _selectedLocation,
        onLocationTap: _onLocationTap,
        onRestaurantChanged: (res) {
          setState(() {
            _selectedExploreRestaurant = res;
          });
        },
        onOpenDetails: _openRestaurantDetails,
      ),
      DabbaScreen(
        activeRestaurant: _selectedExploreRestaurant,
        onBottomNavTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      const OrdersScreen(),
      const ProfileScreen(showBottomNav: false),
    ];

    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: ThekaaBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
