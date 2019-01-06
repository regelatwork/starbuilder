class AttributeDb {
  static List<SfAttribute> attributes = <SfAttribute>[
    SfAttribute.strength,
    SfAttribute.dexterity,
    SfAttribute.constitution,
    SfAttribute.intelligence,
    SfAttribute.wisdom,
    SfAttribute.charisma
  ];

  static List<SfAttribute> parseCell(String input) {
    if (input[0] == '*') {
      return attributes;
    } else if (input[0] == '[') {
      input = input.substring(1, input.length - 1);
      List<SfAttribute> attributes = <SfAttribute>[];
      for (String attribute in input.split(',')) {
        attributes.add(parse(attribute));
      }
      return attributes;
    } else {
      return <SfAttribute>[parse(input)];
    }
  }

  static SfAttribute parse(String input) {
    try {
      String shortInput = input.substring(0, 3);
      for (SfAttribute attribute in attributes) {
        if (shortInput == attribute.shortName) {
          return attribute;
        }
      }
    } catch (e) {
      throw Exception("Invalid Attribute: " + input);
    }
  }
}

class SfAttribute {
  static SfAttribute strength = SfAttribute("Str", "Strength");
  static SfAttribute dexterity = SfAttribute("Dex", "Dexterity");
  static SfAttribute constitution = SfAttribute("Con", "Constitution");
  static SfAttribute intelligence = SfAttribute("Int", "Intelligence");
  static SfAttribute wisdom = SfAttribute("Wis", "Wisdom");
  static SfAttribute charisma = SfAttribute("Cha", "Charisma");

  final String shortName;
  final String longName;

  SfAttribute(this.shortName, this.longName);

  @override
  String toString() {
    return shortName;
  }
}
