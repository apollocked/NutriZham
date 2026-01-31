# NutriZham - Enhanced Recipe App

## New Features Implemented

### 1. 🔍 Search & Filter
- **Search bar**: Search by recipe name or ingredients
- **Category filters**: Filter by Breakfast, Lunch, Dinner, or Snack
- **Filter chips**: Easy-to-use category selection with visual feedback
- **Real-time filtering**: Results update as you type

### 2. 🍽️ Recipe Categories
- Breakfast
- Lunch
- Dinner
- Snack

Each recipe is now categorized, and you can filter the list to show only recipes from a specific category.

### 3. ❤️ Favorites System
- **Bookmark recipes**: Tap the heart icon to save favorites
- **Persistent storage**: Favorites are saved using `shared_preferences` and persist across app restarts
- **Favorites filter**: Toggle the heart icon in the app bar to show only your favorite recipes
- **Visual feedback**: Filled heart for favorited recipes, outlined heart for non-favorites

### 4. 📊 Extended Nutritional Information
- **Calories** (kcal)
- **Protein** (grams)
- **Carbohydrates** (grams)
- **Fats** (grams)

Nutritional information is displayed both in the list view (as compact chips) and in the detail view (as a comprehensive card with icons).

## Installation & Setup

### 1. Update Dependencies
Add the new dependency to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2
```

Or run:
```bash
flutter pub add shared_preferences
```

### 2. Replace Files
Replace your existing files with the new versions:

- `lib/utils/meals_data.dart` - Enhanced data model with categories and nutrition
- `lib/pages/home_page.dart` - Added search, filters, and favorites
- `lib/pages/details_screen.dart` - Enhanced detail view with nutrition breakdown
- `lib/main.dart` - No changes needed

### 3. Install Dependencies
```bash
flutter pub get
```

### 4. Run the App
```bash
flutter run
```

## File Structure
```
lib/
├── main.dart
├── pages/
│   ├── home_page.dart
│   └── details_screen.dart
└── utils/
    └── meals_data.dart
```

## What's New in Each File

### meals_data.dart
- Added `MealCategory` enum (breakfast, lunch, dinner, snack)
- Created `NutritionalInfo` class for detailed nutrition data
- Updated `Recipe` model with `id`, `category`, and `nutrition` fields
- Added 6 new recipes (8 total) covering all meal categories

### home_page.dart
- Converted to `StatefulWidget` to manage state
- Added search TextField with clear button
- Implemented category filter chips
- Added favorites functionality with persistent storage
- Added favorites-only filter toggle in app bar
- Enhanced recipe cards with:
  - Nutritional information chips (P/C/F)
  - Category display
  - Favorite button
  - Error handling for images
- Added empty state for no results

### details_screen.dart
- Enhanced nutritional information display with icon cards
- Added category badge on recipe image
- Improved visual design with:
  - Color-coded nutrient columns
  - Numbered step cards
  - Better spacing and typography
- Added favorite toggle in app bar
- Fixed bullet point encoding issue (now uses proper Unicode bullet)

## Usage Tips

### Searching
- Type recipe names like "Chicken" or "Smoothie"
- Search by ingredients like "banana" or "quinoa"
- Clear search with the X button

### Filtering
- Tap category chips to filter by meal type
- Tap "All" to clear category filter
- Multiple filters work together (search + category + favorites)

### Favorites
- Tap heart icon on any recipe to save it
- Tap heart in app bar to see only favorites
- Favorites persist even after closing the app

## Sample Data Included

8 recipes covering all categories:
- **Breakfast**: Oatmeal with Fruits, Greek Yogurt Parfait
- **Lunch**: Grilled Chicken Bowl, Quinoa Buddha Bowl, Turkey Lettuce Wraps
- **Dinner**: Salmon with Veggies
- **Snack**: Protein Smoothie, Baked Sweet Potato

## Next Steps (Future Enhancements)

Some ideas for further development:
- Add recipe ratings
- Include cooking time and difficulty level
- Create custom meal plans
- Add a shopping list generator
- Implement calorie tracking
- Add recipe images from camera/gallery
- Include nutritional goals and tracking
- Add user-created recipes
- Social sharing features

## Dependencies

- **flutter**: SDK
- **shared_preferences**: ^2.2.2 (for persistent favorites storage)

## Notes

- Image URLs are from external sources (Unsplash, etc.)
- Error handling added for failed image loads
- All data is currently local (no backend)
- Favorites are stored locally on device

Enjoy your enhanced NutriZham app! 🥗✨
