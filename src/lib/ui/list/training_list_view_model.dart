import 'package:flutter/material.dart';
import 'package:muscle_training_counter/model/training_item.dart';
import 'package:muscle_training_counter/repository/training_repository.dart';

class TrainingListViewModel extends ChangeNotifier {
  List<TrainingItem> _items = [];
  late TrainingRepository _repository;

  TrainingListViewModel(TrainingRepository repository) {
    _repository = repository;
    load();
  }

  void load() async {
    _items = await _repository.getAllTraningItems();
    notifyListeners();
  }

  List<TrainingItem> getItems() {
    return _items;
  }

  int getTotalCount() {
    var count = 0;
    _items.forEach((element) => count += element.getCount());
    return count;
  }
}
