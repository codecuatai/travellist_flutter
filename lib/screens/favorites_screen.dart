import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/place.dart';
import '../services/firebase_service.dart';
import '../services/favorites_provider.dart';
import '../widgets/place_card.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' as custom_error;
import '../widgets/no_internet_widget.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FirebaseService _firebaseService = FirebaseService.instance;
  late Future<List<Place>> _placesFuture;

  @override
  void initState() {
    super.initState();
    _loadPlaces();
  }

  void _loadPlaces() {
    _placesFuture = _firebaseService.getAllPlaces();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yêu thích'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favProvider, _) {
          return FutureBuilder<List<Place>>(
            future: _placesFuture,
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
                final allPlaces = snapshot.data!;
                final favoritePlaces = allPlaces
                    .where((place) => favProvider.isFavorite(place.id))
                    .toList();

                if (favoritePlaces.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Chưa có địa điểm yêu thích',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Hãy thêm địa điểm vào yêu thích từ trang chính',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    _loadPlaces();
                    await _placesFuture;
                  },
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    itemCount: favoritePlaces.length,
                    itemBuilder: (context, index) {
                      final place = favoritePlaces[index];
                      return PlaceCard(
                        place: place,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailScreen(place: place),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              }

              // Empty State
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_off, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'Không có dữ liệu',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadPlaces,
        tooltip: 'Làm mới',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
