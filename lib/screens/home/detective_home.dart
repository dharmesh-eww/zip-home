import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../game_design.dart';
import '../screen_navigation.dart';

class DetectiveHome extends StatefulWidget {
  const DetectiveHome({super.key});
  @override
  State<DetectiveHome> createState() => _DetectiveHomeState();
}

class _DetectiveHomeState extends State<DetectiveHome>
    with SingleTickerProviderStateMixin {
  late final AnimationController a;
  @override
  void initState() {
    super.initState();
    a = AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    a.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xff282623),
    body: SafeArea(
      child: LayoutBuilder(
        builder: (_, c) => SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 780),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'ZIP CASES',
                          style: TextStyle(
                            color: Color(0xffe9dfc8),
                            fontFamily: 'serif',
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      _icon(
                        Icons.bar_chart_rounded,
                        () => openGameStatistics(context, GameDesign.detective),
                      ),
                      const SizedBox(width: 8),
                      _icon(
                        Icons.settings,
                        () => openGameSettings(context, GameDesign.detective),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Transform.rotate(
                    angle: -.012,
                    child: Container(
                      padding: const EdgeInsets.all(21),
                      color: const Color(0xffeee7d5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.push_pin, color: Color(0xff8c2424)),
                              Text(
                                ' CASE OF THE DAY',
                                style: TextStyle(
                                  color: Color(0xff8c2424),
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1,
                                ),
                              ),
                              Spacer(),
                              Text('FILE #0717', style: TextStyle(fontSize: 9)),
                            ],
                          ),
                          const Divider(color: Color(0xff817866)),
                          const Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'The Missing\nNumber',
                                      style: TextStyle(
                                        color: Color(0xff221f1b),
                                        fontFamily: 'serif',
                                        fontSize: 29,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Evidence reward: 300 • Streak 7',
                                      style: TextStyle(
                                        color: Color(0xff6e6659),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.fingerprint,
                                color: Color(0xff8c2424),
                                size: 67,
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: () {},
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xff8c2424),
                                shape: const RoundedRectangleBorder(),
                              ),
                              child: const Text('OPEN THE CASE'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'EVIDENCE BOARD',
                      style: TextStyle(
                        color: Color(0xffd0b777),
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Wrap(
                    spacing: 12,
                    runSpacing: 14,
                    children: List.generate(5, (i) => _evidence(i, c.maxWidth)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  Widget _icon(IconData i, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffd0b777)),
      ),
      child: Icon(i, color: const Color(0xffd0b777), size: 19),
    ),
  );

  Widget _evidence(int i, double width) {
    const n = [
      'Easy Lead',
      'Medium Clue',
      'Hard Mystery',
      'Custom Case',
      '2 Min Chase',
    ];
    const ic = [
      Icons.search,
      Icons.visibility,
      Icons.psychology,
      Icons.edit_note,
      Icons.timer,
    ];
    final w = width > 600 ? (math.min(width, 780) - 24) / 3 : (width - 48) / 2;
    return AnimatedBuilder(
      animation: a,
      builder: (_, child) => Transform.translate(
        offset: Offset(math.sin(a.value * math.pi * 2 + i) * 2, 0),
        child: child,
      ),
      child: Semantics(
        button: true,
        label: '${n[i]} difficulty',
        child: InkWell(
          onTap: () {},
          child: Transform.rotate(
            angle: i.isEven ? -.02 : .02,
            child: Container(
              width: w,
              height: 125,
              padding: const EdgeInsets.all(15),
              color: i == 4 ? const Color(0xffd6c08a) : const Color(0xffeee7d5),
              child: Stack(
                children: [
                  const Positioned(
                    top: -12,
                    right: -7,
                    child: Icon(
                      Icons.push_pin,
                      color: Color(0xff8c2424),
                      size: 20,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(ic[i], color: const Color(0xff8c2424), size: 28),
                      const SizedBox(height: 8),
                      Text(
                        n[i],
                        style: const TextStyle(
                          color: Color(0xff221f1b),
                          fontFamily: 'serif',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ],
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
