
class Validation {
  static bool isValidUser(String user) {
    return user != null && user.length > 0 && user.length < 14;
  }

  static bool isValidPassword(String password) {
    return password != null && password.length > 0;
  }
}