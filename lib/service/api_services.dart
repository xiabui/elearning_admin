import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:elearningadmin/model/user.dart';
import 'package:elearningadmin/service/shared_reference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyHttpException extends HttpException {
  final int statusCode;
  MyHttpException(this.statusCode, String message) : super(message);
}

class ApiProvider {
  final String baseUrl = 'https://passwd.tools.pt-infra.net/api/v1';

  Future<bool> requestLoginAPI(context, username, password) async {
    Map<String, String> body = {'username': username, 'password': password};
    final response = await http.post(baseUrl + '/auth/apikey.ldap', body: body);

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      saveCurrentUser(responseJson['data']['apikey']);
      return true;
    } else {
      final responseJson = json.decode(response.body);
      return false;
      //return false;
    }
  }

  Future<List<User>> searchUser(String userid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');

    var uri = baseUrl + '/ldap/users.search?q=' + userid;
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      int length = responseJson['user'].length;
      List<User> userList = [];
      print(length);
      for (int i = 0; i < length; i++) {
        User user = new User.fromJson(responseJson['user'][i]);
        userList.add(user);
      }
      return userList;
    } else {
      print(response.statusCode);
      throw Exception("Error");
    }
  }

  Future<bool> changePassword(String dn, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');

    final body = jsonEncode({'password': password});

    var uri = baseUrl + '/ldap/users.update?dn=' + dn;
    var response = await http.post(uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Token $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: body);

    if (response.statusCode == 200) {
      //final responseJson = json.decode(response.body);
      return true;
    } else {
      //print('Login failed');
      return false;
    }
  }

  Future<bool> changeSchoolMail(String dn, String mail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');

    final body = jsonEncode({'email': mail});

    var uri = baseUrl + '/ldap/users.update?dn=' + dn;
    var response = await http.post(uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Token $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: body);

    if (response.statusCode == 200) {
      //final responseJson = json.decode(response.body);
      return true;
    } else {
      //print('Login failed');
      return false;
    }
  }

  Future<bool> updateUserInfo(
      String firstname, String lastname, String email, String dn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    final body = jsonEncode(
        {'firstname': firstname, 'lastname': lastname, 'email': email});

    var uri = baseUrl + '/ldap/users.update?dn=' + dn;
    var response = await http.post(uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Token $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: body);

    if (response.statusCode == 200) {
      //final responseJson = json.decode(response.body);
      return true;
    } else {
      //print('Login failed');
      return false;
    }
  }

  Future<bool> createUser(String username, String firstname, String lastname,
      String email, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    final body = jsonEncode({
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password
    });

    var uri = baseUrl + '/ldap/users.create';
    var response = await http.post(uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Token $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: body);

    if (response.statusCode == 200) {
      //final responseJson = json.decode(response.body);
      return true;
    } else {
      //print('Login failed');
      return false;
    }
  }

  String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  Future<bool> deleteUser(String dn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');

    var uri = baseUrl + '/ldap/users.delete?dn=' + dn;
    var response = await http.delete(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: 'Token $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.statusCode == 200) {
      //final responseJson = json.decode(response.body);
      return true;
    } else {
      //print('Login failed');
      return false;
    }
  }

  Future<void> getMyInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');

    var uri = baseUrl + '/profile';
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      saveUserInfo(
          utf8convert(responseJson['first_name']),
          utf8convert(responseJson['last_name']),
          responseJson['email'],
          responseJson['username']);
      print('sucess 1');
    } else {
      return;
    }
  }
}
