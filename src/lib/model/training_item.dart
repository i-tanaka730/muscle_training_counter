class TrainingItem {
  String _name;
  int _count;

  TrainingItem(this._name, this._count);

  String getName() => _name;
  int getCount() => _count;
  void changeName(String name) => _name = name;
  void changeCount(int count) => _count = count;
}
