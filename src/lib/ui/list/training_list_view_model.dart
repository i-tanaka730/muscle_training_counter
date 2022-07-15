import 'dart:html';

import 'package:flutter/material.dart';

import '../../model/training_item.dart';
import '../../repository/training_repository.dart';

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

  List<TrainingItem> getAllTraningItems() {
    return _items;
  }
}
