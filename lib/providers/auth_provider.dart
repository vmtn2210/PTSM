import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(AuthService());
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(AuthState.initial());

  Future<void> login(String username, String password) async {
    state = AuthState.loading();
    try {
      final token = await _authService.login(username, password);
      final userId = await _authService.getUserId();
      state = AuthState.authenticated(token: token ?? "", userId: userId ?? "");
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    state = AuthState.initial();
  }

  Future<void> checkAuthStatus() async {
    final isLoggedIn = await _authService.isLoggedIn();
    if (isLoggedIn) {
      final userId = await _authService.getUserId();
      final token = await _authService.getToken();
      if (userId != null && token != null) {
        state = AuthState.authenticated(token: token, userId: userId);
      } else {
        state = AuthState.initial();
      }
    } else {
      state = AuthState.initial();
    }
  }

  Future<void> register({
    required String fullName,
    required String dateOfBirth,
    required String address,
    required String email,
    required String phoneNumber,
    required String gender,
  }) async {
    state = AuthState.loading();
    try {
      final success = await _authService.register(
        fullName: fullName,
        dateOfBirth: dateOfBirth,
        address: address,
        email: email,
        phoneNumber: phoneNumber,
        gender: gender,
      );
      if (success) {
        state = AuthState.initial();
      } else {
        state = AuthState.error("Registration failed");
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}

class AuthState {
  final bool isAuthenticated;
  final String? token;
  final String? userId;
  final bool isLoading;
  final String? error;

  AuthState({
    required this.isAuthenticated,
    this.token,
    this.userId,
    required this.isLoading,
    this.error,
  });

  factory AuthState.initial() =>
      AuthState(isAuthenticated: false, isLoading: false);
  factory AuthState.loading() =>
      AuthState(isAuthenticated: false, isLoading: true);
  factory AuthState.authenticated(
          {required String token, required String userId}) =>
      AuthState(
          isAuthenticated: true,
          token: token,
          userId: userId,
          isLoading: false);
  factory AuthState.error(String error) =>
      AuthState(isAuthenticated: false, isLoading: false, error: error);
}
