import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../model/training_item.dart';

class TraningListPage extends StatefulWidget {
  const TraningListPage({Key? key}) : super(key: key);

  @override
  State<TraningListPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TraningListPage> {
  int _counter = 0;
  final List<TrainingItem> _traningItemlist = [
    TrainingItem("腕立て伏せ", 1500),
    TrainingItem("腹筋", 99999),
    TrainingItem("スクワット", 3000)
  ];

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    await FirebaseFirestore.instance.collection('menu').doc('腕立て伏せ').get().then((DocumentSnapshot snapshot) {
      var count = snapshot.get('count');
      debugPrint(count.toString());
      setState(() {
        _counter = count as int;
      });
    });
  }

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
    // ドキュメント作成
    await FirebaseFirestore.instance
        .collection('menu') // コレクションID
        .doc('腕立て伏せ') // ドキュメントID
        .set({'count': _counter}); // データ
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('筋トレ一覧'),
      ),
      body: ListView.builder(
          itemCount: _traningItemlist.length,
          itemBuilder: (context, index) {
            var item = _traningItemlist[index];
            return Slidable(
              child: Container(
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 50),
                      alignment: Alignment.centerLeft,
                      height: 60,
                      width: 200,
                      child: Text(item.getName()),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 60,
                      width: 50,
                      child: Text("999999"),
                    ),
                    Expanded(
                      child: ButtonBar(
                        children: <Widget>[
                          ElevatedButton(
                            child: const Text('+'),
                            onPressed: () {},
                          ),
                          ElevatedButton(
                            child: const Text('-'),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
