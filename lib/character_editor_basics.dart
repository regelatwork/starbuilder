import 'package:flutter/material.dart';
import 'package:star_builder/character.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:star_builder/database_theme.dart';
import 'package:star_builder/pdf_generator.dart';

class CharacterEditorBasics extends StatefulWidget {
  @override
  _CharacterEditorBasicsState createState() => _CharacterEditorBasicsState();
}

class _CharacterEditorBasicsState extends State<CharacterEditorBasics> {
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
          onSubmitted: _onNameChange,
        ),
        DropdownButton<SfTheme>(
          items: ThemeDb.themes.map((SfTheme theme) {
            return DropdownMenuItem<SfTheme>(value: theme, child: Text(theme.name));
          }).toList(),
          onChanged: (SfTheme value) {},
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

  void _onNameChange(String newValue) {
    if (newValue.trim() == "") {
      return;
    }
    StarfinderCharacter.activeCharacter.name = newValue;
  }

  void _onNameEditComplete() {}
}
