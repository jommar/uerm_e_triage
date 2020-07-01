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
        FormBuilderTextField(
          attribute: 'temperature',
          // initialValue: 34,
          // min: 34,
          // max: 42,
          decoration: InputDecoration(
            labelText: 'Temperature',
          ),
          maxLines: 1,
          validators: [
            FormBuilderValidators.numeric(),
            FormBuilderValidators.min(35),
            FormBuilderValidators.max(42),
          ],
        ),
        FormBuilderCheckbox(
          attribute: 'confirm',
          validators: [
            FormBuilderValidators.requiredTrue(
                errorText:
                    'You have to accept this field in order to continue.'),
          ],
          label: Text(
              'I, $employeeName certify that the information I have given is true, correct, and complete. I understand that failure to answer any question or giving false answer can be penalized in accordance with law. I voluntarily and freely consent to the collection, processing, sharing and storage of the above personal information with the Data Privacy Act of 2012 and it\'s implementing Rules and Regulations.'),
        ),
      ],
    );
  }
}
