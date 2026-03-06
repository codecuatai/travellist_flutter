# ✅ Setup Checklist - Theo Dõi Tiến Độ

Sử dụng checklist này để theo dõi các bước setup. Tiến hành từ trên xuống dưới.

---

## 📋 PHASE 1: Chuẩn Bị (5-10 phút)

- [ ] Kiểm tra Flutter version >= 3.10.7

  ```bash
  flutter --version
  ```

- [ ] Kiểm tra Dart version >= 3.10.7

  ```bash
  dart --version
  ```

- [ ] Cài đặt FlutterFire CLI

  ```bash
  dart pub global activate flutterfire_cli
  ```

- [ ] Xác nhận cài đặt

  ```bash
  flutterfire --version
  ```

- [ ] Tạo Firebase Account (nếu chưa có)
  - Truy cập: https://firebase.google.com
  - Đăng ký tài khoản Google miễn phí

---

## 🔥 PHASE 2: Firebase Setup (10-15 phút)

### 2.1 Tạo Firebase Project

- [ ] Vào https://console.firebase.google.com
- [ ] Nhấn "Add project"
- [ ] Nhập tên: `travellist04`
- [ ] Chọn region: Vietnam / Singapore
- [ ] Hoàn thành tạo project

### 2.2 Config Firebase cho Dự án

```bash
cd d:\BaiTapDH\6.DiDong\FlutterPractice01\travellist04

flutterfire configure --project=travellist04
```

**Lựa chọn khi chạy lệnh:**

- [ ] Platform: **Android** (bắt buộc)
- [ ] Xác nhận Android Package: `com.example.travellist04` ✓

**Kết quả:**

- [ ] File `lib/firebase_options.dart` được tạo/cập nhật
- [ ] Android được config

### 2.3 (Tùy chọn) Config cho iOS

```bash
flutterfire configure --project=travellist04 --platforms=ios
```

---

## 💾 PHASE 3: Firestore Database Setup (15-20 phút)

### 3.1 Tạo Firestore Database

- [ ] Vào Firebase Console
- [ ] Chọn project `travellist04`
- [ ] Vào **Firestore Database** (sidebar trái)
- [ ] Nhấn **Create database**
- [ ] **Region**: Chọn `asia-southeast1` (Singapore)
- [ ] **Mode**: Chọn **Start in test mode**
- [ ] Nhấn **Create**
- [ ] Chờ database khởi tạo xong (1-2 phút)

### 3.2 Tạo Collection `places`

- [ ] Database đã tạo xong
- [ ] Nhấn **+ Start collection**
- [ ] Collection ID: `places`
- [ ] Nhấn **Next**
- [ ] Tạo document đầu tiên:
  - Document ID: `auto`
  - Thêm field: `name` (string) = "Ha Long Bay"
  - Thêm field: `image` (string) = `https://images.unsplash.com/photo-1505228395891-9a51e7e86e81?w=500`
  - Thêm field: `description` (string) = "Kỳ quan thiên nhiên"
  - Thêm field: `location` (string) = "Quảng Ninh"
  - Thêm field: `category` (string) = "Biển đảo"
  - Thêm field: `rating` (number) = 4.8
  - Thêm field: `latitude` (number) = 20.8552
  - Thêm field: `longitude` (number) = 107.1909
- [ ] Nhấn **Save**

### 3.3 Thêm 5 Documents Khác

- [ ] Nhấn **Add document** (5 lần)
- [ ] Copy data từ SETUP.md, section "Sample Data" vào mỗi document

**Documents cần tạo:**

- [ ] Document 2: Hoi An Ancient Town
- [ ] Document 3: Sapa Mountains
- [ ] Document 4: Phu Quoc Island
- [ ] Document 5: Tam Coc
- [ ] Document 6: Mỹ Sơn

### 3.4 Cấu hình Firestore Security Rules

- [ ] Vào **Firestore Database** → Tab **Rules**
- [ ] Copy-paste nội dung từ SETUP.md, section "Firestore Security Rules"
- [ ] Nhấn **Publish**

---

## 📱 PHASE 4: Flutter Project Setup (10 phút)

### 4.1 Tải Dependencies

```bash
cd d:\BaiTapDH\6.DiDong\FlutterPractice01\travellist04

flutter pub get
```

- [ ] Hoàn thành tải packages (firebase_core, cloud_firestore, v.v)

### 4.2 Kiểm tra Version

```bash
flutter --version
```

- [ ] SDK version >= 3.10.7 ✓

### 4.3 Kiểm tra Errors

```bash
flutter analyze
```

- [ ] Không có lỗi syntax
- [ ] Không có lỗi type

---

## 🎯 PHASE 5: Chỉnh Sửa Thông Tin Sinh Viên (2 phút)

- [ ] Mở `lib/utils/constants.dart`
- [ ] Thay đổi dòng:
  ```dart
  static const String appTitle = 'TH3 - [TÊN BẠN] - [MÃ SV]';
  ```
  Ví dụ: `'TH3 - Nguyễn Văn A - 20221234'`

---

## 🚀 PHASE 6: Chạy Ứng Dụng (5 phút)

### 6.1 Chuẩn Bị Device

- [ ] Cắm Android phone hoặc mở Android Emulator
- [ ] Check device:
  ```bash
  flutter devices
  ```

### 6.2 Chạy App

```bash
flutter run
```

- [ ] App cài đặt thành công
- [ ] App khởi chạy
- [ ] Phần tiêu đề hiển thị đúng: `TH3 - [Tên] - [Mã SV]`

---

## 🧪 PHASE 7: Kiểm Tra Chức Năng (5 phút)

### 7.1 Loading State

- [ ] Mở app
- [ ] Nhìn thấy **Shimmer effect** (chữ và hình không cố định)
- [ ] Kéo xuống thấy loading text/placeholder

### 7.2 Success State

- [ ] Sau 2-3 giây, hiển thị **danh sách 6 places** dạng GridView
- [ ] Mỗi card có:
  - [ ] Ảnh place
  - [ ] Tên
  - [ ] Mô tả (cắt gọn)
  - [ ] Rating ⭐

### 7.3 Filter Feature

- [ ] Bấn category **"Biển đảo"** → Chỉ hiển thị 2 places (Ha Long, Phu Quoc)
- [ ] Bấn category **"Núi rừng"** → Chỉ hiển thị 2 places (Sapa, Tam Coc)
- [ ] Bấn category **"Di tích"** → Chỉ hiển thị 2 places (Hoi An, Mỹ Sơn)
- [ ] Bấn category **"Tất cả"** → Hiển thị lại 6 places

### 7.4 Search Feature

- [ ] Gõ "Ha" trong ô tìm kiếm → Hiển thị "Ha Long Bay"
- [ ] Xóa text → Hiển thị lại tất cả

### 7.5 Refresh Button

- [ ] Bấn nút **FAB (floating action button)** → Tải lại data
- [ ] Shimmer hiển thị lại
- [ ] Data được refresh

### 7.6 Error Handling

- [ ] Tắt WiFi/Network
- [ ] Bấn nút Refresh
- [ ] Hiển thị **Error UI**:
  - [ ] Icon ❌
  - [ ] Message: "Oops! Có lỗi xảy ra"
  - [ ] Error detail message
  - [ ] Nút **"Thử lại"**
- [ ] Bấn nút "Thử lại"
- [ ] Bật WiFi lại
- [ ] Data tải thành công

### 7.7 Favorites (Tuỳ chọn)

- [ ] Bấn icon ❤️ trên card → Thêm vào favorites
- [ ] Bấn icon ❤️ ở top-right AppBar
- [ ] Vào **Favorites Screen**
- [ ] Xem danh sách favorites

### 7.8 Detail Screen (Tuỳ chọn)

- [ ] Bấn vào 1 card
- [ ] Vào **Detail Screen**
- [ ] Xem chi tiết place (tên, ảnh, mô tả dài, rating, vị trí)

---

## 🆘 PHASE 8: Troubleshooting (Nếu Có Lỗi)

### Lỗi: App không tải dữ liệu

```bash
flutter clean
flutter pub get
flutter run
```

- [ ] Thử lại

### Lỗi: "firebase_options.dart not found"

```bash
flutterfire configure --project=travellist04
```

- [ ] File được tạo lại

### Lỗi: "Collection places not found"

- [ ] Kiểm tra Firestore Database
- [ ] Đảm bảo collection `places` tồn tại
- [ ] Đảm bảo có documents trong collection

### Lỗi: "Permission denied"

- [ ] Kiểm tra Firestore Security Rules
- [ ] Đảm bảo cho phép `read`

### Lỗi: "Dependency not found"

```bash
flutter pub get
flutter pub upgrade
```

- [ ] Cài lại dependencies

---

## 🎉 PHASE 9: Finalization

### 9.1 Kiểm tra Code Quality

- [ ] Không có lỗi compile
- [ ] Không có warning lớn
- [ ] Code tách file rõ ràng
- [ ] Try-catch xử lý lỗi

### 9.2 Kiểm tra Documentation

- [ ] [ ] Đọc qua SETUP.md
- [ ] [ ] Hiểu PROJECT_STRUCTURE.md
- [ ] [ ] Biết cách chỉnh sửa theo CHANGES.md

### 9.3 Đọc Lại Yêu Cầu Bài Tập

- [ ] ✅ Gọi dữ liệu từ Firebase (không phải mock API)
- [ ] ✅ Xử lý 3 trạng thái: Loading, Error, Success
- [ ] ✅ Hiển thị Loading UI (shimmer)
- [ ] ✅ Hiển thị Error UI (message + Retry)
- [ ] ✅ Hiển thị Success UI (GridView)
- [ ] ✅ Có nút Retry khi lỗi
- [ ] ✅ Code tách file (firebase_service, widgets, screens)
- [ ] ✅ Try-catch xử lý lỗi
- [ ] ✅ Tên ứng dụng: `TH3 - [Tên] - [Mã SV]`
- [ ] ✅ Hỗ trợ filter, search, favorites

---

## 📊 Summary

**Total Time**: ~60 phút

- PHASE 1: 5-10 phút
- PHASE 2: 10-15 phút
- PHASE 3: 15-20 phút
- PHASE 4: 10 phút
- PHASE 5: 2 phút
- PHASE 6: 5 phút
- PHASE 7: 5-10 phút
- PHASE 8: Nếu có lỗi

---

## 📞 Nếu Gặp Vấn Đề

1. Đọc **SETUP.md** (hướng dẫn chi tiết)
2. Xem **PROJECT_STRUCTURE.md** (cấu trúc code)
3. Xem **CHANGES.md** (danh sách thay đổi)
4. Chạy `flutter doctor` để kiểm tra environment

---

✅ **Xong! Bạn đã sẵn sàng submit bài tập** 🚀
