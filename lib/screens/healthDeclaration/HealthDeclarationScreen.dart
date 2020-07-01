import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:triage/components/HistoryWidget.dart';
import 'package:triage/components/SaveFormWidget.dart';
import 'package:triage/components/SymptomsWidget.dart';
import 'package:triage/components/UermWidgets.dart';
import 'package:triage/models/EmployeeProvider.dart';
import 'package:triage/models/HealthDeclarationProvider.dart';

class HealthDeclarationScreen extends StatefulWidget {
  @override
  _HealthDeclarationScreenState createState() =>
      _HealthDeclarationScreenState();
}

class _HealthDeclarationScreenState extends State<HealthDeclarationScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  Map _formVal = {};

  void _saveForm(
      {@required BuildContext context, @required String code}) async {
    Map args;
    Scaffold.of(context).hideCurrentSnackBar();
    if (_formKey.currentState.saveAndValidate()) {
      _formVal = {
        ..._formVal,
        ..._formKey.currentState.value,
      };

      _formVal['temperature'] = double.parse(
          double.parse(_formVal['temperature']).toStringAsFixed(1));

      final response =
          await Provider.of<HealthDeclarationProvider>(context, listen: false)
              .saveForm(form: _formVal, code: code);

      if (response['error'] != null) {
        Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text(
            response['message'],
            textAlign: TextAlign.center,
          ),
        ));
        return;
      }

      if (response['isForCovidEr']) {
        args = Provider.of<HealthDeclarationProvider>(context, listen: false)
            .argsCovidEr;
      } else {
        args = Provider.of<HealthDeclarationProvider>(context, listen: false)
            .argsContinue;
      }

      Provider.of<EmployeeProvider>(context, listen: false).clearEmployees();

      Navigator.of(context).popUntil(ModalRoute.withName('/'));
      Navigator.of(context)
          .pushNamed('/health-declaration-status', arguments: args);
    }
  }

  void _validateForm() {
    if (_formKey.currentState.saveAndValidate()) {
      _formVal = {
        ..._formVal,
        ..._formKey.currentState.value,
      };
      setState(() {
        _currentPage++;
      });
    }
  }

  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final employeeProvider =
        Provider.of<EmployeeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Declaration Form'),
      ),
      body: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      switch (_currentPage) {
                        case 1:
                          return SymptomsWidget();
                        case 2:
                          return HistoryWidget();
                        case 3:
                          return SaveFormWidget(
                            employeeName:
                                employeeProvider.employeeDetails['NAME'],
                          );
                        default:
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              HeaderWidget(
                                label: 'COVID-19 HEALTH DECLARATION FORM',
                              ),
                              BodyWidget(
                                label:
                                    'In line with the Republic Act 11332 "Mandatory Reporting of Notifiable Diseases and Health Events of Public Health Concern Act", and to assure the safety and protection of the general public, please fill out this HEALTH DECLARATION FORM truthfully. This required information will be used in accordance with the law. Any incorrect information provided will be dealth with accordingly. Submit yourself for temperature checking and recording, and procedd to completing the information. Thank you.',
                              ),
                            ],
                          );
                      }
                    },
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.black12,
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (_currentPage < 3) {
                        return RaisedButton(
                          onPressed: () {
                            _validateForm();
                          },
                          child: Text('Continue'),
                        );
                      }
                      return RaisedButton.icon(
                        onPressed: () {
                          _saveForm(
                              context: context,
                              code: employeeProvider.employeeDetails['CODE']);
                        },
                        label: Text('Submit'),
                        icon: Icon(FontAwesomeIcons.save),
                      );
                    },
                  ),
                  FlatButton(
                    onPressed: () {
                      if (_currentPage > 0) {
                        setState(() {
                          _currentPage--;
                        });
                        return;
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text('Back'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
