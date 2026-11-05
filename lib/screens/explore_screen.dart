import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../theme/thekaa_colors.dart';
import '../widgets/explore_header.dart';
import '../widgets/explore_search_bar.dart';
import '../widgets/map_list_selector.dart';
import '../widgets/explore_filter_chips.dart';
import '../widgets/explore_map_section.dart';
import '../widgets/explore_restaurant_card.dart';
import '../widgets/nearby_hidden_gems_section.dart';

class ExploreScreen extends StatefulWidget {
  final Restaurant? initialRestaurant;
  final String location;
  final VoidCallback? onLocationTap;
  final ValueChanged<Restaurant>? onRestaurantChanged;
  final ValueChanged<Restaurant>? onOpenDetails;

  const ExploreScreen({
    super.key,
    this.initialRestaurant,
    this.location = 'Gachibowli',
    this.onLocationTap,
    this.onRestaurantChanged,
    this.onOpenDetails,
  });

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late Restaurant _selectedRestaurant;
  ExploreViewMode _viewMode = ExploreViewMode.map;
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCuisine;
  String? _selectedPrice;
  bool _isWithin3Km = true;

  @override
  void initState() {
    super.initState();
    _selectedRestaurant = widget.initialRestaurant ?? Restaurant.shadabBiryani;
  }

  @override
  void didUpdateWidget(covariant ExploreScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialRestaurant != null && widget.initialRestaurant != oldWidget.initialRestaurant) {
      setState(() {
        _selectedRestaurant = widget.initialRestaurant!;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSelectRestaurant(Restaurant res) {
    setState(() {
      _selectedRestaurant = res;
    });
    widget.onRestaurantChanged?.call(res);
  }

  void _showCuisineFilter() {
    final cuisines = ['All', 'Biryani', 'South Indian', 'Irani Chai & Bakery', 'North Indian', 'Mughlai'];
    showModalBottomSheet(
      context: context,
      backgroundColor: ThekaaColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter by Cuisine',
                style: TextStyle(
                  fontFamily: 'Playfair Display',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ThekaaColors.primaryText,
                ),
              ),
              const SizedBox(height: 12),
              ...cuisines.map((c) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(c, style: const TextStyle(fontFamily: 'Inter', fontSize: 14)),
                    trailing: _selectedCuisine == c || (_selectedCuisine == null && c == 'All')
                        ? const Icon(Icons.check, color: ThekaaColors.terracotta)
                        : null,
                    onTap: () {
                      setState(() {
                        _selectedCuisine = c == 'All' ? null : c;
                      });
                      Navigator.pop(context);
                    },
                  )),
            ],
          ),
        );
      },
    );
  }

  void _showPriceFilter() {
    final prices = ['All', '₹', '₹₹', '₹₹₹'];
    showModalBottomSheet(
      context: context,
      backgroundColor: ThekaaColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter by Price Range',
                style: TextStyle(
                  fontFamily: 'Playfair Display',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ThekaaColors.primaryText,
                ),
              ),
              const SizedBox(height: 12),
              ...prices.map((p) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(p, style: const TextStyle(fontFamily: 'Inter', fontSize: 14)),
                    trailing: _selectedPrice == p || (_selectedPrice == null && p == 'All')
                        ? const Icon(Icons.check, color: ThekaaColors.terracotta)
                        : null,
                    onTap: () {
                      setState(() {
                        _selectedPrice = p == 'All' ? null : p;
                      });
                      Navigator.pop(context);
                    },
                  )),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final nearbyGems = Restaurant.getNearbyGems(_selectedRestaurant.id);

    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // B. Header section
              ExploreHeader(
                onLocationTap: widget.onLocationTap,
              ),
              const SizedBox(height: 14),

              // C. Search bar
              ExploreSearchBar(
                controller: _searchController,
                onFilterTap: _showCuisineFilter,
              ),
              const SizedBox(height: 14),

              // D. Location info & E. Map / List selector
              MapListSelector(
                location: widget.location,
                currentMode: _viewMode,
                onModeChanged: (mode) {
                  setState(() {
                    _viewMode = mode;
                  });
                },
              ),
              const SizedBox(height: 14),

              // F. Filter chips
              ExploreFilterChips(
                selectedCuisine: _selectedCuisine,
                selectedPrice: _selectedPrice,
                isWithin3Km: _isWithin3Km,
                onCuisineTap: _showCuisineFilter,
                onPriceTap: _showPriceFilter,
                onDistanceToggle: () {
                  setState(() {
                    _isWithin3Km = !_isWithin3Km;
                  });
                },
              ),
              const SizedBox(height: 16),

              // VIEW SELECTION: MAP VIEW vs LIST VIEW
              if (_viewMode == ExploreViewMode.map) ...[
                // G. Map preview
                ExploreMapSection(
                  selectedRestaurant: _selectedRestaurant,
                  onMapControlTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Focusing on ${_selectedRestaurant.locality}'),
                        duration: const Duration(seconds: 1),
                        backgroundColor: ThekaaColors.terracotta,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 14),

                // H. Contextual Restaurant result card
                ExploreRestaurantCard(
                  restaurant: _selectedRestaurant,
                  onTap: () {
                    widget.onOpenDetails?.call(_selectedRestaurant);
                  },
                ),
                const SizedBox(height: 20),

                // I. Nearby hidden gems
                NearbyHiddenGemsSection(
                  gems: nearbyGems,
                  onViewAllTap: () {
                    setState(() {
                      _viewMode = ExploreViewMode.list;
                    });
                  },
                  onGemTap: (gem) {
                    _onSelectRestaurant(gem);
                    widget.onOpenDetails?.call(gem);
                  },
                ),
              ] else ...[
                // List View Layout
                Text(
                  'All Recommendations in ${widget.location}',
                  style: TextStyle(
                    fontFamily: 'Playfair Display',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ThekaaColors.primaryText,
                  ),
                ),
                const SizedBox(height: 12),
                ...Restaurant.allRestaurants.map((res) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ExploreRestaurantCard(
                      restaurant: res,
                      onTap: () {
                        _onSelectRestaurant(res);
                        widget.onOpenDetails?.call(res);
                      },
                    ),
                  );
                }),
              ],

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
