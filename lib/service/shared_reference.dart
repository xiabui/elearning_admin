import 'package:shared_preferences/shared_preferences.dart';

saveCurrentUser(String token) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('token', token);
}

saveUserInfo(firstname, lastname, email, username) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('fullname', firstname + ' ' + lastname);
  preferences.setString('lastname', lastname);
  preferences.setString('email', email);
}
