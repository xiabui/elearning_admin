import "package:elearningadmin/model/user.dart";
import 'api_services.dart';

class Repository {
  String keyword;
  ApiProvider appApiProvider = ApiProvider();

  Future<List<User>> searchUser() => appApiProvider.searchUser(keyword);
}
