import 'package:flutter/material.dart';

class CustomFadeAnimation extends StatelessWidget {
  const CustomFadeAnimation(
      {super.key, required this.child, required this.anim});
  final Widget child;
  final Animation<double> anim;
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: child.key == const ValueKey('icon2')
          ? Tween<double>(begin: 1, end: 1).animate(anim)
          : Tween<double>(begin: 1, end: 1).animate(anim),
      child: FadeTransition(opacity: anim, child: child),
    );
  }
}

class CustomScaleAnimation extends StatelessWidget {
  const CustomScaleAnimation(
      {super.key, required this.child, required this.anim});
  final Widget child;
  final Animation<double> anim;
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: child.key == const ValueKey('icon2')
          ? Tween<double>(begin: 0.9, end: 1).animate(anim)
          : Tween<double>(begin: 1, end: 1).animate(anim),
      child: ScaleTransition(scale: anim, child: child),
    );
  }
}

class CustomRotationAnimation extends StatelessWidget {
  const CustomRotationAnimation(
      {super.key, required this.child, required this.anim});
  final Widget child;
  final Animation<double> anim;
  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: child.key == const ValueKey('openArrow')
          ? Tween<double>(begin: 0.9, end: 1).animate(anim)
          : Tween<double>(begin: 0.9, end: 1).animate(anim),
      child: ScaleTransition(scale: anim, child: child),
    );
  }
}
