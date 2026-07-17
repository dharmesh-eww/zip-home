import 'package:flutter/material.dart';
import '../game_design.dart';

class GameStatisticScreen extends StatefulWidget {
  const GameStatisticScreen({super.key, required this.design});
  final GameDesign design;

  @override
  State<GameStatisticScreen> createState() => _GameStatisticScreenState();
}

class _GameStatisticScreenState extends State<GameStatisticScreen> {
  int selectedDifficulty = 0;
  GameDesignStyle get s => widget.design.style;

  static const difficulties = ['Easy', 'Medium', 'Hard', 'Custom', '2 Min'];
  static const stats = [
    [148, 132, 96, 21, '00:34'],
    [112, 91, 58, 14, '01:12'],
    [76, 49, 27, 8, '02:48'],
    [64, 47, 31, 11, '01:56'],
    [93, 68, 43, 16, '00:51'],
  ];

  @override
  Widget build(BuildContext context) {
    final current = stats[selectedDifficulty];
    final radius = s.sharp ? 2.0 : 22.0;
    final foreground = s.dark && widget.design != GameDesign.ocean
        ? s.text
        : s.text;
    return Scaffold(
      backgroundColor: s.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(foreground),
                  const SizedBox(height: 25),
                  Text(
                    'VIEW BY DIFFICULTY',
                    style: TextStyle(
                      color: s.secondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.7,
                    ),
                  ),
                  const SizedBox(height: 11),
                  _difficultyPicker(radius),
                  const SizedBox(height: 23),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 280),
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween(
                          begin: const Offset(.04, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    ),
                    child: Column(
                      key: ValueKey(selectedDifficulty),
                      children: [
                        _hero(current, radius),
                        const SizedBox(height: 13),
                        _statLayout(current, radius),
                        const SizedBox(height: 13),
                        _bestTime(current, radius),
                      ],
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

  Widget _header(Color foreground) => Row(
    children: [
      Material(
        color: s.surface,
        shape: s.sharp ? const RoundedRectangleBorder() : const CircleBorder(),
        child: IconButton(
          tooltip: 'Back',
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_rounded, color: s.primary),
        ),
      ),
      const SizedBox(width: 13),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'STATISTICS',
              style: TextStyle(
                color: foreground,
                fontSize: 25,
                fontWeight: FontWeight.w900,
                fontFamily: s.serif ? 'serif' : null,
                letterSpacing: s.sharp ? 1.5 : -.4,
              ),
            ),
            Text(
              s.title,
              style: TextStyle(
                color: s.primary,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
      Icon(Icons.query_stats_rounded, color: s.secondary, size: 33),
    ],
  );

  Widget _difficultyPicker(double radius) => SizedBox(
    height: 49,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: difficulties.length,
      separatorBuilder: (context, index) => const SizedBox(width: 8),
      itemBuilder: (_, index) {
        final selected = index == selectedDifficulty;
        return ChoiceChip(
          selected: selected,
          onSelected: (_) => setState(() => selectedDifficulty = index),
          showCheckmark: false,
          label: Text(difficulties[index]),
          labelStyle: TextStyle(
            color: selected ? (s.dark ? s.background : Colors.white) : s.text,
            fontWeight: FontWeight.w800,
          ),
          selectedColor: s.primary,
          backgroundColor: s.surface,
          side: BorderSide(color: s.primary.withValues(alpha: .4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        );
      },
    ),
  );

  Widget _hero(List<Object> data, double radius) {
    final played = data[0] as int;
    final wins = data[1] as int;
    final ratio = wins / played;
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: s.gradients[selectedDifficulty % 4]),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: s.primary.withValues(alpha: .28),
            blurRadius: 24,
            offset: const Offset(0, 11),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 82,
            height: 82,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: ratio,
                  strokeWidth: 9,
                  backgroundColor: Colors.white.withValues(alpha: .25),
                  color: Colors.white,
                ),
                Text(
                  '${(ratio * 100).round()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  difficulties[selectedDifficulty].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'WIN RATE',
                  style: TextStyle(color: Colors.white70, fontSize: 10),
                ),
                Text(
                  '$wins of $played puzzles won',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statLayout(List<Object> data, double radius) {
    final cards = [
      ('Total played', '${data[0]}', Icons.grid_view_rounded),
      ('Total wins', '${data[1]}', Icons.emoji_events_rounded),
      ('Perfect plays', '${data[2]}', Icons.auto_awesome_rounded),
      ('Best win streak', '${data[3]}', Icons.local_fire_department_rounded),
    ];
    if (widget.design.index % 3 == 0) {
      return Column(
        children: cards
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: _wideCard(item, radius),
              ),
            )
            .toList(),
      );
    }
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.45,
      crossAxisSpacing: 11,
      mainAxisSpacing: 11,
      children: cards.map((item) => _smallCard(item, radius)).toList(),
    );
  }

  Widget _smallCard((String, String, IconData) item, double radius) =>
      Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(radius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(item.$3, color: s.secondary, size: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.$2,
                  style: TextStyle(
                    color: s.text,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  item.$1,
                  style: TextStyle(
                    color: s.text.withValues(alpha: .6),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _wideCard((String, String, IconData) item, double radius) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 14),
    decoration: _cardDecoration(radius),
    child: Row(
      children: [
        Icon(item.$3, color: s.secondary),
        const SizedBox(width: 13),
        Expanded(
          child: Text(
            item.$1,
            style: TextStyle(color: s.text, fontWeight: FontWeight.w700),
          ),
        ),
        Text(
          item.$2,
          style: TextStyle(
            color: s.primary,
            fontSize: 23,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    ),
  );

  BoxDecoration _cardDecoration(double radius) => BoxDecoration(
    color: s.surface,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: s.primary.withValues(alpha: .25)),
  );

  Widget _bestTime(List<Object> data, double radius) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(19),
    decoration: BoxDecoration(
      color: s.surface,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: s.secondary, width: 2),
    ),
    child: Row(
      children: [
        Container(
          width: 49,
          height: 49,
          decoration: BoxDecoration(
            color: s.secondary.withValues(alpha: .16),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.timer_outlined, color: s.secondary),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BEST TIME',
                style: TextStyle(
                  color: s.text.withValues(alpha: .6),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                '${difficulties[selectedDifficulty]} difficulty',
                style: TextStyle(color: s.text, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        Text(
          data[4] as String,
          style: TextStyle(
            color: s.primary,
            fontSize: 28,
            fontWeight: FontWeight.w900,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}
