# ⚡ Quick Start - Chạy nhanh dự án

Nếu bạn muốn chạy dự án ngay mà không muốn đọc documentation dài, hãy làm theo các bước này:

## 📝 Tóm Tắt 3 Bước Chính

### **Bước 1: Cài đặt FlutterFire CLI** (5 phút)

```bash
dart pub global activate flutterfire_cli
```

### **Bước 2: Config Firebase** (5 phút)

```bash
cd d:\BaiTapDH\6.DiDong\FlutterPractice01\travellist04

flutterfire configure --project=travellist04
```

**Lựa chọn:**

- Project: Chọn `travellist04` (hoặc tạo Firebase Project mới tại firebase.google.com)
- Platforms: Chọn `Android` (hoặc `iOS` nếu dùng Mac)

### **Bước 3: Cài packages & Chạy app** (2 phút)

```bash
flutter pub get
flutter run
```

---

## ✨ Nếu muốn dữ liệu hiển thị ngay, làm điều này:

### **Tạo Firestore Database:**

1. Mở https://console.firebase.google.com/
2. Chọn project `travellist04`
3. Vào **Firestore Database** → **Create database**
4. Chọn region gần nhất (Singapore)
5. Chọn **Start in test mode**
6. Chọn **Create**

### **Thêm dữ liệu (Copy-Paste data dưới đây vào Firestore):**

Tạo collection tên `places` và thêm 6 documents với data:

```json
[
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
  {
    "name": "Hoi An Ancient Town",
    "image": "https://images.unsplash.com/photo-1580541831066-7a46e9e751d4?w=500",
    "description": "Thị trấn cổ đẹp nhất Đông Nam Á",
    "location": "Quảng Nam",
    "category": "Di tích",
    "rating": 4.6,
    "latitude": 15.8794,
    "longitude": 108.3261
  },
  {
    "name": "Sapa Mountains",
    "image": "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=500",
    "description": "Dãy núi hùng vĩ với ruộng bậc thang",
    "location": "Lào Cai",
    "category": "Núi rừng",
    "rating": 4.7,
    "latitude": 22.3402,
    "longitude": 103.8343
  },
  {
    "name": "Phu Quoc Island",
    "image": "https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=500",
    "description": "Đảo lớn nhất Việt Nam",
    "location": "Kiên Giang",
    "category": "Biển đảo",
    "rating": 4.5,
    "latitude": 10.1884,
    "longitude": 103.9754
  },
  {
    "name": "Tam Coc",
    "image": "https://images.unsplash.com/photo-1511632765486-a01980e01a18?w=500",
    "description": "Thắng cảnh thiên nhiên giữa núi rừng",
    "location": "Ninh Bình",
    "category": "Núi rừng",
    "rating": 4.4,
    "latitude": 20.2252,
    "longitude": 105.8842
  },
  {
    "name": "Mỹ Sơn",
    "image": "https://images.unsplash.com/photo-1579649142266-8bacf96f5e17?w=500",
    "description": "Quần thể di tích Chăm Pa",
    "location": "Quảng Nam",
    "category": "Di tích",
    "rating": 4.3,
    "latitude": 15.7459,
    "longitude": 108.0043
  }
]
```

---

## 🧪 Kiểm tra App Chạy

Khi mở app, bạn sẽ thấy:

1. **Loading**: Shimmer effect (chữ và hình không cố định)
2. **Dữ liệu**: Grid của 6 places
3. **Filter**: Bấm vào category để lọc (Biển đảo, Núi rừng, Di tích)
4. **Search**: Tìm tên place
5. **Nút Refresh (FAB)**: Bấm để tải lại
6. **Error (nếu mất internet)**: Hiển thị lỗi + nút "Thử lại"

---

## 🆚 So Sánh: Before vs After

**BEFORE (cũ - HTTP API):**

- Gọi HTTP API từ mocki.io
- Dữ liệu fake, không thay đổi

**AFTER (mới - Firebase):**

- ✅ Dữ liệu thực từ Firestore Database
- ✅ Loading UI: Shimmer effect
- ✅ Error UI: Error message + Retry button
- ✅ Success UI: GridView hiển thị
- ✅ Try-catch xử lý lỗi an toàn
- ✅ Code tách file rõ ràng

---

## 🔧 Nếu gặp vấn đề:

### Problem: App không tải dữ liệu

**Solution:**

```bash
flutter clean
flutter pub get
flutter run
```

### Problem: Firebase error

**Solution:** Kiểm tra firebase_options.dart có đúng không

```bash
flutterfire configure --project=travellist04
```

### Problem: "Collection places not found"

**Solution:** Phải tạo collection `places` trong Firestore Database trước

---

## 📚 Nội dung tài liệu

- **SETUP.md** - Setup chi tiết từng bước (nên đọc)
- **PROJECT_STRUCTURE.md** - Cấu trúc code & cách chỉnh sửa
- **QUICKSTART.md** - File này, chạy nhanh nhất

Chúc bạn thành công! 🎉
