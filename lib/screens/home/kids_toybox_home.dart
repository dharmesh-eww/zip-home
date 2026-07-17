import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../game_design.dart';
import '../screen_navigation.dart';

class KidsToyboxHome extends StatefulWidget {
  const KidsToyboxHome({super.key});
  @override
  State<KidsToyboxHome> createState() => _KidsToyboxHomeState();
}

class _KidsToyboxHomeState extends State<KidsToyboxHome>
    with SingleTickerProviderStateMixin {
  late final AnimationController a;
  @override
  void initState() {
    super.initState();
    a = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    a.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xffbfeaff),
    body: Stack(
      children: [
        const Positioned(
          top: 90,
          left: -20,
          child: Icon(Icons.cloud, color: Colors.white, size: 100),
        ),
        const Positioned(
          top: 190,
          right: -25,
          child: Icon(Icons.cloud, color: Colors.white70, size: 90),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'ZIP\nTOYBOX',
                            style: TextStyle(
                              color: Color(0xff493776),
                              fontSize: 29,
                              height: .82,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        _round(
                          Icons.bar_chart_rounded,
                          const Color(0xffffd33d),
                          () => openGameStatistics(context, GameDesign.kids),
                        ),
                        const SizedBox(width: 9),
                        _round(
                          Icons.settings_rounded,
                          const Color(0xffff6f9e),
                          () => openGameSettings(context, GameDesign.kids),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(19),
                      decoration: BoxDecoration(
                        color: const Color(0xfffff3f8),
                        borderRadius: BorderRadius.circular(36),
                        border: Border.all(
                          color: const Color(0xff493776),
                          width: 3,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'TODAY’S FUN',
                                  style: TextStyle(
                                    color: Color(0xffff4f87),
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(height: 7),
                                Text(
                                  'Follow the\nrainbow!',
                                  style: TextStyle(
                                    color: Color(0xff493776),
                                    fontSize: 27,
                                    height: 1,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '⭐ Win a rainbow badge',
                                  style: TextStyle(
                                    color: Color(0xff766a91),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              AnimatedBuilder(
                                animation: a,
                                builder: (_, child) => Transform.rotate(
                                  angle: math.sin(a.value * math.pi) * .08,
                                  child: child,
                                ),
                                child: const Icon(
                                  Icons.toys_rounded,
                                  color: Color(0xff55c95b),
                                  size: 58,
                                ),
                              ),
                              FilledButton(
                                onPressed: () {},
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xffff4f87),
                                ),
                                child: const Text('GO!'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 23),
                    const Text(
                      'Hop to a level',
                      style: TextStyle(
                        color: Color(0xff493776),
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 13),
                    ...List.generate(5, _step),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _round(IconData i, Color c, VoidCallback onTap) => InkWell(
    onTap: onTap,
    customBorder: const CircleBorder(),
    child: Container(
      width: 47,
      height: 47,
      decoration: BoxDecoration(
        color: c,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xff493776), width: 2),
      ),
      child: Icon(i, color: Colors.white),
    ),
  );

  Widget _step(int i) {
    const n = ['Easy', 'Medium', 'Hard', 'Make My Own', '2 Minute Race'];
    const c = [
      Color(0xff58cf6b),
      Color(0xff4ab8ef),
      Color(0xffff7a59),
      Color(0xffa875e0),
      Color(0xffffbd35),
    ];
    return Align(
      alignment: i.isEven ? Alignment.centerLeft : Alignment.centerRight,
      child: AnimatedBuilder(
        animation: a,
        builder: (_, child) => Transform.scale(
          scale: 1 + math.sin(a.value * math.pi * 2 + i) * .025,
          child: child,
        ),
        child: Semantics(
          button: true,
          label: '${n[i]} difficulty',
          child: InkWell(
            onTap: () {},
            child: Container(
              width: 220,
              margin: const EdgeInsets.only(bottom: 11),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: BoxDecoration(
                color: c[i],
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: const Color(0xff493776), width: 2),
                boxShadow: const [
                  BoxShadow(color: Color(0xff493776), offset: Offset(4, 4)),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      n[i],
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
