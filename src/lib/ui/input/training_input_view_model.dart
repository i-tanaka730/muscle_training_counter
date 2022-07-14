import 'package:flutter/material.dart';
import 'package:muscle_training_counter/repository/firestore_training_repository.dart';

class TrainingInputViewModel extends ChangeNotifier {
  String _name = "";
  int _count = 0;

  final FireStoreTrainingRepository _repository = FireStoreTrainingRepository();

  void changeName(String name) {
    _name = name;
    notifyListeners();
  }

  void changeCount(String count) {
    _count = int.parse(count);
    notifyListeners();
  }

  void addTraningItem() {
    _repository.addTraningItem(_name, _count);
  }

  void updateTraningItem(String id) {
    _repository.updateTraningItem(id, _name, _count);
  }

  void deleteTraningItem(String id) {
    _repository.deleteTraningItem(id);
  }
}
