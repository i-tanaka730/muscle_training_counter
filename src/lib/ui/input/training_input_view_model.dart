import 'package:flutter/material.dart';
//import 'package:muscle_training_counter/model/training_item.dart';
import 'package:muscle_training_counter/repository/firestore_training_repository.dart';

class TrainingInputViewModel extends ChangeNotifier {
  String _name = "いっきー";
  String get name => _name;

  final FireStoreTrainingRepository _repository = FireStoreTrainingRepository();
  void addTraningItem() {
    _repository.addTraningItem(_name);
  }
}
