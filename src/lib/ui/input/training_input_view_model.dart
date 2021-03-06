import 'package:flutter/material.dart';
import 'package:muscle_training_counter/model/training_item.dart';
import 'package:muscle_training_counter/repository/training_repository.dart';

class TrainingInputViewModel extends ChangeNotifier {
  late TrainingRepository _repository;
  String? _id;
  String _name = "";
  int _count = 0;

  String get name => _name;
  int get count => _count;

  TrainingInputViewModel(TrainingRepository repository) {
    _repository = repository;
  }

  void SetItem(TrainingItem? item) {
    if (item != null) {
      _id = item.getId();
      _name = item.getName();
      _count = item.getCount();
    } else {
      _id = null;
      _name = "";
      _count = 0;
    }
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

  void updateTraningItem() {
    if (_id == null) return;
    _repository.updateTraningItem(_id!, _name, _count);
  }

  void deleteTraningItem() {
    if (_id == null) return;
    _repository.deleteTraningItem(_id!);
  }
}
