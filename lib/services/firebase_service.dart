import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/place.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  late FirebaseFirestore _firestore;

  FirebaseService._internal();

  static FirebaseService get instance => _instance;

  Future<void> initialize() async {
    _firestore = FirebaseFirestore.instance;
  }

  /// Kiểm tra xem lỗi có phải là lỗi network không
  bool _isNetworkError(dynamic error) {
    final errorString = error.toString().toLowerCase();
    return errorString.contains('network') ||
        errorString.contains('unavailable') ||
        errorString.contains('timeout') ||
        errorString.contains('connection') ||
        errorString.contains('offline') ||
        errorString.contains('firebase') && errorString.contains('network');
  }

  /// Lấy tất cả địa điểm từ Firestore
  Future<List<Place>> getAllPlaces() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('places')
          .get();

      final List<Place> places = snapshot.docs
          .map(
            (doc) => Place.fromJson({
              ...doc.data() as Map<String, dynamic>,
              'id': doc.id,
            }),
          )
          .toList();

      return places;
    } catch (e) {
      if (_isNetworkError(e)) {
        throw Exception('NO_INTERNET');
      }
      throw Exception('Lỗi khi tải dữ liệu: $e');
    }
  }

  /// Lấy địa điểm theo danh mục
  Future<List<Place>> getPlacesByCategory(String category) async {
    try {
      Query query = _firestore.collection('places');

      if (category != 'Tất cả') {
        query = query.where('category', isEqualTo: category);
      }

      final QuerySnapshot snapshot = await query.get();

      final List<Place> places = snapshot.docs
          .map(
            (doc) => Place.fromJson({
              ...doc.data() as Map<String, dynamic>,
              'id': doc.id,
            }),
          )
          .toList();

      return places;
    } catch (e) {
      if (_isNetworkError(e)) {
        throw Exception('NO_INTERNET');
      }
      throw Exception('Lỗi khi lọc dữ liệu theo danh mục: $e');
    }
  }

  /// Lấy địa điểm theo ID
  Future<Place?> getPlaceById(String placeId) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection('places')
          .doc(placeId)
          .get();

      if (doc.exists) {
        return Place.fromJson({
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
        });
      }
      return null;
    } catch (e) {
      if (_isNetworkError(e)) {
        throw Exception('NO_INTERNET');
      }
      throw Exception('Lỗi khi tải chi tiết địa điểm: $e');
    }
  }

  /// Tìm kiếm địa điểm theo tên
  Future<List<Place>> searchPlaces(String query) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('places')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: '${query}z')
          .get();

      final List<Place> places = snapshot.docs
          .map(
            (doc) => Place.fromJson({
              ...doc.data() as Map<String, dynamic>,
              'id': doc.id,
            }),
          )
          .toList();

      return places;
    } catch (e) {
      if (_isNetworkError(e)) {
        throw Exception('NO_INTERNET');
      }
      throw Exception('Lỗi khi tìm kiếm: $e');
    }
  }

  /// Thêm địa điểm mới (Admin function)
  Future<void> addPlace(Place place) async {
    try {
      await _firestore.collection('places').add(place.toJson());
    } catch (e) {
      throw Exception('Lỗi khi thêm địa điểm: $e');
    }
  }

  /// Cập nhật địa điểm
  Future<void> updatePlace(String placeId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('places').doc(placeId).update(data);
    } catch (e) {
      throw Exception('Lỗi khi cập nhật địa điểm: $e');
    }
  }

  /// Xóa địa điểm
  Future<void> deletePlace(String placeId) async {
    try {
      await _firestore.collection('places').doc(placeId).delete();
    } catch (e) {
      throw Exception('Lỗi khi xóa địa điểm: $e');
    }
  }
}
