# 📚 Fluent — Learn Smarter, Grow Faster

A beautiful Flutter mobile app for browsing and learning from online courses. Built for the Fluentian Internship Programme Task 4.

## ✨ Features

### Screens
- **Splash Screen** — Animated logo intro with smooth transition
- **Dashboard/Home** — Personalized welcome, stats overview, featured courses, in-progress courses, and recommendations
- **Courses Listing** — Full course browser with search, category filters, level filters, and sorting
- **Course Detail** — Rich detail view with full description, stats, tags, progress tracking, and enroll action

### Bonus Features ✅
- 🔍 Real-time search across title, description, instructor, and category
- 🏷️ Category filtering with animated chips
- 📊 Sort by: Popular, Highest Rated, Price (Low/High)
- 🎯 Filter by level: Beginner, Intermediate, Advanced
- ✨ Smooth page transitions and entrance animations
- 💫 Touch feedback on all interactive elements
- 📈 Progress indicators for in-progress courses
- 🔖 Save/bookmark courses
- 🎨 Dynamic color theming per category

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Android Studio / VS Code with Flutter extension

### Installation

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/fluent_app.git
cd fluent_app

# Install dependencies
flutter pub get

# Run on a connected device or emulator
flutter run
```

### Build APK

```bash
flutter build apk --release
```
The APK will be at `build/app/outputs/flutter-apk/app-release.apk`

---

## 📦 Packages Used

| Package | Version | Purpose |
|--------|---------|---------|
| `google_fonts` | ^6.2.1 | Poppins font family |
| `cached_network_image` | ^3.3.1 | Efficient image loading & caching |
| `flutter_rating_bar` | ^4.0.1 | Star rating display |
| `shimmer` | ^3.0.0 | Loading skeleton effects |
| `percent_indicator` | ^4.2.3 | Progress indicators |

---

## 🗂️ Project Structure

```
lib/
├── main.dart                  # App entry + Splash screen
├── theme/
│   └── app_theme.dart         # Colors, typography, theme config
├── models/
│   └── course.dart            # Course data model
├── data/
│   └── mock_data.dart         # 10 mock courses + stats
├── screens/
│   ├── dashboard_screen.dart  # Home/Dashboard screen
│   ├── courses_screen.dart    # Course listing screen
│   └── course_detail_screen.dart # Course detail screen
└── widgets/
    └── course_widgets.dart    # Reusable card components
```

---

## 🎨 Design Highlights

- **Color System**: Category-aware dynamic colors (each course category has its own accent color)
- **Typography**: Poppins font family with a clear hierarchy
- **Cards**: Layered shadow system with image thumbnails, badges, and progress bars
- **Animations**: Entrance fade/slide animations on all screens + animated bottom bar transitions
- **Bottom Nav**: Persistent navigation with animated state indicators

---

## 📱 Screenshots

> Dashboard → Features course carousel, stats banner, recently viewed, and recommended courses

> Courses → Searchable and filterable course list with sort modal

> Detail → Full course info with sticky enroll CTA, progress, and expandable description

---

## 👤 Author

Built for **Fluentian Internship Programme – Task 4**  
Mobile App: Dashboard & Courses Listing

---

## 📄 License

MIT
