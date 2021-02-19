import 'package:acm1/alerts/api_response.dart';
import 'package:acm1/alerts/choose_features.dart';
import 'package:acm1/alerts/logout.dart';
import 'package:acm1/listings/menu_listing.dart';
import 'package:acm1/apis/menu_services.dart';
import 'package:acm1/views/bin_mapping.dart';
import 'package:acm1/views/cooked.dart';
import 'package:get_it/get_it.dart';
import 'package:acm1/views/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class MenuList extends StatefulWidget {
  final int ind;
  final String img;

  MenuList({this.ind, this.img});

  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  MenuService get service => GetIt.instance<MenuService>();
  List<Slide> slides = new List();

  APIResponse<List<MenuForListing>> _menuResponse;
  bool _isLoading = false;
  int count = 0;
  int a = 0;

  List<String> images = [
    'images/tomsoup.png',
    'images/jeerice.png',
    'images/dalmak.png',
    'images/mixveg.png',
    'images/palpan.png',
    'images/ricekhe.png'
  ];

  @override
  void initState() {
    _fetchNote();
    super.initState();
  }

  _fetchNote() async {
    setState(() {
      _isLoading = true;
    });

    _menuResponse = await service.getMenuList();

    setState(() {
      count = _menuResponse.data.length;
    });

    for (int i = widget.ind; i == widget.ind; i++) {
      slides.add(
        new Slide(
          title: _menuResponse.data[i].menuTitle,
          description: "Good, Healthy, Tasty \n Time : 10 min",
          pathImage: images[i],
          marginDescription:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
          marginTitle:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
          backgroundColor: Color(0xff29b6f6),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  Widget renderNextBtn() {
    return Text("Next", style: TextStyle(color: Colors.black, fontSize: 21));
  }

  onSkipPress() {
    showDialog(
        context: context,
        builder: (_) => ChooseFeature(
              menuID: _menuResponse.data[widget.ind].menuID,
              menuTitle: _menuResponse.data[widget.ind].menuTitle,
              img: widget.img,
              imgloc: images[widget.ind],
            ));
  }

  void onTabChangeCompleted(index) {
    setState(() {
      a = index;
      // widget.ind = widget.ind + index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
          centerTitle: true,
        ),
        floatingActionButton: SpeedDial(
          marginBottom: 100,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 30.0),
          // this is ignored if animatedIcon is non null
          // child: Icon(Icons.add),
          visible: true,
          // If true user is forced to close dial manually
          // by tapping main button and overlay is not rendered.
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,

          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 60.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
                child: Icon(Icons.cake),
                backgroundColor: Colors.red,
                label: 'Cook',
                labelStyle: TextStyle(fontSize: 21.0),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ChooseFeature(
                        menuID: _menuResponse.data[widget.ind].menuID,
                        menuTitle: _menuResponse.data[widget.ind].menuTitle)))),
            SpeedDialChild(
                child: Icon(Icons.access_alarm),
                backgroundColor: Colors.red,
                label: 'Being Cooked',
                labelStyle: TextStyle(fontSize: 21.0),
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Cart()))),
            SpeedDialChild(
                child: Icon(Icons.timer),
                backgroundColor: Colors.red,
                label: 'Cooked',
                labelStyle: TextStyle(fontSize: 21.0),
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Cooked()))),
            SpeedDialChild(
                child: Icon(Icons.business_center),
                backgroundColor: Colors.blue,
                label: 'Bin Mapping',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () =>
                    showDialog(context: context, builder: (_) => BinMap())),
            SpeedDialChild(
                child: Icon(Icons.power_settings_new),
                backgroundColor: Colors.blue,
                label: 'Log Out',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () =>
                    showDialog(context: context, builder: (_) => LogOut())),
            /*  SpeedDialChild(
                child: Icon(Icons.message),
                backgroundColor: Colors.blue,
                label: 'Share',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  AdvancedShare.whatsapp(msg: "Hi");
                }), */
          ],
        ),
        body: Builder(builder: (_) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (_menuResponse.error) {
            return Center(child: Text(_menuResponse.errorMessage));
          }
          return IntroSlider(
            slides: this.slides,
            // refFuncGoToTab: this.goToTab,
            nameSkipBtn: "Coo",
            nameDoneBtn: "Cook",
            isShowDoneBtn: true,
            isShowPrevBtn: false,
            isShowSkipBtn: true,
            nameNextBtn: "Next",
            namePrevBtn: "Previous",
            styleNameSkipBtn: TextStyle(fontSize: 21),
            styleNameDoneBtn: TextStyle(fontSize: 21),
            renderNextBtn: this.renderNextBtn(),
            styleNamePrevBtn: TextStyle(fontSize: 21),
            onSkipPress: this.onSkipPress,
            onDonePress: this.onSkipPress,
            onTabChangeCompleted: this.onTabChangeCompleted,
          );
        }));
  }
}
