import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import '../game_design.dart';
import '../screen_navigation.dart';

class CandyHome extends StatefulWidget {
  const CandyHome({super.key});

  @override
  State<CandyHome> createState() => _CandyHomeState();
}

class _CandyHomeState extends State<CandyHome>
    with SingleTickerProviderStateMixin {
  late final AnimationController _float;

  @override
  void initState() {
    super.initState();
    _float = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _float.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xffffd8ec), Color(0xffd8eaff), Color(0xffdfffdc)],
          ),
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _float,
              builder: (_, child) => Positioned(
                top: 90 + _float.value * 24,
                right: -55,
                child: child!,
              ),
              child: _glow(const Color(0xffff79b0), 180),
            ),
            AnimatedBuilder(
              animation: _float,
              builder: (_, child) => Positioned(
                bottom: 100 - _float.value * 20,
                left: -60,
                child: child!,
              ),
              child: _glow(const Color(0xff6cc8ff), 210),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth > 700 ? 48 : 19,
                    vertical: 17,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 780),
                      child: Column(
                        children: [
                          _header(context),
                          const SizedBox(height: 25),
                          _daily(),
                          const SizedBox(height: 28),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'What’s your mood?',
                              style: TextStyle(
                                color: Color(0xff5b4370),
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -.6,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          _moods(constraints.maxWidth),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glow(Color color, double size) => ImageFiltered(
    imageFilter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: .38),
        shape: BoxShape.circle,
      ),
    ),
  );

  Widget _header(BuildContext context) => Row(
    children: [
      Container(
        width: 45,
        height: 45,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffff64aa), Color(0xffa77aff)],
          ),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.bubble_chart_rounded, color: Colors.white),
      ),
      const SizedBox(width: 10),
      const Expanded(
        child: Text(
          'ZIP PUZZLE',
          style: TextStyle(
            color: Color(0xff56396f),
            fontSize: 23,
            fontWeight: FontWeight.w900,
            letterSpacing: -.8,
          ),
        ),
      ),
      GestureDetector(
        onTap: () => openGameStatistics(context, GameDesign.candy),
        child: _glassIcon(Icons.auto_graph_rounded),
      ),
      const SizedBox(width: 8),
      GestureDetector(
        onTap: () => openGameSettings(context, GameDesign.candy),
        child: _glassIcon(Icons.settings_rounded),
      ),
    ],
  );

  Widget _glassIcon(IconData icon) => ClipOval(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        width: 43,
        height: 43,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .42),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: .8)),
        ),
        child: Icon(icon, color: const Color(0xff76588d), size: 20),
      ),
    ),
  );

  Widget _daily() => AnimatedBuilder(
    animation: _float,
    builder: (_, child) => Transform.rotate(
      angle: math.sin(_float.value * math.pi) * .01,
      child: child,
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(36),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .48),
            borderRadius: BorderRadius.circular(36),
            border: Border.all(
              color: Colors.white.withValues(alpha: .9),
              width: 2,
            ),
            boxShadow: const [
              BoxShadow(color: Color(0x22a061b7), blurRadius: 30),
            ],
          ),
          child: Column(
            children: [
              const Row(
                children: [
                  Icon(Icons.stars_rounded, color: Color(0xffff5fa2), size: 19),
                  SizedBox(width: 6),
                  Text(
                    'DAILY DELIGHT',
                    style: TextStyle(
                      color: Color(0xff9a4b83),
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '🔥 7',
                    style: TextStyle(
                      color: Color(0xff76588d),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Icon(
                Icons.extension_rounded,
                color: Color(0xffa77aff),
                size: 62,
              ),
              const SizedBox(height: 7),
              const Text(
                'A sweet little challenge',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff543b69),
                  fontSize: 27,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -.8,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Finish today’s path and collect 120 gems',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xff8b7697), fontSize: 11),
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xffff65aa), Color(0xff9f78ff)],
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x55d663bd),
                      blurRadius: 18,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Let’s play!  ♡',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _moods(double width) {
    const moods = [
      ('Easy', '☺', Color(0xff72dcb5), Color(0xffd9fff0)),
      ('Medium', '✦', Color(0xff65b9ee), Color(0xffdcf3ff)),
      ('Hard', '⚡', Color(0xffff7d95), Color(0xffffdce4)),
      ('Custom', '✎', Color(0xffa77aff), Color(0xffeadfff)),
      ('2 Min', '⏱', Color(0xffffaa55), Color(0xffffebd3)),
    ];
    return Wrap(
      spacing: 11,
      runSpacing: 11,
      children: moods.map((mood) {
        final itemWidth = width > 600
            ? (math.min(width, 780) - 22) / 3
            : (width - 49) / 2;
        return InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(26),
          child: Container(
            width: itemWidth,
            height: 105,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: mood.$4.withValues(alpha: .75),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child: Row(
              children: [
                Text(
                  mood.$2,
                  style: TextStyle(
                    color: mood.$3,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(width: 9),
                Flexible(
                  child: Text(
                    mood.$1,
                    style: const TextStyle(
                      color: Color(0xff614d70),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
