// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:todlrtest/core/helpers.dart';
import 'package:todlrtest/models/tips_model.dart';
import 'package:todlrtest/theme/palette.dart';

class TipsViewWidget extends StatelessWidget {
  final TipsModel tips;
  final int index;
  const TipsViewWidget({
    Key? key,
    required this.tips,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(context),
      width: width(context),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: CustomPaint(
              size: const Size(400, 200),
              painter: CurvedDottedLinePainter(),
            ),
          ),
          if (index != 0)
            Align(
              alignment: Alignment.bottomLeft,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..scale(1.0, -1.0, 1.0),
                child: CustomPaint(
                  size: const Size(400, 200),
                  painter: CurvedDottedLinePainter(),
                ),
              ),
            ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 530,
              margin: const EdgeInsets.only(right: 140),
              child: Stack(
                children: [
                  //! handle bar
                  Align(
                    alignment: const Alignment(1, -0.2),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(-1.3),
                      child: Container(
                        height: 15,
                        width: 170,
                        decoration: BoxDecoration(
                          color: Palette.darkBlue,
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Palette.neutralWhite, width: 2),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //! title container
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 30,
                          width: 200,
                          margin: 40.padH,
                          padding: 10.padH,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: tips.title!.txt(
                              color: Palette.darkBlue,
                              weight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      //! point container
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 170,
                          width: 430,
                          margin: const EdgeInsets.only(bottom: 20, left: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                          decoration: BoxDecoration(
                            color: Palette.beige,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                                color: Palette.neutralWhite, width: 3),
                          ),
                          child: Center(
                            child: AutoSizeText(
                              tips.point!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Palette.neutralWhite,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //! wheels
                  Positioned(
                    bottom: 1.5,
                    left: 70,
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 16,
                          backgroundColor: Palette.neutralWhite,
                          child: CircleAvatar(
                            radius: 13,
                            backgroundColor: Palette.darkBlue,
                          ),
                        ),
                        210.sbW,
                        const CircleAvatar(
                          radius: 16,
                          backgroundColor: Palette.neutralWhite,
                          child: CircleAvatar(
                            radius: 13,
                            backgroundColor: Palette.darkBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).moveInFromTop(delay: 500.ms),
          )
        ],
      ),
    );
  }
}

class CurvedDottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Path path = Path()
      ..moveTo(0, size.height / 2)
      ..quadraticBezierTo(
          size.width / 6, size.height / 4, size.width / 3, size.height / 2)
      ..quadraticBezierTo(size.width / 2, 3 * size.height / 4,
          2 * size.width / 3, size.height / 2)
      ..quadraticBezierTo(
          5 * size.width / 6, size.height / 4, size.width, size.height / 2);

    // Define the length of the dash and gap
    const double dashLength = 5;
    const double gapLength = 5;

    double distance = 0;
    bool isDash = true;

    while (distance < path.computeMetrics().single.length) {
      final double remainingLength = isDash ? dashLength : gapLength;
      distance += remainingLength;

      final Offset p1 =
          path.computeMetrics().single.getTangentForOffset(distance)!.position;

      if (isDash) {
        canvas.drawLine(
            p1,
            path
                .computeMetrics()
                .single
                .getTangentForOffset(distance + gapLength)!
                .position,
            paint);
      }
      isDash = !isDash;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
