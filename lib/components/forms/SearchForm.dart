import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchForm extends StatefulWidget {
  SearchForm({Key key}) : super(key: key);

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

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
                      'Please enter your Code',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Colors.blue[900],
                      )
                    ),
                  ),

                  FormBuilderTextField(
                    attribute: 'Code',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Visitor Code',
                        labelStyle: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.black38)),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: 20),
                  RaisedButton.icon(
                    onPressed: () {
                      
                    },
                    icon: Icon(FontAwesomeIcons.search),
                    label: Text('Search'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}