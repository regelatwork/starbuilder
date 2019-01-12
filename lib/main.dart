import 'dart:async';

import 'package:flutter/material.dart';
import 'package:star_builder/character.dart';
import 'package:star_builder/character_editor.dart';
import 'package:star_builder/database_class.dart';
import 'package:star_builder/database_race.dart';
import 'package:star_builder/database_source.dart';
import 'package:star_builder/database_theme.dart';
import 'package:star_builder/home.dart';

Future main() async {
  await SourceDb.loadDatabase();
  await ThemeDb.loadDatabase();
  await RaceDb.loadDatabase();
  await ClassDb.loadDatabase();
  StarfinderCharacter.characters = [
    StarfinderCharacter("Nugget", "Ysoki", "", "Mechanic", "Xenoarchaeologist"),
    StarfinderCharacter("Koggar", "Nuar", "", "Soldier", "Ace Pilot"),
    StarfinderCharacter("Vylit", "Shirren", "", "Mystic", "Ace Pilot"),
    StarfinderCharacter(
        "Duality", "Lashunta", "Damaya", "Technomancer", "Cyberborn"),
  ];
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
