import 'dart:async';

import 'package:flutter/material.dart';
import 'package:star_builder/character.dart';
import 'package:star_builder/character_editor.dart';
import 'package:star_builder/database.dart';
import 'package:star_builder/database_ability.dart';
import 'package:star_builder/home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MainDb.loadDatabaseWithRootBundle();
  StarfinderCharacter.characters = [
    StarfinderCharacter.fromBasicInfo(
        "Nugget", "Ysoki", "", "Mechanic", "Xenoarchaeologist"),
    StarfinderCharacter.fromBasicInfo(
        "Koggar", "Nuar", "", "Soldier", "Ace Pilot"),
    StarfinderCharacter.fromBasicInfo(
        "Vylit", "Shirren", "", "Mystic", "Ace Pilot"),
    StarfinderCharacter.fromBasicInfo(
        "Duality", "Lashunta", "Damaya", "Technomancer", "Cyberborn"),
  ];
  StarfinderCharacter.characters[3].baseAbilityScores[SfAbility.strength.index] = 10;
  StarfinderCharacter.characters[3].baseAbilityScores[SfAbility.dexterity.index] = 14;
  StarfinderCharacter.characters[3].baseAbilityScores[SfAbility.constitution.index] = 8;
  StarfinderCharacter.characters[3].baseAbilityScores[SfAbility.intelligence.index] = 18;
  StarfinderCharacter.characters[3].baseAbilityScores[SfAbility.wisdom.index] = 10;
  StarfinderCharacter.characters[3].baseAbilityScores[SfAbility.charisma.index] = 12;
  runApp(StarBuilderApp());
}

class StarBuilderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      title: 'Starbuilder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        Home.ROUTE: (context) => Home(),
        CharacterEditor.ROUTE: (context) => CharacterEditor(),
      },
    );
  }
}
