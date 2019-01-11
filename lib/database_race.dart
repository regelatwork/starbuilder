import 'dart:core';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

class RaceDb {
  static List<SfRace> races = <SfRace>[];
  static Map<String, SfRace> map = new Map();

  static loadDatabase() async {
    // Read the data from files
    final csvCodec = new CsvCodec();
    String csvData = await rootBundle.loadString('assets/data/races.csv');
    List<List<dynamic>> rows = csvCodec.decoder.convert(csvData);
    rows.removeAt(0);

    // Populate the race list
    for (List<dynamic> row in rows) {
      String name = row[0];
      SfRace race = SfRace(name);
      races.add(race);
      map.putIfAbsent(name, () => race);
    }
  }

  static SfRace getRace(String race) {
    return map[race];
  }
}

class SfRace {
  final String name;

  SfRace(this.name);
}
