import 'package:flutter/material.dart';
import "package:flutter_animate/flutter_animate.dart";

//! I wrote these to speed up work.
//! while the use of extensions in flutter go against the general widget tree pattern, they allow for faster code typing
//! and an overall developer efficiency boost (for me).

extension IconPath on String {
  String get png => 'lib/assets/images/$this.png';
  String get svg => 'lib/assets/vectors/$this.svg';
}

extension ValueNotifierExtension<T> on T {
  ValueNotifier<T> get beamer => ValueNotifier<T>(this);
}

//! extension for listening to ValueNotifier instances.
extension ValueNotifierBuilderExtension<T> on ValueNotifier<T> {
  Widget sync({
    required Widget Function(BuildContext context, T value, Widget? child)
        builder,
  }) {
    return ValueListenableBuilder<T>(
      valueListenable: this,
      builder: builder,
    );
  }
}

//! extension for listening to a list of ValueNotifier instances.
extension ListenableBuilderExtension on List<Listenable> {
  Widget multiSync({
    required Widget Function(BuildContext context, Widget? child) builder,
  }) {
    return ListenableBuilder(
      listenable: Listenable.merge(this),
      builder: builder,
    );
  }
}

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

//! fade page transition
goToWithRizz(BuildContext context, Widget view) {
  Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) {
        return view;
      },
      transitionDuration: const Duration(milliseconds: 2000),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        animation = CurvedAnimation(
          curve: Curves.linearToEaseOut,
          parent: animation,
        );
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      }));
}

//! text extension
extension StyledTextExtension on String {
  Text txt({
    double? size,
    Color? color,
    FontWeight? weight,
    String? fontFamily,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? align,
    int? maxLines,
    double? height,
  }) {
    return Text(
      this,
      overflow: overflow,
      textAlign: align,
      maxLines: maxLines,
      style: TextStyle(
        height: height,
        fontSize: size,
        color: color,
        fontWeight: weight,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }
}

extension WidgetExtensions on num {
  Widget get sbH => SizedBox(
        height: toDouble(),
      );

  Widget get sbW => SizedBox(
        width: toDouble(),
      );

  EdgeInsetsGeometry get padA => EdgeInsets.all(toDouble());

  EdgeInsetsGeometry get padV => EdgeInsets.symmetric(vertical: toDouble());

  EdgeInsetsGeometry get padH => EdgeInsets.symmetric(horizontal: toDouble());
}

extension WidgetAnimation on Widget {
  Animate fadeInFromTop({
    Duration? delay,
    Duration? animatiomDuration,
    Offset? offset,
  }) =>
      animate(delay: delay ?? 500.ms)
          .move(
            duration: animatiomDuration ?? 500.ms,
            begin: offset ?? const Offset(0, -1),
          )
          .fade(duration: animatiomDuration ?? 500.ms);

  Animate fadeInFromBottom({
    Duration? delay,
    Duration? animatiomDuration,
    Offset? offset,
  }) =>
      animate(delay: delay ?? 500.ms)
          .move(
            duration: animatiomDuration ?? 500.ms,
            begin: offset ?? const Offset(0, 10),
          )
          .fade(duration: animatiomDuration ?? 500.ms);

  Animate fadeIn({
    Duration? delay,
    Duration? animatiomDuration,
    Curve? curve,
  }) =>
      animate(delay: delay ?? 500.ms).fade(
        duration: animatiomDuration ?? 500.ms,
        curve: curve ?? Curves.decelerate,
      );
}
