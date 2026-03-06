# 🚀 Hướng dẫn Setup và Chạy Dự án Travel List với Firebase

## 📋 Yêu cầu trước khi bắt đầu

- Flutter SDK >= 3.10.7
- Dart SDK >= 3.10.7
- Android Studio / Xcode (tùy nền tảng target)
- Firebase Account (tạo account miễn phí tại https://firebase.google.com)
- Git (tuỳ chọn)

---

## 🔧 Các Bước Setup

### **Bước 1: Chuẩn bị Flutter Environment**

```bash
# Kiểm tra phiên bản Flutter
flutter --version

# Cập nhật Flutter (nếu cần)
flutter upgrade

# Kiểm tra setup
flutter doctor
```

### **Bước 2: Cài đặt FlutterFire CLI**

FlutterFire CLI giúp bạn config Firebase tự động. Cài đặt nó:

```bash
# Cài flutterfire_cli toàn cục
dart pub global activate flutterfire_cli

# Xác nhận cài đặt
flutterfire --version
```

### **Bước 3: Tạo Project Firebase**

1. Truy cập [Firebase Console](https://console.firebase.google.com/)
2. Nhấn **"Add project"** hoặc **"Create a new project"**
3. Nhập tên project: `travellist04` (hoặc tên tuỳ ý)
4. Chọn region gần nhất (ví dụ: Southeast Asia - Singapore)
5. Hoàn thành việc tạo project

### **Bước 4: Cấu hình Firebase cho các nền tảng (Android & iOS)**

#### **4.1 Cấu hình cho Android**

```bash
cd d:\BaiTapDH\6.DiDong\FlutterPractice01\travellist04

# Chạy flutterfire configure
flutterfire configure --project=travellist04 --out=lib/firebase_options.dart
```

Lúc này, FlutterFire CLI sẽ hỏi:

- **Chọn platforms**: Chọn `Android` bằng cách nhấn space và Enter
- **Chọn Android package name**: Mặc định là `com.example.travellist04` hoặc tuỳ chỉnh

Sau khi hoàn thành, file `lib/firebase_options.dart` sẽ được cập nhật tự động.

#### **4.2 Cấu hình cho iOS (nếu cần)**

Nếu muốn dev trên iOS:

```bash
flutterfire configure --project=travellist04 --platforms=ios
```

#### **4.3 Cấu hình cho Web (tuỳ chọn)**

```bash
flutterfire configure --project=travellist04 --platforms=web
```

### **Bước 5: Cài đặt Dependencies**

```bash
cd d:\BaiTapDH\6.DiDong\FlutterPractice01\travellist04

# Tải packages mới được thêm (firebase, cloud_firestore)
flutter pub get
```

### **Bước 6: Tạo Firestore Database**

1. Vào [Firebase Console](https://console.firebase.google.com/)
2. Chọn project `travellist04` của bạn
3. Trong sidebar trái, chọn **"Firestore Database"**
4. Nhấn **"Create database"**
5. Chọn region (ví dụ: `asia-southeast1` - Singapore)
6. Chọn **"Start in test mode"** (để test, sau này đổi sang production mode)
7. Nhấn **"Create"** và chờ Firestore khởi tạo xong

### **Bước 7: Thêm Dữ liệu vào Firestore**

Bạn cần tạo một collection tên `places` với các document:

#### **Cách 1: Thêm qua Firebase Console UI (Dễ nhất)**

1. Mở Firestore Database
2. Nhấn **"+ Start collection"**
3. Nhập tên collection: `places`
4. Nhấn **"Next"**
5. Tự động tạo document đầu tiên:
   - Document ID: `auto` (để Firebase tự sinh)
   - Sau đó nhập các field sau:

```json
{
  "name": "Ha Long Bay",
  "image": "https://images.unsplash.com/photo-1505228395891-9a51e7e86e81?w=500",
  "description": "Kỳ quan thiên nhiên thế giới với những vách đá vôi kỳ lạ",
  "location": "Quảng Ninh, Việt Nam",
  "category": "Biển đảo",
  "rating": 4.8,
  "latitude": 20.8552,
  "longitude": 107.1909
}
```

Sau khi lưu document đầu tiên, tiếp tục thêm các document khác. Dưới đây là danh sách sample data:

#### **Sample Data để Copy-Paste:**

**Document 2:**

```json
{
  "name": "Hoi An Ancient Town",
  "image": "https://images.unsplash.com/photo-1580541831066-7a46e9e751d4?w=500",
  "description": "Thị trấn cổ đẹp nhất Đông Nam Á với kiến trúc truyền thống",
  "location": "Quảng Nam, Việt Nam",
  "category": "Di tích",
  "rating": 4.6,
  "latitude": 15.8794,
  "longitude": 108.3261
}
```

**Document 3:**

```json
{
  "name": "Sapa Mountains",
  "image": "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=500",
  "description": "Dãy núi hùng vĩ với ruộng bậc thang và dân tộc đặc biệt",
  "location": "Lào Cai, Việt Nam",
  "category": "Núi rừng",
  "rating": 4.7,
  "latitude": 22.3402,
  "longitude": 103.8343
}
```

**Document 4:**

```json
{
  "name": "Phu Quoc Island",
  "image": "https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=500",
  "description": "Đảo lớn nhất của Việt Nam với bãi biển đẹp và resort cao cấp",
  "location": "Kiên Giang, Việt Nam",
  "category": "Biển đảo",
  "rating": 4.5,
  "latitude": 10.1884,
  "longitude": 103.9754
}
```

**Document 5:**

```json
{
  "name": "Tam Coc",
  "image": "https://images.unsplash.com/photo-1511632765486-a01980e01a18?w=500",
  "description": "Thắng cảnh thiên nhiên tuyệt vời giữa núi rừng quyến rũ",
  "location": "Ninh Bình, Việt Nam",
  "category": "Núi rừng",
  "rating": 4.4,
  "latitude": 20.2252,
  "longitude": 105.8842
}
```

**Document 6:**

```json
{
  "name": "Mỹ Sơn",
  "image": "https://images.unsplash.com/photo-1579649142266-8bacf96f5e17?w=500",
  "description": "Quần thể di tích Chăm Pa linh thiêng nằm lưng chừng núi",
  "location": "Quảng Nam, Việt Nam",
  "category": "Di tích",
  "rating": 4.3,
  "latitude": 15.7459,
  "longitude": 108.0043
}
```

#### **Cách 2: Thêm từ JSON (Nếu muốn nhanh hơn)**

Bạn có thể tạo file `seed_data.dart` trong dự án và chạy script để thêm data. Xem phần "Bonus: Script thêm data tự động" dưới đây.

### **Bước 8: Cấu hình Firestore Security Rules (Quan trọng!)**

1. Vào **Firestore Database** → Tab **"Rules"**
2. Thay thế nội dung bằng:

```
rules_version = '3';
service cloud.firestore {
  match /databases/{database}/documents {
    // Cho phép read dữ liệu places cho tất cả users
    // Chỉ cho admin write (update/delete)
    match /places/{document=**} {
      allow read;
      allow write: if request.auth != null;
    }
  }
}
```

3. Nhấn **"Publish"** để lưu rules

### **Bước 9: Chuẩn bị Project Flutter**

Đảm bảo các thư mục sau tồn tại:

```
lib/
  ├── main.dart (đã update)
  ├── firebase_options.dart (tự động tạo từ flutterfire configure)
  ├── models/
  │   └── place.dart
  ├── screens/
  │   ├── detail_screen.dart
  │   ├── favorites_screen.dart
  │   ├── home_screen.dart (đã update)
  │   └── map_screen.dart
  ├── services/
  │   ├── api_service.dart (old, không dùng nữa)
  │   ├── firebase_service.dart (NEW)
  │   └── favorites_provider.dart
  ├── utils/
  │   └── constants.dart
  └── widgets/
      ├── place_card.dart
      ├── error_widget.dart (NEW)
      ├── loading_widget.dart (NEW)
      └── ...
```

### **Bước 10: Chạy Ứng dụng**

#### **Trên Android Emulator:**

```bash
# Liệt kê các devices có sẵn
flutter devices

# Chạy app
flutter run

# Hoặc chạy với release mode
flutter run --release
```

#### **Trên Android Device (Real Phone):**

1. Kết nối device qua USB
2. Bật USB Debugging trên phone
3. Chạy:

```bash
flutter run
```

#### **Trên iOS (Mac only):**

```bash
flutter run -d "iPhone 15"
```

---

## ✅ Kiểm tra ứng dụng chạy đúng

Khi ứng dụng khởi chạy:

1. **Màn hình Loading**: Hiển thị shimmer effect khi tải data từ Firebase
2. **Dữ liệu hiển thị**: Sau khi tải xong, hiển thị danh sách địa điểm dạng grid
3. **Filter theo category**: Nhấp vào các category để lọc dữ liệu
4. **Search**: Tìm kiếm địa điểm theo tên
5. **Nút Refresh**: Nhấn FAB để tải lại dữ liệu
6. **Error Handling**: Nếu mất connection hoặc lỗi, hiển thị error UI với nút "Thử lại"

---

## 🐛 Troubleshooting

### **Lỗi: "Could not resolve firebase_core"**

```bash
flutter pub get
flutter clean
flutter pub get
```

### **Lỗi: "firebase_options.dart not found"**

Chạy lại flutterfire configure:

```bash
flutterfire configure --project=travellist04
```

### **Lỗi: "Firestore permission denied"**

Kiểm tra Firebase Firestore Rules. Nếu đang test, dùng test mode rules:

```
allow read, write: if request.time < timestamp.date(2026, 12, 31);
```

### **Lỗi: "App not connecting to Firestore"**

- Kiểm tra internet connection
- Đảm bảo Database URL đúng trong `firebase_options.dart`
- Kiểm tra Firestore Rules cho phép read access

### **App chạy nhưng không hiển thị dữ liệu**

- Đảm bảo collection `places` tồn tại trong Firestore
- Kiểm tra xem có documents trong collection không
- Xem logs: `flutter logs`

---

## 📊 Bonus: Script thêm data tự động (tuỳ chọn)

Nếu muốn thêm data Firestore bằng code, tạo file `lib/scripts/seed_data.dart`:

```dart
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> seedFirestoreData() async {
  final firestore = FirebaseFirestore.instance;

  final List<Map<String, dynamic>> placesData = [
    {
      "name": "Ha Long Bay",
      "image": "https://images.unsplash.com/photo-1505228395891-9a51e7e86e81?w=500",
      "description": "Kỳ quan thiên nhiên thế giới",
      "location": "Quảng Ninh",
      "category": "Biển đảo",
      "rating": 4.8,
      "latitude": 20.8552,
      "longitude": 107.1909
    },
    // thêm các item khác
  ];

  for (var place in placesData) {
    await firestore.collection('places').add(place);
  }
}
```

Sau đó gọi hàm này trong `main()` (một lần):

```dart
// Gọi 1 lần thôi
await seedFirestoreData();
```

---

## 📝 Thông tin ứng dụng

- **App Name**: Travel Explorer
- **Title Format**: TH3 - [Họ tên SV] - [Mã SV]
- **Chức năng chính**:
  - ✅ Loading state: Shimmer effect
  - ✅ Error state: Error UI + Retry button
  - ✅ Success state: GridView hiển thị places
  - ✅ Category filter
  - ✅ Search functionality
  - ✅ Favorites support
  - ✅ Detail screen
  - ✅ Map view

---

## 📚 Tài liệu tham khảo

- [Firebase Flutter Setup](https://firebase.flutter.dev/docs/overview/)
- [Firestore Documentation](https://firebase.google.com/docs/firestore)
- Flutter Docs: https://flutter.dev/docs

---

## 🎉 Hoàn tất!

Nếu mọi bước đều thành công, ứng dụng sẽ:

1. Tải dữ liệu từ Firebase Firestore
2. Hiển thị loading UI trong quá trình tải
3. Hiển thị dữ liệu khi thành công
4. Hiển thị error UI với nút Retry khi có lỗi
5. Cho phép filter, search, và quản lý favorites

**Chúc bạn thành công! 🚀**
