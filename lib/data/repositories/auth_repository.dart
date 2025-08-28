abstract class AuthRepository {
  Future<bool> isLoggedIn();
  Future<String?> getUsername();
  Future<bool> login(String email, String password);
  Future<void> logout();
  Future<void> saveAuthState(bool isLoggedIn, String? username);
}

class MockAuthRepository implements AuthRepository {
  bool _isLoggedIn = false;
  String? _username;

  @override
  Future<bool> isLoggedIn() async {
    // TODO: Implementar verificação de estado salvo
    return _isLoggedIn;
  }

  @override
  Future<String?> getUsername() async {
    // TODO: Implementar recuperação de username salvo
    return _username;
  }

  @override
  Future<bool> login(String email, String password) async {
    // Simulação de login mockado
    if (email.isNotEmpty && password.isNotEmpty) {
      _isLoggedIn = true;
      _username = email.split('@').first;

      // TODO: Implementar salvamento do estado
      await saveAuthState(_isLoggedIn, _username);
      return true;
    }
    return false;
  }

  @override
  Future<void> logout() async {
    _isLoggedIn = false;
    _username = null;

    // TODO: Implementar limpeza do estado salvo
    await saveAuthState(_isLoggedIn, _username);
  }

  @override
  Future<void> saveAuthState(bool isLoggedIn, String? username) async {
    // TODO: Implementar persistência do estado
    _isLoggedIn = isLoggedIn;
    _username = username;
  }
}
