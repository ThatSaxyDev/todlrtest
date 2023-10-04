import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todlrtest/core/firebase_provider.dart';
import 'package:todlrtest/features/money_mission_guide/controllers/money_mission_guide_controller.dart';
import 'package:todlrtest/features/money_mission_guide/repositories/money_mission_guide_repository.dart';
import 'package:todlrtest/models/tips_model.dart';

//! provider for the money mission repo
Provider<MoneyMissionGuideRepository> moneyMissionGuideRepositoryProvider =
    Provider((ref) {
  FirebaseFirestore firestore = ref.read(firestoreProvider);
  return MoneyMissionGuideRepository(firestore: firestore);
});

//! provider for the money mission controller
StateNotifierProvider<MoneyMissionGuideController, bool>
    moneyMissionGuideControllerProvider = StateNotifierProvider((ref) {
  MoneyMissionGuideRepository moneyMissionGuideRepository =
      ref.watch(moneyMissionGuideRepositoryProvider);
  return MoneyMissionGuideController(
      moneyMissionGuideRepository: moneyMissionGuideRepository);
});

//! stream provider to get tips
StreamProvider<List<TipsModel>> getTipsProvider = StreamProvider((ref) {
  MoneyMissionGuideController moneyMissionController =
      ref.watch(moneyMissionGuideControllerProvider.notifier);
  return moneyMissionController.getTipsForMission();
});
