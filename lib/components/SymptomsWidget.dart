import 'package:flutter/material.dart';
import 'package:triage/components/DirectionsText.dart';
import 'package:triage/components/HealthDeclarationSwitch.dart';

class SymptomsWidget extends StatelessWidget {
  const SymptomsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map> symptoms = [
      {
        'code': 'fever',
        'english': 'Fever',
        'tagalog': 'Lagnat',
      },
      {
        'code': 'cough_colds',
        'english': 'Cough or Colds',
        'tagalog': 'Ubo o Sipon',
      },
      {
        'code': 'difficulty_breathing',
        'english': 'Difficulty of Breathing',
        'tagalog': 'Kinakapos na hininga',
      },
      {
        'code': 'headache',
        'english': 'Headache',
        'tagalog': 'Sakit ng Ulo',
      },
      {
        'code': 'sore_throat',
        'english': 'Sore Throat',
        'tagalog': 'Namamagang Lalamunan',
      },
      {
        'code': 'joint_pains',
        'english': 'Joint Pains',
        'tagalog': 'Sakit sa Kasu-kasuan',
      },
      {
        'code': 'stomach_ache_diarrhea',
        'english': 'Stomach Ache / Diarrhea',
        'tagalog': 'Sakit sa Tyan / Pagtatae',
      },
      {
        'code': 'sense_of_smell_taste',
        'english': 'New onset less or decreased sense of smell and or taste',
        'tagalog': 'Kawalan ng pang-amoy o panlasa',
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DirectionsText(
          title:
              'Please click on the symptoms that you are currently experiencing. Click Continue to proceed.',
        ),
        ...symptoms
            .map(
              (item) => HealthDeclarationSwitch(
                item: item,
              ),
            )
            .toList(),
      ],
    );
  }
}
