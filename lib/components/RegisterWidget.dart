import 'package:flutter/material.dart';
import 'package:triage/components/forms/RegisterForm.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: RegisterForm(),
    );
  }
}
