
class AuthResponse {
  final String token;
  String username;

  AuthResponse({this.token, this.username});

  factory AuthResponse.fromJson(Map<String, dynamic> parseJson) {
    return AuthResponse(
        token: parseJson['token'].toString(),
        username: parseJson['username'].toString()
    );
  }
}