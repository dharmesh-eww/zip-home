import 'package:flutter/material.dart';

import 'screens/home/cartoon_home.dart';
import 'screens/home/brutalist_home.dart';
import 'screens/home/candy_home.dart';
import 'screens/home/chef_home.dart';
import 'screens/home/detective_home.dart';
import 'screens/home/family_adventure_home.dart';
import 'screens/home/fantasy_quest_home.dart';
import 'screens/home/farm_village_home.dart';
import 'screens/home/kids_toybox_home.dart';
import 'screens/home/luxury_home.dart';
import 'screens/home/minimal_home.dart';
import 'screens/home/nature_home.dart';
import 'screens/home/neon_home.dart';
import 'screens/home/ocean_home.dart';
import 'screens/home/paper_home.dart';
import 'screens/home/retro_home.dart';
import 'screens/home/scifi_home.dart';
import 'screens/home/senior_comfort_home.dart';
import 'screens/home/sports_arena_home.dart';
import 'screens/home/world_tour_home.dart';

void main() => runApp(const ZipPuzzleApp());

class ZipPuzzleApp extends StatelessWidget {
  const ZipPuzzleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zip Puzzle UI Gallery',
      theme: ThemeData(useMaterial3: true),
      home: const DesignGallery(),
    );
  }
}

class DesignGallery extends StatelessWidget {
  const DesignGallery({super.key});

  static const _screens = <Widget>[
    MinimalHome(),
    NeonHome(),
    CartoonHome(),
    LuxuryHome(),
    SciFiHome(),
    NatureHome(),
    RetroHome(),
    PaperHome(),
    BrutalistHome(),
    CandyHome(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(
                    _screens.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: FilledButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => _screens[index],
                          ),
                        ),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text('Home Screen ${index + 1}'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
