import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:muscle_training_counter/ui/input/training_input_view_model.dart';
import 'package:muscle_training_counter/model/training_item.dart';

class TrainingInputPage extends StatefulWidget {
  final TrainingItem? item;

  const TrainingInputPage({Key? key, this.item}) : super(key: key);

  @override
  _TrainingInputPageState createState() => _TrainingInputPageState();
}

class _TrainingInputPageState extends State<TrainingInputPage> {
  late TextEditingController _nameEditingController;
  late TextEditingController _countEditingController;

  @override
  void initState() {
    super.initState();
    var _provider = Provider.of<TrainingInputViewModel>(context, listen: false);
    _provider.SetItem(widget.item);
    _nameEditingController = TextEditingController(text: _provider.name);
    _countEditingController = TextEditingController(text: _provider.count.toString());
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<TrainingInputViewModel>(context, listen: false);
    bool _isCreate = widget.item == null;
    return Scaffold(
      appBar: AppBar(
        // アプリケーションバーに表示するタイトル
        title: Text(_isCreate ? 'トレーニング追加' : 'トレーニング編集'),
      ),
      body: Container(
        // 全体のパディング
        padding: const EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            // 削除ボタン
            Visibility(
              visible: !_isCreate,
              child: Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog<void>(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              content: const Text('まじで削除するよ？'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('いいよ'),
                                  onPressed: () {
                                    _provider.deleteTraningItem();
                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                  },
                                ),
                                TextButton(
                                  child: const Text('やめる'),
                                  onPressed: () {
                                    _provider.deleteTraningItem();
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: const Text(
                      "削除",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // 名前のテキストフィールド
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "名前",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              controller: _nameEditingController,
              onChanged: (String value) {
                _provider.changeName(value);
              },
            ),
            const SizedBox(height: 20),
            // 回数のテキストフィールド
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: "回数",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              controller: _countEditingController,
              onChanged: (String value) {
                _provider.changeCount(value);
              },
            ),
            const SizedBox(height: 20),
            // 追加/更新ボタン
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_isCreate) {
                    _provider.addTraningItem();
                  } else {
                    _provider.updateTraningItem();
                  }
                  // トレーニング一覧画面に戻る
                  Navigator.of(context).pop();
                },
                child: Text(
                  _isCreate ? '追加' : '更新',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // キャンセルボタン
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  side: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                child: const Text(
                  "キャンセル",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
