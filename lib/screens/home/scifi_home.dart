import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../game_design.dart';
import '../screen_navigation.dart';

class SciFiHome extends StatefulWidget {
  const SciFiHome({super.key});

  @override
  State<SciFiHome> createState() => _SciFiHomeState();
}

class _SciFiHomeState extends State<SciFiHome>
    with SingleTickerProviderStateMixin {
  late final AnimationController _radar;

  @override
  void initState() {
    super.initState();
    _radar = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _radar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff020914),
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _SpacePainter())),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth > 700 ? 48 : 18,
                  vertical: 15,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 820),
                    child: Column(
                      children: [
                        _header(context),
                        const SizedBox(height: 20),
                        _mission(),
                        const SizedBox(height: 24),
                        const Row(
                          children: [
                            Text(
                              'SIMULATION MATRIX',
                              style: TextStyle(
                                color: Color(0xff45dfff),
                                fontFamily: 'monospace',
                                fontSize: 11,
                                letterSpacing: 1.8,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                indent: 12,
                                color: Color(0x6645dfff),
                              ),
                            ),
                            Text(
                              ' 05 ONLINE',
                              style: TextStyle(
                                color: Color(0xff59f0ae),
                                fontFamily: 'monospace',
                                fontSize: 9,
                              ),
                            ),
                          ],
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
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff28c9ff)),
          borderRadius: BorderRadius.circular(3),
        ),
        child: const Text(
          'ZP',
          style: TextStyle(
            color: Color(0xff5be8ff),
            fontFamily: 'monospace',
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      const SizedBox(width: 11),
      const Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ZIP PUZZLE',
              style: TextStyle(
                color: Color(0xffd8f8ff),
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
              ),
            ),
            Text(
              'PATHFINDER OS // 5.0',
              style: TextStyle(
                color: Color(0xff39728a),
                fontFamily: 'monospace',
                fontSize: 8,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
      GestureDetector(
        onTap: () => openGameStatistics(context, GameDesign.scifi),
        child: _hudIcon(Icons.data_usage_rounded),
      ),
      const SizedBox(width: 8),
      GestureDetector(
        onTap: () => openGameSettings(context, GameDesign.scifi),
        child: _hudIcon(Icons.settings_outlined),
      ),
    ],
  );

  Widget _hudIcon(IconData icon) => ClipPath(
    clipper: _CutCornerClipper(),
    child: Container(
      width: 44,
      height: 42,
      color: const Color(0x3319bfe7),
      child: Icon(icon, color: const Color(0xff62e9ff), size: 19),
    ),
  );

  Widget _mission() => ClipPath(
    clipper: _CutCornerClipper(cut: 18),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xe6081a29),
        border: Border.all(color: const Color(0xff1d91b5)),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.sensors, color: Color(0xff59f0ae), size: 17),
              SizedBox(width: 7),
              Text(
                'DAILY MISSION DETECTED',
                style: TextStyle(
                  color: Color(0xff59f0ae),
                  fontFamily: 'monospace',
                  fontSize: 10,
                  letterSpacing: 1.4,
                ),
              ),
              Spacer(),
              Text(
                'REWARD 250',
                style: TextStyle(
                  color: Color(0xff45dfff),
                  fontFamily: 'monospace',
                  fontSize: 9,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              AnimatedBuilder(
                animation: _radar,
                builder: (_, child) => Transform.rotate(
                  angle: _radar.value * math.pi * 2,
                  child: child,
                ),
                child: CustomPaint(
                  size: const Size.square(112),
                  painter: _RingPainter(),
                ),
              ),
              const SizedBox(width: 17),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TODAY’S\nPATH',
                      style: TextStyle(
                        color: Color(0xffd9faff),
                        fontSize: 27,
                        height: 1,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 3,
                      ),
                    ),
                    const SizedBox(height: 9),
                    const Text(
                      'STREAK // 07 CYCLES',
                      style: TextStyle(
                        color: Color(0xff608da0),
                        fontFamily: 'monospace',
                        fontSize: 9,
                      ),
                    ),
                    const SizedBox(height: 13),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xff23cceb),
                          foregroundColor: const Color(0xff00111c),
                          shape: const RoundedRectangleBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 13),
                        ),
                        child: const Text(
                          'INITIALIZE',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const LinearProgressIndicator(
            value: .72,
            minHeight: 3,
            backgroundColor: Color(0xff102f41),
            color: Color(0xff59f0ae),
          ),
        ],
      ),
    ),
  );

  Widget _modes(double width) {
    const modes = [
      ('EASY', 'LV.01', Icons.blur_on),
      ('MEDIUM', 'LV.02', Icons.polyline),
      ('HARD', 'LV.03', Icons.hub_outlined),
      ('CUSTOM', 'USER', Icons.tune),
      ('CHALLENGE', '02:00', Icons.timer_outlined),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: modes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: width > 620 ? 3 : 2,
        childAspectRatio: width > 420 ? 1.45 : 1.2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (_, index) {
        final mode = modes[index];
        return InkWell(
          onTap: () {},
          child: ClipPath(
            clipper: _CutCornerClipper(cut: 12),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xd9071724),
                border: Border.all(color: const Color(0xff155c76)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(mode.$3, color: const Color(0xff48dcff), size: 21),
                      const Spacer(),
                      Text(
                        '0${index + 1}',
                        style: const TextStyle(
                          color: Color(0xff27566b),
                          fontFamily: 'monospace',
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mode.$1,
                        style: const TextStyle(
                          color: Color(0xffd4f7ff),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.4,
                        ),
                      ),
                      Text(
                        mode.$2,
                        style: const TextStyle(
                          color: Color(0xff59f0ae),
                          fontFamily: 'monospace',
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CutCornerClipper extends CustomClipper<Path> {
  const _CutCornerClipper({this.cut = 9});
  final double cut;

  @override
  Path getClip(Size size) => Path()
    ..moveTo(0, 0)
    ..lineTo(size.width - cut, 0)
    ..lineTo(size.width, cut)
    ..lineTo(size.width, size.height)
    ..lineTo(cut, size.height)
    ..lineTo(0, size.height - cut)
    ..close();

  @override
  bool shouldReclip(covariant _CutCornerClipper oldClipper) =>
      oldClipper.cut != cut;
}

class _RingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final cyan = Paint()
      ..color = const Color(0xff45dfff)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final green = Paint()
      ..color = const Color(0xff59f0ae)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(center, size.width * .45, cyan);
    canvas.drawCircle(
      center,
      size.width * .31,
      cyan..color = const Color(0x5545dfff),
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width * .39),
      0,
      math.pi * .7,
      false,
      green,
    );
    canvas.drawLine(
      center,
      Offset(center.dx, size.height * .06),
      Paint()
        ..color = const Color(0xaa59f0ae)
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SpacePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
      ..color = const Color(0x141bb9e8)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 42) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), line);
    }
    for (double y = 0; y < size.height; y += 42) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), line);
    }
    final star = Paint()..color = const Color(0x995be8ff);
    for (var i = 0; i < 40; i++) {
      final x = ((i * 83) % 997) / 997 * size.width;
      final y = ((i * 47) % 991) / 991 * size.height;
      canvas.drawCircle(Offset(x, y), i % 3 == 0 ? 1.2 : .6, star);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
