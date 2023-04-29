import 'dart:convert';

import 'package:movie_display/app_models/EmployeeModel.dart';
import 'package:movie_display/app_models/PetModel.dart';

import 'ApiHelper.dart';

class ApiCollection {
  static postApi() async {
    String url = 'employees';
    var body = {};
    var res = await ConnectApi.postCallMethod(url, body: body);
    return res;
  }

  static Future<List<EmployeeData>> get getEmpDetails async {
    var empList = <EmployeeData>[];
    String url = 'https://dummy.restapiexample.com/api/v1/employees';
    url += '';
    // await Future.delayed(Duration(seconds: 5), () async {
    var res = await ConnectApi.getCallMethod(url);
    print('----responsss---$res');

    if (res != null) {
      var data = EmployeeModel.fromJson(res['data']).emplist;
      empList = data;
      return empList;
    } else {
      return empList;
    }
  }

  static Future getPet() async {
    var petList = <Entries>[];
    String url = 'https://api.publicapis.org/entries';
    url += '';

    var res = await ConnectApi.getCallMethod(url);
    print('----responsss---$res');

    if (res != null) {
      var data = PetModel.fromJson(res['entries']).petlist;
      petList = data;
      print('----petList---$petList');

      return petList;
    } else {
      return petList;
    }
  }
}
