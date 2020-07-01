import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:triage/models/UrlModel.dart';
import 'package:http/http.dart' as http;

class HealthDeclarationProvider with ChangeNotifier {
  String _employeeCode;
  final Map _argsContinue = {
    'title': 'You may now enter the UERM premises.',
    'icon': FontAwesomeIcons.checkCircle,
    'color': Colors.green[900],
  };
  final Map _argsCovidEr = {
    'title': 'Please proceed to COVID ER for proper evaluation and management.',
    'icon': FontAwesomeIcons.exclamationCircle,
    'color': Colors.red[900],
  };

  Map get argsCovidEr {
    return _argsCovidEr;
  }

  Map get argsContinue {
    return _argsContinue;
  }

  get employeeCode {
    return _employeeCode;
  }

  void setEmployee({@required String code}) {
    _employeeCode = code;
    notifyListeners();
  }

  saveForm({@required Map form, @required String code}) async {
    bool _isForCovidEr = false;
    List _symptoms = [];
    Map newForm = {};
    form.forEach((key, value) {
      switch (key) {
        case 'temperature':
        case 'confirm':
          break;
        default:
          if (value.toString() == 'true') {
            _isForCovidEr = true;
            _symptoms.add(key);
          }
      }
    });
    if (form['temperature'] > 37.7) {
      _isForCovidEr = true;
    }
    newForm['symptoms'] = _symptoms.join(';');
    newForm['code'] = code;
    newForm['temperature'] = form['temperature'];

    final String url = apiUrl(url: 'etriage/save-health-declaration');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'Code': newForm['code'],
        'SymptomAndHistory_Code': newForm['symptoms'],
        'Temperature': newForm['temperature']
      }),
    );
    Map responseJson = json.decode(response.body);
    responseJson['isForCovidEr'] = _isForCovidEr;

    return responseJson;
  }
}
