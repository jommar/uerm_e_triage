import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class HealthDeclarationStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    // final Map args = {
    //   'title':
    //       'Please proceed to COVID ER for proper evaluation and management.',
    //   'icon': FontAwesomeIcons.exclamationCircle,
    //   'color': Colors.red[900],
    // };
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
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
              Icon(
                args['icon'],
                size: MediaQuery.of(context).size.width * .7,
                color: Colors.white,
              ),
              SizedBox(height: 30),
              Text(
                DateFormat('EEE, MMM d, y', 'en_US')
                    .addPattern('jm')
                    .format(DateTime.now()),
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Text(
                'KINDLY OBSERVE THE FOLLOWING:',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: 18,
                      color: Colors.white,
                    ),
              ),
              Text(
                '• Wear mask at all times',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: 18,
                      color: Colors.white,
                    ),
              ),
              Text(
                '• Observe physical distancing',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: 18,
                      color: Colors.white,
                    ),
              ),
              Text(
                '• Wash or sanitize your hands regularly',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: 18,
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
