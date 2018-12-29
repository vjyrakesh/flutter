class ShoppingList {
  String listName;
  String createdAt;

  ShoppingList(this.listName, this.createdAt);

  ShoppingList.fromMap(Map map) {
    listName = map[listName];
    createdAt = map[createdAt];
  }
}