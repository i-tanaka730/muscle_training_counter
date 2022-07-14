import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../model/training_item.dart';
import '../input/training_input_page.dart';

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

  /// トレーニング入力・編集画面に遷移する
  void _pushTraningInputPage([TrainingItem? item]) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return TrainingInputPage(item: item);
        },
      ),
    );

    // Todoの追加/更新を行う場合があるため、画面を更新する
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('トレーニング一覧'),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
            alignment: Alignment.center,
            height: 60,
            width: double.infinity,
            child: Row(children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                height: 60,
                width: 120,
                child: const Text("合計"),
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 60,
                width: 50,
                child: const Text("999999"),
              ),
            ]),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _traningItemlist.length,
                itemBuilder: (context, index) {
                  var item = _traningItemlist[index];
                  return Slidable(
                    // 左方向にリストアイテムをスライドした場合のアクション
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            // 編集画面に遷移する
                            _pushTraningInputPage(item);
                          },
                          backgroundColor: Colors.yellow,
                          icon: Icons.edit,
                          label: '編集',
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            alignment: Alignment.centerLeft,
                            height: 60,
                            width: 120,
                            child: Text(item.getName()),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 60,
                            width: 50,
                            child: const Text("999999"),
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
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // 入力画面に遷移する
            _pushTraningInputPage,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
