import 'package:muscle_training_counter/model/training_item.dart';

abstract class TrainingRepository {
  List<TrainingItem> getAllTraningItems();
  void addTraningItem(String name, [int? count = 0]);
  void updateTraningItem(String id, [String? name, int? count]);
  void deleteTraningItem(String id);
}
