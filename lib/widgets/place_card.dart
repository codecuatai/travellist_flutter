import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/place.dart';
import '../services/favorites_provider.dart';

class PlaceCard extends StatelessWidget {
  final Place place;
  final VoidCallback onTap;

  const PlaceCard({super.key, required this.place, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flexible image area using AspectRatio to avoid fixed height overflow
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: place.id,
                      child: Image.network(
                        place.image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(color: Colors.grey[300]);
                        },
                        errorBuilder: (context, error, stackTrace) {
                          // Remove small placeholder icon; show neutral background instead
                          return Container(color: Colors.grey[300]);
                        },
                      ),
                    ),
                    // (no overlay favorite button - favorite shown at card bottom)
                  ],
                ),
              ),
            ),

            // Content (no Expanded to keep intrinsic height)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    place.description,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: Text(
                          place.category,
                          style: const TextStyle(fontSize: 10),
                        ),
                        backgroundColor: Colors.blue[100],
                        visualDensity: VisualDensity.compact,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            place.rating.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(width: 8),
                          // Favorite button at bottom-right of card
                          Consumer<FavoritesProvider>(
                            builder: (context, provider, _) {
                              final isFav = provider.isFavorite(place.id);
                              return Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: isFav
                                      ? Colors.redAccent
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.08),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () =>
                                      provider.toggleFavorite(place.id),
                                  icon: Icon(
                                    Icons.favorite,
                                    color: isFav
                                        ? Colors.white
                                        : Colors.redAccent,
                                    size: 18,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
