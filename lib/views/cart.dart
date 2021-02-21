import 'package:acm1/alerts/api_response.dart';
import 'package:acm1/alerts/rateshare.dart';
import 'package:acm1/apis/menu_services.dart';
import 'package:acm1/listings/cart_listing.dart';
import 'package:acm1/views/gridsview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get_it/get_it.dart';

import 'dart:async';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  MenuService get service => GetIt.instance<MenuService>();

  APIResponse<List<CartListing>> _apiResponse;
  bool _isLoading = false;
  Timer timer;
  List<bool> _dialogOpened = [];
  int time = 0;
  List timeList = [];

  @override
  void initState() {
    _fetchCart();
    super.initState();
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) => _fetchCart());
  }

  _fetchCart() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getCartList();

    for (int i = 0; i < _apiResponse.data.length; i++) {
      timeList.add(_apiResponse.data[i].endtime);
      _dialogOpened.add(false);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Being Cooked'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => GridsView()));
            },
            child: Icon(Icons.add)),
        body: Builder(builder: (_) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (_apiResponse.error) {
            return Center(child: Text(_apiResponse.errorMessage));
          }

          return ListView.separated(
            separatorBuilder: (__, _) =>
                Container(child: Divider(height: 0, color: Colors.blue)),
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(
                  _apiResponse.data[index].orderTitle //
                  ,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 20),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Portions : ${_apiResponse.data[index].portions} , Feature A : ${_apiResponse.data[index].feature}%",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 15),
                    ),
                    CountdownTimer(
                      endTime: timeList[index],
                      onEnd: () {
                        if (!_dialogOpened[index]) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              _dialogOpened[index] = true;
                            });
                            showDialog(
                                context: context,
                                builder: (_) => RateShare(
                                      menuTitle:
                                          _apiResponse.data[index].orderTitle,
                                    ));
                          });
                        }
                      },
                      widgetBuilder: (_, time) {
                        if (time == null) {
                          return Container();
                        } else {
                          return Text(
                            "Time remaining : ${time.min == null ? "${1} minute" : "${time.min + 1} minutes"}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15),
                          );
                        }
                      },
                    )
                  ],
                ),
              );
            },
            itemCount: _apiResponse.data.length,
          );
        }));
  }
}
