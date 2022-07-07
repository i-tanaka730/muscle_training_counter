import 'package:flutter/material.dart';
import '../../model/training_item.dart';

class TrainingInputPage extends StatefulWidget {
  /// Todoのモデル
  final TrainingItem? item;

  /// コンストラクタ
  /// Todoを引数で受け取った場合は更新、受け取らない場合は追加画面となる
  const TrainingInputPage({Key? key, this.item}) : super(key: key);

  /// Todo入力画面の状態を生成する
  @override
  State<TrainingInputPage> createState() => _TrainingInputPageState();
}

class _TrainingInputPageState extends State<TrainingInputPage> {
  /// 新規追加か
  late bool _isCreateTodo;

  /// 画面項目：名前
  late String _name;

  /// 画面項目：回数
  late int _count;

  /// 初期処理を行う
  @override
  void initState() {
    super.initState();
    var item = widget.item;

    _name = item?.getName() ?? "";
    _count = item?.getCount() ?? 0;
    _isCreateTodo = item == null;
  }

  /// 画面を作成する
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // アプリケーションバーに表示するタイトル
        title: Text(_isCreateTodo ? 'トレーニング追加' : 'トレーニング編集'),
      ),
      body: Container(
        // 全体のパディング
        padding: const EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            // 削除ボタン
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    // Todoリスト画面に戻る
                    Navigator.of(context).pop();
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
              // TextEditingControllerを使用することで、いちいちsetStateしなくても画面を更新してくれる
              controller: TextEditingController(text: _name),
              onChanged: (String value) {
                _name = value;
              },
            ),
            const SizedBox(height: 20),
            // 回数のテキストフィールド
            TextField(
              autofocus: true,
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
              // TextEditingControllerを使用することで、いちいちsetStateしなくても画面を更新してくれる
              controller: TextEditingController(text: _count.toString()),
              onChanged: (String value) {
                _count = int.parse(value);
              },
            ),
            const SizedBox(height: 20),
            // 追加/更新ボタン
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_isCreateTodo) {
                    // TODO:トレーニングを追加する
                  } else {
                    // TODO:トレーニングを更新する
                  }
                  // トレーニング一覧画面に戻る
                  Navigator.of(context).pop();
                },
                child: Text(
                  _isCreateTodo ? '追加' : '更新',
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
                  // Todoリスト画面に戻る
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
