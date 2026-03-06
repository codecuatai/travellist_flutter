# 🌍 Travel List - Flutter App với Firebase

Ứng dụng Flutter hiển thị danh sách địa điểm du lịch từ **Firebase Firestore** với xử lý trạng thái **Loading**, **Error**, và **Success**.

## ✨ Tính năng

- 📤 **Loading State**: Shimmer effect hiển thị trong quá trình tải dữ liệu
- ❌ **Error State**: Error UI rõ ràng với nút "Thử lại" (Retry)
- ✅ **Success State**: GridView hiển thị danh sách địa điểm
- 🔍 **Search**: Tìm kiếm địa điểm theo tên
- 🏷️ **Filter**: Lọc theo category (Biển đảo, Núi rừng, Di tích)
- ❤️ **Favorites**: Lưu địa điểm yêu thích (SharedPreferences)
- 📍 **Detail Screen**: Xem chi tiết địa điểm
- 🗺️ **Map View**: Xem vị trí trên bản đồ
- 🔄 **Refresh**: Tải lại dữ liệu từ Firebase

## 🚀 Quick Start

**1. Cài FlutterFire CLI:**

```bash
dart pub global activate flutterfire_cli
```

**2. Config Firebase:**

```bash
cd travellist04
flutterfire configure --project=travellist04
```

**3. Tải packages & chạy:**

```bash
flutter pub get
flutter run
```

📖 **Hướng dẫn chi tiết:** Xem [SETUP.md](SETUP.md)

## 📋 Cấu trúc Project

```
lib/
├── main.dart                  # Entry point, Firebase init
├── firebase_options.dart      # Firebase config (auto-generated)
├── models/
│   └── place.dart            # Model Place
├── screens/
│   ├── home_screen.dart      # Main screen
│   ├── detail_screen.dart
│   ├── favorites_screen.dart
│   └── map_screen.dart
├── services/
│   ├── firebase_service.dart (NEW) # Firestore operations
│   └── favorites_provider.dart
├── widgets/
│   ├── place_card.dart
│   ├── error_widget.dart     (NEW) # Error UI
│   └── loading_widget.dart   (NEW) # Loading UI
└── utils/
    └── constants.dart
```

📖 **Chi tiết cấu trúc:** Xem [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)

## 🛠️ Dependencies

- **firebase_core**: ^2.24.0 - Firebase initialization
- **cloud_firestore**: ^4.14.0 - Firestore Database
- **provider**: ^6.0.0 - State management
- **shared_preferences**: ^2.0.15 - Local storage
- **flutter_map**: ^5.0.0 - Map widget
- **shimmer**: ^3.0.0 - Loading effect
- **url_launcher**: ^6.2.0 - Open URLs

## 📳 Yêu cầu

- Flutter SDK >= 3.10.7
- Dart SDK >= 3.10.7
- Firebase Account (miễn phí tại firebase.google.com)

## 🎯 Trạng thái Xử lý (3 States)

### 1. Loading State ⏳

- Hiển thị **Shimmer loading** (giả lập skeleton screen)
- Làm cho UX tốt hơn khi chờ dữ liệu

### 2. Error State ❌

- Hiển thị **Error message** rõ ràng
- Có nút **"Thử lại"** để gọi lại API/Firestore
- Try-catch bắt tất cả ngoại lệ

### 3. Success State ✅

- GridView hiển thị **6 places**
- Hỗ trợ **search** và **filter**
- Mỗi item là Card có:
  - Ảnh place
  - Tên, địa điểm, mô tả
  - Rating
  - Nút favorite
  - Bấm để xem chi tiết

## 🔐 Firebase Setup

### Firestore Collection Structure

Collection: `places`

```json
{
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

### Security Rules

```firestore
rules_version = '3';
service cloud.firestore {
  match /databases/{database}/documents {
    match /places/{document=**} {
      allow read;
      allow write: if request.auth != null;
    }
  }
}
```

## 📝 Thông tin Sinh viên

Chỉnh sửa trong `lib/utils/constants.dart`:

```dart
static const String appTitle = 'TH3 - [TÊN BẠN] - [MÃ SV]';
```

## 🟢 Testing

### Test Loading State

App sẽ hiển thị shimmer khi tải dữ liệu từ Firestore.

### Test Error State

- Tắt WiFi/Mạng để trigger error
- Bấn nút "Thử lại" sẽ tải lại dữ liệu

### Test Success State

- Mở app với internet bình thường
- Sẽ hiển thị danh sách 6 places

## 🎨 UI Components

- **LoadingWidget**: Shimmer loading effect
- **ErrorWidget**: Error message + Retry button
- **PlaceCard**: Item card trong grid
- **AppBar**: Hiển thị app title + favorites button

## 📚 Tài liệu

- [SETUP.md](SETUP.md) - **Hướng dẫn setup chi tiết** ⭐ Đọc cái này đầu tiên
- [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) - Cấu trúc code & cách chỉnh sửa
- [QUICKSTART.md](QUICKSTART.md) - Chạy nhanh nhất

## 🐛 Troubleshooting

**App không tải dữ liệu?**

```bash
flutter clean
flutter pub get
flutter run
```

**Firebase error?**

```bash
flutterfire configure --project=travellist04
```

**Collection not found?**

- Tạo collection `places` trong Firestore Database
- Thêm ít nhất 1 document

## 📞 Hỗ trợ

Nếu gặp vấn đề:

1. Đọc [SETUP.md](SETUP.md) chi tiết
2. Kiểm tra Firestore Database & Security Rules
3. Xem logs: `flutter logs`
4. Chạy `flutter doctor` để kiểm tra environment

---

**Created**: 2026  
**Status**: ✅ Sẵn sàng chạy  
**Framework**: Flutter + Firebase
