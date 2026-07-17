import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../game_design.dart';
import '../screen_navigation.dart';

class WorldTourHome extends StatefulWidget {
  const WorldTourHome({super.key});
  @override
  State<WorldTourHome> createState() => _WorldTourHomeState();
}

class _WorldTourHomeState extends State<WorldTourHome>
    with SingleTickerProviderStateMixin {
  late final AnimationController a;
  @override
  void initState() {
    super.initState();
    a = AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..repeat();
  }

  @override
  void dispose() {
    a.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xffe6ecdd),
    body: Stack(
      children: [
        const Positioned(
          top: 100,
          right: -45,
          child: Icon(Icons.public, color: Color(0x15176b74), size: 230),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(19),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 780),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: const Color(0xff176b74),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: const Icon(
                            Icons.flight_takeoff,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'ZIP JOURNEY',
                            style: TextStyle(
                              color: Color(0xff233c43),
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        _icon(
                          Icons.bar_chart,
                          () => openGameStatistics(context, GameDesign.world),
                        ),
                        const SizedBox(width: 8),
                        _icon(
                          Icons.settings,
                          () => openGameSettings(context, GameDesign.world),
                        ),
                      ],
                    ),
                    const SizedBox(height: 23),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xfffffcf2),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x30233c43),
                            blurRadius: 18,
                            offset: Offset(0, 9),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 12,
                            ),
                            decoration: const BoxDecoration(
                              color: Color(0xffdf6548),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(18),
                              ),
                            ),
                            child: const Row(
                              children: [
                                Text(
                                  'DAILY BOARDING PASS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.qr_code, color: Colors.white),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'DESTINATION',
                                        style: TextStyle(
                                          color: Color(0xff7c8c89),
                                          fontSize: 9,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                      Text(
                                        'KYOTO',
                                        style: TextStyle(
                                          color: Color(0xff233c43),
                                          fontSize: 34,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                      Text(
                                        'Puzzle ZP-0717  •  Streak 7',
                                        style: TextStyle(
                                          color: Color(0xff657a7c),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    const Icon(
                                      Icons.temple_buddhist_rounded,
                                      color: Color(0xffdf6548),
                                      size: 52,
                                    ),
                                    FilledButton(
                                      onPressed: () {},
                                      style: FilledButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xff176b74,
                                        ),
                                      ),
                                      child: const Text('BOARD'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 26),
                    const Row(
                      children: [
                        Text(
                          'CHOOSE A ROUTE',
                          style: TextStyle(
                            color: Color(0xff233c43),
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Expanded(
                          child: Divider(indent: 12, color: Color(0xff176b74)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    ...List.generate(5, _ticket),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _icon(IconData i, VoidCallback onTap) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(9),
    child: Container(
      width: 43,
      height: 43,
      decoration: BoxDecoration(
        color: const Color(0xfffffcf2),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Icon(i, color: const Color(0xff176b74), size: 20),
    ),
  );

  Widget _ticket(int i) {
    const n = [
      'LOCAL / EASY',
      'REGIONAL / MEDIUM',
      'EXPRESS / HARD',
      'PRIVATE / CUSTOM',
      'RACE / 2 MIN',
    ];
    const code = ['EZ 101', 'MD 202', 'HD 303', 'CU 404', 'TM 205'];
    return AnimatedBuilder(
      animation: a,
      builder: (_, child) => Transform.translate(
        offset: Offset(math.sin(a.value * math.pi * 2 + i) * 4, 0),
        child: child,
      ),
      child: Semantics(
        button: true,
        label: '${n[i]} difficulty',
        child: InkWell(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: const Color(0xfffffcf2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xffb9c5b4)),
            ),
            child: Row(
              children: [
                Container(
                  width: 55,
                  height: 69,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xff176b74),
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(9),
                    ),
                  ),
                  child: const RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      'ZIP AIR',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        n[i],
                        style: const TextStyle(
                          color: Color(0xff233c43),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        code[i],
                        style: const TextStyle(
                          color: Color(0xffdf6548),
                          fontSize: 10,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.flight_rounded, color: Color(0xffdf6548)),
                const SizedBox(width: 14),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
