import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class HealthDeclarationSwitch extends StatelessWidget {
  final Map item;
  const HealthDeclarationSwitch({this.item});

  @override
  Widget build(BuildContext context) {
    return FormBuilderSwitch(
      initialValue: false,
      attribute: item['code'],
      label: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            item['english'],
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 10),
          Text(item['tagalog']),
        ],
      ),
    );
  }
}
