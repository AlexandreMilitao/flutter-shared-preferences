import 'package:sqlite_offline/data/storage/local_storage.dart';

abstract class AuthRepository {
  Future<bool> isLoggedIn();
  Future<String?> getUsername();
  Future<bool> login(String email, String password);
  Future<void> logout();
  Future<void> saveAuthState(bool isLoggedIn, String? username);
}

class MockAuthRepository implements AuthRepository {
  final LocalStorage localStorage;

  MockAuthRepository({required this.localStorage});

  final String isLoggedStorageKey = "isLoggedKey";
  final String usernameStorageKey = "usernameKey";

  bool _isLoggedIn = false;
  String? _username;

  @override
  Future<bool> isLoggedIn() async {
    final result = await localStorage.getData<String>(key: isLoggedStorageKey);
    _isLoggedIn = result == "true";
    return _isLoggedIn;
  }

  @override
  Future<String?> getUsername() async {
    final result = await localStorage.getData<String>(key: usernameStorageKey);
    _username = result;
    return _username;
  }

  @override
  Future<bool> login(String email, String password) async {
    // Simulação de login mockado
    if (email.isNotEmpty && password.isNotEmpty) {
      _isLoggedIn = true;
      _username = email.split('@').first;

      await saveAuthState(_isLoggedIn, _username);
      return true;
    }
    return false;
  }

  @override
  Future<void> logout() async {
    _isLoggedIn = false;
    _username = null;

    await saveAuthState(_isLoggedIn, _username);
  }

  @override
  Future<void> saveAuthState(bool isLoggedIn, String? username) async {
    await localStorage.create(key: isLoggedStorageKey, data: isLoggedIn);

    await localStorage.create(key: usernameStorageKey, data: username);

    _isLoggedIn = isLoggedIn;
    _username = username;
  }
}
