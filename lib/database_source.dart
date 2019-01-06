import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

class SourceDb {
  static List<SfSource> sources = <SfSource>[];

  static loadDatabase() async {
    // Read the data from files
    final csvCodec = new CsvCodec();
    String csvData = await rootBundle.loadString('assets/data/sources.csv');
    List<List<dynamic>> rows = csvCodec.decoder.convert(csvData);

    // Populate the theme list
    for(List<dynamic> row in rows) {
      String shortName = row[0];
      String longName = row[1];
      bool hardcover = row[2]=='Y'?true:false;
      String adventurePath = row[3];
      sources.add(SfSource(shortName,longName,hardcover,adventurePath));
    }
  }

  static List<SfSource> parseCell(String input) {
    if(input[0] == '[') {
      input = input.substring(1, input.length-1);
      List<SfSource> sources = <SfSource>[];
      for(String source in input.split(',')) {
        sources.add(SourceDb.parse(source));
      }
      return sources;
    }
    else {
      return <SfSource>[SourceDb.parse(input)];
    }
  }

  static SfSource parse(String input) {
    for(SfSource source in sources) {
      if(input == source.shortName) {
        return source;
      }
    }
    throw Exception("Invalid Source: "+input);
  }
}

class SfSource {
  final String shortName;
  final String longName;
  final bool hardcover;
  final String adventurePath;

  SfSource(this.shortName, this.longName, this.hardcover, this.adventurePath);
}