import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../game_design.dart';
import '../screen_navigation.dart';

class FarmVillageHome extends StatefulWidget {
  const FarmVillageHome({super.key});
  @override
  State<FarmVillageHome> createState() => _FarmVillageHomeState();
}

class _FarmVillageHomeState extends State<FarmVillageHome>
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
    backgroundColor: const Color(0xffdff1c8),
    body: Stack(
      children: [
        Positioned.fill(child: CustomPaint(painter: _FieldPainter())),
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
                          Icons.agriculture_rounded,
                          color: Color(0xff4d793c),
                          size: 39,
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'ZIP HARVEST',
                            style: TextStyle(
                              color: Color(0xff304126),
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        _icon(
                          Icons.bar_chart,
                          () => openGameStatistics(context, GameDesign.farm),
                        ),
                        const SizedBox(width: 8),
                        _icon(
                          Icons.settings,
                          () => openGameSettings(context, GameDesign.farm),
                        ),
                      ],
                    ),
                    const SizedBox(height: 23),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xfffff8da),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(70),
                          topRight: Radius.circular(70),
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18),
                        ),
                        border: Border.all(
                          color: const Color(0xff784c2e),
                          width: 3,
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 22),
                          const Icon(
                            Icons.roofing_rounded,
                            color: Color(0xffd94e3d),
                            size: 55,
                          ),
                          const Text(
                            'MORNING HARVEST',
                            style: TextStyle(
                              color: Color(0xff4d793c),
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Daily Farm Puzzle',
                            style: TextStyle(
                              color: Color(0xff304126),
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const Text(
                            'Grow 5 sunflowers • Streak 7',
                            style: TextStyle(
                              color: Color(0xff7c6c55),
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 13),
                          FilledButton.icon(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xff4d793c),
                            ),
                            icon: const Icon(Icons.grass),
                            label: const Text('START HARVEST'),
                          ),
                          const SizedBox(height: 18),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'FOLLOW THE SIGNPOSTS',
                      style: TextStyle(
                        color: Color(0xff304126),
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ...List.generate(5, _sign),
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
    borderRadius: BorderRadius.circular(10),
    child: Container(
      width: 43,
      height: 43,
      decoration: BoxDecoration(
        color: const Color(0xfffff8da),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xff4d793c), width: 2),
      ),
      child: Icon(i, color: const Color(0xff4d793c), size: 20),
    ),
  );

  Widget _sign(int i) {
    const n = [
      'Easy Meadow',
      'Medium Orchard',
      'Hard Hills',
      'Custom Field',
      '2 Min Market',
    ];
    const c = [
      Color(0xff6d994f),
      Color(0xffd4933c),
      Color(0xffb85b3d),
      Color(0xff638a8a),
      Color(0xffd64f52),
    ];
    return AnimatedBuilder(
      animation: a,
      builder: (_, child) => Transform.rotate(
        angle: math.sin(a.value * math.pi * 2 + i) * .012,
        child: child,
      ),
      child: Align(
        alignment: i.isEven ? Alignment.centerLeft : Alignment.centerRight,
        child: Semantics(
          button: true,
          label: '${n[i]} difficulty',
          child: InkWell(
            onTap: () {},
            child: Container(
              width: 265,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: BoxDecoration(
                color: c[i],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(i.isEven ? 5 : 25),
                  bottomLeft: Radius.circular(i.isEven ? 5 : 25),
                  topRight: Radius.circular(i.isEven ? 25 : 5),
                  bottomRight: Radius.circular(i.isEven ? 25 : 5),
                ),
                boxShadow: const [
                  BoxShadow(color: Color(0x44784c2e), offset: Offset(3, 4)),
                ],
              ),
              child: Row(
                children: [
                  Icon(i == 4 ? Icons.timer : Icons.eco, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      n[i],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = const Color(0x174d793c)
      ..strokeWidth = 2;
    for (double y = 300; y < size.height; y += 35) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y + 80), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
