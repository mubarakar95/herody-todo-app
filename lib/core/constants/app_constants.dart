class AppConstants {
  static const String appName = 'Herody Todo';
  static const String firebaseAuthBaseUrl = 'https://identitytoolkit.googleapis.com/v1';
  static const String firebaseDatabaseBaseUrl = 'https://herody-todo-app-default-rtdb.asia-southeast1.firebasedatabase.app';
  
  // Note: For production, use Firebase Auth SDK instead of REST API
  static const String firebaseWebApiKey = 'YOUR_FIREBASE_WEB_API_KEY';
  
  static const String tasksNode = 'tasks';
  static const String usersNode = 'users';
  
  static const Duration authTimeout = Duration(seconds: 30);
  static const Duration databaseTimeout = Duration(seconds: 30);
}
