import 'entity.dart';

class CountUsage extends Entity {
  CountUsage({this.sixToNineAM, this.nineToTwelveAM, this.twelveToThreePM, this.threeToSixPM, this.sixToNinePM, this.nineToTwelvePM});


  CountUsage.fromJson(List<dynamic> json) {
    this.sixToNineAM = json[0][0][0]['Count'].toDouble();
    this.nineToTwelveAM = json[1][0][0]['Count'].toDouble();
    this.twelveToThreePM = json[2][0][0]['Count'].toDouble();
    this.threeToSixPM = json[3][0][0]['Count'].toDouble();
    this.sixToNinePM = json[4][0][0]['Count'].toDouble();
    this.nineToTwelvePM = json[5][0][0]['Count'].toDouble();
  }

  var sixToNineAM;
  var nineToTwelveAM;
  var twelveToThreePM;
  var threeToSixPM;
  var sixToNinePM;
  var nineToTwelvePM;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['count1'] = this.sixToNineAM;
    data['count2'] = this.nineToTwelveAM;
    data['count3'] = this.twelveToThreePM;
    data['count4'] = this.threeToSixPM;
    data['count5'] = this.sixToNinePM;
    data['count6'] = this.nineToTwelvePM;
    return data;
  }

}