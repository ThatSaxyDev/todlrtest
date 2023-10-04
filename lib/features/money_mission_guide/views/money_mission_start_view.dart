import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:todlrtest/core/helpers.dart';
import 'package:todlrtest/core/widgets/custom_button.dart';
import 'package:todlrtest/features/money_mission_guide/views/money_mission_tips_view.dart';
import 'package:todlrtest/theme/palette.dart';

class MoneyMissionStartView extends ConsumerStatefulWidget {
  const MoneyMissionStartView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MoneyMissionStartViewState();
}

class _MoneyMissionStartViewState extends ConsumerState<MoneyMissionStartView> {
  PageController startMissionPageController = PageController();
  ValueNotifier<int> startMissionProgressIndex = 0.beamer;

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
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: startMissionPageController,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        'Mission 1'
                            .txt(
                              size: 24,
                              weight: FontWeight.w600,
                              color: Palette.purple,
                            )
                            .fadeInFromTop(),
                        5.sbH,
                        'Identify Needs and Wants at the\nGrocery Store'
                            .txt(size: 20, align: TextAlign.center)
                            .fadeInFromBottom(),
                        50.sbH,
                      ],
                    ),
                    Center(
                      child:
                          'Hey there, young adventurer,\nIt\'s time for your first mission. Your\nmission is to team up with mum or\ndad to identify and categorise items\naround you that are needs or wants.\nGood Luck!!'
                              .txt(
                                size: 19,
                                align: TextAlign.start,
                                color: Palette.purple,
                                height: 1.6,
                              )
                              .fadeInFromTop(delay: 400.ms),
                    ),
                  ],
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
              child: startMissionProgressIndex.sync(
                builder: (context, value, child) => CustomButton(
                  onTap: () {
                    if (startMissionProgressIndex.value == 0) {
                      startMissionPageController
                          .animateToPage(
                        1,
                        duration: 300.ms,
                        curve: Curves.easeIn,
                      )
                          .whenComplete(() {
                        startMissionProgressIndex.value = 1;
                      });
                    } else {
                      goToWithRizz(context, const MoneyMissionTipsView());
                    }
                  },
                  width: 170,
                  isText: false,
                  text: 'Start Mission',
                  item: switch (startMissionProgressIndex.value) {
                    0 => 'Start Mission'.txt(
                        size: 16,
                        weight: FontWeight.w600,
                        color: Palette.neutralWhite,
                      ),
                    _ => 'Go!'
                        .txt(
                          size: 16,
                          weight: FontWeight.w600,
                          color: Palette.neutralWhite,
                        )
                        .fadeInFromBottom(delay: 0.ms),
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
