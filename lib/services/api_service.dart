import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/place.dart';
import '../utils/constants.dart';

class ApiService {
  // Sample data for demonstration
  static List<Place> _getSampleData() {
    return [
      Place(
        id: '1',
        name: 'Ha Long Bay',
        image:
            'https://images.unsplash.com/photo-1505228395891-9a51e7e86e81?w=500',
        description: 'Kỳ quan thiên nhiên thế giới với những vách đá vôi kỳ lạ',
        location: 'Quảng Ninh, Việt Nam',
        category: 'Biển đảo',
        rating: 4.8,
        latitude: 20.8552,
        longitude: 107.1909,
      ),
      Place(
        id: '2',
        name: 'Hoi An Ancient Town',
        image:
            'https://images.unsplash.com/photo-1580541831066-7a46e9e751d4?w=500',
        description:
            'Thị trấn cổ đẹp nhất Đông Nam Á với kiến trúc truyền thống',
        location: 'Quảng Nam, Việt Nam',
        category: 'Di tích',
        rating: 4.6,
        latitude: 15.8794,
        longitude: 108.3261,
      ),
      Place(
        id: '3',
        name: 'Sapa Mountains',
        image:
            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=500',
        description: 'Dãy núi hùng vĩ với ruộng bậc thang và dân tộc đặc biệt',
        location: 'Lào Cai, Việt Nam',
        category: 'Núi rừng',
        rating: 4.7,
        latitude: 22.3402,
        longitude: 103.8343,
      ),
      Place(
        id: '4',
        name: 'Phu Quoc Island',
        image:
            'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500',
        description: 'Hòn đảo thiên đường với bãi cát trắng và biển xanh',
        location: 'Kiên Giang, Việt Nam',
        category: 'Biển đảo',
        rating: 4.5,
        latitude: 10.2167,
        longitude: 103.9667,
      ),
      Place(
        id: '5',
        name: 'Mekong Delta',
        image:
            'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=500',
        description: 'Vùng đất ẩm thấp với kênh rạch và cuộc sống đi làng',
        location: 'An Giang, Việt Nam',
        category: 'Núi rừng',
        rating: 4.3,
        latitude: 10.7626,
        longitude: 104.7282,
      ),
      Place(
        id: '6',
        name: 'Hue Ancient Capital',
        image:
            'https://images.unsplash.com/photo-1518895949257-7621c3c786d7?w=500',
        description: 'Kinh đô cổ của nhà vua với kiến trúc tráng lệ',
        location: 'Thừa Thiên Huế, Việt Nam',
        category: 'Di tích',
        rating: 4.4,
        latitude: 16.4637,
        longitude: 107.5909,
      ),
      Place(
        id: '7',
        name: 'Cat Ba Island',
        image:
            'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=500',
        description: 'Hòn đảo lớn nhất vịnh Hạ Long với bãi biển tuyệt đẹp',
        location: 'Quảng Ninh, Việt Nam',
        category: 'Biển đảo',
        rating: 4.5,
        latitude: 20.7192,
        longitude: 107.0560,
      ),
      Place(
        id: '8',
        name: 'Da Lat city',
        image:
            'https://images.unsplash.com/photo-1469022563149-aa64dbd37ff0?w=500',
        description: 'Thành phố hoa với khí hậu mát mẻ và cảnh quan lãng mạn',
        location: 'Lâm Đồng, Việt Nam',
        category: 'Núi rừng',
        rating: 4.6,
        latitude: 11.9388,
        longitude: 108.4453,
      ),
    ];
  }

  Future<List<Place>> fetchPlaces() async {
    try {
      final response = await http
          .get(Uri.parse(AppConstants.apiBaseUrl))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('Request timeout'),
          );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((place) => Place.fromJson(place as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load travel places: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback to sample data on error
      debugPrint('API Error: $e, using sample data');
      return _getSampleData();
    }
  }

  Future<List<Place>> fetchPlacesByCategory(String category) async {
    try {
      final allPlaces = await fetchPlaces();
      if (category == 'Tất cả') {
        return allPlaces;
      }
      return allPlaces.where((place) => place.category == category).toList();
    } catch (e) {
      throw Exception('Error fetching places by category: ${e.toString()}');
    }
  }
}
