part of 'token_provider.dart';

/// Class implementasi dari [TokenProvider].
class TokenProviderImpl implements TokenProvider {
  final SessionsLocalDataSource _sessionLocalDataSource;

  /// Variabel untuk menyimpan token di cached memory.
  String? _cachedToken;

  TokenProviderImpl(this._sessionLocalDataSource);

  /// Mengambil `AuthToken` yang tersimpan di memory jika ada, atau
  /// akan di fallback untuk mengambil pada local storage.
  @override
  Future<String?> getToken() async {
    return _cachedToken ?? await _sessionLocalDataSource.getAccessToken();
  }

  @override
  void setToken(String token) {
    _cachedToken = token;
  }

  @override
  void clearToken() {
    _cachedToken = null;
  }
}
