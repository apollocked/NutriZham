NutriZham - Complete Food Recipe App 🥗💪
A comprehensive food recipe mobile app with authentication, meal planning, ratings, multi-language support (English/Kurdish/Arabic), and Firebase backend.

✨ All Features Implemented
🎉 Firebase Cloud Sync & User Data Management
✅ Firebase Firestore Integration for user favorites and planned meals

✅ Real-time sync across multiple devices

✅ Offline support with local caching (SharedPreferences)

✅ Auto-sync on login - data syncs automatically

✅ Conflict resolution - merges local and cloud data

✅ Error handling - graceful fallback when offline

🔐 Complete Firebase Authentication System
✅ Email/Password Registration with Firestore user creation

✅ Secure Login with Firebase Authentication

✅ Google Sign-In integration

✅ Password Reset functionality

✅ Account Deletion with Firestore cleanup

✅ Profile Updates synced to Firebase

✅ Session Management with Firebase persistence

🎉 Welcome Page & Onboarding
✅ Beautiful welcome screen on first launch

✅ Language selection (English, Kurdish, Arabic)

✅ Dark mode toggle preview

✅ Auto-detects device language

✅ One-time setup experience

✅ Smooth transition to login

🏠 Home Page (Recipe Discovery)
✅ Firebase Firestore integration with pagination

✅ Infinite scroll loading (20 recipes per batch)

✅ Real-time search by name/ingredients

✅ Filter by 6 categories (Breakfast, Lunch, Dinner, Snack, Bulking, Cutting)

✅ Favorites toggle with instant Firebase sync

✅ "Recipe of the Day" feature

✅ Display ratings (stars + count)

✅ Color-coded nutrition chips

✅ Responsive card layout

✅ Empty states for no results

🔍 Search Page
✅ Dedicated search interface

✅ Real-time filtering as you type

✅ Category filter chips

✅ Clear search button

✅ Clean results display with compact cards

✅ Navigate to recipe details

✅ Empty state when no recipes found

📅 Planner Page
✅ Add/remove meals from daily plan with Firebase sync

✅ Total calorie counter with macros breakdown

✅ Protein, Carbs, Fats summary

✅ Recommended meals section

✅ Persistent meal planning (SharedPreferences + Firestore)

✅ Visual meal organization

✅ Empty state guidance

✅ Real-time updates via StreamController

✅ Firebase recipe integration

👤 Profile Page
✅ User avatar with first letter

✅ User info display (username, email, age) from Firebase

✅ Stats cards (Favorites count, Planned meals count)

✅ Favorite recipes preview (top 5) from Firestore

✅ Firebase-powered favorites list

✅ Quick access to settings

✅ Logout functionality

✅ Edit account navigation

⚙️ Settings Page
✅ Edit Account: Update username, email, age (syncs to Firebase)

✅ Dark/Light Mode: System-wide theme toggle

✅ Language Switch: English 🇬🇧 ↔ Kurdish (کوردی) ↔ Arabic (العربية)

✅ Delete Account: With confirmation dialog and Firestore cleanup

✅ Organized sections (Account, Appearance)

✅ Real-time preference persistence

✅ Clean, modern UI

📖 Recipe Details
✅ Full recipe view with emoji icon

✅ Category badge

✅ Rating system (aggregate rating display)

✅ User rating (tap stars to rate 1-5)

✅ Your rating display

✅ Complete nutritional breakdown with icons

✅ Ingredients list with bullets

✅ Step-by-step numbered instructions

✅ Favorite toggle in header (syncs to Firestore)

✅ Multi-language content support

✅ Smooth animations

🎨 Design Features
✅ Modern Material Design 3

✅ Dark mode optimized for OLED screens

✅ Minimalist color palette (Emerald green primary)

✅ Centralized color system (app_colors.dart)

✅ Consistent spacing and typography

✅ Smooth transitions and animations

✅ Category-specific colors

✅ Accessible contrast ratios

✅ Custom widgets library

🌐 Localization (i18n)
✅ English - Complete support

✅ Kurdish (Sorani) - Full translation (کوردی)

✅ Arabic - Complete support (العربية)

✅ All UI elements translated

✅ Recipe titles, ingredients, steps in all languages

✅ RTL layout support for Arabic/Kurdish

✅ Language preference persistence

✅ Device language auto-detection

📱 Bottom Navigation
✅ Home tab (Recipe discovery)

✅ Search tab (Advanced search)

✅ Planner tab (Meal planning)

✅ Profile tab (User management)

✅ Active state indicators

✅ Icon transitions

✅ Labels in selected language

🔥 Complete Firebase Integration
✅ Cloud Firestore
Users Collection: Stores user profiles, favorites, planned meals

Recipes Collection: Recipe database with multi-language support

Real-time Updates: StreamController integration for instant UI updates

Efficient Queries: Pagination, filtering, indexing

✅ Firebase Authentication
Email/Password Auth: Secure user authentication

Google Sign-In: Alternative login method

Password Management: Reset password functionality

Session Management: Automatic session persistence

📁 Complete Project Structure
text
lib/
├── main.dart # App entry & Firebase initialization
├── models/
│ └── user_model.dart # User data model (updated with favorites/plannedMeals)
├── services/
│ ├── auth_service.dart # Authentication service (Firebase)
│ ├── firebase_auth_service.dart # Firebase Auth implementation
│ ├── firestore_service.dart # Firestore user data management
│ ├── preferences_helper.dart # App preferences (theme, language)
│ ├── favorites_helper.dart # Favorites with Firestore sync
│ └── meal_planner_service.dart # Meal planner with Firestore sync
├── utils/
│ ├── app_colors.dart # Color palette constants
│ ├── app_localizations.dart # EN/KU/AR translations
│ └── meals_data.dart # Recipe data models
├── widgets/
│ ├── custom_app_bar.dart # Reusable app bar
│ ├── custom_buttons.dart # Button components
│ ├── custom_text_field.dart # Input fields
│ ├── category_widgets.dart # Category chips/badges
│ ├── recipe_card.dart # Recipe list items
│ ├── nutrition_info_widget.dart # Nutrition displays
│ ├── search_bar_widget.dart # Search input
│ ├── empty_state_widget.dart # Empty states
│ └── stat_and_menu_widgets.dart # Stats & menu items
└── pages/
├── authotication/
│ ├── welcome_page.dart # First-launch onboarding
│ ├── login_page.dart # Login screen (updated with Firebase)
│ └── register_page.dart # Registration screen (updated with Firebase)
├── layout/
│ ├── main_navigation.dart # Bottom nav container
│ ├── home_page.dart # Recipe discovery (with Firestore)
│ ├── search_page.dart # Search interface (with Firestore)
│ ├── planner_page.dart # Meal planner (with Firestore sync)
│ ├── details_screen.dart # Recipe details (with Firestore favorites)
│ └── profile_page/
│ ├── profile_page.dart # User profile (Firestore data)
│ ├── settings_page.dart # Settings menu
│ ├── edit_account_page.dart # Account editing (Firestore sync)
│ └── app_features_page.dart # App features showcase
🚀 Quick Installation Guide

1. Prerequisites
   bash

# Install Flutter (latest stable)

flutter doctor

# Verify Flutter installation

flutter --version 2. Firebase Setup
Step 1: Create Firebase Project

Go to Firebase Console

Create new project "NutriZham"

Enable Google Analytics (optional)

Step 2: Add Android App

Package name: com.yourcompany.nutrizham

Download google-services.json

Place in android/app/google-services.json

Step 3: Add iOS App

Bundle ID: com.yourcompany.nutrizham

Download GoogleService-Info.plist

Place in ios/Runner/GoogleService-Info.plist

Step 4: Enable Firestore

In Firebase Console → Firestore Database

Create database (start in test mode)

Create collections: recipes, users

3. Update Dependencies
   Add to pubspec.yaml:

yaml
dependencies:
flutter:
sdk: flutter

# Firebase Core

firebase_core: ^2.24.2

# Firebase Auth

firebase_auth: ^4.15.0

# Cloud Firestore

cloud_firestore: ^4.13.6

# Google Sign-In

google_sign_in: ^6.1.5

# Local Storage

shared_preferences: ^2.2.2

# Utilities

intl: ^0.18.1

dev_dependencies:
flutter_test:
sdk: flutter
flutter_lints: ^3.0.0
Install dependencies:

bash
flutter pub get 4. Configure Platforms
Android (android/app/build.gradle):

gradle
apply plugin: 'com.google.gms.google-services'

android {
defaultConfig {
minSdkVersion 21
targetSdkVersion 34
multiDexEnabled true
}
}
iOS (ios/Podfile):

ruby
platform :ios, '12.0' 5. Copy All Provided Files
Copy all the files from this project to their respective locations in your Flutter project as shown in the project structure above.

6. Run the App
   bash

# Clean build

flutter clean

# Get dependencies

flutter pub get

# Run on device/emulator

flutter run
🔐 Firebase Security Rules
Add to Firebase Console → Firestore → Rules:

javascript
rules_version = '2';
service cloud.firestore {
match /databases/{database}/documents {
// Users can only read/write their own document
match /users/{userId} {
allow read, write: if request.auth != null && request.auth.uid == userId;
}

    // Authenticated users can read recipes
    match /recipes/{recipeId} {
      allow read: if request.auth != null;
      allow write: if false; // Admin-only for now
    }

}
}
🔄 How Data Sync Works
Sync Flow
User logs in → Data loads from Firestore to local storage

User adds favorite → Updates both local storage and Firestore

User goes offline → Changes saved locally, queued for sync

User comes online → Queued changes sync to Firestore

Multiple devices → All devices get real-time updates via Firestore

Key Features
Offline-first: App works without internet

Conflict resolution: Smart merging strategy

Real-time updates: UI updates instantly

Error handling: Graceful degradation on network issues

🍽️ Sample Recipe Data for Firestore
Import this structure to your recipes collection:

json
{
"id": "recipe_001",
"title": {
"en": "Grilled Chicken Bowl",
"ku": "قاپی مریشکی برژاو",
"ar": "وعاء دجاج مشوي"
},
"icon": "🍗",
"category": "bulking",
"nutrition": {
"calories": 420,
"protein": 45.0,
"carbs": 35.0,
"fats": 12.0
},
"ingredients": {
"en": ["200g chicken breast", "100g brown rice", "1 cup mixed vegetables"],
"ku": ["٢٠٠ گرام سنگی مریشک", "١٠٠ گرام برنجی قاوەیی", "١ پێیاڵە سەوزەی تێکەڵ"],
"ar": ["200 جرام صدر دجاج", "100 جرام أرز بني", "1 كوب خضار مشكلة"]
},
"steps": {
"en": ["Season chicken with salt and pepper", "Grill chicken for 6-7 minutes"],
"ku": ["تامی مریشک بە خوێ و بیبەر بکە", "مریشک بۆ ٦-٧ خولەک لە هەر لایەک برژێنە"],
"ar": ["تبل الدجاج بالملح والفلفل", "شوي الدجاج لمدة 6-7 دقائق على كل جانب"]
},
"rating": 4.8,
"ratingCount": 156
}
🌍 Multi-Language Support
Languages Available
English (en) - Default language

Kurdish (ku) - Sorani dialect (کوردی)

Arabic (ar) - Modern Standard Arabic (العربية)

How to Use
All UI text automatically translates

Recipe content shows in selected language

RTL layout for Arabic and Kurdish

Language preference saved across sessions

🐛 Troubleshooting
Common Issues
Firebase Not Working:

Check google-services.json is in correct location

Verify Firebase initialization in main.dart

Check internet connection

Review Firestore security rules

Sync Not Working:

Ensure user is logged in

Check Firestore permissions

Verify network connectivity

Check console for error messages

App Crashes:

bash

# Clean and rebuild

flutter clean
flutter pub get
flutter run
Debug Commands
bash

# View detailed logs

flutter run --verbose

# Clear all caches

flutter clean && rm -rf .dart_tool .packages pubspec.lock
🎯 Future Enhancements
Planned Features
Push notifications for meal reminders

Recipe sharing with friends

Nutrition tracking with charts

Barcode scanner for food products

Social features (follow users, share meals)

Advanced search by nutrition goals

Shopping list generator from meal plans

Technical Improvements
Firebase App Check for security

Analytics integration

Crashlytics for error reporting

Performance monitoring

Deep linking for recipe sharing

📞 Support
Getting Help
Check troubleshooting section above

Review Firebase documentation

Check Flutter.dev for guides

Stack Overflow with tags: flutter, firebase, firestore

Reporting Issues
When reporting issues, include:

Device model and OS version

Flutter version (flutter --version)

Steps to reproduce

Error messages/screenshots

🚀 Quick Start Summary
bash

# 1. Clone and setup

git clone <repository>
cd nutrizham

# 2. Install dependencies

flutter pub get

# 3. Setup Firebase (follow guide above)

# 4. Run the app

flutter run

# 5. Test features:

# - Welcome screen

# - Registration/Login

# - Recipe browsing

# - Favorites sync

# - Meal planning

# - Multi-language

# - Dark mode

Happy cooking and healthy eating! 🥗💻

Built with Flutter & Firebase | Version 2.2.0 | Last Updated: February 2026
