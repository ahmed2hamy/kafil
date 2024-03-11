class UserConfig {
  UserConfig._();

  static final UserConfig _userConfig = UserConfig._();

  factory UserConfig() {
    return _userConfig;
  }

  static String? _accessToken;

  static String? get accessToken => _accessToken;

  static void setAccessToken(String? accessToken) {
    if (accessToken != null) {
      _accessToken = accessToken;
    }
  }

  static void logOut() {
    _accessToken = null;
  }
}
