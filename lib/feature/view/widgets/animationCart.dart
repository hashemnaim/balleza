import 'package:flutter/material.dart';

class AnimationCart extends StatefulWidget {
  final int count;
  final int index;
  final Widget child;
  final bool grid;
  final int duration;
  AnimationCart(
      {this.count, this.index, this.child, this.grid = false, this.duration});

  @override
  _AnimationCartState createState() => _AnimationCartState();
}

class _AnimationCartState extends State<AnimationCart>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
        duration: Duration(
          milliseconds: widget.duration,
        ),
        vsync: this);
    _animation = Tween<double>(begin: 0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval((1 / widget.count) * widget.index, 1.0,
            curve: Curves.fastOutSlowIn)));
    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => FadeTransition(
        opacity: _animation,
        child: Transform(
          transform: Matrix4.translationValues(
              widget.grid ? 0.0 : 100 * (-1.0 + _animation.value),
              widget.grid ? 100 * (1.0 - _animation.value) : 0.0,
              0.0),
          child: widget.child,
        ),
      ),
    );
  }
}
