# Herody Todo App

A Flutter To-Do List application with Firebase Authentication and State Management.

## Features

- **User Authentication**: Sign up and login with email/password using Firebase Authentication
- **Task Management**: 
  - View all tasks
  - Add new tasks
  - Edit existing tasks
  - Mark tasks as completed
  - Delete tasks
- **State Management**: Using Provider for efficient state handling
- **Database**: Firebase Realtime Database with REST API integration
- **Responsive Design**: Adapts to different screen sizes

## Prerequisites

- Flutter SDK (3.x or later)
- Dart SDK (3.x or later)
- Android SDK
- A Firebase project

## Firebase Setup

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new Firebase project
3. Enable **Authentication**:
   - Go to Authentication > Sign-in method
   - Enable "Email/Password" provider
4. Enable **Realtime Database**:
   - Go to Realtime Database
   - Create a database (start in test mode for development)
5. Download your `google-services.json` file:
   - Go to Project Settings
   - Add app (Android)
   - Download the config file
6. Replace the placeholder `android/app/google-services.json` with your actual file

## Configuration

### Update API Key (Important!)

In `lib/data/services/auth_service.dart`, replace the placeholder API key:

```dart
// Find this line:
'${AppConstants.firebaseAuthBaseUrl}/accounts:signUp?key=AIzaSyPlaceholderKeyForDevelopment'

// Replace with your actual Firebase Web API key:
// '${AppConstants.firebaseAuthBaseUrl}/accounts:signUp?key=YOUR_ACTUAL_API_KEY'
```

To get your API key:
1. Go to Firebase Console > Project Settings
2. Go to "General" tab
3. Scroll down to "Your apps" > Web app
4. Copy the "API Key" from the config object

### Update Database URL

In `lib/core/constants/app_constants.dart`, update the database URL:

```dart
// Replace with your Firebase Realtime Database URL
static const String firebaseDatabaseBaseUrl = 'https://your-project-id.firebaseio.com';
```

## Installation

1. Clone the repository
2. Get dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Build APK

Debug APK:
```bash
flutter build apk --debug
```

Release APK:
```bash
flutter build apk --release
```

The APK will be generated at: `build/app/outputs/flutter-apk/`

## Project Structure

```
lib/
├── core/
│   ├── constants/     # App constants
│   ├── theme/          # App theme and colors
│   └── utils/          # Utility functions
├── data/
│   ├── models/         # Data models (Task, User)
│   ├── repositories/   # Data repositories
│   └── services/       # API services
├── presentation/
│   ├── providers/      # State management providers
│   ├── screens/        # App screens
│   └── widgets/        # Reusable widgets
└── main.dart           # App entry point
```

## Technologies Used

- **Flutter** - Cross-platform framework
- **Provider** - State management
- **Firebase Authentication** - User authentication
- **Firebase Realtime Database** - Real-time data storage
- **HTTP** - REST API calls

## License

This project is for demonstration purposes.
