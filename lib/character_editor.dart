import 'package:flutter/material.dart';
import 'package:star_builder/character.dart';
import 'package:star_builder/character_editor_basics.dart';

class CharacterEditor extends StatefulWidget {
  static const String ROUTE = "char/";
  final String title = StarfinderCharacter.activeCharacter.name;

  @override
  _CharacterEditorState createState() => _CharacterEditorState();
}

class _CharacterEditorState extends State<CharacterEditor>
    with SingleTickerProviderStateMixin {
  final List<String> tabTitles = <String>["One", "Two"];//, "Three", "Four", "Five"];

  final List<Tab> myTabs = <Tab>[
    Tab(text: '1'),
    Tab(text: '2'),
//    Tab(text: '3'),
//    Tab(text: '4'),
//    Tab(text: '5'),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabTitles.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs.map((CharacterEditorTab characterEditorTab) {
            return Tab(text: characterEditorTab.title);
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((CharacterEditorTab characterEditorTab) {
          return characterEditorTab.widget;
        }).toList(),
      ),
    );
  }
}

class CharacterEditorTab {
  const CharacterEditorTab({this.title, this.widget});

  final String title;
  final Widget widget;
}

List<CharacterEditorTab> tabs = <CharacterEditorTab>[
  CharacterEditorTab(title: "Basics", widget: CharacterEditorBasics()),
  CharacterEditorTab(title: "Classes", widget: Text("Classic!")),
//  CharacterEditorTab(title: "Feats", widget: null),
//  CharacterEditorTab(title: "Spells", widget: null),
//  CharacterEditorTab(title: "Equipment", widget: null),
];
