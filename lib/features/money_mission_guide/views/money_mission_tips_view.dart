import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:todlrtest/core/helpers.dart';
import 'package:todlrtest/core/widgets/custom_button.dart';
import 'package:todlrtest/features/money_mission_guide/providers/money_mission_guide_providers.dart';
import 'package:todlrtest/features/money_mission_guide/views/end_view.dart';
import 'package:todlrtest/features/money_mission_guide/widgets/tips_view_widget.dart';
import 'package:todlrtest/models/tips_model.dart';
import 'package:todlrtest/theme/palette.dart';

class MoneyMissionTipsView extends ConsumerStatefulWidget {
  const MoneyMissionTipsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MoneyMissionTipsViewState();
}

class _MoneyMissionTipsViewState extends ConsumerState<MoneyMissionTipsView> {
  PageController tipsPageController = PageController();
  ValueNotifier<int> pageIndex = 0.notifier;
  ValueNotifier<bool> isPlaying = false.notifier;
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    isPlaying.value = true;
    playAudio();
  }

  void playAudio() async {
    await player.setAsset('tips'.audio);
    await player.setLoopMode(LoopMode.one);
    player.play();
  }

  @override
  void dispose() {
    player.dispose();
    pageIndex.dispose();
    tipsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<List<TipsModel>> asyncTips = ref.watch(getTipsProvider);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('background'.png), fit: BoxFit.cover),
        ),
        child: asyncTips.when(
          data: (List<TipsModel> tips) {
            return Stack(
              children: [
                SizedBox(
                  height: height(context),
                  width: width(context),
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: tipsPageController,
                    itemCount: tips.length,
                    itemBuilder: (context, index) {
                      return TipsViewWidget(
                        tips: tips[index],
                        index: index,
                      );
                    },
                  ),
                ),

                //! exit
                Positioned(
                  left: 35,
                  top: 40,
                  child: CustomButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    height: 30,
                    width: 30,
                    radius: 30,
                    isText: false,
                    item: Icon(
                      PhosphorIcons.bold.x,
                      color: Palette.neutralWhite,
                      size: 23,
                    ),
                  ),
                ),

                //! sound
                Positioned(
                  left: 20,
                  bottom: 20,
                  child: isPlaying.sync(
                    builder: (context, value, child) => CustomButton(
                        onTap: () async {
                          switch (isPlaying.value) {
                            case true:
                              player.pause();
                              isPlaying.value = false;
                              break;

                            case false:
                              player.play();
                              isPlaying.value = true;
                              break;
                            default:
                              () {};
                          }
                        },
                        height: 60,
                        width: 60,
                        radius: 20,
                        isText: false,
                        showShadow: true,
                        showBorder: true,
                        color: Palette.btnPink,
                        item: Icon(
                          isPlaying.value
                              ? PhosphorIcons.fill.speakerSimpleHigh
                              : PhosphorIcons.fill.speakerSimpleX,
                          color: Palette.neutralWhite,
                          size: 30,
                        )),
                  ),
                ),

                //! next
                Positioned(
                  right: 22,
                  bottom: 26,
                  child: pageIndex.sync(
                    builder: (context, value, child) => CustomButton(
                      onTap: () async {
                        if (pageIndex.value != tips.length - 1) {
                          pageIndex.value++;
                          tipsPageController.animateToPage(
                            pageIndex.value,
                            duration: 500.ms,
                            curve: Curves.linearToEaseOut,
                          );
                          switch (pageIndex.value) {
                            case 1:
                              await player.seek(9.seconds);
                              break;
                            case 2:
                              await player.seek(25500.ms);
                              break;
                            default:
                              () {};
                          }
                        } else {
                          pageIndex.value++;
                          tipsPageController.animateToPage(
                            pageIndex.value,
                            duration: 500.ms,
                            curve: Curves.linearToEaseOut,
                          );
                          player.pause();
                          fadeTo(context, const MoneyMissionEndView());
                        }
                      },
                      width: 180,
                      isText: false,
                      item: switch (pageIndex.value == tips.length - 1) {
                        false => 'Next Tip'.txt(
                            size: 16,
                            weight: FontWeight.w600,
                            color: Palette.neutralWhite,
                          ),
                        true => 'Mission Complete!'
                            .txt(
                              size: 16,
                              weight: FontWeight.w600,
                              color: Palette.neutralWhite,
                            )
                            .fadeInFromBottom(delay: 0.ms),
                      },
                    ).fadeInFromBottom(),
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) {
            error.toString().log();
            return const Column(
              children: [
                Text('An error occured'),
              ],
            );
          },
          loading: () => const Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ),
      ),
    );
  }
}
