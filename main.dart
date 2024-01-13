import 'dart:io';

class MenuItem {
  String name;
  double price;

  MenuItem(this.name, this.price);
}

class OrderItem {
  MenuItem item;
  int quantity;

  OrderItem(this.item, this.quantity);
}

class Menu {
  List<MenuItem> items = [];

  void addItem(String name, double price) {
    var newItem = MenuItem(name, price);
    items.add(newItem);
    print("$name added to the menu with price \$${price.toStringAsFixed(2)}");
  }

  void displayMenu() {
    if (items.isEmpty) {
      print("Menu is empty.");
    } else {
      print("Menu:");
      for (var i = 0; i < items.length; i++) {
        print(
            "${i + 1}. ${items[i].name} - \$${items[i].price.toStringAsFixed(2)}");
      }
    }
  }
}

class Order {
  List<OrderItem> items = [];

  double calculateTotal() {
    return items
        .map((orderItem) => orderItem.item.price * orderItem.quantity)
        .fold(0, (a, b) => a + b);
  }

  void displayOrder() {
    if (items.isEmpty) {
      print("Order is empty.");
    } else {
      print("Order:");
      for (var i = 0; i < items.length; i++) {
        print("${i + 1}. ${items[i].item.name} - "
            "\$${items[i].item.price.toStringAsFixed(2)} - "
            "Quantity: ${items[i].quantity}");
      }
      print("Total: \$${calculateTotal().toStringAsFixed(2)}");
    }
  }
}

void main() {
  var menu = Menu();
  var order = Order();

  print("Welcome to the Restaurant Management System!");

  while (true) {
    print("\nOptions:");
    print("1. Add Item to Menu");
    print("2. Display Menu");
    print("3. Add Item to Order");
    print("4. Display Order and Total");
    print("5. Exit");

    stdout.write("Enter your choice: ");
    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write("Enter item name: ");
        var itemName = stdin.readLineSync();
        stdout.write("Enter item price: ");
        var itemPrice = double.parse(stdin.readLineSync()!);

        menu.addItem(itemName!, itemPrice);
        break;

      case '2':
        menu.displayMenu();
        break;

      case '3':
        if (menu.items.isEmpty) {
          print("Menu is empty. Please add items to the menu first.");
        } else {
          menu.displayMenu();
          stdout.write("Enter the item number to add to the order: ");
          var itemNumber = int.parse(stdin.readLineSync()!) - 1;

          if (itemNumber >= 0 && itemNumber < menu.items.length) {
            stdout.write("Enter quantity: ");
            var quantity = int.parse(stdin.readLineSync()!);

            var orderItem = OrderItem(menu.items[itemNumber], quantity);
            order.items.add(orderItem);
            print(
                "${menu.items[itemNumber].name} added to the order with quantity $quantity.");
          } else {
            print("Invalid item number.");
          }
        }
        break;

      case '4':
        order.displayOrder();
        break;

      case '5':
        print("Exiting the Bakery Management System. Goodbye!");
        return;

      default:
        print("Invalid choice. Please enter a valid option.");
    }
  }
}
