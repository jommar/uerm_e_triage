import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigatorWidget extends StatelessWidget {
  List _pages = [
    {
      'title': 'New',
      'color': Colors.blue,
      'icon': FontAwesomeIcons.userPlus,
      'route': '/register',
    },
    {
      'title': 'Existing',
      'color': Colors.red,
      'icon': FontAwesomeIcons.searchPlus,
      'route': '/search',
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