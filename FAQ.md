# ❓ FAQ - Câu Hỏi Thường Gặp

---

## 📚 Tài Liệu

### Q1: Tôi nên bắt đầu từ file nào?

**A:** Có 3 lựa chọn:

1. **❤️Nếu vội** (10 phút): START_HERE.md → QUICKSTART.md
2. **💯 Nếu muốn đầy đủ** (1 tiếng): SETUP.md → CHECKLIST.md
3. **🎓 Nếu muốn hiểu code** (2 tiếng): CHANGES.md → PROJECT_STRUCTURE.md

### Q2: Sự khác biệt giữa các doc là gì?

**A:**

- **START_HERE.md**: Tóm tắt, 5 phút
- **QUICKSTART.md**: Nhanh, 10 phút, copy-paste data
- **SETUP.md**: Chi tiết toàn bộ, 30 phút ⭐ **Nên đọc**
- **PROJECT_STRUCTURE.md**: Giải thích code
- **CHECKLIST.md**: Theo dõi tiến độ, checkbox mỗi bước
- **CHANGES.md**: Thay đổi gì
- **COMMANDS.md**: CLI commands
- **SUMMARY.md**: Tóm tắt file structure

### Q3: Đọc file nào để hiểu thay đổi?

**A:** CHANGES.md (trước và sau so sánh, rất rõ ràng)

---

## 🔥 Firebase

### Q4: Tôi cần account Firebase không?

**A:** Có, bắt buộc. Tạo tại https://firebase.google.com (miễn phí)

### Q5: Firebase có miễn phí không?

**A:** Có! Spark Plan (miễn phí) đủ cho bài tập này

### Q6: Tôi cần tạo gì trong Firebase?

**A:**

1. Project: `travellist04`
2. Firestore Database
3. Collection: `places`
4. 6 documents với sample data

### Q7: Firestore là gì?

**A:** Firestore = Database của Firebase (cloud database real-time)

### Q8: Làm sao tôi biết Firebase config đúng không?

**A:** Chạy app, nếu:

- Thấy loading + placeholder → OK
- Thấy data hiển thị → OK
- Thấy error → Kiểm tra firebase_options.dart

---

## 🚀 Setup & Installation

### Q9: Tôi cần cài gì?

**A:**

1. FlutterFire CLI: `dart pub global activate flutterfire_cli`
2. Firestore Database (qua Firebase Console)

### Q10: Lệnh nào chạy đầu tiên?

**A:**

```bash
dart pub global activate flutterfire_cli
flutterfire configure --project=travellist04
flutter pub get
flutter run
```

### Q11: flutterfire configure làm gì?

**A:** Tạo `lib/firebase_options.dart` (config Firebase cho app)

### Q12: firebase_options.dart là gì?

**A:** File config Firebase (API keys,project ID, etc.)

### Q13: Tôi có cần chỉnh firebase_options.dart không?

**A:** **Không**. File tự động generate bởi `flutterfire configure`

### Q14: Tôi có cần thêm API keys manually không?

**A:** **Không**. flutterfire configure làm tất cả

---

## 💻 Flutter

### Q15: Phiên bản Flutter tối thiểu là bao nhiêu?

**A:** 3.10.7 trở lên

### Q16: Tôi cần cài gì để chạy Flutter?

**A:**

- Flutter SDK
- Android Studio / Xcode
- Emulator hoặc physical device

### Q17: Làm sao check Flutter version?

**A:**

```bash
flutter --version
flutter doctor
```

### Q18: Tôi cần chạy trên Android hay iOS?

**A:** Android là đủ. iOS là optional

### Q19: Tôi có cần emulator không?

**A:** Hoặc emulator hoặc physical device. Emulator dễ hơn

---

## 📱 Chạy App

### Q20: Làm sao chạy app?

**A:**

```bash
flutter run
```

### Q21: Ứng dụng chạy nhưng không hiển thị dữ liệu?

**A:**

1. Kiểm tra: Firestore collection `places` có tồn tại không?
2. Kiểm tra: Collection có documents không?
3. Kiểm tra: Internet connection?
4. Xem logs: `flutter logs`

### Q22: Loading mãi mãi không xong?

**A:**

1. Kiểm tra internet
2. Xem logs: `flutter logs`
3. Kiểm tra Firestore Security Rules (allow read?)

### Q23: Thấy error UI (lỗi)?

**A:** Bấn nút "Thử lại" (Retry). Nếu còn lỗi:

1. Kiểm tra Firestore Security Rules
2. Kiểm tra collection tồn tại không
3. Xem logs: `flutter logs`

### Q24: App crash?

**A:**

1. Xem logs chi tiết: `flutter run -v`
2. Kiểm tra import statements
3. Kiểm tra code syntax

---

## 🔐 Firestore Security

### Q25: Tôi cần set Security Rules không?

**A:** Có, copy-paste từ SETUP.md section "Firestore Security Rules"

### Q26: Security Rules là gì?

**A:** Rules để kiểm soát ai có quyền read/write database

### Q27: Tôi nên dùng test mode hay production?

**A:** Test mode cho bài tập. Production cho app thực tế

### Q28: Test mode rules là gì?

**A:**

```
allow read, write: if request.time < timestamp.date(2026, 12, 31);
```

---

## 📝 Code

### Q29: File nào mới?

**A:**

- `lib/services/firebase_service.dart` ✨ NEW
- `lib/widgets/error_widget.dart` ✨ NEW
- `lib/widgets/loading_widget.dart` ✨ NEW
- `lib/firebase_options.dart` ✨ NEW

### Q30: File nào thay đổi?

**A:**

- `lib/main.dart` ✏️ UPDATED
- `lib/screens/home_screen.dart` ✏️ UPDATED
- `pubspec.yaml` ✏️ UPDATED
- `README.md` ✏️ UPDATED

### Q31: Tôi cần hiểu tất cả code không?

**A:** Không bắt buộc lúc lúc, nhưng nên đọc một lần (xem PROJECT_STRUCTURE.md)

### Q32: FirebaseService là gì?

**A:** Service class gọi Firestore (singleton pattern, try-catch error handling)

### Q33: ErrorWidget là gì?

**A:** Widget hiển thị error message + nút "Thử lại"

### Q34: LoadingWidget là gì?

**A:** Widget hiển thị shimmer loading effect (giả lập skeleton screen)

### Q35: Làm sao thêm code mới?

**A:** Thêm vào methods của FirebaseService, hoặc tạo new files

---

## 🎨 UI & UX

### Q36: Tôi muốn thay đổi design?

**A:** Edit `lib/screens/home_screen.dart` hoặc `lib/widgets/`

### Q37: Làm sao thay đổi màu?

**A:** Edit `Colors.blue[700]` → `Colors.red[700]` (hoặc màu khác)

### Q38: Làm sao thay đổi layout (GridView → ListView)?

**A:** Edit `home_screen.dart`, method `_buildSuccessUI()`, thay `GridView` → `ListView`

### Q39: Loading bar mãi mãi là normal không?

**A:** Không. Nếu > 5 giây có vấn đề. Kiểm tra internet & Firestore

### Q40: Shimmer effect là gì?

**A:** Animation effect khi tải dữ liệu (chữ và hình không cố định)

---

## ❤️ Favorites & Features

### Q41: Favorites hoạt động không?

**A:** Shuffle, bấn ❤️ icon trên card hoặc detail screen

### Q42: Favorites lưu ở đâu?

**A:** SharedPreferences (local storage trên phone)

### Q43: Làm sao xóa favorites?

**A:** Bấn ❤️ icon lần nữa (toggle off)

### Q44: Map hoạt động không?

**A:** Có, bấn vào card → detail screen → xem map

---

## 🔄 Updates & Changes

### Q45: Tôi có cần chỉnh gì sau khi clone?

**A:**

1. `flutterfire configure --project=travellist04`
2. Tạo Firestore Database
3. Thêm sample data
4. Chỉnh tên sinh viên (constants.dart)

### Q46: Làm sao update dependencies?

**A:**

```bash
flutter pub get
```

Hoặc nếu cần version mới:

```bash
flutter pub upgrade
```

### Q47: Có breaking changes không?

**A:** Không. Code phía dưới vẫn hoạt động (favorites, map, detail screen)

### Q48: Tôi có cần xóa api_service.dart không?

**A:** Không bắt buộc, nhưng có thể xóa sau khi confirm tất cả OK

---

## 🆘 Troubleshooting

### Q49: Android SDK not found?

**A:**

```bash
flutter doctor
# Follow instructions to install Android SDK
```

### Q50: "Could not resolve dependencies"?

**A:**

```bash
flutter clean
flutter pub get
```

### Q51: Build cache corrupted?

**A:**

```bash
flutter clean
cd ios && rm -rf Pods Podfile.lock
cd ..
flutter pub get
flutter run
```

### Q52: Emulator not responding?

**A:** Restart emulator hoặc kill process

### Q53: Hot reload không hoạt động?

**A:** Nhấn `R` thay vì `r` (hot restart)

### Q54: Device not found?

**A:**

```bash
flutter devices
adb devices
```

### Q55: Permission denied trên device?

**A:** Enable USB debugging trên phone, reconnect

---

## 📊 Testing

### Q56: Làm sao test loading state?

**A:** App tải dữ liệu từ Firestore, thấy shimmer là OK

### Q57: Làm sao test error state?

**A:** Tắt WiFi, bấn refresh, thấy error UI là OK

### Q58: Làm sao test retry?

**A:** Gặp error, bấn "Thử lại", bật WiFi, thấy data là OK

### Q59: Làm sao test search?

**A:** Gõ tên trong search box, xem kết quả

### Q60: Làm sao test filter?

**A:** Bấn category, xem dữ liệu lọc đúng

---

## 📱 Android vs iOS

### Q61: Có khác gì iOS và Android code?

**A:** Không, code chính là chung. Firebase SDK điều chỉnh

### Q62: Tôi có cần setup iOS không?

**A:** Không bắt buộc. Android là đủ. iOS là optional

### Q63: iOS hoạt động không?

**A:** Nếu dùng Mac, chạy: `flutterfire configure --project=travellist04 --platforms=ios`

---

## 💰 Cost & Pricing

### Q64: Dùng Firebase có tốn tiền không?

**A:** Không! Spark Plan (free) đủ cho bài tập

### Q65: Dữ liệu có được lưu miễn phí không?

**A:** Có, tới 1GB (Spark Plan)

### Q66: Nếu vượt quá?

**A:** Firebase sẽ thông báo. Upgrade plan hoặc xóa dữ liệu

---

## 🎓 Learning

### Q67: Tôi học được gì từ dự án này?

**A:**

- Firebase integration
- Async/await programming
- FutureBuilder patterns
- Error handling (try-catch)
- Widget composition
- State management
- Provider pattern

### Q68: Tôi nên học thêm gì?

**A:**

- Firebase security rules
- Real-time sync (cloud functions)
- Authentication
- Cloud storage

### Q69: Tài liệu tham khảo nào?

**A:**

- Flutter docs: https://flutter.dev
- Firebase docs: https://firebase.google.com/docs
- Dart docs: https://dart.dev

---

## ✅ Submission

### Q70: Tôi có cần submit code hay apk?

**A:** Thường là submit source code (.dart files), hoặc apk nếu yêu cầu

### Q71: Tôi có cần remove firebase_options.dart trước khi submit?

**A:** Kiểm tra hướng dẫn bài tập. Nếu không nói thì giữ lại

### Q72: Tôi có cần include documentation?

**A:** Có! Documentation + code source

### Q73: Checklist trước submit gì?

**A:**

- [ ] App chạy không lỗi
- [ ] Loading UI hoạt động
- [ ] Error UI hoạt động
- [ ] Success UI hiển thị đúng
- [ ] Filter, search OK
- [ ] Tên sinh viên đúng
- [ ] Không có purple warning/error

---

## 🎉 Success Criteria

### Q74: Làm sao biết code đúng?

**A:** Khi:

- App chạy không crash
- Dữ liệu từ Firestore hiển thị
- 3 states (load/error/success) hoạt động
- Nút retry bấn được
- Tên sinh viên hiển thị đúng

### Q75: Debug output nên như thế nào?

**A:**

```
I/flutter: Loading... (loading state)
I/flutter: Data loaded successfully (success state)
I/flutter: Error: [error message] (error state)
```

---

## 📞 More Help?

Nếu không tìm thấy câu trả lời:

1. Xem **SETUP.md** → Troubleshooting
2. Xem **PROJECT_STRUCTURE.md** → Chi tiết code
3. Xem logs: `flutter logs`
4. Chạy: `flutter doctor`

---

**Happy coding! 🚀**

Nếu còn câu hỏi khác, kiểm tra documentation files hoặc `flutter help`
