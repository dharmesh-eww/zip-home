import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../game_design.dart';
import '../screen_navigation.dart';

class OceanHome extends StatefulWidget {
  const OceanHome({super.key});
  @override
  State<OceanHome> createState() => _OceanHomeState();
}

class _OceanHomeState extends State<OceanHome>
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
    backgroundColor: const Color(0xff043a55),
    body: Stack(
      children: [
        ...List.generate(
          8,
          (i) => AnimatedBuilder(
            animation: a,
            builder: (context, child) => Positioned(
              left: ((i * 67) % 330).toDouble(),
              top: 100 + ((i * 91 + a.value * 120) % 650),
              child: Container(
                width: 8.0 + i % 3 * 5,
                height: 8.0 + i % 3 * 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0x6688eeff)),
                ),
              ),
            ),
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 740),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.waves_rounded,
                          color: Color(0xff72e0e0),
                          size: 38,
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'ZIP OCEAN',
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
                          () => openGameStatistics(context, GameDesign.ocean),
                        ),
                        const SizedBox(width: 8),
                        _icon(
                          Icons.settings,
                          () => openGameSettings(context, GameDesign.ocean),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Container(
                      width: 310,
                      height: 310,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xffd8ffff),
                        border: Border.all(
                          color: const Color(0xff8d6948),
                          width: 12,
                        ),
                        boxShadow: const [
                          BoxShadow(color: Color(0x6656dce8), blurRadius: 30),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'DAILY DIVE',
                            style: TextStyle(
                              color: Color(0xff007e9e),
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                            ),
                          ),
                          const Icon(
                            Icons.scuba_diving_rounded,
                            color: Color(0xffff8066),
                            size: 53,
                          ),
                          const Text(
                            'Coral Reef\nRescue',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff06435a),
                              fontSize: 28,
                              height: 1,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            '🐢 Save 3 turtles • Streak 7',
                            style: TextStyle(
                              color: Color(0xff397486),
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(height: 11),
                          FilledButton(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xff007e9e),
                            ),
                            child: const Text('DIVE IN'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'CHOOSE YOUR DEPTH',
                      style: TextStyle(
                        color: Color(0xff72e0e0),
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 12,
                      children: List.generate(5, _bubble),
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

  Widget _icon(IconData i, VoidCallback onTap) => InkWell(
    onTap: onTap,
    customBorder: const CircleBorder(),
    child: Container(
      width: 43,
      height: 43,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0x2256dce8),
        border: Border.all(color: const Color(0xff72e0e0)),
      ),
      child: Icon(i, color: const Color(0xff72e0e0), size: 19),
    ),
  );

  Widget _bubble(int i) {
    const n = [
      'Shallow\nEasy',
      'Lagoon\nMedium',
      'Abyss\nHard',
      'My Dive\nCustom',
      '2 Min\nCurrent',
    ];
    const ic = [
      Icons.water,
      Icons.sailing,
      Icons.anchor,
      Icons.tune,
      Icons.timer,
    ];
    return AnimatedBuilder(
      animation: a,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, math.sin(a.value * math.pi * 2 + i) * 5),
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
          borderRadius: BorderRadius.circular(55),
          child: Container(
            width: 108,
            height: 108,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xff46c7d5), Color(0xff087b9c)],
              ),
              border: Border.all(color: const Color(0xffa7ffff), width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(ic[i], color: Colors.white, size: 27),
                Text(
                  n[i],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
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
