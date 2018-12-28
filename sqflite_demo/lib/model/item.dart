class Item {
  String name;

  Item(this.name);

  Item.fromMap(Map map) {
    name = map[name];
  }
}