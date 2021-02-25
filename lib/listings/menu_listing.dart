class MenuForListing {
  String menuID;
  String menuTitle;
  String menuImg;
  int menuInd;
  String menImgloc;
  int menurating;
  int mot1;
  int mot2;
  int mot3;
  int mot4;

  MenuForListing(
      {this.menuID,
      this.menuTitle,
      this.menuImg,
      this.menuInd,
      this.menImgloc,
      this.menurating,
      this.mot1,
      this.mot2,
      this.mot3,
      this.mot4});

  factory MenuForListing.fromJson(Map<String, dynamic> items) {
    return MenuForListing(
        menuID: items["id"] as String,
        menuTitle: items["name"] as String,
        menuImg: items["image"] as String,
        menuInd: items["index"] as int,
        menImgloc: items["imagelocal"] as String,
        menurating: items["rating"] as int,
        mot1: items["Motor1"] as int,
        mot2: items["Motor2"] as int,
        mot3: items["Motor3"] as int,
        mot4: items["Motor4"] as int);
  }
}
