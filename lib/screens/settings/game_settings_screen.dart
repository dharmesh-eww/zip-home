import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../game_design.dart';

class GameSettingsScreen extends StatefulWidget {
  const GameSettingsScreen({super.key, required this.design});
  final GameDesign design;

  @override
  State<GameSettingsScreen> createState() => _GameSettingsScreenState();
}

class _GameSettingsScreenState extends State<GameSettingsScreen>
    with SingleTickerProviderStateMixin {
  ThemeMode selectedTheme = ThemeMode.system;
  int selectedPath = 0;
  late final AnimationController animation;

  GameDesignStyle get s => widget.design.style;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = s.sharp ? 3.0 : 22.0;
    return Scaffold(
      backgroundColor: s.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _SettingsMotif(s.primary, widget.design.index),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(radius),
                      const SizedBox(height: 28),
                      Text('APPEARANCE', style: _labelStyle()),
                      const SizedBox(height: 11),
                      _themeSelector(radius),
                      const SizedBox(height: 28),
                      Text('PATH COLOR', style: _labelStyle()),
                      const SizedBox(height: 6),
                      Text(
                        'Choose one three-color gradient for your puzzle path.',
                        style: TextStyle(
                          color: s.text.withValues(alpha: .65),
                          fontSize: widget.design == GameDesign.senior
                              ? 16
                              : 12,
                        ),
                      ),
                      const SizedBox(height: 14),
                      ...List.generate(
                        s.gradients.length,
                        (index) => _gradientOption(index, radius),
                      ),
                      const SizedBox(height: 22),
                      _preview(radius),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _labelStyle() => TextStyle(
    color: s.dark && widget.design != GameDesign.ocean ? s.text : s.primary,
    fontSize: 12,
    fontWeight: FontWeight.w900,
    letterSpacing: 1.8,
    fontFamily: s.serif ? 'serif' : null,
  );

  Widget _header(double radius) => Row(
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
              'SETTINGS',
              style: TextStyle(
                color: s.dark && widget.design != GameDesign.ocean
                    ? s.text
                    : s.text,
                fontSize: 25,
                fontWeight: FontWeight.w900,
                letterSpacing: s.sharp ? 2 : -.5,
                fontFamily: s.serif ? 'serif' : null,
              ),
            ),
            Text(
              s.title,
              style: TextStyle(
                color: s.secondary,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
      Icon(Icons.tune_rounded, color: s.primary, size: 30),
    ],
  );

  Widget _themeSelector(double radius) => Container(
    padding: const EdgeInsets.all(7),
    decoration: BoxDecoration(
      color: s.surface,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: s.primary.withValues(alpha: .35)),
    ),
    child: Row(
      children: [
        _themeChoice(ThemeMode.system, Icons.brightness_auto, 'System', radius),
        _themeChoice(ThemeMode.light, Icons.light_mode, 'Light', radius),
        _themeChoice(ThemeMode.dark, Icons.dark_mode, 'Dark', radius),
      ],
    ),
  );

  Widget _themeChoice(
    ThemeMode mode,
    IconData icon,
    String label,
    double radius,
  ) {
    final selected = selectedTheme == mode;
    return Expanded(
      child: Semantics(
        selected: selected,
        button: true,
        child: InkWell(
          onTap: () => setState(() => selectedTheme = mode),
          borderRadius: BorderRadius.circular(radius * .7),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: selected ? s.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(radius * .7),
            ),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: selected
                      ? (s.dark ? s.background : Colors.white)
                      : s.text.withValues(alpha: .65),
                ),
                const SizedBox(height: 5),
                Text(
                  label,
                  style: TextStyle(
                    color: selected
                        ? (s.dark ? s.background : Colors.white)
                        : s.text,
                    fontWeight: FontWeight.w800,
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

  Widget _gradientOption(int index, double radius) {
    final selected = selectedPath == index;
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Semantics(
        button: true,
        selected: selected,
        label: 'Path gradient ${index + 1}',
        child: InkWell(
          onTap: () => setState(() => selectedPath = index),
          borderRadius: BorderRadius.circular(radius),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: s.surface,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: selected ? s.secondary : s.primary.withValues(alpha: .2),
                width: selected ? 3 : 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: s.gradients[index]),
                      borderRadius: BorderRadius.circular(
                        math.max(0, radius - 7),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 13),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  child: Icon(
                    selected
                        ? Icons.check_circle_rounded
                        : Icons.circle_outlined,
                    key: ValueKey(selected),
                    color: selected
                        ? s.secondary
                        : s.text.withValues(alpha: .35),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _preview(double radius) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: s.surface,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: s.primary.withValues(alpha: .25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('LIVE PATH PREVIEW', style: _labelStyle()),
        const SizedBox(height: 16),
        AnimatedBuilder(
          animation: animation,
          builder: (context, child) => CustomPaint(
            size: const Size(double.infinity, 70),
            painter: _PathPreviewPainter(
              s.gradients[selectedPath],
              animation.value,
            ),
          ),
        ),
      ],
    ),
  );
}

class _PathPreviewPainter extends CustomPainter {
  const _PathPreviewPainter(this.colors, this.progress);
  final List<Color> colors;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(8, size.height * .7)
      ..lineTo(size.width * .25, size.height * .25)
      ..lineTo(size.width * .5, size.height * .7)
      ..lineTo(size.width * .73, size.height * .25)
      ..lineTo(size.width - 8, size.height * .55);
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment(-1 + progress * .4, 0),
        end: Alignment(1 + progress * .4, 0),
        colors: colors,
      ).createShader(Offset.zero & size)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 9;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _PathPreviewPainter oldDelegate) => true;
}

class _SettingsMotif extends CustomPainter {
  const _SettingsMotif(this.color, this.seed);
  final Color color;
  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: .055)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (var i = 0; i < 10; i++) {
      final center = Offset(
        ((i * 89 + seed * 17) % 337) / 337 * size.width,
        ((i * 131 + seed * 23) % 557) / 557 * size.height,
      );
      if (seed.isEven) {
        canvas.drawCircle(center, 16.0 + i % 4 * 7, paint);
      } else {
        canvas.drawRect(
          Rect.fromCenter(center: center, width: 30, height: 30),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _SettingsMotif oldDelegate) => false;
}
