/// Model class to represent an item in a shopping list.

class ShoppingListItem {
  String itemName;
  String itemQuantity;

  ShoppingListItem(this.itemName, this.itemQuantity);

  ShoppingListItem.fromMap(Map map) {
    itemName = map[itemName];
    itemQuantity = map[itemQuantity];
  }
}