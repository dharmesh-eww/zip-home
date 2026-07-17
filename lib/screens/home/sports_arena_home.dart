import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../game_design.dart';
import '../screen_navigation.dart';

class SportsArenaHome extends StatefulWidget {
  const SportsArenaHome({super.key});
  @override
  State<SportsArenaHome> createState() => _SportsArenaHomeState();
}

class _SportsArenaHomeState extends State<SportsArenaHome>
    with SingleTickerProviderStateMixin {
  late final AnimationController a;
  @override
  void initState() {
    super.initState();
    a = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    a.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xff071a11),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 780),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: const Color(0xffb8f13b),
                      child: const Icon(
                        Icons.sports_score,
                        color: Color(0xff071a11),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'ZIP LEAGUE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    _icon(
                      Icons.bar_chart,
                      () => openGameStatistics(context, GameDesign.sports),
                    ),
                    const SizedBox(width: 8),
                    _icon(
                      Icons.settings,
                      () => openGameSettings(context, GameDesign.sports),
                    ),
                  ],
                ),
                const SizedBox(height: 19),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff102d1d),
                    border: Border.all(
                      color: const Color(0xff376344),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 9,
                        ),
                        color: const Color(0xffb8f13b),
                        child: const Row(
                          children: [
                            Text(
                              'DAILY MATCH',
                              style: TextStyle(
                                color: Color(0xff071a11),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'LIVE',
                              style: TextStyle(
                                color: Color(0xffe14727),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'BRAIN\nVS GRID',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 31,
                                      height: .9,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(height: 9),
                                  Text(
                                    'SEASON STREAK  07',
                                    style: TextStyle(
                                      color: Color(0xff93b89e),
                                      fontSize: 10,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                const Text(
                                  '500',
                                  style: TextStyle(
                                    color: Color(0xffb8f13b),
                                    fontSize: 35,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const Text(
                                  'POINTS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                  ),
                                ),
                                const SizedBox(height: 9),
                                FilledButton(
                                  onPressed: () {},
                                  style: FilledButton.styleFrom(
                                    backgroundColor: const Color(0xffff6a2a),
                                    shape: const RoundedRectangleBorder(),
                                  ),
                                  child: const Text('KICK OFF'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Row(
                  children: [
                    Text(
                      'TRAINING DRILLS',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.speed, color: Color(0xffb8f13b)),
                  ],
                ),
                const SizedBox(height: 12),
                ...List.generate(5, _drill),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget _icon(IconData i, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffb8f13b)),
      ),
      child: Icon(i, color: const Color(0xffb8f13b), size: 20),
    ),
  );

  Widget _drill(int i) {
    const n = [
      'WARM-UP / EASY',
      'TRAINING / MEDIUM',
      'PRO / HARD',
      'CUSTOM DRILL',
      '2 MINUTE SPRINT',
    ];
    const v = [.3, .48, .7, .58, .9];
    return AnimatedBuilder(
      animation: a,
      builder: (_, child) => Transform.translate(
        offset: Offset(math.sin(a.value * math.pi * 2 + i) * 3, 0),
        child: child,
      ),
      child: Semantics(
        button: true,
        label: '${n[i]} difficulty',
        child: InkWell(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.only(bottom: 9),
            padding: const EdgeInsets.all(15),
            color: const Color(0xff102d1d),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '0${i + 1}',
                      style: const TextStyle(
                        color: Color(0xffff6a2a),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Text(
                        n[i],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const Icon(Icons.play_arrow, color: Color(0xffb8f13b)),
                  ],
                ),
                const SizedBox(height: 9),
                AnimatedBuilder(
                  animation: a,
                  builder: (context, child) => LinearProgressIndicator(
                    value: math.min(1, v[i] + a.value * .05),
                    minHeight: 4,
                    backgroundColor: const Color(0xff285039),
                    color: const Color(0xffb8f13b),
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
