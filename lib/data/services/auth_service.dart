import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';

class AuthService {
  String? _idToken;
  String? _localId;

  String? get idToken => _idToken;
  String? get localId => _localId;
  bool get isAuthenticated => _idToken != null && _localId != null;

  Future<Map<String, dynamic>> signUp(String email, String password) async {
    try {
      final url = Uri.parse(
        '${AppConstants.firebaseAuthBaseUrl}/accounts:signUp?key=${AppConstants.firebaseWebApiKey}',
      );

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        _idToken = data['idToken'];
        _localId = data['localId'];
        return {
          'success': true,
          'localId': _localId,
          'idToken': _idToken,
          'email': email,
        };
      } else {
        return {
          'success': false,
          'error': data['error']?['message'] ?? 'Signup failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      final url = Uri.parse(
        '${AppConstants.firebaseAuthBaseUrl}/accounts:signInWithPassword?key=${AppConstants.firebaseWebApiKey}',
      );

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        _idToken = data['idToken'];
        _localId = data['localId'];
        return {
          'success': true,
          'localId': _localId,
          'idToken': _idToken,
          'email': email,
        };
      } else {
        return {
          'success': false,
          'error': data['error']?['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: ${e.toString()}',
      };
    }
  }

  void signOut() {
    _idToken = null;
    _localId = null;
  }

  void setCredentials(String idToken, String localId) {
    _idToken = idToken;
    _localId = localId;
  }
}
