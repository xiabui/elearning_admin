abstract class Entity {
  Entity({this.id});

  Entity.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
  }

  String id;

  Map<String, dynamic> toJson();

}