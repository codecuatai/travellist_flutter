import 'package:flutter/material.dart';
import '../models/place.dart';
import '../services/firebase_service.dart';
import '../services/connectivity_service.dart';
import '../widgets/place_card.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' as custom_error;
import '../widgets/no_internet_widget.dart';
import 'favorites_screen.dart';
import '../utils/constants.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseService _firebaseService = FirebaseService.instance;
  final ConnectivityService _connectivityService = ConnectivityService.instance;
  String _selectedCategory = 'Tất cả';
  String _searchQuery = '';
  late Future<List<Place>> _filteredPlacesFuture;

  @override
  void initState() {
    super.initState();
    _loadPlaces();
  }

  void _loadPlaces() async {
    // Check internet connection first
    final hasInternet = await _connectivityService.hasInternetConnection();

    if (!hasInternet) {
      _filteredPlacesFuture = Future.error(Exception('NO_INTERNET'));
    } else {
      _filteredPlacesFuture = _firebaseService.getPlacesByCategory(
        _selectedCategory,
      );
    }
    setState(() {});
  }

  void _onCategoryChanged(String category) {
    setState(() {
      _selectedCategory = category;
      _loadPlaces();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appTitle),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
        elevation: 4,
        actions: [
          IconButton(
            tooltip: 'Xem Favorites',
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: AppConstants.categories.length,
                itemBuilder: (context, index) {
                  final category = AppConstants.categories[index];
                  final isSelected = _selectedCategory == category;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) => _onCategoryChanged(category),
                      backgroundColor: Colors.grey[200],
                      selectedColor: Colors.blue[300],
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Search box
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tìm địa điểm...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: (v) {
                setState(() {
                  _searchQuery = v.trim();
                });
              },
            ),
          ),
          // Places List
          Expanded(
            child: FutureBuilder<List<Place>>(
              future: _filteredPlacesFuture,
              builder: (context, snapshot) {
                // Loading State
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget(itemCount: 6);
                }

                // Error State
                if (snapshot.hasError) {
                  final errorMessage = snapshot.error.toString();

                  // Check if it's a network error
                  if (errorMessage.contains('NO_INTERNET')) {
                    return NoInternetWidget(onRetry: _loadPlaces);
                  }

                  return custom_error.ErrorWidget(
                    message: errorMessage.replaceAll('Exception: ', ''),
                    onRetry: _loadPlaces,
                  );
                }

                // Success State
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return _buildSuccessUI(snapshot.data!);
                }

                // Empty State
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_off,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Không tìm thấy địa điểm',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadPlaces,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildSuccessUI(List<Place> places) {
    return RefreshIndicator(
      onRefresh: () async {
        _loadPlaces();
        await _filteredPlacesFuture;
      },
      child: Builder(
        builder: (context) {
          final filtered = places
              .where(
                (p) =>
                    p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                    p.description.toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ),
              )
              .toList();

          if (filtered.isEmpty) {
            return ListView(
              children: [
                const SizedBox(height: 80),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Không tìm thấy địa điểm theo từ khóa "$_searchQuery"',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ),
                ),
              ],
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final place = filtered[index];
              return PlaceCard(
                place: place,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(place: place),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
