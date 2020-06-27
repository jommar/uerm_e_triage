import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triage/models/EmployeeProvider.dart';
import 'package:triage/models/HealthDeclarationProvider.dart';
import 'package:triage/screens/employee/SearchEmployeeForm.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final healthDeclarationProvider = Provider.of<HealthDeclarationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Employees'),
      ),
      body: EmployeeSearchForm(),
    );
  }
}