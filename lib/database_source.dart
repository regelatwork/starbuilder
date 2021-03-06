import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class SourceDb {
  static List<SfSource> sources = <SfSource>[];
  static String assetName = 'assets/data/sources.csv';

  static loadDatabase(AssetBundle assetBundle) async {
    // Read the data from files
    final csvCodec = new CsvCodec();
    String csvData = await assetBundle.loadString(assetName);
    List<List<dynamic>> rows = csvCodec.decoder.convert(csvData);
    rows.removeAt(0);

    // Populate the theme list
    for (List<dynamic> row in rows) {
      String shortName = row[0];
      String longName = row[1];
      bool hardcover = row[2] == 'Y' ? true : false;
      String adventurePath = row[3];
      bool sfs = row[2] == 'Y' ? true : false;
      sources.add(SfSource(shortName, longName, hardcover, adventurePath, sfs));
    }
  }

  static List<SfSource> parseCell(String input) {
    if (input[0] == '[') {
      input = input.substring(1, input.length - 1);
      List<SfSource> sources = <SfSource>[];
      for (String source in input.split(',')) {
        sources.add(SourceDb.parse(source));
      }
      return sources;
    } else {
      return <SfSource>[SourceDb.parse(input)];
    }
  }

  static SfSource parse(String input) {
    for (SfSource source in sources) {
      if (input == source.shortName) {
        return source;
      }
    }
    throw Exception("Invalid Source: " + input);
  }
}

class SfSource {
  final String shortName;
  final String longName;
  final bool hardcover;
  final String adventurePath;
  final bool sfs;

  SfSource(this.shortName, this.longName, this.hardcover, this.adventurePath,
      this.sfs);
}
