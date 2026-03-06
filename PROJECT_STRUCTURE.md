# 📂 Cấu trúc và Tổ chức Code Dự án Travel List

## 🏗️ Tổng quan cấu trúc thư mục

```
travellist04/
├── lib/
│   ├── main.dart                    # Entry point, Firebase initialization
│   ├── firebase_options.dart        # Firebase config (auto-generated)
│   │
│   ├── models/
│   │   └── place.dart              # Model Place với fromJson/toJson
│   │
│   ├── screens/
│   │   ├── home_screen.dart        # Main screen, UI cho loading/error/success
│   │   ├── detail_screen.dart      # Chi tiết địa điểm
│   │   ├── favorites_screen.dart   # Danh sách yêu thích
│   │   └── map_screen.dart         # Bản đồ
│   │
│   ├── services/
│   │   ├── firebase_service.dart   # (NEW) Gọi Firestore, xử lý lỗi
│   │   ├── api_service.dart        # (OLD) Không dùng nữa
│   │   └── favorites_provider.dart # Provider quản lý favorites
│   │
│   ├── widgets/
│   │   ├── place_card.dart         # Card item trong list
│   │   ├── error_widget.dart       # (NEW) Error UI với nút Retry
│   │   ├── loading_widget.dart     # (NEW) Shimmer loading UI
│   │   └── ...
│   │
│   └── utils/
│       └── constants.dart          # Hằng số (categories, app title)
│
├── android/                         # Native Android code
├── ios/                            # Native iOS code
├── web/                            # Web platform
├── pubspec.yaml                    # Dependencies (đã thêm firebase_core, cloud_firestore)
│
├── SETUP.md                        # (NEW) Hướng dẫn setup Firebase
├── PROJECT_STRUCTURE.md            # (NEW) File này - Tổ chức code
└── README.md                       # Mô tả project
```

---

## 🔑 Chi tiết các file quan trọng

### **1. main.dart** - Entry point

**Thay đổi:**

- Thêm Firebase initialization
- Gọi `FirebaseService.instance.initialize()`

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseService.instance.initialize();

  runApp(const MyApp());
}
```

**Tác dụng**: Đảm bảo Firebase được khởi tạo trước khi app chạy.

---

### **2. firebase_options.dart** - Firebase Configuration

**Lưu ý:**

- File này **tự động tạo** khi chạy `flutterfire configure`
- Chứa API keys cho Android, iOS, Web, etc.
- Đừng commit lên GitHub (thêm vào .gitignore)

**Cấu trúc:**

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'YOUR_KEY',
  appId: 'YOUR_APP_ID',
  messagingSenderId: 'YOUR_SENDER_ID',
  projectId: 'travellist04',
  // ...
);
```

---

### **3. models/place.dart** - Data Model

**Không thay đổi cấu trúc:**

```dart
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

  factory Place.fromJson(Map<String, dynamic> json) { ... }
  Map<String, dynamic> toJson() { ... }
}
```

**Ghi chú:**

- Có method `fromJson()` để convert từ Firestore document
- Có method `toJson()` để save vào Firestore

---

### **4. services/firebase_service.dart** - (NEW) Business Logic

**Chính là Core service cho ứng dụng:**

```dart
class FirebaseService {
  // Singleton pattern
  static final FirebaseService _instance = FirebaseService._internal();

  static FirebaseService get instance => _instance;

  // Methods chính:

  // 1. Lấy tất cả places
  Future<List<Place>> getAllPlaces() { ... }

  // 2. Lấy places theo category
  Future<List<Place>> getPlacesByCategory(String category) { ... }

  // 3. Lấy 1 place theo ID
  Future<Place?> getPlaceById(String placeId) { ... }

  // 4. Tìm kiếm
  Future<List<Place>> searchPlaces(String query) { ... }

  // 5. CRUD operations (Admin)
  Future<void> addPlace(Place place) { ... }
  Future<void> updatePlace(String placeId, Map<String, dynamic> data) { ... }
  Future<void> deletePlace(String placeId) { ... }
}
```

**Đặc điểm:**

- ✅ Try-catch xử lý lỗi an toàn
- ✅ Throw Exception với message rõ ràng
- ✅ Singleton pattern (chỉ có 1 instance)
- ✅ Hỗ trợ Firestore query filters

---

### **5. screens/home_screen.dart** - (UPDATED) Main UI

**Thay đổi lớn:**

- Thay `ApiService` → `FirebaseService`
- Thay `_buildShimmerLoading()` → `LoadingWidget`
- Thay `_buildErrorUI()` → `custom_error.ErrorWidget`

**Luồng xử lý:**

1. **initState**: Gọi `_loadPlaces()`
2. **FutureBuilder**:
   - `ConnectionState.waiting` → Hiển thị `LoadingWidget` (shimmer)
   - `snapshot.hasError` → Hiển thị `ErrorWidget` với nút Retry
   - `snapshot.hasData` → Hiển thị `_buildSuccessUI()`
   - Rỗng → Hiển thị "Không tìm thấy"

3. **\_buildSuccessUI()**: GridView + RefreshIndicator + Filter + Search

```dart
FutureBuilder<List<Place>>(
  future: _filteredPlacesFuture,
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

    return /* Empty State */;
  },
)
```

---

### **6. widgets/error_widget.dart** - (NEW) Error UI

**Hiển thị khi có lỗi:**

```dart
class ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80, color: Colors.red[400]),
          SizedBox(height: 24),
          Text('Oops! Có lỗi xảy ra'),
          Text(message),  // Display error message
          SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: onRetry,  // Gọi hàm retry
            icon: Icon(Icons.refresh),
            label: Text('Thử lại'),
          ),
        ],
      ),
    );
  }
}
```

**Sử dụng:**

```dart
custom_error.ErrorWidget(
  message: snapshot.error.toString(),
  onRetry: _loadPlaces,  // Gọi lại load data
)
```

---

### **7. widgets/loading_widget.dart** - (NEW) Loading UI

**Hiển thị khi đang tải:**

```dart
class LoadingWidget extends StatelessWidget {
  final int itemCount;  // Số shimmer items

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(/* Shimmer placeholder */)
        );
      },
    );
  }
}
```

**Sử dụng:**

```dart
if (snapshot.connectionState == ConnectionState.waiting) {
  return const LoadingWidget(itemCount: 6);
}
```

---

### **8. utils/constants.dart** - Configuration

```dart
class AppConstants {
  static const String appTitle = 'TH3 - Tran Van Tai - 123456';  // Thay tên sinh viên

  static const List<String> categories = [
    'Tất cả',
    'Biển đảo',
    'Núi rừng',
    'Di tích',
  ];
}
```

**Tùy chỉnh:**

- Thay `'Tran Van Tai - 123456'` bằng **tên và mã SV của bạn**
- Thêm/xóa categories theo nhu cầu

---

## 🔄 Luồng dữ liệu (Data Flow)

```
┌─────────────────┐
│  main.dart      │ Init Firebase
└────────┬────────┘
         │
         ▼
┌──────────────────────┐
│  home_screen.dart    │ Call initState()
└────────┬─────────────┘
         │
         ▼
┌──────────────────────────┐
│  firebase_service.dart   │ getPlacesByCategory()
│  (Try-Catch Error)       │
└────────┬─────────────────┘
         │
         ▼
┌──────────────────────────┐
│  Firestore Database      │ SELECT * FROM places WHERE category = ?
└────────┬─────────────────┘
         │
         ▼
┌──────────────────────────────────────────────────┐
│  FutureBuilder receives data/error               │
├──────────────────────────────────────────────────┤
│ IF loading → LoadingWidget (Shimmer)             │
│ IF error   → ErrorWidget (Retry button)          │
│ IF success → GridView (Places) + Filter + Search │
└──────────────────────────────────────────────────┘
```

---

## ⚙️ Cách Chỉnh Sửa Ứng Dụng

### **Thêm Category mới:**

1. Sửa `constants.dart`:

```dart
static const List<String> categories = [
  'Tất cả',
  'Biển đảo',
  'Núi rừng',
  'Di tích',
  'Nhà hàng',  // Category mới
];
```

2. Thêm documents mới trong Firestore với category = 'Nhà hàng'

---

### **Thay đổi thông tin sinh viên:**

Edit `constants.dart`:

```dart
static const String appTitle = 'TH3 - [TÊN BẠN] - [MÃ SV]';
```

---

### **Thêm Filter khi chạy:**

Sửa `firebase_service.dart`:

```dart
Future<List<Place>> getPlacesByRating(double minRating) async {
  try {
    final QuerySnapshot snapshot = await _firestore
        .collection('places')
        .where('rating', isGreaterThanOrEqualTo: minRating)
        .get();

    return snapshot.docs
        .map((doc) => Place.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id}))
        .toList();
  } catch (e) {
    throw Exception('Lỗi: $e');
  }
}
```

---

### **Thêm Feature Mới (ví dụ: Sorting):**

1. Tạo method mới trong `firebase_service.dart`
2. Gọi method đó từ `home_screen.dart`
3. Update UI để hiển thị sorting options

---

## 📋 Checklist Trước khi Submit

- [ ] Thông tin sinh viên đúng trong AppBar: `TH3 - [Tên] - [Mã]`
- [ ] Loading UI: Shimmer effect hiển thị đúng
- [ ] Error UI: Lỗi hiển thị rõ, có nút Retry
- [ ] Success UI: GridView/ListView hiển thị đúng
- [ ] Category filter: Hoạt động
- [ ] Search: Hoạt động
- [ ] Retry button: Hoạt động (test bằng cách tắt WiFi)
- [ ] Code tách file rõ ràng (không viết toàn bộ ở main.dart)
- [ ] Try-catch bắt lỗi an toàn
- [ ] Không có lỗi compile, warning

---

## 🎯 Các trạng thái xử lý bắt buộc

✅ **LOADING STATE**:

- Hiển thị shimmer/skeleton loading
- Không để màn hình trắng tinh

✅ **ERROR STATE**:

- Hiển thị error message rõ ràng
- Có nút "Thử lại" (Retry)
- Khi nhấn retry, gọi lại API/Firestore

✅ **SUCCESS STATE**:

- Hiển thị dữ liệu dưới dạng ListView hoặc GridView
- Item card có design gọn gàng, text dài cắt gọn
- Hỗ trợ filter, search, interaction

---

Chúc bạn code vui vẻ! 🚀
