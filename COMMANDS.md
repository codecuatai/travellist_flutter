# 💻 COMMANDS - Danh Sách Lệnh Cần Chạy

Hướng dẫn này liệt kê tất cả lệnh CLI bạn cần chạy để setup dự án.

---

## 🟢 PHASE 1: Setup Flutter Environment

### 1.1 Kiểm tra phiên bản (Optional)

```bash
flutter --version
```

**Expected Output:**

```
Flutter 3.10.7 (or higher)
```

### 1.2 Kiểm tra environment

```bash
flutter doctor
```

**Expected Output:**

```
✓ Flutter (Channel stable)
✓ Android toolchain
✓ Xcode (nếu Mac)
✓ Connected device
```

### 1.3 Upgrade Flutter (nếu cần)

```bash
flutter upgrade
```

---

## 🟠 PHASE 2: Install FlutterFire CLI

### 2.1 Cài đặt (1 lần toàn cục)

```bash
dart pub global activate flutterfire_cli
```

### 2.2 Xác nhận cài đặt

```bash
flutterfire --version
```

**Expected Output:**

```
FlutterFire CLI version X.X.X
```

---

## 🔴 PHASE 3: Configure Firebase for Project

### 3.1 Navigate to project

```bash
cd d:\BaiTapDH\6.DiDong\FlutterPractice01\travellist04
```

### 3.2 Configure Firebase (Dùng flutterfire)

```bash
flutterfire configure --project=travellist04
```

**Lựa chọn khi chạy:**

```
? Which platforms would you like to enable for this app?
  ◯ android
  ◉ ios
  ◯ macos
  ◯ windows
  ◯ linux
  ◯ web

Chọn: android (hoặc iOS nếu dùng Mac)
```

**Result:**

- `lib/firebase_options.dart` được tạo/cập nhật ✓
- Android được configured ✓

---

## 🟡 PHASE 4: Install Dependencies

### 4.1 Tải packages

```bash
flutter pub get
```

**Expected Output:**

```
Running "flutter pub get" in travellist04...
packages get completed successfully.
```

### 4.2 Kiểm tra errors (Optional)

```bash
flutter analyze
```

**Expected Output:**

```
No issues found!
```

---

## 🔵 PHASE 5: Run App

### 5.1 List devices

```bash
flutter devices
```

**Example Output:**

```
2 connected devices:

Android Emulator    • emulator-5554 • android • Android 13 (API 33)
Chrome              • chrome         • web     • Chrome 120.0.0.0
```

### 5.2 Run on Android Emulator/Device

```bash
flutter run
```

### 5.2 Hoặc chỉ định device cụ thể

```bash
flutter run -d emulator-5554
```

```bash
flutter run -d "Android Device"
```

### 5.3 Release mode (faster)

```bash
flutter run --release
```

---

## 🟣 PHASE 6: Cleanup (nếu gặp vấn đề)

### 6.1 Clean build

```bash
flutter clean
```

### 6.2 Tải lại dependencies

```bash
flutter pub get
```

### 6.3 Run lại

```bash
flutter run
```

---

## 🆘 TROUBLESHOOTING COMMANDS

### Problem: Build errors

```bash
# Full clean
flutter clean

# Get packages
flutter pub get

# Analyze
flutter analyze

# Run
flutter run
```

### Problem: Firebase not found

```bash
# Reconfigure Firebase
flutterfire configure --project=travellist04
```

### Problem: Package locked errors

```bash
# Upgrade packages
flutter pub upgrade
```

### Problem: Pod errors (iOS only)

```bash
cd ios
rm Podfile.lock
pod install
cd ..
flutter run
```

---

## 📊 QUICK COMMAND CHEAT SHEET

| Command                                        | Purpose                  |
| ---------------------------------------------- | ------------------------ |
| `flutter --version`                            | Check Flutter version    |
| `flutter doctor`                               | Check environment issues |
| `flutter devices`                              | List available devices   |
| `flutter pub get`                              | Install dependencies     |
| `flutter clean`                                | Clean build              |
| `flutter run`                                  | Run on device/emulator   |
| `flutter run --release`                        | Run optimized version    |
| `flutter logs`                                 | View app logs            |
| `flutter analyze`                              | Check code quality       |
| `dart pub global activate flutterfire_cli`     | Install FlutterFire      |
| `flutterfire configure --project=travellist04` | Configure Firebase       |

---

## 🚀 COMPLETE SETUP COMMAND SEQUENCE

Chạy các lệnh này theo thứ tự (copy-paste từng lệnh 1):

```bash
# 1. Check Flutter
flutter --version

# 2. Install FlutterFire
dart pub global activate flutterfire_cli

# 3. Verify FlutterFire installed
flutterfire --version

# 4. Navigate to project
cd d:\BaiTapDH\6.DiDong\FlutterPractice01\travellist04

# 5. Configure Firebase
flutterfire configure --project=travellist04
# (Select: android)

# 6. Get packages
flutter pub get

# 7. List devices
flutter devices

# 8. Run app
flutter run
```

**Total time**: ~3-5 minutes ⏱️

---

## 📱 DEVICE-SPECIFIC COMMANDS

### Android Emulator

```bash
# List Android emulators
emulator -list-avds

# Start emulator (if not running)
emulator -avd <emulator_name>

# Run on specific emulator
flutter run -d <emulator_id>
```

### Android Device (Real Phone)

```bash
# Enable USB debugging on phone

# Check connected device
adb devices

# Run on real device
flutter run -d <device_id>
```

### iOS Simulator (Mac only)

```bash
# List iOS simulators
xcrun simctl list

# Run on iOS
flutter run -d <simulator_id>
```

### Web

```bash
# Run on web/browser
flutter run -d chrome
```

---

## 🔍 DEBUG COMMANDS

### View logs

```bash
flutter logs
```

### Run with verbose output

```bash
flutter run -v
```

### Check specific file errors

```bash
flutter analyze lib/main.dart
```

---

## ✅ VERIFICATION COMMANDS

### Check if app runs

```bash
flutter run
```

### Verify Firebase integration

```bash
grep -r "firebase_core" lib/
grep -r "FirebaseService" lib/
```

### Check dependencies installed

```bash
flutter pub list
```

---

## 📝 Common Workflows

### Daily Development

```bash
# 1. Get latest code
git pull

# 2. Get dependencies
flutter pub get

# 3. Run app
flutter run
```

### After Firebase Config Change

```bash
# 1. Reconfigure
flutterfire configure --project=travellist04

# 2. Get dependencies
flutter pub get

# 3. Run
flutter run
```

### After Major Changes

```bash
# 1. Clean everything
flutter clean

# 2. Get dependencies
flutter pub get

# 3. Analyze
flutter analyze

# 4. Run
flutter run
```

### Prepare for Submission

```bash
# 1. Clean
flutter clean

# 2. Build apk (for Android)
flutter build apk --release

# 2. Build app (for iOS, Mac only)
flutter build ios --release
```

---

## 🎯 STEP-BY-STEP FOR FIRST RUN

Copy-paste các command này 1 cái 1:

```bash
dart pub global activate flutterfire_cli
```

```bash
cd d:\BaiTapDH\6.DiDong\FlutterPractice01\travellist04
```

```bash
flutterfire configure --project=travellist04
```

```bash
flutter pub get
```

```bash
flutter devices
```

```bash
flutter run
```

⏰ Thời gian: ~5 phút

---

## ⚠️ If Commands Don't Work

### On Windows

```bash
# Use double quotes for paths
flutter run -d "My Device"

# Or use full path
cd D:\BaiTapDH\6.DiDong\FlutterPractice01\travellist04
```

### If flutterfire not found

```bash
# Add to PATH or use full path
~/.pub-cache/bin/flutterfire configure --project=travellist04

# Or reinstall
dart pub global activate flutterfire_cli

# Restart terminal/command prompt
```

### On Mac/Linux

```bash
# Use single quotes for paths
flutter run -d 'My Device'

# Use export for env vars
export FLUTTER_ROOT="/path/to/flutter"
```

---

## 📞 HELP COMMANDS

### Get Flutter help

```bash
flutter help
```

### Get specific command help

```bash
flutter run --help
flutter pub --help
```

### Get FlutterFire help

```bash
flutterfire --help
```

---

## ✨ TIPS

1. **Add to PATH**: Thêm Flutter bin folder vào PATH để gọi lệnh từ bất kì chỗ nào
2. **Keep terminal open**: Đừng đóng terminal khi app chạy
3. **Hot reload**: Nhấn `r` trong terminal để hot reload app
4. **Hot restart**: Nhấn `R` trong terminal để hot restart
5. **Stop app**: Nhấn `q` trong terminal để dừng app

---

## 🎉 Ready!

Khi không có error nào, app sẽ chạy thành công ✅

**Next step**: Đọc SETUP.md để setup Firestore Database

---

**Happy coding!** 🚀
