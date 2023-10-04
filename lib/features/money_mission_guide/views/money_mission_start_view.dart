import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
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
    await player.setAsset('heythere'.audio);
    await player.setLoopMode(LoopMode.one);
    player.play();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

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

            //! go button
            Positioned(
              right: 45,
              bottom: 45,
              child: CustomButton(
                onTap: () async {
                  player.pause();
                  fadeTo(context, const MoneyMissionTipsView());
                },
                width: 170,
                text: 'Go',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
