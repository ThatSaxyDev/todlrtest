import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//! the provider for the cloud firestore instance
Provider<FirebaseFirestore> firestoreProvider =
    Provider((ref) => FirebaseFirestore.instance);
