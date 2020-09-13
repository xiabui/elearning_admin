import 'dart:convert';

import 'entity.dart';

String utf8convert(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}

class User extends Entity {
  User({this.email, this.firstname, this.lastname, this.dn});

  User.fromJson(Map<String, dynamic> json) {
    //this.username = json['username'];
    this.email = json['mail'];
    this.firstname = utf8convert(json['sn']);
    this.lastname = utf8convert(json['givenName']);
    this.dn = json['dn'];
    this.lastLogin = json['loggedin_at'];
  }

  //String username;
  String email;
  String firstname;
  String lastname;
  String dn;
  String lastLogin;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    //data['username'] = this.username;
    data['email'] = this.email;
    data['first_name'] = this.firstname;
    data['last_name'] = this.lastname;
    data['dn'] = this.dn;
    data['loggedin_at'] = this.lastLogin;
    return data;
  }
}
