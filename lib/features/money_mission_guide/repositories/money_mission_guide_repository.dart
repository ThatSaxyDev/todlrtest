import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todlrtest/models/tips_model.dart';

class MoneyMissionGuideRepository {
  final FirebaseFirestore _firestore;
  const MoneyMissionGuideRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  //! collection reference for tips collection
  CollectionReference get _tips => _firestore.collection('tips');

  //! get tips
  Stream<List<TipsModel>> getTipsForMission() {
    return _tips.snapshots().map((event) => event.docs
        .map((e) => TipsModel.fromMap(e.data() as Map<String, dynamic>))
        .toList());
  }
}
