import 'package:flutter/material.dart';
import '../game_design.dart';
import '../screen_navigation.dart';

class BrutalistHome extends StatefulWidget {
  const BrutalistHome({super.key});

  @override
  State<BrutalistHome> createState() => _BrutalistHomeState();
}

class _BrutalistHomeState extends State<BrutalistHome>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f0e9),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 820),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        constraints.maxWidth > 700 ? 44 : 16,
                        15,
                        constraints.maxWidth > 700 ? 44 : 16,
                        16,
                      ),
                      child: _header(context),
                    ),
                    _marquee(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth > 700 ? 44 : 16,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 22),
                          _daily(),
                          const SizedBox(height: 24),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'PICK YOUR\nPROBLEM.',
                              style: TextStyle(
                                color: Color(0xff111111),
                                fontSize: 30,
                                height: .9,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -1.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          _modes(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Expanded(
        child: Text(
          'ZIP\nPUZZLE',
          style: TextStyle(
            color: Color(0xff0c0c0c),
            fontSize: 39,
            height: .78,
            fontWeight: FontWeight.w900,
            letterSpacing: -3,
          ),
        ),
      ),
      GestureDetector(
        onTap: () => openGameStatistics(context, GameDesign.brutalist),
        child: _squareIcon(Icons.bar_chart_rounded),
      ),
      const SizedBox(width: 8),
      GestureDetector(
        onTap: () => openGameSettings(context, GameDesign.brutalist),
        child: _squareIcon(Icons.settings),
      ),
    ],
  );

  Widget _squareIcon(IconData icon) => Container(
    width: 46,
    height: 46,
    decoration: const BoxDecoration(
      color: Color(0xffe94b35),
      border: Border.fromBorderSide(BorderSide(color: Colors.black, width: 3)),
      boxShadow: [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
    ),
    child: Icon(icon, color: Colors.black, size: 21),
  );

  Widget _marquee() => Container(
    height: 31,
    color: Colors.black,
    // clipBehavior: Clip.hardEdge,
    child: AnimatedBuilder(
      animation: _ticker,
      builder: (_, child) => Transform.translate(
        offset: Offset(-160 * _ticker.value, 0),
        child: child,
      ),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '  CONNECT EVERY BLOCK  ★  ONE LINE ONLY  ★  CONNECT EVERY BLOCK  ★  ONE LINE ONLY  ★',
          maxLines: 1,
          style: TextStyle(
            color: Color(0xffffe500),
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.3,
          ),
        ),
      ),
    ),
  );

  Widget _daily() => Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      color: Color(0xffffe500),
      border: Border.fromBorderSide(BorderSide(color: Colors.black, width: 3)),
      boxShadow: [BoxShadow(color: Colors.black, offset: Offset(8, 8))],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          color: const Color(0xffe94b35),
          child: const Text(
            'TODAY // DAILY CHALLENGE',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 11,
              letterSpacing: 1,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'SOLVE IT.\nNO EXCUSES.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 31,
                        height: .9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.5,
                      ),
                    ),
                  ),
                  Icon(Icons.grid_4x4, color: Colors.black, size: 66),
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                'STREAK: 07  /  REWARD: 200',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'PLAY NOW →',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
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
  );

  Widget _modes() {
    const modes = [
      ('01', 'EASY', 'WARM UP'),
      ('02', 'MEDIUM', 'FOCUS'),
      ('03', 'HARD', 'SUFFER'),
      ('04', 'CUSTOM', 'YOUR RULES'),
      ('05', 'CHALLENGE', '02:00'),
    ];
    return Column(
      children: modes
          .map(
            (mode) => InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(bottom: 9),
                decoration: const BoxDecoration(
                  color: Color(0xfff2f0e9),
                  border: Border.fromBorderSide(
                    BorderSide(color: Colors.black, width: 2.5),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      color: Colors.black,
                      child: Text(
                        mode.$1,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        mode.$2,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      mode.$3,
                      style: const TextStyle(
                        color: Color(0xffe94b35),
                        fontWeight: FontWeight.w900,
                        fontSize: 9,
                      ),
                    ),
                    const SizedBox(width: 13),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
