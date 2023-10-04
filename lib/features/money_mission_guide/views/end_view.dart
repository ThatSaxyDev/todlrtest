import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:todlrtest/core/helpers.dart';
import 'package:todlrtest/core/widgets/custom_button.dart';
import 'package:todlrtest/features/money_mission_guide/providers/money_mission_guide_providers.dart';
import 'package:todlrtest/features/money_mission_guide/views/start_view.dart';
import 'package:todlrtest/theme/palette.dart';

class MoneyMissionEndView extends ConsumerStatefulWidget {
  const MoneyMissionEndView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MoneyMissionEndViewState();
}

class _MoneyMissionEndViewState extends ConsumerState<MoneyMissionEndView> {
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
    await player.setAsset('well'.audio);

    player.play();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int points = ref.watch(pointsControllerProvider);
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

            //! lightning
            Positioned(
              right: 40,
              top: 40,
              child: Row(
                children: [
                  Icon(
                    PhosphorIcons.fill.lightning,
                    size: 30,
                    color: Palette.liteYellow,
                  ),
                  points.toString().txt(size: 22, color: Palette.neutralWhite),
                ],
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

            //! start mission
            Positioned(
              right: 45,
              bottom: 45,
              child: CustomButton(
                onTap: () {
                  player.pause();
                  ref.read(pointsControllerProvider.notifier).resetPoints();
                  fadeTo(context, const StartView());
                },
                width: 170,
                text: 'Restart',
              ).fadeInFromBottom(),
            ),
          ],
        ),
      ),
    );
  }
}
