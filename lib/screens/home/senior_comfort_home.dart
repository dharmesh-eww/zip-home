import 'package:flutter/material.dart';
import '../game_design.dart';
import '../screen_navigation.dart';

class SeniorComfortHome extends StatefulWidget {
  const SeniorComfortHome({super.key});
  @override
  State<SeniorComfortHome> createState() => _SeniorComfortHomeState();
}

class _SeniorComfortHomeState extends State<SeniorComfortHome>
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
    backgroundColor: const Color(0xfff4f1e9),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.wb_sunny_rounded,
                      color: Color(0xffb66a1d),
                      size: 38,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'ZIP PUZZLE',
                        style: TextStyle(
                          color: Color(0xff183f39),
                          fontSize: 27,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    _action(
                      Icons.bar_chart_rounded,
                      'Statistics',
                      () => openGameStatistics(context, GameDesign.senior),
                    ),
                    const SizedBox(width: 8),
                    _action(
                      Icons.settings_rounded,
                      'Settings',
                      () => openGameSettings(context, GameDesign.senior),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color(0xff175f55),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TODAY’S PUZZLE',
                        style: TextStyle(
                          color: Color(0xff175f55),
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 9),
                      const Text(
                        'A gentle daily challenge',
                        style: TextStyle(
                          color: Color(0xff202b29),
                          fontSize: 28,
                          height: 1.1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 9),
                      const Text(
                        'Seven-day streak • No time limit',
                        style: TextStyle(
                          color: Color(0xff4d5d59),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 19),
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xff175f55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.play_arrow_rounded, size: 30),
                          label: const Text(
                            'START TODAY’S PUZZLE',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
                const Text(
                  'Choose a level',
                  style: TextStyle(
                    color: Color(0xff202b29),
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                ...List.generate(5, _level),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget _action(IconData i, String label, VoidCallback onTap) => Semantics(
    button: true,
    label: label,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xff175f55)),
        ),
        child: Icon(i, color: const Color(0xff175f55), size: 25),
      ),
    ),
  );

  Widget _level(int i) {
    const names = [
      'Easy',
      'Medium',
      'Hard',
      'Custom Size',
      '2 Minute Challenge',
    ];
    const details = [
      'A relaxed start',
      'A little more thinking',
      'A strong brain workout',
      'Choose your own board',
      'Play against the clock',
    ];
    const icons = [
      Icons.sentiment_satisfied_rounded,
      Icons.route_rounded,
      Icons.psychology_rounded,
      Icons.tune_rounded,
      Icons.timer_rounded,
    ];
    return AnimatedBuilder(
      animation: a,
      builder: (_, child) => Container(
        margin: const EdgeInsets.only(bottom: 11),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(
                0xff175f55,
              ).withValues(alpha: .08 + a.value * .08),
              blurRadius: 12,
            ),
          ],
        ),
        child: child,
      ),
      child: Semantics(
        button: true,
        label: '${names[i]}. ${details[i]}',
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(14),
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: i == 0
                    ? const Color(0xff175f55)
                    : const Color(0xffc6cec8),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Icon(icons[i], color: const Color(0xff175f55), size: 31),
                const SizedBox(width: 17),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        names[i],
                        style: const TextStyle(
                          color: Color(0xff202b29),
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        details[i],
                        style: const TextStyle(
                          color: Color(0xff53615d),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xff175f55),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
