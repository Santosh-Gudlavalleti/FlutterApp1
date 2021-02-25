import 'package:flutter/foundation.dart';

class MenuInsert {
  String menuTitle;
  String menuid;
  int menuportions;
  double menufeat;
  int menuTime;
  int mot1;
  int mot2;
  int mot3;
  int mot4;

  MenuInsert(
      {@required this.menuTitle,
      @required this.menuid,
      @required this.menuportions,
      @required this.menufeat,
      @required this.menuTime,
      this.mot1,
      this.mot2,
      this.mot3,
      this.mot4});

  Map<String, dynamic> toJson() {
    return {
      'item_name': menuTitle,
      'item_id': menuid,
      'portions': menuportions,
      'feature': menufeat,
      'EndTime': menuTime,
      'Motor1': mot1,
      'Motor2': mot2,
      'Motor3': mot3,
      'Motor4': mot4,
    };
  }
}
