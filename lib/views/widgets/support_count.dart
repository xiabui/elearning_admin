class SupportCount {
  DateTime logdate;
  int counter;

  SupportCount({this.logdate, this.counter});

  factory SupportCount.fromJson(Map<String, dynamic> json){
    return SupportCount(
      logdate: json['logdate'] as DateTime,
      counter: json['counter'] as int,
    );
  }
}