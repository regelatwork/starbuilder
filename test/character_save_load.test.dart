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
  },
  "Base Ability Scores": {
    "Str": 12,
    "Dex": 12,
    "Con": 12,
    "Int": 12,
    "Wis": 13,
    "Cha": 12
  }
}
""";

StarfinderCharacter getBob(){
  StarfinderCharacter character = StarfinderCharacter.fromBasicInfo(
      "Bob", "Human", "", "Mystic", "Colonist");
  character.setAbilities([12, 12, 12, 12, 13, 12]);
  return character;
}

final dualityString = """
{
  "Basic Info": {
    "Name": "\\"Duality\\"",
    "Race": ["Lashunta", "Damaya"],
    "BaseClass": "Technomancer",
    "Theme": "Cyberborn"
  },
  "Base Ability Scores": {
    "Str": 10,
    "Dex": 14,
    "Con": 8,
    "Int": 18,
    "Wis": 10,
    "Cha": 13
  }
}
""";

StarfinderCharacter getDuality(){
  StarfinderCharacter character = StarfinderCharacter.fromBasicInfo(
      "\"Duality\"", "Lashunta", "Damaya", "Technomancer", "Cyberborn");
  character.setAbilities([10,14,8,18,10,13]);
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
