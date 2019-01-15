import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:star_builder/character.dart';
import 'package:star_builder/database.dart';
import "package:test/test.dart";

import 'DiskAssetBundle.dart';

final bobString = """
{
  "Basic Info": {
    "Name": "Bob",
    "Race": "Human",
    "BaseClass": "Mystic",
    "Theme": "Colonist"
  }
}
""";

StarfinderCharacter getBob(){
  StarfinderCharacter character = StarfinderCharacter.fromBasicInfo(
      "Bob", "Human", "", "Mystic", "Colonist");
  return character;
}

final dualityString = """
{
  "Basic Info": {
    "Name": "\\"Duality\\"",
    "Race": ["Lashunta", "Damaya"],
    "BaseClass": "Technomancer",
    "Theme": "Cyberborn"
  }
}
""";

StarfinderCharacter getDuality(){
  StarfinderCharacter character = StarfinderCharacter.fromBasicInfo(
      "\"Duality\"", "Lashunta", "Damaya", "Technomancer", "Cyberborn");
  return character;
}

void main() {
  setUp(() async {
    AssetBundle assetBundle =
    await DiskAssetBundle.loadAssets(MainDb.getAssetNames());
    await MainDb.loadDatabaseWithAssetBundle(assetBundle);
  });

  group("Character", () {
    test('Save Test - Bob', () async {
      expect(getBob().save(), jsonEncode(jsonDecode(bobString)));
    });
    test('Load Test - Bob', () async {
      expect(getBob().save(), StarfinderCharacter.load(bobString).save());
    });

    test('Save Test - "Duality"', () async {
      expect(getDuality().save(), jsonEncode(jsonDecode(dualityString)));
    });
    test('Load Test - "Duality"', () async {
      expect(getDuality().save(), StarfinderCharacter.load(dualityString).save());
    });
  });
}
