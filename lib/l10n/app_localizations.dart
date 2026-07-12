import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ku.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('ku')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'NutriZham'**
  String get appTitle;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @validatingEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email Address.'**
  String get validatingEmail;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @enterCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter current password'**
  String get enterCurrentPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get enterNewPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get confirmNewPassword;

  /// No description provided for @currentPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Current password is required'**
  String get currentPasswordRequired;

  /// No description provided for @newPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'New password is required'**
  String get newPasswordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be 6 characters'**
  String get passwordTooShort;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmPasswordRequired;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @verifyPassword.
  ///
  /// In en, this message translates to:
  /// **'Verify Password'**
  String get verifyPassword;

  /// No description provided for @validating.
  ///
  /// In en, this message translates to:
  /// **'Validating...'**
  String get validating;

  /// No description provided for @passwordVerified.
  ///
  /// In en, this message translates to:
  /// **'Password verified'**
  String get passwordVerified;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password'**
  String get wrongPassword;

  /// No description provided for @pleaseVerifyCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Please verify current password first'**
  String get pleaseVerifyCurrentPassword;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// No description provided for @passwordInfoMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter your current password and your new password. Your new password must be 6 characters.'**
  String get passwordInfoMessage;

  /// No description provided for @pleaseFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all required fields'**
  String get pleaseFillAllFields;

  /// No description provided for @errorUpdatingPassword.
  ///
  /// In en, this message translates to:
  /// **'Error updating password'**
  String get errorUpdatingPassword;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @planner.
  ///
  /// In en, this message translates to:
  /// **'Planner'**
  String get planner;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @recipes.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get recipes;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search recipes or ingredients...'**
  String get searchPlaceholder;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @recipesFound.
  ///
  /// In en, this message translates to:
  /// **'recipes found'**
  String get recipesFound;

  /// No description provided for @recipeFound.
  ///
  /// In en, this message translates to:
  /// **'recipe found'**
  String get recipeFound;

  /// No description provided for @noRecipesFound.
  ///
  /// In en, this message translates to:
  /// **'No recipes found'**
  String get noRecipesFound;

  /// No description provided for @tryDifferentSearch.
  ///
  /// In en, this message translates to:
  /// **'Try a different search or filter'**
  String get tryDifferentSearch;

  /// No description provided for @noFavorites.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get noFavorites;

  /// No description provided for @tapToSave.
  ///
  /// In en, this message translates to:
  /// **'Tap the + icon on recipes to save them'**
  String get tapToSave;

  /// No description provided for @recipeOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'Recipe of the Day'**
  String get recipeOfTheDay;

  /// No description provided for @breakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get breakfast;

  /// No description provided for @lunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get lunch;

  /// No description provided for @dinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get dinner;

  /// No description provided for @snack.
  ///
  /// In en, this message translates to:
  /// **'Snack'**
  String get snack;

  /// No description provided for @bulking.
  ///
  /// In en, this message translates to:
  /// **'Bulking'**
  String get bulking;

  /// No description provided for @cutting.
  ///
  /// In en, this message translates to:
  /// **'Cutting'**
  String get cutting;

  /// No description provided for @nutritionalInfo.
  ///
  /// In en, this message translates to:
  /// **'Nutritional Information'**
  String get nutritionalInfo;

  /// No description provided for @calories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get calories;

  /// No description provided for @protein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get protein;

  /// No description provided for @carbs.
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get carbs;

  /// No description provided for @fats.
  ///
  /// In en, this message translates to:
  /// **'Fats'**
  String get fats;

  /// No description provided for @ingredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get ingredients;

  /// No description provided for @preparationSteps.
  ///
  /// In en, this message translates to:
  /// **'Preparation Steps'**
  String get preparationSteps;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @ratings.
  ///
  /// In en, this message translates to:
  /// **'ratings'**
  String get ratings;

  /// No description provided for @rateThisMeal.
  ///
  /// In en, this message translates to:
  /// **'Rate this Meal'**
  String get rateThisMeal;

  /// No description provided for @yourRating.
  ///
  /// In en, this message translates to:
  /// **'Your Rating'**
  String get yourRating;

  /// No description provided for @submitRating.
  ///
  /// In en, this message translates to:
  /// **'Submit Rating'**
  String get submitRating;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @kurdish.
  ///
  /// In en, this message translates to:
  /// **'کوردی'**
  String get kurdish;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @editAccount.
  ///
  /// In en, this message translates to:
  /// **'Edit Account'**
  String get editAccount;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @appFeature.
  ///
  /// In en, this message translates to:
  /// **'App Features'**
  String get appFeature;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since'**
  String get memberSince;

  /// No description provided for @mealPlanner.
  ///
  /// In en, this message translates to:
  /// **'Meal Planner'**
  String get mealPlanner;

  /// No description provided for @emptyPlan.
  ///
  /// In en, this message translates to:
  /// **'Your Daily Plan is Empty'**
  String get emptyPlan;

  /// No description provided for @dailyPlan.
  ///
  /// In en, this message translates to:
  /// **'Daily Plan'**
  String get dailyPlan;

  /// No description provided for @weeklyPlan.
  ///
  /// In en, this message translates to:
  /// **'Weekly Plan'**
  String get weeklyPlan;

  /// No description provided for @recommendedMeals.
  ///
  /// In en, this message translates to:
  /// **'Recommended Meals'**
  String get recommendedMeals;

  /// No description provided for @basedOnYourGoals.
  ///
  /// In en, this message translates to:
  /// **'Based on your fitness goals'**
  String get basedOnYourGoals;

  /// No description provided for @totalCalories.
  ///
  /// In en, this message translates to:
  /// **'Total Calories'**
  String get totalCalories;

  /// No description provided for @todaysMeals.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Meals'**
  String get todaysMeals;

  /// No description provided for @addToPlan.
  ///
  /// In en, this message translates to:
  /// **'Add to Plan'**
  String get addToPlan;

  /// No description provided for @removeFromPlan.
  ///
  /// In en, this message translates to:
  /// **'Remove from Plan'**
  String get removeFromPlan;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @pleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait...'**
  String get pleaseWait;

  /// No description provided for @accountDeleted.
  ///
  /// In en, this message translates to:
  /// **'Account deleted successfully'**
  String get accountDeleted;

  /// No description provided for @accountUpdated.
  ///
  /// In en, this message translates to:
  /// **'Account updated successfully'**
  String get accountUpdated;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get loginSuccess;

  /// No description provided for @registerSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration successful'**
  String get registerSuccess;

  /// No description provided for @yourPlanIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your daily meal plan is empty'**
  String get yourPlanIsEmpty;

  /// No description provided for @startAddingMeals.
  ///
  /// In en, this message translates to:
  /// **'Start adding meals from the home page'**
  String get startAddingMeals;

  /// No description provided for @noRecipesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No recipes available'**
  String get noRecipesAvailable;

  /// No description provided for @welcomeTo.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcomeTo;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language'**
  String get selectLanguage;

  /// No description provided for @continue_text.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_text;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @selectTheme.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred theme'**
  String get selectTheme;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @appFeatures.
  ///
  /// In en, this message translates to:
  /// **'App Features'**
  String get appFeatures;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @developedBy.
  ///
  /// In en, this message translates to:
  /// **'Developed By'**
  String get developedBy;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'If you have any issues or questions, please contact us:'**
  String get contactUs;

  /// No description provided for @builtWith.
  ///
  /// In en, this message translates to:
  /// **'Built with ❤️ in Kurdistan.'**
  String get builtWith;

  /// No description provided for @allFeatures.
  ///
  /// In en, this message translates to:
  /// **'All Features'**
  String get allFeatures;

  /// No description provided for @recipesApp.
  ///
  /// In en, this message translates to:
  /// **'Recipes & Meal Planning App'**
  String get recipesApp;

  /// No description provided for @descriptionFlutterFirebase.
  ///
  /// In en, this message translates to:
  /// **'This app was developed for Flutter and Firebase learning purposes. The code is open source.'**
  String get descriptionFlutterFirebase;

  /// No description provided for @emailSupport.
  ///
  /// In en, this message translates to:
  /// **'hamabarznji1990@gmail.com'**
  String get emailSupport;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'A comprehensive fitness nutrition app with meal planning'**
  String get appDescription;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// No description provided for @signUpWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign up with Google'**
  String get signUpWithGoogle;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @couldNotLoadProfile.
  ///
  /// In en, this message translates to:
  /// **'Could not load profile'**
  String get couldNotLoadProfile;

  /// No description provided for @groceryList.
  ///
  /// In en, this message translates to:
  /// **'Grocery List'**
  String get groceryList;

  /// No description provided for @nutritionGoals.
  ///
  /// In en, this message translates to:
  /// **'Daily Nutrition Goals'**
  String get nutritionGoals;

  /// No description provided for @addMeal.
  ///
  /// In en, this message translates to:
  /// **'Add Meal'**
  String get addMeal;

  /// No description provided for @noMealsPlanned.
  ///
  /// In en, this message translates to:
  /// **'No meals planned yet'**
  String get noMealsPlanned;

  /// No description provided for @allMealsPlanned.
  ///
  /// In en, this message translates to:
  /// **'All meals already planned'**
  String get allMealsPlanned;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'items'**
  String get items;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @caloriesGoal.
  ///
  /// In en, this message translates to:
  /// **'Calories (kcal)'**
  String get caloriesGoal;

  /// No description provided for @proteinGoal.
  ///
  /// In en, this message translates to:
  /// **'Protein (g)'**
  String get proteinGoal;

  /// No description provided for @carbsGoal.
  ///
  /// In en, this message translates to:
  /// **'Carbs (g)'**
  String get carbsGoal;

  /// No description provided for @fatsGoal.
  ///
  /// In en, this message translates to:
  /// **'Fats (g)'**
  String get fatsGoal;

  /// No description provided for @tapToBrowse.
  ///
  /// In en, this message translates to:
  /// **'Tap to browse recipes'**
  String get tapToBrowse;

  /// No description provided for @planThisMeal.
  ///
  /// In en, this message translates to:
  /// **'Plan This Meal'**
  String get planThisMeal;

  /// No description provided for @addToMeal.
  ///
  /// In en, this message translates to:
  /// **'Add to meal'**
  String get addToMeal;

  /// No description provided for @added.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get added;

  /// No description provided for @youAreOffline.
  ///
  /// In en, this message translates to:
  /// **'You are offline'**
  String get youAreOffline;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternet;

  /// No description provided for @connectToLoad.
  ///
  /// In en, this message translates to:
  /// **'Connect to the internet to load recipes'**
  String get connectToLoad;

  /// No description provided for @kcal.
  ///
  /// In en, this message translates to:
  /// **'kcal'**
  String get kcal;

  /// No description provided for @proteinAbbr.
  ///
  /// In en, this message translates to:
  /// **'P'**
  String get proteinAbbr;

  /// No description provided for @carbsAbbr.
  ///
  /// In en, this message translates to:
  /// **'C'**
  String get carbsAbbr;

  /// No description provided for @fatsAbbr.
  ///
  /// In en, this message translates to:
  /// **'F'**
  String get fatsAbbr;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @onlineRequired.
  ///
  /// In en, this message translates to:
  /// **'This action requires an internet connection'**
  String get onlineRequired;

  /// No description provided for @dayMon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get dayMon;

  /// No description provided for @dayTue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get dayTue;

  /// No description provided for @dayWed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get dayWed;

  /// No description provided for @dayThu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get dayThu;

  /// No description provided for @dayFri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get dayFri;

  /// No description provided for @daySat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get daySat;

  /// No description provided for @daySun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get daySun;

  /// No description provided for @addedToSlot.
  ///
  /// In en, this message translates to:
  /// **'{recipe} added to {slot}'**
  String addedToSlot(Object recipe, Object slot);

  /// No description provided for @searchByIngredients.
  ///
  /// In en, this message translates to:
  /// **'Search by Ingredients'**
  String get searchByIngredients;

  /// No description provided for @searchIngredients.
  ///
  /// In en, this message translates to:
  /// **'Search ingredients...'**
  String get searchIngredients;

  /// No description provided for @pickIngredients.
  ///
  /// In en, this message translates to:
  /// **'Pick what you have'**
  String get pickIngredients;

  /// No description provided for @recipesYouCanMake.
  ///
  /// In en, this message translates to:
  /// **'Recipes you can make'**
  String get recipesYouCanMake;

  /// No description provided for @selectIngredientsHint.
  ///
  /// In en, this message translates to:
  /// **'Select ingredients to find matching recipes'**
  String get selectIngredientsHint;

  /// No description provided for @noMatchingRecipes.
  ///
  /// In en, this message translates to:
  /// **'No recipes match your ingredients'**
  String get noMatchingRecipes;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emailRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalidEmail;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get passwordRequired;

  /// No description provided for @usernameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a username'**
  String get usernameRequired;

  /// No description provided for @usernameTooShort.
  ///
  /// In en, this message translates to:
  /// **'Username must be at least 3 characters'**
  String get usernameTooShort;

  /// No description provided for @invalidAgeRange.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid age (10-100)'**
  String get invalidAgeRange;

  /// No description provided for @ageRequired.
  ///
  /// In en, this message translates to:
  /// **'Age is required'**
  String get ageRequired;

  /// No description provided for @minAgeError.
  ///
  /// In en, this message translates to:
  /// **'Must be at least 13 years old'**
  String get minAgeError;

  /// No description provided for @invalidAge.
  ///
  /// In en, this message translates to:
  /// **'Invalid age'**
  String get invalidAge;

  /// No description provided for @noPlanLoaded.
  ///
  /// In en, this message translates to:
  /// **'No plan loaded'**
  String get noPlanLoaded;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'v1.0.0'**
  String get appVersion;

  /// No description provided for @groceryListInfo.
  ///
  /// In en, this message translates to:
  /// **'You selected {mealCount} meals across {dayCount} days. Items used in multiple meals show a multiplier so you buy enough.'**
  String groceryListInfo(Object mealCount, Object dayCount);

  /// No description provided for @selectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String selectedCount(Object count);

  /// No description provided for @recipeCount.
  ///
  /// In en, this message translates to:
  /// **'{count} recipes'**
  String recipeCount(Object count);

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'more'**
  String get more;

  /// No description provided for @meals.
  ///
  /// In en, this message translates to:
  /// **'Meals'**
  String get meals;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// No description provided for @exitAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Exit NutriZham?'**
  String get exitAppTitle;

  /// No description provided for @exitApp.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit?'**
  String get exitApp;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'ku'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'ku':
      return AppLocalizationsKu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
