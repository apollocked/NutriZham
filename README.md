Markdown

# NutriZham - Complete Food Recipe App 🥗💪

NutriZham is a high-performance, trilingual food recipe and meal planning mobile application. Built with **Flutter** and **Firebase**, it offers a seamless experience for users to discover recipes, track macros, and sync data across devices.

---

## ✨ Core Features

### 🔐 Firebase Authentication System

- **Multiple Auth Methods:** Email/Password & Google Sign-In integration.
- **Secure Management:** Password reset, profile updates, and complete account deletion.
- **Session Persistence:** Automatic login across app restarts.

### 🏠 Recipe Discovery & Search

- **Real-time Firestore Sync:** Features infinite scroll (20 recipes per batch).
- **Smart Filtering:** Filter by 6 goals: _Breakfast, Lunch, Dinner, Snack, Bulking, and Cutting_.
- **Recipe of the Day:** Featured daily content to inspire healthy eating.
- **Interactive Search:** Real-time filtering with compact result cards.

### 📅 Meal Planner & Nutrition

- **Macro Tracking:** Automated calorie, protein, carb, and fat calculation.
- **Offline-First:** Local caching with `SharedPreferences` and automatic cloud merging.
- **Visual Organization:** Color-coded nutrition chips and responsive card layouts.

### 🌐 Full Localization (i18n)

- **Supported Languages:** English 🇬🇧, Kurdish (کوردی) ☀️, and Arabic (العربية) 🇸🇦.
- **Native RTL Support:** Full Right-to-Left layout adjustment for Kurdish and Arabic.
- **Auto-Detection:** Detects and applies device language settings on first launch.

---

## 🛠 Technical Architecture

### 📂 Project Structure

```text
lib/
├── models/      # User & Recipe data structures
├── services/    # Firebase Auth, Firestore, & Local Storage
├── utils/       # Colors, Localizations, & Mock Data
├── widgets/     # Custom UI components (Material 3)
└── pages/       # Authentication, Layout, & Settings
```

⚡ Data Sync Strategy
The app uses a Conflict Resolution Merge strategy:

Local Changes: Saved instantly to SharedPreferences.

Cloud Sync: Pushed to Firestore when a connection is detected.

Real-time Updates: Uses StreamController to update UI components instantly across devices.

🚀 Installation & Setup

1. Prerequisites
   Flutter SDK (Latest Stable)

A Firebase Project

2. Configuration
   Android: Place google-services.json in android/app/

iOS: Place GoogleService-Info.plist in ios/Runner/

3. Setup Commands
   Bash
   flutter pub get

# Ensure your Firebase project has Firestore and Auth enabled

flutter run
🔐 Firestore Security Rules
To protect user data, apply these rules in your Firebase Console:

JavaScript
rules_version = '2';
service cloud.firestore {
match /databases/{database}/documents {
match /users/{userId} {
allow read, write: if request.auth != null && request.auth.uid == userId;
}
match /recipes/{recipeId} {
allow read: if request.auth != null;
allow write: if false; // Admin only
}
}
}
🎨 UI/UX Highlights
Material Design 3: Modern, clean aesthetics.

OLED Dark Mode: High-contrast dark theme for battery saving.

Emerald Green Palette: Focused on health and freshness.

Responsive Layout: Optimized for both small and large smartphone screens.

🎯 Future Roadmap
[ ] Push notifications for meal reminders.

[ ] Barcode scanner for nutrition logging.

[ ] Social sharing for custom meal plans.

Built with ❤️ by the NutriZham Team | Version 2.1.0 (2026)
