import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triage/models/HealthDeclarationProvider.dart';
import 'package:triage/screens/employee/SearchEmployeeForm.dart';

class VisitorScreen extends StatelessWidget {
  const VisitorScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final healthDeclarationProvider =
        Provider.of<HealthDeclarationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitor'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonTheme(
                minWidth: 250.0,
                height: 100.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register-visitor');
                  },
                  child: Text(
                    "NEW",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ButtonTheme(
                minWidth: 250.0,
                height: 100.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/search-visitor');
                  },
                  child: Text(
                    "EXISTING",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
