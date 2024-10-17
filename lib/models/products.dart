class Product {
  final String name;
  final String category;
  final String supplier;
  final int price;
  final int quantity;

  Product({required this.name, required this.category, required this.price, required this.supplier, required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'supplier': supplier,
      'price': price,
      'quantity': quantity,
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'],
      category: map['category'],
      supplier: map['supplier'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }
}
