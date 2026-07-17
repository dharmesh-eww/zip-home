import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../game_design.dart';
import '../screen_navigation.dart';

class MinimalHome extends StatefulWidget {
  const MinimalHome({super.key});

  @override
  State<MinimalHome> createState() => _MinimalHomeState();
}

class _MinimalHomeState extends State<MinimalHome>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fc),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth > 700 ? 48 : 22,
              vertical: 16,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 780),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(context),
                    const SizedBox(height: 30),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (_, child) => Transform.translate(
                        offset: Offset(
                          0,
                          math.sin(_controller.value * math.pi) * -5,
                        ),
                        child: child,
                      ),
                      child: _dailyCard(),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Choose your flow',
                      style: TextStyle(
                        color: Color(0xff101828),
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -.5,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _modes(constraints.maxWidth),
                    const SizedBox(height: 20),
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
    children: [
      Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xff1769ff),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.grid_view_rounded, color: Colors.white),
      ),
      const SizedBox(width: 12),
      const Expanded(
        child: Text(
          'ZIP PUZZLE',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            letterSpacing: -.8,
          ),
        ),
      ),
      GestureDetector(
        onTap: () => openGameStatistics(context, GameDesign.minimal),
        child: _icon(Icons.bar_chart_rounded),
      ),
      const SizedBox(width: 8),
      GestureDetector(
        onTap: () => openGameSettings(context, GameDesign.minimal),
        child: _icon(Icons.tune_rounded),
      ),
    ],
  );

  Widget _icon(IconData icon) => Container(
    width: 43,
    height: 43,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0d101828),
          blurRadius: 16,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Icon(icon, color: const Color(0xff344054), size: 21),
  );

  Widget _dailyCard() => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xff1769ff), Color(0xff74a5ff)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(28),
      boxShadow: const [
        BoxShadow(
          color: Color(0x381769ff),
          blurRadius: 32,
          offset: Offset(0, 16),
        ),
      ],
    ),
    child: Stack(
      children: [
        Positioned(
          right: -20,
          top: -35,
          child: Icon(
            Icons.extension_rounded,
            color: Colors.white.withValues(alpha: .12),
            size: 145,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.wb_sunny_outlined, color: Colors.white, size: 18),
                SizedBox(width: 7),
                Text(
                  'DAILY CHALLENGE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Text(
              'Find today’s\nperfect path.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 31,
                height: 1.08,
                fontWeight: FontWeight.w700,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _miniStat('7 days', 'STREAK'),
                const SizedBox(width: 20),
                _miniStat('120', 'REWARD'),
                const Spacer(),
                FilledButton.icon(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xff1769ff),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 15,
                    ),
                  ),
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Play'),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  Widget _miniStat(String value, String label) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      Text(
        label,
        style: const TextStyle(color: Color(0xffdce8ff), fontSize: 9),
      ),
    ],
  );

  Widget _modes(double width) {
    const data = [
      ('Easy', 'A gentle start', Icons.spa_outlined),
      ('Medium', 'Find your rhythm', Icons.route_rounded),
      ('Hard', 'Think deeper', Icons.psychology_outlined),
      ('Custom', 'Make it yours', Icons.tune_rounded),
      ('Challenge', '2 MIN', Icons.timer_outlined),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: width > 620 ? 3 : 2,
        childAspectRatio: width > 420 ? 1.55 : 1.18,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (_, index) {
        final item = data[index];
        return InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(22),
          child: Ink(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xffedf1f7)),
              boxShadow: const [
                BoxShadow(color: Color(0x09101828), blurRadius: 18),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(item.$3, color: const Color(0xff1769ff)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.$1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      item.$2,
                      style: const TextStyle(
                        color: Color(0xff98a2b3),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
