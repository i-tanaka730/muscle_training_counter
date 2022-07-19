import 'package:flutter/material.dart';
import 'package:muscle_training_counter/repository/training_repository.dart';

class TrainingInputViewModel extends ChangeNotifier {
  String _name = "";
  int _count = 0;
  late TrainingRepository _repository;

  TrainingInputViewModel(TrainingRepository repository) {
    _repository = repository;
  }

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
