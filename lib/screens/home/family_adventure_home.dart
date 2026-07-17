import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../game_design.dart';
import '../screen_navigation.dart';

class FamilyAdventureHome extends StatefulWidget {
  const FamilyAdventureHome({super.key});
  @override
  State<FamilyAdventureHome> createState() => _FamilyAdventureHomeState();
}

class _FamilyAdventureHomeState extends State<FamilyAdventureHome>
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
    backgroundColor: const Color(0xfffff4dc),
    body: SafeArea(
      child: LayoutBuilder(
        builder: (_, c) => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 780),
              child: Column(
                children: [
                  _header(),
                  const SizedBox(height: 22),
                  _familyBoard(),
                  const SizedBox(height: 25),
                  const Row(
                    children: [
                      Text(
                        'Choose a game piece',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Color(0xff263759),
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.people_alt_rounded, color: Color(0xff3478f6)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: c.maxWidth > 600 ? 3 : 2,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: List.generate(5, _piece),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  Widget _header() => Row(
    children: [
      const Icon(Icons.extension_rounded, color: Color(0xffff9f1c), size: 38),
      const SizedBox(width: 8),
      const Expanded(
        child: Text(
          'ZIP PUZZLE',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Color(0xff263759),
          ),
        ),
      ),
      _icon(
        Icons.bar_chart_rounded,
        () => openGameStatistics(context, GameDesign.family),
      ),
      const SizedBox(width: 8),
      _icon(
        Icons.settings_rounded,
        () => openGameSettings(context, GameDesign.family),
      ),
    ],
  );

  Widget _icon(IconData i, VoidCallback onTap) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(15),
    child: Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(i, color: const Color(0xff3478f6)),
    ),
  );

  Widget _familyBoard() => Container(
    decoration: BoxDecoration(
      color: const Color(0xff3478f6),
      borderRadius: BorderRadius.circular(30),
      boxShadow: const [
        BoxShadow(
          color: Color(0x443478f6),
          blurRadius: 25,
          offset: Offset(0, 12),
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'FAMILY DAILY',
                  style: TextStyle(
                    color: Color(0xffffd166),
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Everyone can\nplay together!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    height: 1.05,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '🔥 7 days   ★ 3 stars',
                  style: TextStyle(color: Color(0xffdce9ff), fontSize: 11),
                ),
                const SizedBox(height: 15),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xffffc928),
                    foregroundColor: const Color(0xff263759),
                  ),
                  child: const Text(
                    'PLAY TOGETHER',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 18),
          child: Icon(
            Icons.family_restroom_rounded,
            color: Colors.white,
            size: 72,
          ),
        ),
      ],
    ),
  );

  Widget _piece(int i) {
    const names = ['Easy', 'Medium', 'Hard', 'Custom', '2 Min'];
    const icons = [
      Icons.child_care,
      Icons.route,
      Icons.psychology,
      Icons.tune,
      Icons.timer,
    ];
    const colors = [
      Color(0xff54c785),
      Color(0xff54a8ef),
      Color(0xffff6b6b),
      Color(0xffa879df),
      Color(0xffffa62b),
    ];
    return AnimatedBuilder(
      animation: a,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, math.sin(a.value * math.pi * 2 + i) * 3),
        child: child,
      ),
      child: Semantics(
        button: true,
        label: '${names[i]} difficulty',
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(22),
          child: Ink(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: colors[i], width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icons[i], color: colors[i], size: 32),
                const SizedBox(height: 7),
                Text(
                  names[i],
                  style: const TextStyle(
                    color: Color(0xff263759),
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
