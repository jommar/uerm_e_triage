import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:triage/models/AuthProvider.dart';

class HealthDeclarationStatusScreen extends StatelessWidget {
  final Color textColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    final String name = Provider.of<AuthProvider>(context).authName;
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Declaration Status'),
      ),
      backgroundColor: args['color'],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                args['title'],
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: textColor,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                name,
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Icon(
                args['icon'],
                size: MediaQuery.of(context).size.width * .6,
                color: textColor,
              ),
              SizedBox(height: 40),
              Text(
                DateFormat('EEE, MMM d, y', 'en_US')
                    .addPattern('jm')
                    .format(DateTime.now()),
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: textColor,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Text(
                'KINDLY OBSERVE THE FOLLOWING:',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: 18,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 10),
              Text(
                '• Wear a mask at all times\n• Observe physical distancing\n• Wash or sanitize your hands regularly',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: 18,
                      color: textColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
