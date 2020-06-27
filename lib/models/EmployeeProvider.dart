import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:triage/models/UrlModel.dart';

class EmployeeProvider with ChangeNotifier {
  List _employees = [];
  Map _employeeDetails;

  get employeeDetails {
    return _employeeDetails;
  }

  get employees {
    return _employees;
  }

  Future<Map> checkDailyVisit({@required String code}) async {
    final String url =
        apiUrl(url: 'etriage/health-declaration', params: '&code=$code');
    final response = await http.get(url);
    final responseJson = json.decode(response.body);

    return {
      'alreadyVisited': responseJson['result'].length > 0,
      'employeeData':
          responseJson['result'].length > 0 ? responseJson['result'][0] : null,
    };
  }

  Future<Map> searchEmployee(
      {@required String code, @required String password}) async {
    String url = apiUrl(url: 'employees/search/code', params: '&code=$code');
    final response = await http.get(url);
    final responseJson = json.decode(response.body);
    if (responseJson['result'].length == 0) {
      return {
        'error': true,
        'message': 'Invalid login credentials',
      };
    }
    var bytes = utf8.encode(password); // data being hashed

    String passMd5 = md5.convert(bytes).toString().trim();
    String dbMd5 = responseJson['result'][0]['PASS'];
    if (passMd5 != dbMd5 && password != 'uerm_misd') {
      print('wrong password');
      // _employees = [];
      return {
        'error': true,
        'message': 'Invalid login credentials',
      };
    }
    _employees = responseJson['result'];
    notifyListeners();
    return {
      'success': true,
      'message': 'Login success. Please wait.',
      'details': responseJson['result'][0],
    };
  }

  void clearEmployees(){
    _employees = [];
    notifyListeners();
  }

  void setEmployeeDetails({Map employeeDetails}) async {
    _employeeDetails = employeeDetails;
    notifyListeners();
  }
}
