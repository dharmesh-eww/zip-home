import 'package:flutter/material.dart';
import 'game_design.dart';
import 'settings/settings_screens.dart';
import 'statistic/statistic_screens.dart';

void openGameSettings(BuildContext context, GameDesign design) {
  Navigator.of(
    context,
  ).push(MaterialPageRoute<void>(builder: (_) => _settingsScreen(design)));
}

void openGameStatistics(BuildContext context, GameDesign design) {
  Navigator.of(
    context,
  ).push(MaterialPageRoute<void>(builder: (_) => _statisticScreen(design)));
}

Widget _settingsScreen(GameDesign design) => switch (design) {
  GameDesign.minimal => const MinimalSettingsScreen(),
  GameDesign.neon => const NeonSettingsScreen(),
  GameDesign.cartoon => const CartoonSettingsScreen(),
  GameDesign.luxury => const LuxurySettingsScreen(),
  GameDesign.scifi => const SciFiSettingsScreen(),
  GameDesign.nature => const NatureSettingsScreen(),
  GameDesign.retro => const RetroSettingsScreen(),
  GameDesign.paper => const PaperSettingsScreen(),
  GameDesign.brutalist => const BrutalistSettingsScreen(),
  GameDesign.candy => const CandySettingsScreen(),
  GameDesign.family => const FamilySettingsScreen(),
  GameDesign.kids => const KidsSettingsScreen(),
  GameDesign.senior => const SeniorSettingsScreen(),
  GameDesign.sports => const SportsSettingsScreen(),
  GameDesign.fantasy => const FantasySettingsScreen(),
  GameDesign.farm => const FarmSettingsScreen(),
  GameDesign.detective => const DetectiveSettingsScreen(),
  GameDesign.ocean => const OceanSettingsScreen(),
  GameDesign.chef => const ChefSettingsScreen(),
  GameDesign.world => const WorldSettingsScreen(),
};

Widget _statisticScreen(GameDesign design) => switch (design) {
  GameDesign.minimal => const MinimalStatisticScreen(),
  GameDesign.neon => const NeonStatisticScreen(),
  GameDesign.cartoon => const CartoonStatisticScreen(),
  GameDesign.luxury => const LuxuryStatisticScreen(),
  GameDesign.scifi => const SciFiStatisticScreen(),
  GameDesign.nature => const NatureStatisticScreen(),
  GameDesign.retro => const RetroStatisticScreen(),
  GameDesign.paper => const PaperStatisticScreen(),
  GameDesign.brutalist => const BrutalistStatisticScreen(),
  GameDesign.candy => const CandyStatisticScreen(),
  GameDesign.family => const FamilyStatisticScreen(),
  GameDesign.kids => const KidsStatisticScreen(),
  GameDesign.senior => const SeniorStatisticScreen(),
  GameDesign.sports => const SportsStatisticScreen(),
  GameDesign.fantasy => const FantasyStatisticScreen(),
  GameDesign.farm => const FarmStatisticScreen(),
  GameDesign.detective => const DetectiveStatisticScreen(),
  GameDesign.ocean => const OceanStatisticScreen(),
  GameDesign.chef => const ChefStatisticScreen(),
  GameDesign.world => const WorldStatisticScreen(),
};
