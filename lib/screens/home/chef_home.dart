import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../game_design.dart';
import '../screen_navigation.dart';

class ChefHome extends StatefulWidget {
  const ChefHome({super.key});
  @override
  State<ChefHome> createState() => _ChefHomeState();
}

class _ChefHomeState extends State<ChefHome>
    with SingleTickerProviderStateMixin {
  late final AnimationController a;
  @override
  void initState() {
    super.initState();
    a = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    a.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xffffe1ca),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.restaurant_menu_rounded,
                      color: Color(0xffd33d34),
                      size: 38,
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'ZIP KITCHEN',
                        style: TextStyle(
                          color: Color(0xff4c2926),
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    _icon(
                      Icons.bar_chart,
                      () => openGameStatistics(context, GameDesign.chef),
                    ),
                    const SizedBox(width: 8),
                    _icon(
                      Icons.settings,
                      () => openGameSettings(context, GameDesign.chef),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: const Color(0xff23443b),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xff8b5c39),
                      width: 8,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CHEF’S SPECIAL',
                              style: TextStyle(
                                color: Color(0xffffd16b),
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                              ),
                            ),
                            SizedBox(height: 9),
                            Text(
                              'Today’s fresh\npuzzle',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'serif',
                                fontSize: 29,
                                height: 1,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '♡ ♡ ♡  •  7 day streak',
                              style: TextStyle(
                                color: Color(0xffffb8a6),
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
                              Icons.soup_kitchen_rounded,
                              color: Color(0xffffd16b),
                              size: 58,
                            ),
                          ),
                          FilledButton(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xffd33d34),
                            ),
                            child: const Text('COOK!'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Row(
                  children: [
                    Text(
                      'PUZZLE MENU',
                      style: TextStyle(
                        color: Color(0xff4c2926),
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'TODAY',
                      style: TextStyle(
                        color: Color(0xffd33d34),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...List.generate(5, _dish),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget _icon(IconData i, VoidCallback onTap) => InkWell(
    onTap: onTap,
    customBorder: const CircleBorder(),
    child: Container(
      width: 43,
      height: 43,
      decoration: BoxDecoration(
        color: const Color(0xfffffbef),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: const Color(0xffd33d34), width: 2),
      ),
      child: Icon(i, color: const Color(0xffd33d34), size: 20),
    ),
  );

  Widget _dish(int i) {
    const n = [
      'Easy Appetizer',
      'Medium Entrée',
      'Hard Special',
      'Custom Recipe',
      '2 Min Express',
    ];
    const d = [
      'Light & simple',
      'Perfectly balanced',
      'Extra spicy',
      'Made your way',
      'Fast service',
    ];
    const ic = [
      Icons.bakery_dining,
      Icons.ramen_dining,
      Icons.local_fire_department,
      Icons.menu_book,
      Icons.timer,
    ];
    return AnimatedBuilder(
      animation: a,
      builder: (_, child) => Transform.translate(
        offset: Offset(i.isEven ? a.value * 3 : -a.value * 3, 0),
        child: child,
      ),
      child: Semantics(
        button: true,
        label: '${n[i]} difficulty',
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(18),
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xfffffbef),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: i == 4
                    ? const Color(0xffd33d34)
                    : const Color(0xffe5bda1),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 51,
                  height: 51,
                  decoration: const BoxDecoration(
                    color: Color(0xffffd16b),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(ic[i], color: const Color(0xff8a3d2f)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        n[i],
                        style: const TextStyle(
                          color: Color(0xff4c2926),
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        d[i],
                        style: const TextStyle(
                          color: Color(0xff9a7167),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'ADD +',
                  style: TextStyle(
                    color: Color(0xffd33d34),
                    fontWeight: FontWeight.w900,
                    fontSize: 11,
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
