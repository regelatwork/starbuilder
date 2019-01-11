import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:star_builder/character.dart';
import 'package:star_builder/database_theme.dart';
import 'package:star_builder/pdf_generator.dart';

class CharacterEditorBasics extends StatefulWidget {
  @override
  _CharacterEditorBasicsState createState() => _CharacterEditorBasicsState();
}

class _CharacterEditorBasicsState extends State<CharacterEditorBasics> {
  String name = StarfinderCharacter.activeCharacter.name;
  SfTheme theme = StarfinderCharacter.activeCharacter.theme;

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            labelText: "Character Name",
            hintText: name,
          ),
          onSubmitted: _onNameChange,
        ),
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
}
