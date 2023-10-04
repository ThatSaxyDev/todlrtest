import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todlrtest/core/helpers.dart';
import 'package:todlrtest/features/money_mission_guide/providers/money_mission_guide_providers.dart';
import 'package:todlrtest/features/money_mission_guide/widgets/tips_view_widget.dart';
import 'package:todlrtest/models/tips_model.dart';

class MoneyMissionTipsView extends ConsumerStatefulWidget {
  const MoneyMissionTipsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MoneyMissionTipsViewState();
}

class _MoneyMissionTipsViewState extends ConsumerState<MoneyMissionTipsView> {
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
                    itemCount: tips.length,
                    itemBuilder: (context, index) {
                      return TipsViewWidget(
                        tips: tips[index],
                        index: index,
                      );
                    },
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
