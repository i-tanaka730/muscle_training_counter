import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:muscle_training_counter/ui/list/training_list_page.dart';
import 'package:provider/provider.dart';
import 'package:muscle_training_counter/ui/input/training_input_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //←Firebaseを初期化する際に必要らしい
  await Firebase.initializeApp(); //←Firebaseを初期化
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TrainingInputViewModel()),
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
