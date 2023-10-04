// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:todlrtest/theme/palette.dart';

class CustomButton extends StatefulWidget {
  final double? height;
  final double? width;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? radius;
  final void Function()? onTap;
  final Color? color;
  final Widget? item;
  final String? text;
  final bool isText;
  final Color? textColor;
  final bool showBorder;
  final bool showShadow;
  const CustomButton({
    Key? key,
    this.height,
    this.width,
    this.fontSize,
    this.fontWeight,
    this.radius,
    this.onTap,
    this.color,
    this.item,
    this.text,
    this.isText = true,
    this.textColor,
    this.showBorder = false,
    this.showShadow = false,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap!.call();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      child: Transform.scale(
        scale: _scale,
        child: Container(
          height: widget.height ?? 50,
          width: widget.width ?? double.infinity,
          decoration: BoxDecoration(
            color: widget.color ?? Palette.purple,
            borderRadius: BorderRadius.all(
              Radius.circular(widget.radius ?? 30),
            ),
            border: Border.all(
              width: 0.5,
              color:
                  widget.showBorder ? Palette.neutralBlack.withOpacity(0.5) : Colors.transparent,
            ),
            boxShadow: widget.showShadow
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2.0,
                      offset: const Offset(0.0, 3),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: widget.isText == true
                ? Text(
                    widget.text ?? '',
                    style: TextStyle(
                      fontSize: widget.fontSize ?? 16,
                      fontWeight: widget.fontWeight ?? FontWeight.w600,
                      color: widget.textColor ?? Palette.neutralWhite,
                    ),
                  )
                : widget.item,
          ),
        ),
      ),
    );
  }
}
