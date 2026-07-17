import 'package:flutter/material.dart';
import '../game_design.dart';
import '../screen_navigation.dart';

class RetroHome extends StatefulWidget {
  const RetroHome({super.key});

  @override
  State<RetroHome> createState() => _RetroHomeState();
}

class _RetroHomeState extends State<RetroHome>
    with SingleTickerProviderStateMixin {
  late final AnimationController _blink;

  @override
  void initState() {
    super.initState();
    _blink = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _blink.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff24113f),
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _ScanlinePainter())),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth > 700 ? 48 : 16,
                  vertical: 15,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 740),
                    child: Column(
                      children: [
                        _scoreBar(context),
                        const SizedBox(height: 21),
                        const Text(
                          'ZIP PUZZLE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xffffe66d),
                            fontFamily: 'monospace',
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            shadows: [
                              Shadow(
                                color: Color(0xffff4fa3),
                                offset: Offset(4, 4),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          '★ ARCADE EDITION ★',
                          style: TextStyle(
                            color: Color(0xff69f6ff),
                            fontFamily: 'monospace',
                            fontSize: 10,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _daily(),
                        const SizedBox(height: 23),
                        AnimatedBuilder(
                          animation: _blink,
                          builder: (_, child) => Opacity(
                            opacity: .45 + _blink.value * .55,
                            child: child,
                          ),
                          child: const Text(
                            '— SELECT LEVEL —',
                            style: TextStyle(
                              color: Color(0xff69f6ff),
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 13),
                        _levels(),
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

  Widget _scoreBar(BuildContext context) => Row(
    children: [
      const Expanded(
        child: Text(
          'HI-SCORE  04200',
          style: TextStyle(
            color: Color(0xffff8b3d),
            fontFamily: 'monospace',
            fontSize: 10,
          ),
        ),
      ),
      GestureDetector(
        onTap: () => openGameStatistics(context, GameDesign.retro),
        child: _pixelIcon(Icons.bar_chart, const Color(0xff69f6ff)),
      ),
      const SizedBox(width: 8),
      GestureDetector(
        onTap: () => openGameSettings(context, GameDesign.retro),
        child: _pixelIcon(Icons.settings, const Color(0xffff4fa3)),
      ),
    ],
  );

  Widget _pixelIcon(IconData icon, Color color) => Container(
    width: 39,
    height: 36,
    decoration: BoxDecoration(
      color: const Color(0xff341b58),
      border: Border.all(color: color, width: 2),
      boxShadow: [BoxShadow(color: color, offset: const Offset(3, 3))],
    ),
    child: Icon(icon, color: color, size: 18),
  );

  Widget _daily() => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(19),
    decoration: BoxDecoration(
      color: const Color(0xff36185d),
      border: Border.all(color: const Color(0xffff4fa3), width: 3),
      boxShadow: const [
        BoxShadow(color: Color(0xffff8b3d), offset: Offset(7, 7)),
      ],
    ),
    child: Column(
      children: [
        const Row(
          children: [
            Text('◆', style: TextStyle(color: Color(0xffffe66d))),
            Expanded(
              child: Text(
                ' DAILY CHALLENGE ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            Text('◆', style: TextStyle(color: Color(0xffffe66d))),
          ],
        ),
        const SizedBox(height: 17),
        const Icon(
          Icons.videogame_asset_rounded,
          color: Color(0xff69f6ff),
          size: 48,
        ),
        const SizedBox(height: 10),
        const Text(
          'CONNECT ALL NODES!',
          style: TextStyle(
            color: Color(0xffffe66d),
            fontFamily: 'monospace',
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'STREAK x7  •  BONUS 500',
          style: TextStyle(
            color: Color(0xffbda7cf),
            fontFamily: 'monospace',
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 17),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xffffe66d),
              foregroundColor: const Color(0xff24113f),
              shape: const RoundedRectangleBorder(),
              side: const BorderSide(color: Colors.white, width: 2),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text(
              '▶ PRESS START',
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _levels() {
    const levels = [
      ('1UP', 'EASY', Color(0xff69f6ff)),
      ('2UP', 'MEDIUM', Color(0xff78ff80)),
      ('3UP', 'HARD', Color(0xffff8b3d)),
      ('EDIT', 'CUSTOM', Color(0xffff4fa3)),
      ('TIME', 'CHALLENGE 02:00', Color(0xffffe66d)),
    ];
    return Column(
      children: levels
          .map(
            (level) => InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(bottom: 9),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff2d174b),
                  border: Border(
                    left: BorderSide(color: level.$3, width: 5),
                    top: const BorderSide(color: Color(0xff5c3778)),
                    right: const BorderSide(color: Color(0xff5c3778)),
                    bottom: const BorderSide(color: Color(0xff5c3778)),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 55,
                      child: Text(
                        level.$1,
                        style: TextStyle(
                          color: level.$3,
                          fontFamily: 'monospace',
                          fontSize: 11,
                        ),
                      ),
                    ),
                    Text(
                      level.$2,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    Text('▶', style: TextStyle(color: level.$3, fontSize: 11)),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ScanlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x16000000)
      ..strokeWidth = 2;
    for (double y = 0; y < size.height; y += 5) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
