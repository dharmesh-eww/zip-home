import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../game_design.dart';
import '../screen_navigation.dart';

class PaperHome extends StatelessWidget {
  const PaperHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0e8d8),
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _PaperPainter())),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth > 700 ? 50 : 20,
                  vertical: 18,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 760),
                    child: Column(
                      children: [
                        _header(context),
                        const SizedBox(height: 28),
                        _daily(),
                        const SizedBox(height: 29),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Choose a page',
                            style: TextStyle(
                              color: Color(0xff33312d),
                              fontFamily: 'serif',
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const SizedBox(height: 13),
                        _notes(constraints.maxWidth),
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
      Transform.rotate(
        angle: -.05,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: const Color(0xffffdf70),
          child: const Text(
            'ZIP PUZZLE',
            style: TextStyle(
              color: Color(0xff252525),
              fontWeight: FontWeight.w900,
              fontSize: 20,
              letterSpacing: -.5,
            ),
          ),
        ),
      ),
      const Spacer(),
      GestureDetector(
        onTap: () => openGameStatistics(context, GameDesign.paper),
        child: _paperIcon(Icons.bar_chart_rounded, const Color(0xff72a8a1)),
      ),
      const SizedBox(width: 9),
      GestureDetector(
        onTap: () => openGameSettings(context, GameDesign.paper),
        child: _paperIcon(Icons.settings_outlined, const Color(0xffde806b)),
      ),
    ],
  );

  Widget _paperIcon(IconData icon, Color color) => Container(
    width: 42,
    height: 42,
    decoration: BoxDecoration(
      color: const Color(0xfffffcf3),
      border: Border.all(color: const Color(0xff393631), width: 1.5),
      boxShadow: const [
        BoxShadow(color: Color(0x44393631), offset: Offset(3, 3)),
      ],
    ),
    child: Icon(icon, color: color, size: 20),
  );

  Widget _daily() => Transform.rotate(
    angle: .015,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 25, 22, 21),
      decoration: BoxDecoration(
        color: const Color(0xfffffcf3),
        border: Border.all(color: const Color(0xff38342f), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3338342f),
            blurRadius: 2,
            offset: Offset(7, 9),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -38,
            left: 35,
            child: Transform.rotate(
              angle: -.08,
              child: Container(
                width: 78,
                height: 22,
                color: const Color(0xaaf2c66d),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'DAILY CHALLENGE',
                style: TextStyle(
                  color: Color(0xffdf6c58),
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.3,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 12),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Draw one\nperfect line.',
                      style: TextStyle(
                        color: Color(0xff2f2d29),
                        fontFamily: 'serif',
                        fontWeight: FontWeight.w700,
                        fontSize: 29,
                        height: 1.06,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.gesture_rounded,
                    color: Color(0xff72a8a1),
                    size: 64,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Streak: 7  •  Reward: ★ 120',
                    style: TextStyle(
                      color: Color(0xff777067),
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xffdd735e),
                      shape: const RoundedRectangleBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      'PLAY NOW →',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );

  Widget _notes(double width) {
    const notes = [
      ('Easy', 'Take it slow', Color(0xffffdf70), -.025),
      ('Medium', 'A clever turn', Color(0xff9bc9c0), .02),
      ('Hard', 'No erasers!', Color(0xffef9a88), -.015),
      ('Custom', 'Make a puzzle', Color(0xffb8aad5), .025),
      ('Challenge', '2 minute dash', Color(0xfff2b96d), -.02),
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 15,
      children: notes.map((note) {
        final itemWidth = width > 600
            ? (math.min(width, 760) - 24) / 3
            : (width - 52) / 2;
        return Transform.rotate(
          angle: note.$4,
          child: InkWell(
            onTap: () {},
            child: Container(
              width: itemWidth,
              height: 112,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: note.$3,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x30393631),
                    blurRadius: 3,
                    offset: Offset(4, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    note.$1,
                    style: const TextStyle(
                      color: Color(0xff302e2a),
                      fontWeight: FontWeight.w900,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    note.$2,
                    style: const TextStyle(
                      color: Color(0xff625e57),
                      fontFamily: 'serif',
                      fontStyle: FontStyle.italic,
                      fontSize: 11,
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

class _PaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x183b5e83)
      ..strokeWidth = 1;
    for (double y = 42; y < size.height; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    final margin = Paint()
      ..color = const Color(0x28dd735e)
      ..strokeWidth = 1;
    canvas.drawLine(const Offset(38, 0), Offset(38, size.height), margin);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
