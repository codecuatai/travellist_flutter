class Place {
  final String id;
  final String name;
  final String image;
  final String description;
  final String location;
  final String category;
  final double rating;
  final double latitude;
  final double longitude;

  Place({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.location,
    required this.category,
    required this.rating,
    required this.latitude,
    required this.longitude,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? 'Unknown',
      image: json['image'] ?? '',
      description: json['description'] ?? 'No description available',
      location: json['location'] ?? 'Unknown',
      category: json['category'] ?? 'Tất cả',
      rating: (json['rating'] ?? 0.0).toDouble(),
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'location': location,
      'category': category,
      'rating': rating,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
