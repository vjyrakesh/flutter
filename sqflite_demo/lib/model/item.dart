/// Model class to represent a shopping item.

class Item {
  String name;

  Item(this.name);

  Item.fromMap(Map map) {
    name = map[name];
  }
}