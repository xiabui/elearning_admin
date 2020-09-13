import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:elearningadmin/model/user.dart';
import 'package:observable/observable.dart';
import 'package:elearningadmin/src/validator/validators.dart';
import 'package:elearningadmin/service/repository.dart';

class LoginBloc {
  StreamController _userController = new StreamController();
  StreamController _passwordController = new StreamController();

  Stream get userStream => _userController.stream;
  Stream get passwordStream => _passwordController.stream;

  bool isValidInfomation(String user, String password) {
    if (!Validation.isValidUser(user)) {
      _userController.sink.addError("Invalid username.");
      return false;
    }
    _userController.sink.add("Passed");

    if (!Validation.isValidPassword(password)) {
      _passwordController.sink.addError("Invalid password.");
      return false;
    }
    _passwordController.sink.add("Passed");

    return true;
  }

  dispose() {
    _userController.close();
    _passwordController.close();
  }
}