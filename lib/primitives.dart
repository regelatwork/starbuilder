class Attributes {
  static const List<Attribute> attributes = <Attribute>[
    Attribute.Strength,
    Attribute.Dexterity,
    Attribute.Constitution,
    Attribute.Intelligence,
    Attribute.Wisdom,
    Attribute.Charisma
  ];

  static List<Attribute> parseCell(String input) {
    if (input[0] == '*'){
      return Attributes.attributes;
    }
    else if(input[0] == '[') {
      input = input.substring(1, input.length-2);
      List<Attribute> attributes = <Attribute>[];
      for(String attribute in input.split(',')) {
        attributes.add(Attributes.parse(attribute));
      }
      return attributes;
    }
    else {
      return <Attribute>[Attributes.parse(input)];
    }
  }

  static Attribute parse(String input) {
    String shortInput = input.toLowerCase().substring(0, 3);
    if (shortInput == 'str') {
      return Attribute.Strength;
    } else if (shortInput == 'dex') {
      return Attribute.Dexterity;
    } else if (shortInput == 'con') {
      return Attribute.Constitution;
    } else if (shortInput == 'int') {
      return Attribute.Intelligence;
    } else if (shortInput == 'wis') {
      return Attribute.Wisdom;
    } else if (shortInput == 'cha') {
      return Attribute.Charisma;
    }
  }

  static String render(Attribute attribute) {
    if (attribute == Attribute.Strength) {
      return 'Strength';
    } else if (attribute == Attribute.Dexterity) {
      return 'Dexterity';
    } else if (attribute == Attribute.Constitution) {
      return 'Constitution';
    } else if (attribute == Attribute.Intelligence) {
      return 'Intelligence';
    } else if (attribute == Attribute.Wisdom) {
      return 'Wisdom';
    } else if (attribute == Attribute.Charisma) {
      return 'Charisma';
    }
  }

  static String renderShort(Attribute attribute) {
    if (attribute == Attribute.Strength) {
      return 'Str';
    } else if (attribute == Attribute.Dexterity) {
      return 'Dex';
    } else if (attribute == Attribute.Constitution) {
      return 'Con';
    } else if (attribute == Attribute.Intelligence) {
      return 'Int';
    } else if (attribute == Attribute.Wisdom) {
      return 'Wis';
    } else if (attribute == Attribute.Charisma) {
      return 'Cha';
    }
  }
}

enum Attribute {
  Strength,
  Dexterity,
  Constitution,
  Intelligence,
  Wisdom,
  Charisma
}

enum Source {
  CRB, // Starfinder (Core Rulebook)
  PW, // Pact Worlds
  ARM, // Armory
  AA, // Alien Archive
  AA2, // Alien Archive 2
  AP1, // Dead Suns
  AP2, // Dead Suns
  AP3, // Dead Suns
  AP4, // Dead Suns
  AP5, // Dead Suns
  AP6, // Dead Suns
  AP7, // Against the Aeon Throne
  AP8, // Against the Aeon Throne
  AP9, // Against the Aeon Throne
  AP10, // Signal of Screams
  AP11, // Signal of Screams
  AP12, // Signal of Screams
  AP13, // Dawn of Flame
  AP14, // Dawn of Flame
  AP15, // Dawn of Flame
  AP16, // Dawn of Flame
  AP17, // Dawn of Flame
  AP18, // Dawn of Flame
  AP19, // Attack of the Swarm
  AP20, // Attack of the Swarm
  AP21, // Attack of the Swarm
  AP22, // Attack of the Swarm
  AP23, // Attack of the Swarm
  AP24 // Attack of the Swarm
}
