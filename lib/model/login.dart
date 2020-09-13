class Login {
  final String username;
  final String password;

  Login({this.username, this.password});

  Login.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'];

}