import 'dart:ui';

import 'package:flutter/material.dart';
import '../game_design.dart';
import '../screen_navigation.dart';

class NeonHome extends StatefulWidget {
  const NeonHome({super.key});

  @override
  State<NeonHome> createState() => _NeonHomeState();
}

class _NeonHomeState extends State<NeonHome>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff05030b),
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _NeonGridPainter())),
          Positioned(
            top: 120,
            left: -90,
            child: _orb(const Color(0xff8d2bff), 220),
          ),
          Positioned(
            bottom: 80,
            right: -110,
            child: _orb(const Color(0xff00e5ff), 240),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth > 700 ? 48 : 20,
                  vertical: 18,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Column(
                      children: [
                        _header(context),
                        const SizedBox(height: 28),
                        _daily(),
                        const SizedBox(height: 28),
                        const Row(
                          children: [
                            Text(
                              'SELECT PROTOCOL',
                              style: TextStyle(
                                color: Color(0xff8bf7ff),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2.2,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                indent: 16,
                                color: Color(0x557d46ff),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        ..._modeTiles(),
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

  Widget _orb(Color color, double size) => ImageFiltered(
    imageFilter: ImageFilter.blur(sigmaX: 45, sigmaY: 45),
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: .2),
      ),
    ),
  );

  Widget _header(BuildContext context) => Row(
    children: [
      const Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ZIP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                height: .9,
                fontWeight: FontWeight.w900,
                letterSpacing: 5,
              ),
            ),
            Text(
              'PUZZLE // 02',
              style: TextStyle(
                color: Color(0xff00e5ff),
                fontSize: 11,
                letterSpacing: 3,
              ),
            ),
          ],
        ),
      ),
      GestureDetector(
        onTap: () => openGameStatistics(context, GameDesign.neon),
        child: _neonIcon(Icons.query_stats_rounded, const Color(0xff00e5ff)),
      ),
      const SizedBox(width: 10),
      GestureDetector(
        onTap: () => openGameSettings(context, GameDesign.neon),
        child: _neonIcon(Icons.settings_outlined, const Color(0xffc144ff)),
      ),
    ],
  );

  Widget _neonIcon(IconData icon, Color color) => Container(
    width: 44,
    height: 44,
    decoration: BoxDecoration(
      color: color.withValues(alpha: .08),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: .55)),
      boxShadow: [
        BoxShadow(color: color.withValues(alpha: .22), blurRadius: 14),
      ],
    ),
    child: Icon(icon, color: color, size: 20),
  );

  Widget _daily() => AnimatedBuilder(
    animation: _pulse,
    builder: (_, child) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: const Color(
              0xff773cff,
            ).withValues(alpha: .18 + _pulse.value * .16),
            blurRadius: 24 + _pulse.value * 16,
          ),
        ],
      ),
      child: child,
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: const Color(0xff120d20).withValues(alpha: .82),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: const Color(0xff8048ff), width: 1.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.bolt, color: Color(0xff00f5d4), size: 18),
                  Text(
                    ' DAILY SIGNAL',
                    style: TextStyle(
                      color: Color(0xff00f5d4),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                      fontSize: 11,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'STREAK 07',
                    style: TextStyle(color: Color(0xffbcb1d2), fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'CRACK THE\nNEON GRID',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 31,
                  height: 1.05,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  const Text(
                    '+ 250 XP',
                    style: TextStyle(
                      color: Color(0xffc144ff),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xff742cff), Color(0xff00d9ff)],
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(color: Color(0x9900d9ff), blurRadius: 18),
                      ],
                    ),
                    child: TextButton.icon(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 13,
                        ),
                      ),
                      icon: const Icon(Icons.play_arrow, size: 19),
                      label: const Text('JACK IN'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );

  List<Widget> _modeTiles() {
    const modes = [
      ('EASY', '01', Color(0xff00f5d4)),
      ('MEDIUM', '02', Color(0xff00d9ff)),
      ('HARD', '03', Color(0xff8b5cff)),
      ('CUSTOM', '04', Color(0xffff3cac)),
      ('CHALLENGE · 2 MIN', '05', Color(0xffff9d3c)),
    ];
    return modes
        .map(
          (mode) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xaa0d0916),
                  border: Border(
                    left: BorderSide(color: mode.$3, width: 2),
                    top: const BorderSide(color: Color(0x332fddff)),
                    right: const BorderSide(color: Color(0x332fddff)),
                    bottom: const BorderSide(color: Color(0x332fddff)),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Text(
                      mode.$2,
                      style: TextStyle(
                        color: mode.$3,
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(width: 18),
                    Text(
                      mode.$1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.4,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.chevron_right, color: mode.$3, size: 20),
                  ],
                ),
              ),
            ),
          ),
        )
        .toList();
  }
}

class _NeonGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x167b55ff)
      ..strokeWidth = 1;
    const gap = 34.0;
    for (double x = 0; x < size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
