// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todlrtest/core/helpers.dart';

class FadeSwitcher extends StatefulWidget {
  final Widget firstChild;
  final Widget secondChild;
  final ValueNotifier<bool> first;
  const FadeSwitcher({
    Key? key,
    required this.firstChild,
    required this.secondChild,
    required this.first,
  }) : super(key: key);

  @override
  State<FadeSwitcher> createState() => _FadeSwitcherState();
}

class _FadeSwitcherState extends State<FadeSwitcher> {
  @override
  Widget build(BuildContext context) {
    return widget.first.sync(
      builder: (context, value, child) => AnimatedCrossFade(
        firstCurve: Curves.easeOutBack,
        secondCurve: Curves.easeInBack,
        firstChild: widget.firstChild,
        secondChild: widget,
        crossFadeState:
            widget.first.value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
