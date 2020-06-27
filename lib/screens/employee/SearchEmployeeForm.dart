import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:triage/components/UermWidgets.dart';
import 'package:triage/models/AuthProvider.dart';
import 'package:triage/models/EmployeeProvider.dart';
import 'package:triage/models/HealthDeclarationProvider.dart';

class EmployeeSearchForm extends StatefulWidget {
  @override
  _EmployeeSearchFormState createState() => _EmployeeSearchFormState();
}

class _EmployeeSearchFormState extends State<EmployeeSearchForm> {
  bool _isLoading = false;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  _redirect(redirectPage) {
    redirectPage;
  }

  _searchEmployee({@required BuildContext context}) async {
    if (_formKey.currentState.saveAndValidate()) {
      Scaffold.of(context).hideCurrentSnackBar();
      setState(() {
        _isLoading = true;
      });
      final Map formVals = _formKey.currentState.value;

      final result = await Provider.of<EmployeeProvider>(context, listen: false)
          .searchEmployee(
              code: formVals['code'], password: formVals['password']);
      setState(() {
        _isLoading = false;
      });
      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: result['error'] != null
            ? Theme.of(context).errorColor
            : Colors.green[900],
        content: Text(
          result['message'],
          textAlign: TextAlign.center,
        ),
      ));
      if (result['success'] != null) {
        Scaffold.of(context).hideCurrentSnackBar();
        // print('YAAY');
        await _selectEmployee(
          employee: result['details'],
          context: context,
        );
      } else {
        Provider.of<EmployeeProvider>(context, listen: false).clearEmployees();
      }
    }
  }

  _selectEmployee({@required Map employee, BuildContext context}) async {
    Provider.of<AuthProvider>(context, listen: false)
        .setName(name: employee['NAME']);
    Provider.of<HealthDeclarationProvider>(context, listen: false)
        .setEmployee(code: employee['CODE']);
    Provider.of<EmployeeProvider>(context, listen: false)
        .setEmployeeDetails(employeeDetails: employee);
    final response = await Provider.of<EmployeeProvider>(context, listen: false)
        .checkDailyVisit(code: employee['CODE']);

    if (response['alreadyVisited']) {
      Map args = {};
      if (response['employeeData']['symptoms'] != null) {
        args = Provider.of<HealthDeclarationProvider>(context, listen: false)
            .argsCovidEr;
      } else if (response['employeeData']['temperature'] > 37.7) {
        args = Provider.of<HealthDeclarationProvider>(context, listen: false)
            .argsCovidEr;
      } else {
        args = Provider.of<HealthDeclarationProvider>(context, listen: false)
            .argsContinue;
      }
      _redirect(Navigator.of(context)
          .pushNamed('/health-declaration-status', arguments: args));
    } else {
      _redirect(Navigator.of(context).pushNamed('/health-declaration'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context);
    return FormBuilder(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              color: Colors.blue[100],
              child: Text(
                'Use your login credentials in the UERM Web Apps.',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: Colors.blue[900],
                )
              ),
            ),
            FormBuilderTextField(
              attribute: 'code',
              textAlign: TextAlign.center,
              validators: [
                FormBuilderValidators.required(),
              ],
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'Employee Code',
                  labelStyle: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.black38)),
              style: Theme.of(context).textTheme.headline4,
            ),
            FormBuilderTextField(
              attribute: 'password',
              obscureText: true,
              maxLines: 1,
              textAlign: TextAlign.center,
              validators: [
                FormBuilderValidators.required(),
              ],
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.black38)),
              style: Theme.of(context).textTheme.headline4,
            ),
            _isLoading
                ? LoadingWidget()
                : RaisedButton.icon(
                    onPressed: () {
                      _searchEmployee(context: context);
                    },
                    icon: Icon(FontAwesomeIcons.signInAlt),
                    label: Text('Login'),
                  ),
            if (!_isLoading)
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (employeeProvider.employees.length > 0) {
                      return EmployeeList(
                          employees: employeeProvider.employees,
                          redirect: _redirect);
                    }
                    return Container();
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class EmployeeList extends StatelessWidget {
  final List employees;
  final redirect;
  EmployeeList({@required this.employees, this.redirect});

  _selectEmployee({@required Map employee, BuildContext context}) async {
    Provider.of<HealthDeclarationProvider>(context, listen: false)
        .setEmployee(code: employee['CODE']);
    Provider.of<EmployeeProvider>(context, listen: false)
        .setEmployeeDetails(employeeDetails: employee);
    final response = await Provider.of<EmployeeProvider>(context, listen: false)
        .checkDailyVisit(code: employee['CODE']);

    if (response['alreadyVisited']) {
      Map args = {};
      if (response['employeeData']['symptoms'] != null) {
        args = Provider.of<HealthDeclarationProvider>(context, listen: false)
            .argsCovidEr;
      } else if (response['employeeData']['temperature'] > 37.7) {
        args = Provider.of<HealthDeclarationProvider>(context, listen: false)
            .argsCovidEr;
      } else {
        args = Provider.of<HealthDeclarationProvider>(context, listen: false)
            .argsContinue;
      }
      redirect(Navigator.of(context)
          .pushNamed('/health-declaration-status', arguments: args));
    } else {
      redirect(Navigator.of(context).pushNamed('/health-declaration'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxWidth,
          child: ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  _selectEmployee(employee: employees[index], context: context);
                },
                leading: CircleAvatar(
                  radius: 60,
                  child: Text(employees[index]['CODE']),
                ),
                title: Text(employees[index]['NAME']),
                subtitle: Text(employees[index]['POS_DESC']),
              );
            },
          ),
        );
      },
    );
  }
}
