import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenNotifier extends StateNotifier<String?> {
  TokenNotifier() : super(null);

  void setToken(String token) {
    state = token;
  }

  void clearToken() {
    state = null;
  }
}

final userTokenProvider = StateNotifierProvider<TokenNotifier, String?>((ref) {
  return TokenNotifier();
});
