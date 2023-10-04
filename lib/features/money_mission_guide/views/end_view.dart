import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:todlrtest/core/helpers.dart';
import 'package:todlrtest/core/widgets/custom_button.dart';
import 'package:todlrtest/features/money_mission_guide/views/money_mission_start_view.dart';
import 'package:todlrtest/theme/palette.dart';

class MoneyMissionEndView extends ConsumerStatefulWidget {
  const MoneyMissionEndView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MoneyMissionEndViewState();
}

class _MoneyMissionEndViewState extends ConsumerState<MoneyMissionEndView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('background'.png), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            //! mission
            Align(
              alignment: const Alignment(0, -0.3),
              child: Container(
                height: height(context) * 0.7,
                width: width(context) * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Palette.borderPink, width: 10),
                ),
                child: Center(
                  child: 'Well Done!'
                      .txt(
                        size: 30,
                        weight: FontWeight.w600,
                        align: TextAlign.start,
                        color: Palette.purple,
                        height: 1.6,
                      )
                      .fadeInFromTop(delay: 400.ms),
                ),
              ),
            ),

            //! sound
            Positioned(
              left: 20,
              bottom: 20,
              child: CustomButton(
                onTap: () {},
                height: 60,
                width: 60,
                radius: 20,
                isText: false,
                showShadow: true,
                showBorder: true,
                color: Palette.btnPink,
                item: Icon(
                  PhosphorIcons.fill.speakerSimpleHigh,
                  color: Palette.neutralWhite,
                  size: 30,
                ),
              ),
            ),

            //! start mission
            Positioned(
              right: 45,
              bottom: 45,
              child: CustomButton(
                onTap: () {
                  // int count = 0;
                  // Navigator.of(context).popUntil((_) => count++ >= 2);
                  goToWithRizz(context, const MoneyMissionStartView());
                },
                width: 170,
                text: 'Restart',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
