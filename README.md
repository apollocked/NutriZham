# NutriZham 🥗💪

**NutriZham** is a modern, trilingual **food recipe & meal planning app** focused on nutrition, performance, and usability. Built with **Flutter** and **Firebase**, it delivers fast recipe discovery, macro tracking, and seamless cross-device sync.

---

## 🚀 Why NutriZham?

- ⚡ Fast, scalable Flutter architecture
- 🌍 English • Kurdish • Arabic (full RTL support)
- 📊 Built-in macro & calorie tracking
- ☁️ Secure Firebase-backed cloud sync
- 🌙 Polished Material 3 UI with Dark Mode

---

## ✨ Features

### 🔐 Authentication (Firebase Auth)
- Email & Password authentication
- Google Sign‑In
- Password reset & account deletion
- Persistent login sessions

### 🍽 Recipe Discovery
- Infinite scrolling (Firestore pagination – 20 items/batch)
- Smart filters:
  - Breakfast
  - Lunch
  - Dinner
  - Snack
  - Bulking
  - Cutting
- **Recipe of the Day** spotlight
- Real‑time search with compact recipe cards

### 📅 Meal Planner & Nutrition
- Automatic macro calculation:
  - Calories
  - Protein
  - Carbohydrates
  - Fats
- Offline‑first experience
- Local caching + automatic cloud merge
- Color‑coded nutrition indicators

### 🌐 Localization & RTL
- Languages:
  - 🇬🇧 English
  - ☀️ Kurdish (کوردی)
  - 🇸🇦 Arabic (العربية)
- Full Right‑to‑Left layout handling
- Automatic device language detection

---

## 🧱 Project Architecture

```text
lib/
├── models/        # Data models (User, Recipe)
├── services/      # Firebase, Firestore, Local Storage
├── utils/         # Constants, Colors, Localization
├── widgets/       # Reusable UI components
└── pages/         # Screens (Auth, Home, Planner, Settings)
```

### ⚡ Data Sync Strategy

- **Local First:** Changes saved instantly using SharedPreferences
- **Cloud Sync:** Auto‑sync to Firestore when online
- **Live Updates:** Stream‑based UI refresh across devices

---

## 🛠 Installation

### 1️⃣ Prerequisites
- Flutter SDK (latest stable)
- Firebase project (Auth + Firestore enabled)

### 2️⃣ Firebase Setup

**Android**
```
android/app/google-services.json
```

**iOS**
```
ios/Runner/GoogleService-Info.plist
```

### 3️⃣ Run the App

```bash
flutter pub get
flutter run
```

---

## 🔐 Firestore Security Rules

```js
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
```

---

## 🎨 UI / UX

- Material Design 3
- OLED‑optimized Dark Mode
- Health‑focused green accent palette
- Fully responsive layouts

---

## 🛣 Roadmap

- ⏰ Meal reminder notifications
- 📷 Barcode scanner for nutrition logging
- 🤝 Social sharing & meal plans

---

## 📦 Version

**v2.1.0 – 2026**

---

Built with ❤️ for healthy living.

