import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:star_builder/character.dart';
import 'package:star_builder/character_editor_ability_score.dart';
import 'package:star_builder/database_ability.dart';
import 'package:star_builder/database_class.dart';
import 'package:star_builder/database_race.dart';
import 'package:star_builder/database_theme.dart';
import 'package:star_builder/pdf_generator.dart';

class CharacterEditorBasics extends StatefulWidget {
  @override
  _CharacterEditorBasicsState createState() => _CharacterEditorBasicsState();
}

class _CharacterEditorBasicsState extends State<CharacterEditorBasics> {
  String name = StarfinderCharacter.activeCharacter.name;
  SfTheme theme = StarfinderCharacter.activeCharacter.theme;
  SfRace race = StarfinderCharacter.activeCharacter.race;
  SfClass baseClass = StarfinderCharacter.activeCharacter.baseClass;

  void _print() {
    PDFDocument pdf =
        PdfGenerator.generateForCharacter(StarfinderCharacter.activeCharacter);
    Printing.printPdf(document: pdf);
  }

  void _share() {
    PDFDocument pdf =
        PdfGenerator.generateForCharacter(StarfinderCharacter.activeCharacter);
    Printing.sharePdf(document: pdf);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Character Name
          Divider(),
          Text(
            "Character Name",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: name,
            ),
            onSubmitted: _onNameChange,
            // TODO - See if we can make it so that tapping away updates
          ),

          // Themes
          Divider(),
          Text(
            "Theme",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          DropdownButton<SfTheme>(
            value: theme,
            items: ThemeDb.themes.map((SfTheme theme) {
              return DropdownMenuItem<SfTheme>(
                value: theme,
                child: Row(
                  children: <Widget>[
                    Text(theme.name),
                    Text(theme.attributes.toString()),
                  ],
                ),
              );
            }).toList(),
            onChanged: _onThemeChange,
          ),

          // Races
          Divider(),
          Text(
            "Race",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          DropdownButton<String>(
            value: race.name,
            items: RaceDb.racesByName.keys.map((String raceName) {
              return DropdownMenuItem<String>(
                value: raceName,
                child: Row(
                  children: <Widget>[
                    Text(raceName),
                  ],
                ),
              );
            }).toList(),
            onChanged: _onRaceChange,
          ),
          Visibility(
            child: Column(
              children: <Widget>[
                Text(race.division),
                DropdownButton<SfRace>(
                  value: race,
                  items: RaceDb.racesByName[race.name].map((SfRace race) {
                    return DropdownMenuItem<SfRace>(
                      value: race,
                      child: Row(
                        children: <Widget>[
                          Text(race.subname),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: _onRaceDivisionChange,
                ),
              ],
            ),
            // TODO - Make the race correctly track whether this is shown
            visible: race.subname != "",
          ),

          // Base Class
          Divider(),
          Text(
            "Base Class",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          DropdownButton<SfClass>(
            value: baseClass,
            items: ClassDb.classes.map((SfClass baseClass) {
              return DropdownMenuItem<SfClass>(
                value: baseClass,
                child: Row(
                  children: <Widget>[
                    Text(baseClass.name),
                    Text(baseClass.attributes.toString()),
                  ],
                ),
              );
            }).toList(),
            onChanged: _onClasseChange,
          ),
          // 'Class' primary ability score
          Visibility(
            child: Column(
              children: <Widget>[
                Text("Primary Ability Score"),
                DropdownButton<SfAbility>(
                  items: baseClass.attributes.map((SfAbility ability) {
                    return DropdownMenuItem<SfAbility>(
                      value: ability,
                      child: Row(
                        children: <Widget>[
                          Text(ability.longName),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: _onClassPrimaryAbilityChoiceChange,
                ),
              ],
            ),
            // TODO - Make the race correctly track whether this is shown
            visible: baseClass.attributes.length > 1,
          ),

          // Ability Scores
          Divider(),
          Text(
            "Ability Scores",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // 'Human' ability adjustment
          Visibility(
            child: Column(
              children: <Widget>[
                Text("Racial +2 Bonus"),
                DropdownButton<SfAbility>(
                  items: AbilityDb.attributes.map((SfAbility ability) {
                    return DropdownMenuItem<SfAbility>(
                      value: ability,
                      child: Row(
                        children: <Widget>[
                          Text(ability.longName),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: _onRacialAbilityChoiceChange,
                ),
              ],
            ),
            // TODO - Make the race correctly track whether this is shown
            visible: race.name == "Human",
          ),
          // 'Themeless' ability adjustment
          Visibility(
            child: Column(
              children: <Widget>[
                Text("Theme +1 Bonus"),
                DropdownButton<SfAbility>(
                  items: theme.attributes.map((SfAbility ability) {
                    return DropdownMenuItem<SfAbility>(
                      value: ability,
                      child: Row(
                        children: <Widget>[
                          Text(ability.longName),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: _onThemeAbilityChoiceChange,
                ),
              ],
            ),
            // TODO - Make the race correctly track whether this is shown
            visible: theme.attributes.length > 1,
          ),
          CharacterEditorAbilityScore(abilityScore: SfAbility.strength),
          CharacterEditorAbilityScore(abilityScore: SfAbility.dexterity),
          CharacterEditorAbilityScore(abilityScore: SfAbility.constitution),
          CharacterEditorAbilityScore(abilityScore: SfAbility.intelligence),
          CharacterEditorAbilityScore(abilityScore: SfAbility.wisdom),
          CharacterEditorAbilityScore(abilityScore: SfAbility.charisma),

          // Print / Share PDF
          Divider(),
          Text(
            "PDF Options",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          MaterialButton(
            color: Colors.blue,
            child: Text(
              'Print',
            ),
            onPressed: _print,
          ),
          MaterialButton(
            color: Colors.blue,
            child: Text(
              'Share',
            ),
            onPressed: _share,
          ),
        ],
      ),
    );
  }

  void _onNameChange(String newName) {
    if (newName.trim() == "") {
      return;
    }
    StarfinderCharacter.activeCharacter.name = newName;
    setState(() {
      name = newName;
    });
  }

  void _onThemeChange(SfTheme newTheme) {
    StarfinderCharacter.activeCharacter.theme = newTheme;
    setState(() {
      theme = newTheme;
    });
  }

  void _onRaceChange(String newRaceName) {
    SfRace newRace = RaceDb.racesByName[newRaceName][0];
    StarfinderCharacter.activeCharacter.race = newRace;
    setState(() {
      race = newRace;
    });
  }

  void _onRaceDivisionChange(SfRace newRace) {
    StarfinderCharacter.activeCharacter.race = newRace;
    setState(() {
      race = newRace;
    });
  }

  void _onClasseChange(SfClass newBaseClass) {
    StarfinderCharacter.activeCharacter.baseClass = newBaseClass;
    setState(() {
      baseClass = newBaseClass;
    });
  }

  void _onRacialAbilityChoiceChange(SfAbility value) {}

  void _onThemeAbilityChoiceChange(SfAbility value) {}

  void _onClassPrimaryAbilityChoiceChange(SfAbility value) {}
}
