# NutriZham 🥗💪

A comprehensive fitness nutrition app with Kurdish language support and dark mode designed for bodybuilders and fitness enthusiasts.

## ✨ Features

### 🔍 Search & Filter
- **Real-time search**: Search recipes by name or ingredients
- **Category filtering**: Filter by Breakfast, Lunch, Dinner, Snack, Bulking, or Cutting
- **Smart results**: See how many recipes match your search
- **Empty states**: Helpful messages when no recipes are found

### 🥗 Recipe Categories
- **Breakfast** (تایبەتە) - Start your day right
- **Lunch** (نانی نیوەڕۆ) - Midday fuel
- **Dinner** (نانی ئێوارە) - Evening meals
- **Snack** (خواردنی سووک) - Quick bites
- **Bulking** (زیادکردنی قەبارە) - High-calorie muscle-building meals
- **Cutting** (لاوازبوون) - Low-calorie fat-loss meals

### 🔥 Complete Nutrition Info
- **Calories** (کالۆری) - Total energy
- **Protein** (پڕۆتین) - Muscle building
- **Carbs** (کاربۆهایدرات) - Energy source
- **Fats** (چەوری) - Essential nutrients

Each recipe displays macros in color-coded chips and detailed breakdown on the detail screen.

### ❤️ Favorites System
- **Bookmark recipes**: Tap the heart icon to save favorites
- **Persistent storage**: Favorites saved across app restarts
- **Quick access**: Toggle favorites-only view from the app bar
- **Visual feedback**: Filled/outlined hearts show favorite status

### 🇬🇧 🇹🇯 Language Switching
- **English ↔ Kurdish**: Full bilingual support
- **Complete translation**: All UI elements, recipe names, ingredients, and steps
- **Persistent preference**: Language choice saved automatically
- **Easy switching**: Change language from settings menu

### 🌙 Dark Mode (Fitness Theme)
- **Sleek dark theme**: Professional fitness app aesthetic
- **Eye-friendly**: Perfect for evening meal planning
- **Persistent**: Dark mode preference saved
- **Smooth toggle**: Switch themes instantly from settings

## 📱 Screenshots

The app features:
- Clean, modern Material Design 3 interface
- Smooth animations and transitions
- Professional color scheme (green primary color)
- Card-based layouts for easy scanning
- Responsive design for all screen sizes

## 🚀 Installation

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile deployment)

### Steps

1. **Clone or download** the project files

2. **Install dependencies**:
```bash
flutter pub get
```

3. **Run the app**:
```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── main.dart                      # App entry point with theme management
├── pages/
│   ├── home_page.dart            # Recipe list with search & filters
│   └── details_screen.dart       # Recipe details with nutrition
└── utils/
    ├── meals_data.dart           # Recipe data model & sample recipes
    └── app_localizations.dart    # English & Kurdish translations
```

## 🍳 Sample Recipes (10 Total)

### Bulking Recipes
1. **Grilled Chicken Bowl** (مرگی برژاو لەگەڵ برنج) - 420 kcal, 35g protein
2. **Protein Smoothie** (خواردنەوەی پڕۆتین) - 310 kcal, 25g protein
3. **Mass Gainer Shake** (شەیکی زیادکردنی قەبارە) - 650 kcal, 40g protein

### Cutting Recipes
1. **Turkey Lettuce Wraps** (بوقچەی بووقەڵەموون و تووک) - 265 kcal, 28g protein
2. **Egg White Omelette** (ئۆملێتی سپێڵکی هێلکە) - 180 kcal, 22g protein

### Breakfast
1. **Oatmeal with Fruits** (جۆ دۆشاو لەگەڵ میوە) - 280 kcal
2. **Greek Yogurt Parfait** (ماستی یۆنانی لەگەڵ گرانۆلا) - 220 kcal

### Lunch & Dinner
1. **Salmon with Veggies** (ماسی سەلمۆن لەگەڵ سەوزە) - 380 kcal
2. **Quinoa Buddha Bowl** (قاپی کینۆا) - 395 kcal

### Snacks
1. **Baked Sweet Potato** (پەتاتەی شیرینی برژاو) - 180 kcal

## 🔧 Customization

### Adding New Recipes

Edit `lib/utils/meals_data.dart`:

```dart
Recipe(
  id: '11',
  title: {
    'en': 'Your Recipe Name',
    'ku': 'ناوی ڕێچەتەکەت',
  },
  image: 'https://your-image-url.jpg',
  nutrition: NutritionalInfo(
    calories: 400,
    protein: 30,
    carbs: 45,
    fats: 12,
  ),
  category: MealCategory.bulking, // or lunch, dinner, cutting, etc.
  ingredients: {
    'en': ['Ingredient 1', 'Ingredient 2'],
    'ku': ['پێکهاتەی ١', 'پێکهاتەی ٢'],
  },
  steps: {
    'en': ['Step 1', 'Step 2'],
    'ku': ['هەنگاوی ١', 'هەنگاوی ٢'],
  },
),
```

### Adding New Languages

1. Edit `lib/utils/app_localizations.dart`
2. Add new language code to the `_localizedValues` map
3. Translate all strings
4. Add language option to settings dropdown in `home_page.dart`

### Customizing Colors

Edit the theme in `lib/main.dart`:

```dart
theme: ThemeData(
  primarySwatch: Colors.blue, // Change primary color
  // ... other theme properties
),
```

## 🎨 Color Scheme

### Light Mode
- Primary: Green (#4CAF50)
- Background: White (#FFFFFF)
- Cards: White with elevation
- Text: Black/Dark Gray

### Dark Mode (Fitness Theme)
- Background: #121212
- Cards: #1E1E1E
- Surface: #2C2C2C
- Text: White/Light Gray
- Accent: Green (#4CAF50)

## 📊 Nutritional Information Display

- **List View**: Compact macro chips (P/C/F) with color coding
- **Detail View**: Large nutritional card with icons
  - 🔥 Calories (Red)
  - 💪 Protein (Blue)
  - 🍞 Carbs (Orange)
  - 💧 Fats (Purple)

## 🔐 Data Persistence

Uses `shared_preferences` package to store:
- ❤️ Favorite recipes (list of recipe IDs)
- 🌙 Dark mode preference (boolean)
- 🇬🇧/🇹🇯 Language preference (string: 'en' or 'ku')

All preferences are automatically loaded on app start and saved when changed.

## 🌍 Localization

### Supported Languages
- **English** (en) - Full support
- **Kurdish** (ku) - Full support (Sorani dialect)

### Translation Coverage
- ✅ All UI strings
- ✅ Recipe titles
- ✅ Ingredients
- ✅ Preparation steps
- ✅ Category names
- ✅ Nutritional labels

## 🎯 Use Cases

Perfect for:
- 💪 Bodybuilders tracking macros
- 🏃 Athletes managing nutrition
- 🥗 Health-conscious individuals
- 🇹🇯 Kurdish-speaking fitness enthusiasts
- 📱 Anyone wanting a dark mode recipe app

## 🛠️ Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2  # For persistent storage
```

## 🐛 Known Issues & Future Enhancements

### Potential Additions
- [ ] Meal planning calendar
- [ ] Shopping list generator
- [ ] Calorie tracking dashboard
- [ ] Custom recipe creation
- [ ] Recipe ratings and reviews
- [ ] Cooking timers
- [ ] Serving size calculator
- [ ] More languages (Arabic, Persian, etc.)
- [ ] Offline mode
- [ ] Recipe sharing

## 📝 Notes

- All recipe images are loaded from external URLs
- Error handling included for failed image loads
- Recipes can be in multiple categories
- Kurdish translations use Sorani dialect
- Dark mode optimized for OLED screens

## 🙏 Credits

- Built with Flutter & Dart
- Material Design 3 components
- Recipe images from Unsplash and various sources
- Kurdish translations provided

## 📄 License

This project is provided as-is for educational and personal use.

---

**Enjoy your fitness journey with NutriZham! 💪🥗**

*For support or questions, please open an issue in the repository.*
