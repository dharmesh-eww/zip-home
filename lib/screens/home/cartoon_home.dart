import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../game_design.dart';
import '../screen_navigation.dart';

class CartoonHome extends StatefulWidget {
  const CartoonHome({super.key});

  @override
  State<CartoonHome> createState() => _CartoonHomeState();
}

class _CartoonHomeState extends State<CartoonHome>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounce;

  @override
  void initState() {
    super.initState();
    _bounce = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffff3c4),
      body: Stack(
        children: [
          const Positioned(
            top: 115,
            left: -30,
            child: _Blob(Color(0x556bdcff), 125),
          ),
          const Positioned(
            top: 300,
            right: -50,
            child: _Blob(Color(0x55ff8fb1), 160),
          ),
          const Positioned(
            bottom: 80,
            left: -60,
            child: _Blob(Color(0x5587e66b), 180),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth > 700 ? 48 : 18,
                  vertical: 14,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 760),
                    child: Column(
                      children: [
                        _header(context),
                        const SizedBox(height: 20),
                        _daily(),
                        const SizedBox(height: 25),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Pick a puzzle!',
                            style: TextStyle(
                              color: Color(0xff263159),
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -.8,
                            ),
                          ),
                        ),
                        const SizedBox(height: 13),
                        _modes(constraints.maxWidth),
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
    );
  }

  Widget _header(BuildContext context) => Row(
    children: [
      AnimatedBuilder(
        animation: _bounce,
        builder: (_, child) => Transform.rotate(
          angle: math.sin(_bounce.value * math.pi * 2) * .04,
          child: child,
        ),
        child: const Text(
          'ZIP\nPUZZLE',
          style: TextStyle(
            color: Color(0xff31457a),
            height: .82,
            fontSize: 29,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.5,
            shadows: [Shadow(color: Colors.white, offset: Offset(2, 2))],
          ),
        ),
      ),
      const Spacer(),
      GestureDetector(
        onTap: () => openGameStatistics(context, GameDesign.cartoon),
        child: _bubbleIcon(Icons.bar_chart_rounded, const Color(0xff5ec8ff)),
      ),
      const SizedBox(width: 9),
      GestureDetector(
        onTap: () => openGameSettings(context, GameDesign.cartoon),
        child: _bubbleIcon(Icons.settings_rounded, const Color(0xffff8e57)),
      ),
    ],
  );

  Widget _bubbleIcon(IconData icon, Color color) => Container(
    width: 47,
    height: 47,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      border: Border.all(color: const Color(0xff263159), width: 2),
      boxShadow: const [
        BoxShadow(color: Color(0xff263159), offset: Offset(3, 4)),
      ],
    ),
    child: Icon(icon, color: Colors.white, size: 22),
  );

  Widget _daily() => AnimatedBuilder(
    animation: _bounce,
    builder: (_, child) => Transform.translate(
      offset: Offset(0, -3 * _bounce.value),
      child: child,
    ),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xffffc83d),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(35),
        ),
        border: Border.all(color: const Color(0xff263159), width: 2.5),
        boxShadow: const [
          BoxShadow(color: Color(0xff263159), offset: Offset(6, 7)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xff263159),
                      width: 2,
                    ),
                  ),
                  child: const Text(
                    '☀ DAILY CHALLENGE',
                    style: TextStyle(
                      color: Color(0xff263159),
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Twist, zip,\nand win!',
                  style: TextStyle(
                    color: Color(0xff263159),
                    fontSize: 30,
                    height: 1,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '🔥 7 day streak   ⭐ +100',
                  style: TextStyle(
                    color: Color(0xff665322),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              const Icon(
                Icons.extension_rounded,
                color: Color(0xfff05c5c),
                size: 61,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff75d65b),
                  foregroundColor: const Color(0xff263159),
                  elevation: 0,
                  side: const BorderSide(color: Color(0xff263159), width: 2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
                  'PLAY!',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  Widget _modes(double width) {
    const modes = [
      ('Easy', '🌱', Color(0xff72d965)),
      ('Medium', '⚡', Color(0xff5ec8ff)),
      ('Hard', '🔥', Color(0xffff6c6c)),
      ('Custom', '🎨', Color(0xffb58aff)),
      ('2 Min!', '⏱', Color(0xffff9f43)),
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: modes.map((mode) {
        final itemWidth = width > 600
            ? (math.min(width, 760) - 24) / 3
            : (width - 48) / 2;
        return SizedBox(
          width: itemWidth,
          height: 105,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: mode.$3,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: const Color(0xff263159), width: 2),
                boxShadow: const [
                  BoxShadow(color: Color(0xff263159), offset: Offset(4, 5)),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(mode.$2, style: const TextStyle(fontSize: 27)),
                  const SizedBox(height: 3),
                  Text(
                    mode.$1,
                    style: const TextStyle(
                      color: Color(0xff263159),
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob(this.color, this.size);
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}
