class CartListing {
  String orderID;
  String orderTitle;
  bool orderstatus;
  int portions;
  int feature;
  int endtime;
  int mot1;
  int mot2;
  int mot3;
  int mot4;

  CartListing(
      {this.orderID,
      this.orderTitle,
      this.orderstatus,
      this.portions,
      this.feature,
      this.endtime,
      this.mot1,
      this.mot2,
      this.mot3,
      this.mot4});

  factory CartListing.fromJson(Map<String, dynamic> item) {
    {
      return CartListing(
          orderID: item['item_id'],
          orderTitle: item['item_name'],
          orderstatus: item['is_cooked'],
          portions: item['portions'],
          feature: item['feature'],
          endtime: item['EndTime'],
          mot1: item['Motor1'],
          mot2: item['Motor2'],
          mot3: item['Motor3'],
          mot4: item['Motor4']);
    }
  }
}
