import 'package:flutter_riverpod/flutter_riverpod.dart';

class PointsController extends StateNotifier<int> {
  PointsController() : super(0);

  //! add to points
  void addToPoints() {
    state++;
  }

  //! set to points
  void resetPoints() {
    state = 0;
  }
}
