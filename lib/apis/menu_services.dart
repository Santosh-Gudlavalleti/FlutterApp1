import 'dart:convert';
import 'package:http/http.dart' as http;
import '../alerts/api_response.dart';
import '../listings/bin_listing.dart';
import '../listings/bin_update.dart';
import '../listings/cart_listing.dart';
import '../listings/cooked_listing.dart';
import '../listings/menu_insert.dart';
import '../listings/menu_listing.dart';

class MenuService {
  static const API = 'https://acmg90.herokuapp.com/v1/graphql';
  var headers = {
    'content-type': 'application/json',
    'x-hasura-admin-secret': 'acmcfi'
  };

  static Future<List<MenuForListing>> getMenu() async {
    var header = {
      'content-type': 'application/json',
      'x-hasura-admin-secret': 'acmcfi'
    };
    var sun =
        '{"query":"query MyQuery {\n  items {\n    name\n    id\n    image\n    index\n    rating\n    Motor1\n    Motor2\n    Motor3\n    Motor4\n  }\n}\n","variables":null,"operationName":"MyQuery"}';

    try {
      final response = await http.post(API, headers: header, body: sun);
      if (response.statusCode == 200) {
        final jsonDatas = json.decode(response.body);
        final note = <MenuForListing>[];
        for (var items in jsonDatas["data"]["items"]) {
          note.add(MenuForListing.fromJson(items));
        }
        return note;
        // return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception("Error");
    }
  }

  static List<MenuForListing> parseGrids(String responseBody) {
    final parsed = json.decode(responseBody);
    final stuff = parsed["data"]["items"];
    return stuff
        .map<MenuForListing>((json) => MenuForListing.fromJson(json))
        .toList();
  }

  Future<APIResponse<List<BinListing>>> getBinList() {
    var data =
        '{"query":"query MyQuery {\n  bins {\n    Name\n    id\n    Bin_Number\n  }\n}\n","variables":null,"operationName":"MyQuery"}';
    return http.post(API, headers: headers, body: data).then((re) {
      if (re.statusCode == 200) {
        final jsonDatas = json.decode(re.body);
        final note = <BinListing>[];
        for (var items in jsonDatas["data"]["bins"]) {
          if (true) {
            note.add(BinListing.fromJson(items));
          }
        }
        return APIResponse<List<BinListing>>(data: note);
      }
      return APIResponse<List<BinListing>>(
          error: true, errorMessage: 'An Error efklmkfln Occurred');
    }).catchError((_) => APIResponse<List<MenuForListing>>(
        error: true, errorMessage: 'An Error cjjc  Occurred'));
  }

  Future<APIResponse<List<MenuForListing>>> getMenuList() {
    var data =
        '{"query":"query MyQuery {\n  items {\n    name\n    id\n    image\n    index\n    imagelocal\n    rating\n    Motor1\n    Motor2\n    Motor3\n    Motor4\n  }\n}\n","variables":null,"operationName":"MyQuery"}';
    return http.post(API, headers: headers, body: data).then((res) {
      if (res.statusCode == 200) {
        final jsonDatas = json.decode(res.body);
        final note = <MenuForListing>[];
        for (var items in jsonDatas["data"]["items"]) {
          note.add(MenuForListing.fromJson(items));
        }
        return APIResponse<List<MenuForListing>>(data: note);
      }
      return APIResponse<List<MenuForListing>>(
          error: true, errorMessage: 'An Error efklmkfln Occurred');
    }).catchError((_) => APIResponse<List<MenuForListing>>(
        error: true, errorMessage: 'An Error cjjc  Occurred'));
  }

  Future<APIResponse<List<CartListing>>> getCartList() {
    var data =
        '{"query":"query MyQuery {\n  orders {\n    item_name\n    id\n    is_cooked\n   portions\n   feature\n    EndTime\n    Motor1\n    Motor2\n    Motor3\n    Motor4\n  }\n}\n","variables":null,"operationName":"MyQuery"}';
    return http.post(API, headers: headers, body: data).then((ress) {
      if (ress.statusCode == 200) {
        final jsonDat = json.decode(ress.body);
        final notess = <CartListing>[];
        for (var items in jsonDat["data"]["orders"]) {
          if (items["is_cooked"] == false) {
            notess.add(CartListing.fromJson(items));
          }
        }
        return APIResponse<List<CartListing>>(data: notess);
      }
      return APIResponse<List<CartListing>>(
          error: true, errorMessage: 'An Error efklmkfln Occurred');
    }).catchError((_) => APIResponse<List<MenuForListing>>(
        error: true, errorMessage: 'An Error cjjc  Occurred'));
  }

  Future<APIResponse<List<CookListing>>> getCookedList() {
    var datass =
        '{"query":"query MyQuery {\n  orders {\n    item_name\n    id\n    is_cooked\n   portions\n    EndTime\n  }\n}\n","variables":null,"operationName":"MyQuery"}';
    return http.post(API, headers: headers, body: datass).then((resp) {
      if (resp.statusCode == 200) {
        final jsonDatas = json.decode(resp.body);
        final note = <CookListing>[];
        for (var items in jsonDatas["data"]["orders"]) {
          if (items["is_cooked"] == true) {
            note.add(CookListing.fromJson(items));
          }
        }
        return APIResponse<List<CookListing>>(data: note);
      }
      return APIResponse<List<CookListing>>(
          error: true, errorMessage: 'An Error efklmkfln Occurred');
    }).catchError((_) => APIResponse<List<CookListing>>(
        error: true, errorMessage: 'An Error cjjc  Occurred'));
  }

  Future<APIResponse<bool>> createOrder(MenuInsert item) {
    var req =
        '{"query":"mutation MyMutation {\\n  insert_orders(objects: {item_id: \\"${item.menuid}\\" , item_name: \\"${item.menuTitle}\\", Motor1: \\"${item.mot1}\\", Motor2: \\"${item.mot2}\\", Motor3: \\"${item.mot3}\\", Motor4: \\"${item.mot4}\\", machine_id: \\"7da727c4-87d4-428e-b72e-07505195e9c1\\", user_id: \\"7da727c4-87d4-428e-b72e-07505195e9c1\\", is_cooked: \\"false\\", portions: \\"${item.menuportions}\\", feature: \\"${item.menufeat}\\", EndTime: \\"${item.menuTime}\\"}) {\\n    affected_rows\\n  }\\n}\\n","variables":null,"operationName":"MyMutation"}';
    return http.post(API, headers: headers, body: req).then((val) {
      if (val.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(
          error: true, errorMessage: 'An Error  4uihrfu Occurred');
    }).catchError((_) => APIResponse<bool>(
        error: true, errorMessage: 'An Error  t3fiedwyk Occurred'));
  }

  Future<APIResponse<bool>> updateBin(BinUpdate item) {
    var req =
        '{"query":"mutation MyMutation { update_bins(where: {id: {_eq: \\"${item.binid}\\"}}, _set: {Bin_Number: \\"${item.binnum}\\"}) { affected_rows returning { Name id Bin_Number } }}","variables":null,"operationName":"MyMutation"}';

    return http.post(API, headers: headers, body: req).then((val) {
      if (val.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(
          error: true, errorMessage: 'An Error  4uihrfu Occurred');
    }).catchError((_) => APIResponse<bool>(
        error: true, errorMessage: 'An Error  t3fiedwyk Occurred'));
  }
}
/*import 'package:http/http.dart' as http;

void main() async {
  var headers = {
    'content-type': 'application/json',
    'x-hasura-admin-secret': 'acmcfi'
  };

  var data = '{"query":"mutation MyMutation($user_id: uuid = \"7da727c4-87d4-428e-b72e-07505195e9c1\", $machine_id: uuid = \"7da727c4-87d4-428e-b72e-07505195e9c1\", $item_id: uuid = \"\") {\n  insert_orders(objects: {item_id: $item_id, machine_id: $machine_id, user_id: $user_id}) {\n    affected_rows\n  }\n}\n","variables":{"item_id":"7136a15a-00f1-4b8e-bb50-25f17c39a6eb"},"operationName":"MyMutation"}';

  var res = await http.post('https://acmg90.herokuapp.com/v1/graphql', headers: headers, body: data);
  if (res.statusCode != 200) throw Exception('http.post error: statusCode= ${res.statusCode}');
  print(res.body);
} */
