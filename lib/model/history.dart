import 'entity.dart';

class History extends Entity {
  History({this.date, this.content});


  History.fromJson(Map<String, dynamic> json) {
    this.date = json['date'].toDate();
    this.content = json['content'];
  }

  DateTime date;
  String content;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date'] = this.date;
    data['content'] = this.content;
    return data;
  }

}