# 📝 Danh sách Thay Đổi (Changelog)

## Những gì đã thay đổi trong dự án

### ✅ Files Mới Tạo (New)

1. **lib/services/firebase_service.dart**
   - Service xử lý tất cả Firestore operations
   - Singleton pattern
   - Try-catch xử lý lỗi an toàn
   - Methods: getPlacesByCategory, getPlaceById, searchPlaces, etc.

2. **lib/widgets/error_widget.dart**
   - Error UI component
   - Hiển thị lỗi với icon, message, nút Retry
   - Gọi callback khi bấn Retry

3. **lib/widgets/loading_widget.dart**
   - Loading UI component
   - Shimmer skeleton effect
   - 6 items placeholder

4. **lib/firebase_options.dart**
   - Firebase configuration file
   - **Auto-generated** khi chạy `flutterfire configure`
   - Chứa API keys cho Android, iOS, Web

5. **Documentation Files:**
   - **SETUP.md** - Hướng dẫn setup Firebase chi tiết (⭐ Bắt buộc đọc)
   - **PROJECT_STRUCTURE.md** - Cấu trúc code & cách chỉnh sửa
   - **QUICKSTART.md** - Chạy nhanh nhất
   - **CHANGES.md** - File này, danh sách thay đổi

### 🔄 Files Đã Cập Nhật (Modified)

1. **pubspec.yaml**

   ```diff
   + firebase_core: ^2.24.0
   + cloud_firestore: ^4.14.0
   ```

2. **lib/main.dart**

   ```diff
   + import 'package:firebase_core/firebase_core.dart';
   + import 'firebase_options.dart';
   + import 'services/firebase_service.dart';

   + void main() async {
   +   WidgetsFlutterBinding.ensureInitialized();
   +   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   +   await FirebaseService.instance.initialize();
     runApp(const MyApp());
   }
   ```

3. **lib/screens/home_screen.dart**

   ```diff
   - import '../services/api_service.dart';
   + import '../services/firebase_service.dart';

   - import 'package:shimmer/shimmer.dart';
   + import '../widgets/loading_widget.dart';
   + import '../widgets/error_widget.dart' as custom_error;

   - final ApiService _apiService = ApiService();
   + final FirebaseService _firebaseService = FirebaseService.instance;

   - _filteredPlacesFuture = _apiService.fetchPlacesByCategory(_selectedCategory);
   + _filteredPlacesFuture = _firebaseService.getPlacesByCategory(_selectedCategory);

   # FutureBuilder states:
   - Thay _buildShimmerLoading() → const LoadingWidget(itemCount: 6)
   - Thay _buildErrorUI() → custom_error.ErrorWidget(...)

   # Build method:
   - Xóa methods: _buildShimmerLoading(), _buildErrorUI()
   - Giữ: _buildSuccessUI()
   ```

4. **README.md**
   - Cập nhật toàn bộ nội dung
   - Thêm Firebase info
   - Thêm link tới documentation

### ❌ Files Không Dùng Nữa (Deprecated)

1. **lib/services/api_service.dart**
   - Không được import trong home_screen.dart nữa
   - Có thể xóa sau khi confirm tất cả hoạt động

---

## 🎯 Khác biệt chính: Before vs After

### BEFORE (Old Implementation)

```dart
// main.dart
void main() {
  runApp(const MyApp());
}

// home_screen.dart
final ApiService _apiService = ApiService();

FutureBuilder<List<Place>>(
  future: _apiService.fetchPlacesByCategory(_selectedCategory),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return _buildShimmerLoading(); // Shimmer inline
    }
    // ...
  },
)

Widget _buildShimmerLoading() {
  return ListView.builder(
    itemCount: 6,
    itemBuilder: (context, index) {
      return Shimmer.fromColors(/* ... */);
    },
  );
}
```

**Vấn đề:**

- ❌ Gọi HTTP API từ mocki.io (dữ liệu fake)
- ❌ Shimmer inline trong home_screen.dart
- ❌ Không có proper error handling
- ❌ Code không tách file

### AFTER (New Implementation)

```dart
// main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseService.instance.initialize();
  runApp(const MyApp());
}

// services/firebase_service.dart
class FirebaseService {
  Future<List<Place>> getPlacesByCategory(String category) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('places')
          .where('category', isEqualTo: category)
          .get();
      // ...
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }
}

// home_screen.dart
final FirebaseService _firebaseService = FirebaseService.instance;

FutureBuilder<List<Place>>(
  future: _firebaseService.getPlacesByCategory(_selectedCategory),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const LoadingWidget(itemCount: 6);
    }

    if (snapshot.hasError) {
      return custom_error.ErrorWidget(
        message: snapshot.error.toString(),
        onRetry: _loadPlaces,
      );
    }

    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
      return _buildSuccessUI(snapshot.data!);
    }

    return /* Empty state */;
  },
)
```

**Cải tiến:**

- ✅ Dữ liệu thực từ Firebase Firestore
- ✅ Loading UI: LoadingWidget riêng
- ✅ Error UI: ErrorWidget riêng với Retry button
- ✅ Try-catch xử lý lỗi an toàn
- ✅ Code tách file rõ ràng (firebase_service, error_widget, loading_widget)

---

## 🔫 Cấu trúc Data bây giờ

### BEFORE (API Response)

```json
// HTTP Response từ mocki.io
{
  "places": [
    { "id": 1, "name": "Ha Long Bay", ... },
    { "id": 2, "name": "Hoi An", ... }
  ]
}
```

### AFTER (Firestore Document)

```json
// Firestore Collection: places
{
  "documentId": "auto-generated",
  "name": "Ha Long Bay",
  "image": "https://...",
  "description": "...",
  "location": "Quảng Ninh",
  "category": "Biển đảo",
  "rating": 4.8,
  "latitude": 20.8552,
  "longitude": 107.1909
}
```

---

## 📦 Dependencies Mới

```yaml
dependencies:
  # Firebase
  firebase_core: ^2.24.0 # Firebase initialization
  cloud_firestore: ^4.14.0 # Firestore Database

  # Existing
  provider: ^6.0.0 # State management
  shared_preferences: ^2.0.15 # Local storage
  # ...
```

---

## 🔄 Migration Guide

Nếu có code cũ khác sử dụng ApiService, cần update:

```dart
// OLD
import 'services/api_service.dart';
final ApiService _apiService = ApiService();
_apiService.fetchPlacesByCategory(category);

// NEW
import 'services/firebase_service.dart';
final FirebaseService _firebaseService = FirebaseService.instance;
_firebaseService.getPlacesByCategory(category);
```

---

## ✨ New Features

1. **Real Firestore Database**: Dữ liệu lưu trữ thực trên Firebase
2. **Error Handling**: Xử lý lỗi proper với UI & Retry button
3. **Loading UI**: Shimmer effect xinh xắn
4. **Separated Components**: Error & Loading widgets riêng biệt
5. **Try-Catch Safety**: Tất cả Firestore operations được bảo vệ

---

## 🚀 Tiếp theo (What's Next)

Sau khi setup Firebase & chạy được ứng dụng:

1. [ ] Thay đổi app title theo tên sinh viên (constants.dart)
2. [ ] Thêm categories mới nếu muốn
3. [ ] Tùy chỉnh design (colors, fonts, layouts)
4. [ ] Thêm features mới (sorting, rating filters, etc.)
5. [ ] Deploy lên Google Play Store / App Store (optional)

---

## 📊 Summary Checklist

- [x] Thêm Firebase dependencies
- [x] Tạo firebase_service.dart
- [x] Tạo error_widget.dart
- [x] Tạo loading_widget.dart
- [x] Cập nhật main.dart
- [x] Cập nhật home_screen.dart
- [x] Tạo firebase_options.dart (template)
- [x] Cập nhật README.md
- [x] Viết SETUP.md
- [x] Viết PROJECT_STRUCTURE.md
- [x] Viết QUICKSTART.md
- [x] Viết CHANGES.md (file này)

---

Dự án đã sẵn sàng! Hãy làm theo [SETUP.md](SETUP.md) để chạy ứng dụng. 🎉
