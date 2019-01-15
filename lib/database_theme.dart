import 'dart:core';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:star_builder/database_ability.dart';
import 'package:star_builder/database_source.dart';

class ThemeDb {
  static List<SfTheme> themes = <SfTheme>[];
  static Map<String, SfTheme> map = new Map();
  static String assetName = 'assets/data/themes.csv';

  static loadDatabase(AssetBundle assetBundle) async {
    // Read the data from files
    final csvCodec = new CsvCodec();
    String csvData = await assetBundle.loadString(assetName);
    List<List<dynamic>> rows = csvCodec.decoder.convert(csvData);
    rows.removeAt(0);

    // Populate the theme list
    for (List<dynamic> row in rows) {
      String name = row[0];
      List<SfAbility> attributes = AttributeDb.parseCell(row[1]);
      List<String> skills = <String>[];
      List<SfSource> sources = SourceDb.parseCell(row[3]);
      SfTheme theme = SfTheme(name, attributes, skills, sources);
      themes.add(theme);
      map.putIfAbsent(name, () => theme);
    }
  }

  static SfTheme getTheme(String theme) {
    return map[theme];
  }
}

class SfTheme {
  final String name;
  final List<SfAbility> attributes;
  final List<String> skills;
  final List<SfSource> sources;

  SfTheme(this.name, this.attributes, this.skills, this.sources);
}
