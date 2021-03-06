import 'package:flutter/material.dart';
import 'package:muscle_training_counter/repository/firestore_training_repository.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:muscle_training_counter/ui/list/training_list_page.dart';
import 'package:muscle_training_counter/ui/list/training_list_view_model.dart';
import 'package:muscle_training_counter/ui/input/training_input_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var repository = FireStoreTrainingRepository();
  runApp(
    MultiProvider(
      providers: [
        // 各画面クラスに1つクラスを挟み、そこで登録すべき？
        // https://github.com/yasukotelin/mvvm_example/blob/master/lib/ui/home/home_page.dart
        ChangeNotifierProvider(create: (_) => TrainingListViewModel(repository)),
        ChangeNotifierProvider(create: (_) => TrainingInputViewModel(repository)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '筋トレカウンター',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TraningListPage(),
    );
  }
}
