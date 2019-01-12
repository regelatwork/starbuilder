import 'dart:core';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

class RaceDb {
  static List<SfRace> races = <SfRace>[];
  static Map<String, List<SfRace>> racesByName = new Map();
  static Map<String, SfRace> racesBySubname = new Map();

  static loadDatabase() async {
    // Read the data from files
    final csvCodec = new CsvCodec();
    String csvData = await rootBundle.loadString('assets/data/races.csv');
    List<List<dynamic>> rows = csvCodec.decoder.convert(csvData);
    rows.removeAt(0);

    // Populate the race list
    for (List<dynamic> row in rows) {
      String name = row[0];
      String subname = row[2];
      SfRace race = SfRace(name, subname);
      races.add(race);
      racesByName.putIfAbsent(name, () => <SfRace>[]);
      racesByName[name].add(race);
      racesBySubname.putIfAbsent(name+subname, () => race);
    }
  }

  static List<SfRace> getRaces(String name) {
    return racesByName[name];
  }

  static SfRace getRace(String name, String subname) {
    return racesBySubname[name+subname];
  }
}

class SfRace {
  final String name;
  final String subname;

  SfRace(this.name, this.subname);
}
