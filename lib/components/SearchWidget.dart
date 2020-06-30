import 'package:flutter/material.dart';
import 'package:triage/components/forms/SearchForm.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: SearchForm(),
    );
  }
}