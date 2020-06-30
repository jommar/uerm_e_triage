import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  List<Map> formElements = [
      {
        'type': FormBuilderDateTimePicker,
        'attribute': 'firstName',
        'label': 'First Name',
      },

      {
        'type': FormBuilderDateTimePicker,
        'attribute': 'middleInitial',
        'label': 'Middle Initial',
      },

      {
        'type': FormBuilderDateTimePicker,
        'attribute': 'lastName',
        'label': 'Last Name',
      },

      {
        'type': FormBuilderDateTimePicker,
        'attribute': 'address',
        'label': 'Address',
      },

      {
        'type': FormBuilderDateTimePicker,
        'attribute': 'contactNo',
        'label': 'Contact No.',
      },
      
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  color: Colors.blue[100],
                  child: Text(
                    'Please fill up all the fields',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Colors.blue[900],
                    )
                  ),
                ),

                ...formElements.map((elements) => 
                  FormBuilderTextField(
                    attribute: elements['attribute'],
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: elements['label'],
                        labelStyle: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.black38)),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),

                

                SizedBox(height: 20),
                RaisedButton.icon(
                  onPressed: () {
                    
                  },
                  icon: Icon(FontAwesomeIcons.save),
                  label: Text('Save'),
                ),
              ],
            ),
          )
        )
      )
    );
  }
}
