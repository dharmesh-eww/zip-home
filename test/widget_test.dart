import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/main.dart';
import 'package:app/screens/game_design.dart';
import 'package:app/screens/home/chef_home.dart';
import 'package:app/screens/home/detective_home.dart';
import 'package:app/screens/home/family_adventure_home.dart';
import 'package:app/screens/home/fantasy_quest_home.dart';
import 'package:app/screens/home/farm_village_home.dart';
import 'package:app/screens/home/kids_toybox_home.dart';
import 'package:app/screens/home/ocean_home.dart';
import 'package:app/screens/home/senior_comfort_home.dart';
import 'package:app/screens/home/sports_arena_home.dart';
import 'package:app/screens/home/world_tour_home.dart';
import 'package:app/screens/settings/game_settings_screen.dart';
import 'package:app/screens/statistic/game_statistic_screen.dart';

void main() {
  testWidgets('opens a selected home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ZipPuzzleApp());

    expect(find.text('Home Screen 1'), findsOneWidget);
    expect(find.text('Home Screen 5'), findsOneWidget);

    await tester.tap(find.text('Home Screen 1'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('ZIP PUZZLE'), findsOneWidget);
    expect(find.text('Daily Challenge'), findsNothing);
    expect(find.text('DAILY CHALLENGE'), findsOneWidget);
  });

  testWidgets('all distinct game styles render', (WidgetTester tester) async {
    const screens = <Widget>[
      FamilyAdventureHome(),
      KidsToyboxHome(),
      SeniorComfortHome(),
      SportsArenaHome(),
      FantasyQuestHome(),
      FarmVillageHome(),
      DetectiveHome(),
      OceanHome(),
      ChefHome(),
      WorldTourHome(),
    ];

    for (final screen in screens) {
      await tester.pumpWidget(MaterialApp(home: screen));
      await tester.pump(const Duration(milliseconds: 100));
      expect(
        tester.takeException(),
        isNull,
        reason: '${screen.runtimeType} should render without overflow',
      );
    }
  });

  testWidgets('all matching settings and statistics screens render', (
    WidgetTester tester,
  ) async {
    for (final design in GameDesign.values) {
      await tester.pumpWidget(
        MaterialApp(home: GameSettingsScreen(design: design)),
      );
      await tester.pump(const Duration(milliseconds: 50));
      expect(
        tester.takeException(),
        isNull,
        reason: '${design.name} settings should render',
      );

      await tester.pumpWidget(
        MaterialApp(home: GameStatisticScreen(design: design)),
      );
      await tester.pump(const Duration(milliseconds: 50));
      expect(
        tester.takeException(),
        isNull,
        reason: '${design.name} statistics should render',
      );
    }
  });

  testWidgets('settings and difficulty statistics are selectable', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: GameSettingsScreen(design: GameDesign.minimal)),
    );
    await tester.tap(find.text('Dark'));
    await tester.pump();
    await tester.tap(find.bySemanticsLabel('Path gradient 3'));
    await tester.pump();
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(
      const MaterialApp(home: GameStatisticScreen(design: GameDesign.minimal)),
    );
    await tester.tap(find.text('Hard'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('49 of 76 puzzles won'), findsOneWidget);
  });
}
