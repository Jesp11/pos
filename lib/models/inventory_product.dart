import 'package:pos/models/products.dart';

class InventoryProduct extends Product {
  int availableQuantity;

  InventoryProduct({
    required String name,
    required int price,
    required int quantity,
    required String category,
    required String supplier,
    required this.availableQuantity,
  }) : super(
          name: name,
          price: price,
          quantity: quantity,
          category: category,
          supplier: supplier,
        );
}
