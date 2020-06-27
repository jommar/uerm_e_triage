import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:triage/components/HealthDeclarationSwitch.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map> history = [
      {
        'code': 'travel_14_days',
        'english': 'Travel in the past 14 days with local transmission of COVID-19',
        'tagalog': 'Paglalakbay sa nakaraang 14 na araw sa lugar na may local na hawaan ng COVID-19',
      },
      {
        'code': 'person_with_travel_history',
        'english': 'Exposure to person with history of travel with local transmission of COVID-19',
        'tagalog': 'Pagkalantad sa taong naglakbay sa lugar na may local na hawaan ng COVID-19',
      },
      {
        'code': 'exposure_to_individuals',
        'english': 'Exposure to cluster of Individuals with flu-like illness inn household or workplace',
        'tagalog': 'Pagkalantad sa grupo ng mga indibidwal na may sakit na tulad ng trangkaso sa bahay o opisina',
      },
      {
        'code': 'exposure_to_confirmed_case',
        'english': 'Exposure to a confirmed case of COVID-19',
        'tagalog': 'Pagkalantad sa isang kumpirmadong kaso ng COVID-19',
      },
      {
        'code': 'exposed_to_pui',
        'english': 'Exposure to a Probable and/or Suspected case of COVID-19',
        'tagalog': 'Pagkalantad sa isang Probable at/o Suspected case ng COVID-19',
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...history
            .map(
              (item) => HealthDeclarationSwitch(item: item,),
            )
            .toList(),
      ],
    );
  }
}
