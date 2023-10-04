import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:todlrtest/core/helpers.dart';
import 'package:todlrtest/core/widgets/custom_button.dart';
import 'package:todlrtest/core/widgets/switcher.dart';
import 'package:todlrtest/features/money_mission_guide/providers/money_mission_guide_providers.dart';
import 'package:todlrtest/models/tips_model.dart';
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
    AsyncValue<List<TipsModel>> asyncTips = ref.watch(getTipsProvider);
    return Scaffold(
      // body: asyncTips.when(
      //   data: (List<TipsModel> tips) {
      //     print(tips[0].title);
      //     return Center();
      //   },
      //   error: (error, stackTrace) {
      //     print(error.toString());
      //     return const Column(
      //       children: [
      //         Text('An error occured'),
      //       ],
      //     );
      //   },
      //   loading: () => const Center(
      //     child: SizedBox(
      //       height: 50,
      //       width: 50,
      //       child: CircularProgressIndicator.adaptive(),
      //     ),
      //   ),
      // ),
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
                              .fadeInFromBottom(delay: 400.ms),
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
                    startMissionPageController
                        .animateToPage(
                      1,
                      duration: 300.ms,
                      curve: Curves.easeIn,
                    )
                        .whenComplete(() {
                      startMissionProgressIndex.value = 1;
                    });
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
                    _ => 'Go!'.txt(
                        size: 16,
                        weight: FontWeight.w600,
                        color: Palette.neutralWhite,
                      ).fadeInFromBottom(delay: 0.ms),
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
