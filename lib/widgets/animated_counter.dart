import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  final int initialValue;
  final int maxValue;
  final Duration animationDuration;
  final Color? primaryColor;

  const AnimatedCounter({
    super.key,
    this.initialValue = 0,
    this.maxValue = 100,
    this.animationDuration = const Duration(milliseconds: 300),
    this.primaryColor,
  })  : assert(maxValue > 0),
        assert(initialValue >= 0),
        assert(initialValue <= maxValue);

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with TickerProviderStateMixin {
  late int count;
  late AnimationController _controller;
  late Animation<double> _animation;

  bool get isMax => count >= widget.maxValue;

  @override
  void initState() {
    super.initState();

    count = widget.initialValue;

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.animationDuration != widget.animationDuration) {
      _controller.duration = widget.animationDuration;
    }

    if (oldWidget.initialValue != widget.initialValue ||
        oldWidget.maxValue != widget.maxValue) {
      count = count.clamp(0, widget.maxValue);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _animateTap() async {
    await _controller.forward(from: 0);

    if (mounted) {
      await _controller.reverse();
    }
  }

  void _increment() {
    if (isMax) return;

    setState(() {
      count++;
    });

    _animateTap();
  }

  void _decrement() {
    if (count <= 0) return;

    setState(() {
      count--;
    });

    _animateTap();
  }

  void _reset() {
    setState(() {
      count = widget.initialValue;
    });

    _animateTap();
  }

  @override
  Widget build(BuildContext context) {
    final progress = count / widget.maxValue;
    final baseColor =
        widget.primaryColor ?? Theme.of(context).colorScheme.primary;

    final progressColor = Color.lerp(
      baseColor,
      Colors.green,
      progress,
    )!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Animated Counter',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),

            ScaleTransition(
              scale: _animation,
              child: AnimatedDefaultTextStyle(
                duration: widget.animationDuration,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isMax ? Colors.green : progressColor,
                    ),
                child: Text('$count'),
              ),
            ),

            const SizedBox(height: 16),

            TweenAnimationBuilder<double>(
              tween: Tween<double>(end: progress),
              duration: widget.animationDuration,
              builder: (context, value, child) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: value,
                    minHeight: 10,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progressColor,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 8),
            Text('$count / ${widget.maxValue}'),
            const SizedBox(height: 16),

            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [
                IconButton.filled(
                  onPressed: _decrement,
                  tooltip: 'Зменшити',
                  icon: const Icon(Icons.remove),
                ),
                IconButton.filled(
                  onPressed: _increment,
                  tooltip: 'Збільшити',
                  icon: const Icon(Icons.add),
                ),
                IconButton.outlined(
                  onPressed: _reset,
                  tooltip: 'Скинути',
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),

            if (isMax)
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  'Максимум досягнуто!',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}