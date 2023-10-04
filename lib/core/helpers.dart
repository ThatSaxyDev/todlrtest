import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "package:flutter_animate/flutter_animate.dart";

//! I wrote these to speed up work.
//! while the use of extensions in flutter go against the general widget tree pattern, they allow for faster code typing
//! and an overall developer efficiency boost (for me).

extension IconPath on String {
  String get png => 'lib/assets/images/$this.png';
  String get svg => 'lib/assets/vectors/$this.svg';
}

extension AudioPath on String {
  String get audio => 'lib/assets/audios/$this.m4a';
}

extension ValueNotifierExtension<T> on T {
  ValueNotifier<T> get notifier => ValueNotifier<T>(this);
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
fadeTo(BuildContext context, Widget view) {
  Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) {
        return view;
      },
      transitionDuration: const Duration(milliseconds: 1000),
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

goTo(BuildContext context, Widget view) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => view,
  ));
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
    Duration? animationDuration,
    Offset? offset,
  }) =>
      animate(delay: delay ?? 500.ms)
          .move(
            duration: animationDuration ?? 500.ms,
            begin: offset ?? const Offset(0, -10),
            curve: Curves.linearToEaseOut,
          )
          .fade(duration: animationDuration ?? 500.ms);

  Animate moveInFromTop({
    Duration? delay,
    Duration? animationDuration,
    Offset? offset,
  }) =>
      animate(delay: delay ?? 500.ms).move(
        duration: animationDuration ?? 500.ms,
        begin: offset ?? const Offset(0, -20),
        curve: Curves.linearToEaseOut,
      );

  Animate fadeInFromBottom({
    Duration? delay,
    Duration? animationDuration,
    Offset? offset,
  }) =>
      animate(delay: delay ?? 500.ms)
          .move(
            duration: animationDuration ?? 500.ms,
            begin: offset ?? const Offset(0, 10),
            curve: Curves.linearToEaseOut,
          )
          .fade(duration: animationDuration ?? 500.ms);

  Animate fadeIn({
    Duration? delay,
    Duration? animationDuration,
    Curve? curve,
  }) =>
      animate(delay: delay ?? 500.ms).fade(
        duration: animationDuration ?? 500.ms,
        curve: curve ?? Curves.decelerate,
      );
}

//! LOG EXTENSION - THIS HELPS TO CALL PRINT SAFELY ON ANY OBJECT
extension Log on Object {
  void log() {
    if (kDebugMode) {
      print(toString());
    }
  }
}
