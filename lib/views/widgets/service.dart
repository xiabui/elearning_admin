import 'dart:convert';
import 'package:http/http.dart' as http;
import 'support_count.dart';

class Services {
  static const ROOT = 'https://spayed-wraps.000webhostapp.com/get.php';
  static const _GET_ALL_ACTION = 'GET_CURRENT_WEEK';


  static Future<List<SupportCount>> getAllData() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      print("Create table response: ${response.body}");
      if(200 == response.statusCode){
        List<SupportCount> list = parseResponse(response.body);
        return list;
      } else {
        return List<SupportCount>();
      }
    } catch(e) {
      return List<SupportCount>();
    }
  }

  static List<SupportCount> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<SupportCount>((json) => SupportCount.fromJson(json)).toList();
  }
}