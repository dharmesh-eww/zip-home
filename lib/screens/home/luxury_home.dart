import 'package:flutter/material.dart';
import '../game_design.dart';
import '../screen_navigation.dart';

class LuxuryHome extends StatefulWidget {
  const LuxuryHome({super.key});

  @override
  State<LuxuryHome> createState() => _LuxuryHomeState();
}

class _LuxuryHomeState extends State<LuxuryHome>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmer;

  @override
  void initState() {
    super.initState();
    _shimmer = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff071323),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.2,
            colors: [Color(0xff172c45), Color(0xff071323)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth > 700 ? 52 : 22,
                vertical: 20,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    children: [
                      _header(context),
                      const SizedBox(height: 40),
                      _hero(),
                      const SizedBox(height: 34),
                      const Row(
                        children: [
                          Expanded(child: Divider(color: Color(0xff776642))),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'THE COLLECTION',
                              style: TextStyle(
                                color: Color(0xffd9bf7d),
                                fontSize: 11,
                                letterSpacing: 2.8,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: Color(0xff776642))),
                        ],
                      ),
                      const SizedBox(height: 18),
                      _modes(),
                      const SizedBox(height: 22),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) => Row(
    children: [
      const Icon(Icons.diamond_outlined, color: Color(0xffd9bf7d), size: 28),
      const SizedBox(width: 11),
      const Expanded(
        child: Text(
          'ZIP PUZZLE',
          style: TextStyle(
            fontFamily: 'serif',
            color: Color(0xfff5ead0),
            fontSize: 21,
            letterSpacing: 3.2,
          ),
        ),
      ),
      GestureDetector(
        onTap: () => openGameStatistics(context, GameDesign.luxury),
        child: _icon(Icons.bar_chart_rounded),
      ),
      const SizedBox(width: 10),
      GestureDetector(
        onTap: () => openGameSettings(context, GameDesign.luxury),
        child: _icon(Icons.settings_outlined),
      ),
    ],
  );

  Widget _icon(IconData icon) => Container(
    width: 42,
    height: 42,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: const Color(0xff8c774b)),
    ),
    child: Icon(icon, color: const Color(0xffd9bf7d), size: 19),
  );

  Widget _hero() => Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
    decoration: BoxDecoration(
      color: const Color(0xff0b1b2c),
      border: Border.all(color: const Color(0xff927a48)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 30,
          offset: Offset(0, 16),
        ),
      ],
    ),
    child: Column(
      children: [
        const Text(
          'TODAY’S EDITION',
          style: TextStyle(
            color: Color(0xffc5a862),
            fontSize: 10,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Daily Challenge',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xfff8efd9),
            fontFamily: 'serif',
            fontSize: 34,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 17),
        AnimatedBuilder(
          animation: _shimmer,
          builder: (_, child) => ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              begin: Alignment(-2 + _shimmer.value * 4, 0),
              end: Alignment(-1 + _shimmer.value * 4, 0),
              colors: const [
                Color(0xff9a7b3f),
                Color(0xffffe7a3),
                Color(0xff9a7b3f),
              ],
            ).createShader(bounds),
            child: child,
          ),
          child: const Icon(Icons.hub_outlined, color: Colors.white, size: 74),
        ),
        const SizedBox(height: 14),
        const Text(
          'An exquisite path awaits.',
          style: TextStyle(
            color: Color(0xff9dacba),
            fontFamily: 'serif',
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 22),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _LuxuryStat('07', 'DAY STREAK'),
            SizedBox(width: 35),
            _LuxuryStat('250', 'GOLD REWARD'),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xff081522),
              backgroundColor: const Color(0xffd9bf7d),
              side: const BorderSide(color: Color(0xffffe8a8)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: const RoundedRectangleBorder(),
            ),
            child: const Text(
              'BEGIN THE CHALLENGE',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 11,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _modes() {
    const modes = [
      ('I', 'Easy', 'A graceful introduction'),
      ('II', 'Medium', 'A considered pursuit'),
      ('III', 'Hard', 'The master’s test'),
      ('IV', 'Custom', 'Your private collection'),
      ('V', 'Challenge · 2 Min', 'Against the hourglass'),
    ];
    return Column(
      children: modes
          .map(
            (mode) => InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(bottom: 9),
                padding: const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 15,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xff0d1e30),
                  border: Border(bottom: BorderSide(color: Color(0xff635433))),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 38,
                      child: Text(
                        mode.$1,
                        style: const TextStyle(
                          color: Color(0xffd9bf7d),
                          fontFamily: 'serif',
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mode.$2,
                            style: const TextStyle(
                              color: Color(0xfff1e7d0),
                              fontFamily: 'serif',
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            mode.$3,
                            style: const TextStyle(
                              color: Color(0xff718092),
                              fontSize: 10,
                              letterSpacing: .5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: Color(0xffa88e54),
                      size: 17,
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _LuxuryStat extends StatelessWidget {
  const _LuxuryStat(this.value, this.label);
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        value,
        style: const TextStyle(
          color: Color(0xfff3dfad),
          fontFamily: 'serif',
          fontSize: 22,
        ),
      ),
      Text(
        label,
        style: const TextStyle(
          color: Color(0xff7f8b98),
          fontSize: 8,
          letterSpacing: 1.5,
        ),
      ),
    ],
  );
}
