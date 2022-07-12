import 'package:muscle_training_counter/repository/training_repository.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreTrainingRepository implements TrainingRepository {
  void addTraningItem(String name) {
    FirebaseFirestore.instance.collection('menu').add({'name': name, 'count': 0});
  }
}
