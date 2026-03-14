import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Future<Map<String, dynamic>> signUp(String email, String password) async {
    return await _authService.signUp(email, password);
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    return await _authService.signIn(email, password);
  }

  void signOut() {
    _authService.signOut();
  }

  bool get isAuthenticated => _authService.isAuthenticated;
  
  String? get currentUserId => _authService.localId;
  
  String? get idToken => _authService.idToken;

  void setCredentials(String idToken, String localId) {
    _authService.setCredentials(idToken, localId);
  }

  User? get currentUser {
    if (!isAuthenticated) return null;
    return User(
      uid: _authService.localId!,
      email: '',
      createdAt: DateTime.now(),
    );
  }
}
