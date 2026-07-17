import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../game_design.dart';
import '../screen_navigation.dart';

class NatureHome extends StatefulWidget {
  const NatureHome({super.key});

  @override
  State<NatureHome> createState() => _NatureHomeState();
}

class _NatureHomeState extends State<NatureHome>
    with SingleTickerProviderStateMixin {
  late final AnimationController _wind;

  @override
  void initState() {
    super.initState();
    _wind = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _wind.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe9efe2),
      body: Stack(
        children: [
          Positioned(
            top: -80,
            right: -70,
            child: _leafCircle(250, const Color(0xffcad9bd)),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: _leafCircle(280, const Color(0xffd7caaa)),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth > 700 ? 48 : 22,
                  vertical: 18,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 760),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _header(context),
                        const SizedBox(height: 32),
                        _daily(),
                        const SizedBox(height: 30),
                        const Text(
                          'Wander your way',
                          style: TextStyle(
                            color: Color(0xff263c2c),
                            fontFamily: 'serif',
                            fontSize: 26,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 15),
                        _trail(),
                        const SizedBox(height: 22),
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

  Widget _leafCircle(double size, Color color) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );

  Widget _header(BuildContext context) => Row(
    children: [
      AnimatedBuilder(
        animation: _wind,
        builder: (_, child) => Transform.rotate(
          angle: math.sin(_wind.value * math.pi) * .06,
          child: child,
        ),
        child: const Icon(
          Icons.eco_rounded,
          color: Color(0xff54775b),
          size: 34,
        ),
      ),
      const SizedBox(width: 10),
      const Expanded(
        child: Text(
          'ZIP PUZZLE',
          style: TextStyle(
            color: Color(0xff23372a),
            fontFamily: 'serif',
            fontSize: 23,
            letterSpacing: 1.5,
          ),
        ),
      ),
      GestureDetector(
        onTap: () => openGameStatistics(context, GameDesign.nature),
        child: _action(Icons.insights_rounded),
      ),
      const SizedBox(width: 9),
      GestureDetector(
        onTap: () => openGameSettings(context, GameDesign.nature),
        child: _action(Icons.tune_rounded),
      ),
    ],
  );

  Widget _action(IconData icon) => Container(
    width: 43,
    height: 43,
    decoration: const BoxDecoration(
      color: Color(0xaafffff5),
      shape: BoxShape.circle,
    ),
    child: Icon(icon, color: const Color(0xff54775b), size: 20),
  );

  Widget _daily() => Container(
    padding: const EdgeInsets.all(23),
    decoration: const BoxDecoration(
      color: Color(0xff365a43),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(55),
        topRight: Radius.circular(16),
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(55),
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x33365a43),
          blurRadius: 28,
          offset: Offset(0, 14),
        ),
      ],
    ),
    child: Stack(
      children: [
        Positioned(
          right: -18,
          top: -20,
          child: Icon(
            Icons.park_rounded,
            size: 145,
            color: Colors.white.withValues(alpha: .07),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'TODAY’S TRAIL',
              style: TextStyle(
                color: Color(0xffbad3b8),
                fontSize: 10,
                letterSpacing: 2.5,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Daily Challenge',
              style: TextStyle(
                color: Color(0xfffffbed),
                fontFamily: 'serif',
                fontSize: 31,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'Follow each stone. Leave no path behind.',
              style: TextStyle(color: Color(0xffcbd9c8), fontSize: 12),
            ),
            const SizedBox(height: 23),
            Row(
              children: [
                const Icon(
                  Icons.local_fire_department_outlined,
                  color: Color(0xffefc977),
                  size: 19,
                ),
                const Text(
                  ' 7 day streak',
                  style: TextStyle(color: Color(0xfffffbed), fontSize: 12),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xffe9d9a5),
                    foregroundColor: const Color(0xff284332),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 13,
                    ),
                  ),
                  child: const Text('Begin walk'),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  Widget _trail() {
    const modes = [
      ('Easy', 'A quiet clearing', Color(0xff77966f)),
      ('Medium', 'Through the grove', Color(0xffb18b55)),
      ('Hard', 'The wild ridge', Color(0xff9b6659)),
      ('Custom', 'Choose your trail', Color(0xff678a89)),
      ('Challenge · 2 Min', 'Race the sunset', Color(0xffc27e45)),
    ];
    return Column(
      children: List.generate(modes.length, (index) {
        final mode = modes[index];
        return IntrinsicHeight(
          child: Row(
            children: [
              SizedBox(
                width: 36,
                child: Column(
                  children: [
                    Container(
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                        color: mode.$3,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xfff6f4e8),
                          width: 3,
                        ),
                      ),
                    ),
                    if (index < modes.length - 1)
                      const Expanded(
                        child: VerticalDivider(
                          width: 1,
                          color: Color(0xffaebca5),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 11),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 17,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xccfffdf3),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mode.$1,
                                style: const TextStyle(
                                  color: Color(0xff2c4031),
                                  fontFamily: 'serif',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                mode.$2,
                                style: const TextStyle(
                                  color: Color(0xff819083),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Color(0xff66806a),
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
