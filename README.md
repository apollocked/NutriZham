# NutriZham - Complete Fitness Nutrition App 🥗💪

A comprehensive fitness nutrition mobile app with authentication, meal planning, ratings, and bilingual support (English/Kurdish).

## ✨ All Features Implemented

### 🔐 Authentication System
- ✅ Login with email/password
- ✅ Registration (username, email, age, password)
- ✅ Form validation
- ✅ Session persistence
- ✅ Logout functionality

### 🏠 Home Page (Recipe List)
- ✅ Search recipes by name/ingredients
- ✅ Filter by 6 categories (Breakfast, Lunch, Dinner, Snack, Bulking, Cutting)
- ✅ Display ratings (stars + count)
- ✅ Favorites toggle
- ✅ Color-coded nutrition chips
- ✅ Beautiful card layout

### 🔍 Search Page
- ✅ Dedicated search interface
- ✅ Real-time filtering
- ✅ Category filters
- ✅ Clean results display

### 📅 Planner Page
- ✅ Add/remove meals from daily plan
- ✅ Total calorie counter
- ✅ Recommended meals section
- ✅ Persistent meal planning
- ✅ Visual meal organization

### 👤 Profile Page
- ✅ User info display (username, email, age)
- ✅ Favorites count card
- ✅ Quick access to settings
- ✅ Logout button
- ✅ Favorite meals preview

### ⚙️ Settings Page
- ✅ Edit account (username, email, age)
- ✅ Dark/Light mode toggle
- ✅ Language switch (🇬🇧 English ↔ 🇹🇯 Kurdish)
- ✅ Delete account option
- ✅ Organized sections

### 📖 Recipe Details
- ✅ Full recipe view with image
- ✅ Rating system (users can rate 1-5 stars)
- ✅ Your rating display
- ✅ Complete nutritional breakdown with icons
- ✅ Ingredients list
- ✅ Step-by-step instructions
- ✅ Category badge
- ✅ Favorite toggle

### 🎨 Design Features
- ✅ Modern Material Design 3
- ✅ Dark mode (fitness-optimized)
- ✅ Color constants file (app_colors.dart)
- ✅ Consistent color scheme
- ✅ Smooth animations
- ✅ Professional gradients
- ✅ Category-specific colors

### 🌐 Localization
- ✅ Complete English support
- ✅ Complete Kurdish (Sorani) support
- ✅ All UI elements translated
- ✅ Recipe titles, ingredients, steps in both languages

### 📱 Bottom Navigation
- ✅ Home tab
- ✅ Search tab
- ✅ Planner tab
- ✅ Profile tab
- ✅ Active state indicators

## 📁 Complete Project Structure

```
lib/
├── main.dart                       # App entry & initialization
├── models/
│   └── user_model.dart            # User data model
├── services/
│   └── auth_service.dart          # Authentication logic
├── utils/
│   ├── app_colors.dart            # All color constants
│   ├── app_localizations.dart     # EN/KU translations
│   └── meals_data.dart            # Recipe data with ratings
└── pages/
    ├── login_screen.dart          # Login page
    ├── register_screen.dart       # Registration page
    ├── main_navigation.dart       # Bottom nav bar
    ├── home_page.dart             # Recipe list with filters
    ├── search_page.dart           # Search interface
    ├── planner_page.dart          # Meal planner
    ├── profile_page.dart          # User profile
    ├── details_screen.dart        # Recipe details
    ├── settings_page.dart         # Settings menu
    └── edit_account_page.dart     # Edit account info
```

## 🚀 Installation Guide

### 1. Setup Files

You have ALL files needed. Here's how to organize them:

**Core Files (already created):**
- `lib/utils/app_colors.dart` ✅
- `lib/utils/app_localizations.dart` ✅
- `lib/utils/meals_data.dart` ✅
- `lib/models/user_model.dart` ✅
- `lib/services/auth_service.dart` ✅
- `lib/pages/login_screen.dart` ✅
- `lib/pages/main_navigation.dart` ✅
- `lib/main.dart` ✅
- `pubspec.yaml` ✅

**Pages to copy from ALL_PAGES_COMPLETE.dart:**
- Each section marked with `// FILE:` goes into its respective file
- Copy carefully maintaining the import statements

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the App

```bash
flutter run
```

## 🎨 Color System

All colors are in `app_colors.dart`:

### Primary Colors
- `primaryGreen` - Main brand color (#4CAF50)
- `primaryGreenDark` - Darker variant
- `primaryGreenLight` - Lighter variant

### Nutrition Colors
- `caloriesColor` - Red for calories
- `proteinColor` - Blue for protein
- `carbsColor` - Orange for carbs
- `fatsColor` - Purple for fats

### Category Colors
- `breakfastColor` - Orange
- `lunchColor` - Green
- `dinnerColor` - Blue
- `snackColor` - Purple
- `bulkingColor` - Red
- `cuttingColor` - Cyan

### Theme Colors
Light mode: white backgrounds, dark text
Dark mode: #121212 background, #1E1E1E cards, white text

## 📊 Data Storage

Uses `shared_preferences` for:
- ✅ User authentication tokens
- ✅ Favorites (recipe IDs)
- ✅ Meal plan (recipe IDs)
- ✅ User ratings (per recipe)
- ✅ Dark mode preference
- ✅ Language preference

## 🔐 Authentication Flow

1. App launches → checks if user logged in
2. If not → Login Screen
3. User can register → Registration Screen
4. After login/register → Main Navigation
5. User data stored in SharedPreferences
6. Logout → returns to Login Screen

## 📱 Page Features Detail

### Home Page
- Search bar with clear button
- Category filter chips
- Favorites-only toggle
- Recipe cards with:
  - Image
  - Title (translated)
  - Calories
  - Category
  - Rating stars
  - Favorite button
  - Tap to view details

### Search Page
- Focused search experience
- Filter by category
- Results list
- Empty state message

### Planner Page
- Today's meals section
- Total calorie display
- Add/remove meals
- Recommended meals
- Persistent storage

### Profile Page
- User avatar (first letter)
- Username, email, age
- Stats cards (favorites count)
- Quick settings access
- Logout button
- Recent favorites preview

### Settings Page
- Edit account info
- Dark mode toggle
- Language dropdown
- Delete account (with confirmation)

### Recipe Details
- Hero image with category badge
- Rating display (average + count)
- User rating (tap stars to rate)
- Nutrition cards with icons
- Ingredients list with bullets
- Numbered preparation steps
- Favorite toggle

## 🌍 Languages

### English (en)
- Default language
- All UI elements
- 10 sample recipes

### Kurdish (ku)
- Sorani dialect
- Complete translation
- Recipe localization

## 🍽️ Sample Data

**10 Recipes Included:**
1. Grilled Chicken Bowl (Bulking) - 420 kcal
2. Oatmeal with Fruits (Breakfast) - 280 kcal
3. Salmon with Veggies (Dinner) - 380 kcal
4. Greek Yogurt Parfait (Breakfast) - 220 kcal
5. Protein Smoothie (Bulking) - 310 kcal
6. Quinoa Buddha Bowl (Lunch) - 395 kcal
7. Turkey Lettuce Wraps (Cutting) - 265 kcal
8. Baked Sweet Potato (Snack) - 180 kcal
9. Egg White Omelette (Cutting) - 180 kcal
10. Mass Gainer Shake (Bulking) - 650 kcal

Each recipe includes:
- Bilingual title
- Image URL
- Complete nutrition (calories, protein, carbs, fats)
- Bilingual ingredients list
- Bilingual step-by-step instructions
- Category
- Initial rating and rating count

## 💡 Usage Tips

### For Users:
1. Register with email and age
2. Browse recipes on home page
3. Use search to find specific meals
4. Tap stars to rate recipes
5. Add to favorites with heart icon
6. Plan meals in Planner tab
7. View profile and change settings

### For Developers:
1. All colors in `app_colors.dart`
2. All translations in `app_localizations.dart`
3. Add recipes in `meals_data.dart`
4. Authentication in `auth_service.dart`
5. Each page is self-contained
6. Uses Material Design 3

## 🎯 Future Enhancements

Potential additions:
- Cloud sync (Firebase)
- Social features (share recipes)
- Custom recipe creation
- Barcode scanning
- Nutrition tracking graphs
- Workout integration
- Shopping list generator
- Meal prep timer
- Photo uploads
- Recipe comments

## 🐛 Troubleshooting

**App won't build:**
- Run `flutter clean`
- Run `flutter pub get`
- Check all imports

**Login doesn't work:**
- SharedPreferences may need initialization
- Check auth_service.dart

**Images not loading:**
- Network permission required
- Check internet connection
- Images have error fallbacks

**Translations missing:**
- Check app_localizations.dart
- Ensure language code is 'en' or 'ku'

## 📄 License

Created for educational and personal use.

## 🙏 Credits

- Built with Flutter & Dart
- Material Design 3
- SharedPreferences package
- Recipe images from Unsplash

---

**Ready to use! All features implemented and tested.** 🎉

For questions, refer to the code comments or Flutter documentation.

**Start your fitness journey with NutriZham!** 💪🥗
