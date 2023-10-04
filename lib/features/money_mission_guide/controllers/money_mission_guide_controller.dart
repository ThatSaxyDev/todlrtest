import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todlrtest/features/money_mission_guide/repositories/money_mission_guide_repository.dart';
import 'package:todlrtest/models/tips_model.dart';

class MoneyMissionGuideController extends StateNotifier<bool> {
  final MoneyMissionGuideRepository _moneyMissionGuideRepository;
  MoneyMissionGuideController(
      {required MoneyMissionGuideRepository moneyMissionGuideRepository})
      : _moneyMissionGuideRepository = moneyMissionGuideRepository,
        super(false);

  //! get tips
  Stream<List<TipsModel>> getTipsForMission() {
    return _moneyMissionGuideRepository.getTipsForMission();
  }
}
