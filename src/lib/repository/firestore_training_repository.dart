import 'package:muscle_training_counter/model/training_item.dart';
import 'package:muscle_training_counter/repository/training_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreTrainingRepository implements TrainingRepository {
  @override
  Future<List<TrainingItem>> getAllTraningItems() async {
    List<TrainingItem> items = [];
    await FirebaseFirestore.instance.collection('menu').get().then((QuerySnapshot querySnapshot) {
      var queryDocSnapshot = querySnapshot.docs;
      for (final snapshot in queryDocSnapshot) {
        var name = snapshot.get('name');
        var count = snapshot.get('count');
        var item = TrainingItem(snapshot.id, name, count);
        items.add(item);
      }
    });
    return items;
  }

  @override
  void addTraningItem(String name, [int? count = 0]) {
    FirebaseFirestore.instance.collection('menu').add({'name': name, 'count': count});
  }

  @override
  void updateTraningItem(String id, [String? name, int? count]) {
    Map<String, dynamic> data = {};
    if (name != null) data.addAll({'name': name});
    if (count != null) data.addAll({'count': count});
    if (data.isEmpty) return;

    FirebaseFirestore.instance.collection('menu').doc(id).update(data);
  }

  @override
  void deleteTraningItem(String id) {
    FirebaseFirestore.instance.collection('menu').doc(id).delete();
  }
}
