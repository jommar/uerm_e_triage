import 'dart:convert';

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
    final String url = apiUrl(url: 'etriage/health-declaration', params: '&code=$code');
    final response = await http.get(url);
    final responseJson = json.decode(response.body);

    return {
      'alreadyVisited':responseJson['result'].length > 0,
      'employeeData':responseJson['result'].length > 0 ? responseJson['result'][0] : null,
    };
  }

  Future<void> searchEmployee({@required String search}) async {
    final numberRegEx = RegExp(r"[0-9]");
    String url;
    if (numberRegEx.hasMatch(search)) {
      url = apiUrl(url: 'employees/search/code', params: '&code=$search');
    } else {
      url = apiUrl(url: 'employees/search/name', params: '&name=$search');
    }
    final response = await http.get(url);
    final responseJson = json.decode(response.body);
    _employees = responseJson['result'];
    notifyListeners();
  }

  void setEmployeeDetails({Map employeeDetails}) async {
    _employeeDetails = employeeDetails;
    notifyListeners();
  }
}
