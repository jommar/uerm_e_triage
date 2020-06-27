import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SaveFormWidget extends StatelessWidget {
  final String employeeName;
  const SaveFormWidget({this.employeeName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FormBuilderSlider(
          attribute: 'temperature',
          initialValue: 35,
          min: 35,
          max: 42,
          decoration: InputDecoration(
            labelText: 'Temperature',
          ),
        ),
        FormBuilderCheckbox(
          attribute: 'confirm',
          validators: [
            FormBuilderValidators.requiredTrue(),
          ],
          label: Text('I, $employeeName certify that the information I have given is true, correct, and complete. I understand that failure to answer any question or giving false answer can be penalized in accordance with law. I voluntarily and freely consent to the collection, processing, sharing and storage of the above personal information with the Data Privacy Act of 2012 and it\'s implementing Rules and Regulations.'),
        ),
      ],
    );
  }
}
