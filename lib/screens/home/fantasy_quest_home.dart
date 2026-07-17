import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../game_design.dart';
import '../screen_navigation.dart';

class FantasyQuestHome extends StatefulWidget {
  const FantasyQuestHome({super.key});
  @override
  State<FantasyQuestHome> createState() => _FantasyQuestHomeState();
}

class _FantasyQuestHomeState extends State<FantasyQuestHome>
    with SingleTickerProviderStateMixin {
  late final AnimationController a;
  @override
  void initState() {
    super.initState();
    a = AnimationController(vsync: this, duration: const Duration(seconds: 4))
      ..repeat();
  }

  @override
  void dispose() {
    a.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xff17122d),
    body: Stack(
      children: [
        const Positioned(
          top: 100,
          right: -50,
          child: Icon(Icons.auto_awesome, color: Color(0x226ecfff), size: 180),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.castle_rounded,
                          color: Color(0xffffcf67),
                          size: 38,
                        ),
                        const SizedBox(width: 9),
                        const Expanded(
                          child: Text(
                            'ZIP REALMS',
                            style: TextStyle(
                              color: Color(0xfffff3db),
                              fontFamily: 'serif',
                              fontSize: 24,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        _rune(
                          Icons.bar_chart_rounded,
                          () => openGameStatistics(context, GameDesign.fantasy),
                        ),
                        const SizedBox(width: 8),
                        _rune(
                          Icons.settings,
                          () => openGameSettings(context, GameDesign.fantasy),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xffffcf67), Color(0xff8d62bd)],
                        ),
                        borderRadius: BorderRadius.circular(110),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 27,
                          vertical: 30,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xff2a2048),
                          borderRadius: BorderRadius.circular(106),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'DAILY QUEST',
                              style: TextStyle(
                                color: Color(0xffffcf67),
                                fontSize: 11,
                                letterSpacing: 3,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Icon(
                              Icons.auto_awesome_rounded,
                              color: Color(0xffc998ff),
                              size: 52,
                            ),
                            const Text(
                              'The Golden\nLabyrinth',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xfffff3db),
                                fontFamily: 'serif',
                                fontSize: 31,
                                height: 1.05,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Treasure: 240 crystals  •  Streak VII',
                              style: TextStyle(
                                color: Color(0xffb9aaca),
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(height: 15),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xffffcf67),
                                side: const BorderSide(
                                  color: Color(0xffffcf67),
                                ),
                              ),
                              child: const Text('BEGIN QUEST'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 27),
                    const Text(
                      'CHOOSE A REALM',
                      style: TextStyle(
                        color: Color(0xffc998ff),
                        letterSpacing: 2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 13,
                      runSpacing: 16,
                      children: List.generate(5, _realm),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _rune(IconData i, VoidCallback onTap) => InkWell(
    onTap: onTap,
    customBorder: const CircleBorder(),
    child: Container(
      width: 43,
      height: 43,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xff8d62bd)),
      ),
      child: Icon(i, color: const Color(0xffffcf67), size: 19),
    ),
  );

  Widget _realm(int i) {
    const n = [
      'Meadow\nEasy',
      'Forest\nMedium',
      'Volcano\nHard',
      'Forge\nCustom',
      'Time Rift\n2 Min',
    ];
    const ic = [
      Icons.grass,
      Icons.forest,
      Icons.local_fire_department,
      Icons.construction,
      Icons.hourglass_bottom,
    ];
    return AnimatedBuilder(
      animation: a,
      builder: (_, child) => Transform.rotate(
        angle: math.sin(a.value * math.pi * 2 + i) * .025,
        child: Transform.scale(
          scale: 1 + math.sin(a.value * math.pi * 2 + i) * .025,
          child: child,
        ),
      ),
      child: Semantics(
        button: true,
        label: n[i].replaceAll('\n', ' '),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(60),
          child: Container(
            width: 116,
            height: 116,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xff2a2048),
              border: Border.all(
                color: i == 4
                    ? const Color(0xffffcf67)
                    : const Color(0xff7956a3),
                width: 2,
              ),
              boxShadow: const [
                BoxShadow(color: Color(0x448d62bd), blurRadius: 16),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(ic[i], color: const Color(0xffffcf67), size: 28),
                const SizedBox(height: 5),
                Text(
                  n[i],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xfffff3db),
                    fontFamily: 'serif',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
