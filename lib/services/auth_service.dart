class AuthService {
  final List<Map<String, String>> dummyUsers = [
    {"username": "admin", "password": "1234"},
    {"username": "bulut", "password": "1907"},
  ];

  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // giriş bekletmesi
    return dummyUsers.any((user) =>
        user['username'] == username && user['password'] == password);
  }
}
