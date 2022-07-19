import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:muscle_training_counter/ui/list/training_list_view_model.dart';
import 'package:muscle_training_counter/ui/input/training_input_page.dart';
import 'package:muscle_training_counter/model/training_item.dart';

class TraningListPage extends StatelessWidget {
  const TraningListPage({Key? key}) : super(key: key);

  @override
  StatelessElement createElement() => StatelessElement(this);

  void _pushTraningInputPage(BuildContext context, [TrainingItem? item]) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          var addItem = TrainingInputPage(item: item);
          Provider.of<TrainingListViewModel>(context).load();
          return addItem;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var traningItems = Provider.of<TrainingListViewModel>(context).getItems();
    var totalCount = Provider.of<TrainingListViewModel>(context).getTotalCount();
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
                child: Text(totalCount.toString()),
              ),
            ]),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: traningItems.length,
                itemBuilder: (context, index) {
                  var item = traningItems[index];
                  return Slidable(
                    // 左方向にリストアイテムをスライドした場合のアクション
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            // 編集画面に遷移する
                            _pushTraningInputPage(context, item);
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
                            child: Text(item.getCount().toString()),
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
        onPressed: () => _pushTraningInputPage(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
