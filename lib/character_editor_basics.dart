import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:star_builder/character.dart';
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
          TextField(
            decoration: InputDecoration(
              labelText: "Character Name",
              hintText: name,
            ),
            onSubmitted: _onNameChange,
            // TODO - See if we can make it so that tapping away updates
          ),

          // Theme
          Text("Theme"),
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

          // Race
          Text("Race"),
          DropdownButton<SfRace>(
            value: race,
            items: RaceDb.races.map((SfRace race) {
              return DropdownMenuItem<SfRace>(
                value: race,
                child: Row(
                  children: <Widget>[
                    Text(race.name),
                  ],
                ),
              );
            }).toList(),
            onChanged: _onRaceChange,
          ),

          // Print / Share PDF
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

  void _onRaceChange(SfRace newRace) {
    StarfinderCharacter.activeCharacter.race = newRace;
    setState(() {
      race = newRace;
    });
  }
}
