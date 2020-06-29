import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:triage/models/AuthProvider.dart';
import 'package:triage/models/EmployeeProvider.dart';
import 'package:triage/models/HealthDeclarationProvider.dart';
import 'package:triage/screens/HealthDeclarationStatusScreen.dart';
import 'package:triage/screens/employee/EmployeeScreen.dart';
import 'package:triage/screens/healthDeclaration/HealthDeclarationScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EmployeeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HealthDeclarationProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'UERM E-Triage',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.blue[50],
          appBarTheme: AppBarTheme(
            color: Colors.blue[700],
          ),
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.blue, textTheme: ButtonTextTheme.primary),
        ),
        routes: {
          '/': (_) => Router(),
          '/health-declaration': (_) => HealthDeclarationScreen(),
          '/employees': (_) => EmployeeScreen(),
          '/health-declaration-status': (_) => HealthDeclarationStatusScreen(),
        },
      ),
    );
  }
}

class Router extends StatelessWidget {
  List _pages = [
    {
      'title': 'Employees',
      'color': Colors.blue,
      'icon': FontAwesomeIcons.hospitalUser,
      'route': '/employees',
    },
    {
      'title': 'Visitors',
      'color': Colors.red,
      'icon': FontAwesomeIcons.users,
      'route': '/visitors',
    },
    {
      'title': 'Consultants',
      'color': Colors.orange,
      'icon': FontAwesomeIcons.userMd,
      'route': '/consultants',
    },
    {
      'title': 'Others',
      'color': Colors.purple,
      'icon': FontAwesomeIcons.userShield,
      'route': '/others',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UERM E-Triage'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        padding: EdgeInsets.all(10),
        itemCount: _pages.length,
        itemBuilder: (context, index) {
          Map currentPage = _pages[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(currentPage['route']);
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Icon(
                        currentPage['icon'],
                        size: constraints.maxWidth * .35,
                        color: Colors.white,
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    currentPage['title'],
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.white,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              color: currentPage['color'],
            ),
          );
        },
      ),
    );
  }
}
