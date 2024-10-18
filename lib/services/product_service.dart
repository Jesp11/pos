import 'package:hive/hive.dart';
import 'package:pos/models/products.dart';

class ProductService {
  final Box productBox;

  ProductService() : productBox = Hive.box('productBox');

  Future<bool> registerProduct({
    required String name,
    required String category,
    required String supplier,
    required int price,
    required int quantity,
  }) async {
    try {
      final product = Product(
        name: name,
        category: category,
        supplier: supplier,
        price: price,
        quantity: quantity,
      );

      await productBox.add(product.toMap());
      return true; 
    } catch (e) {
      return false; 
    }
  }

  List<Product> getProducts() {
    return productBox.values
        .map((e) => Product.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> deleteProduct(Product product) async {
    final index = productBox.values.toList().indexWhere(
      (element) => Product.fromMap(Map<String, dynamic>.from(element)).name == product.name,
    );

    if (index != -1) {
      await productBox.deleteAt(index);
    }
  }

  Future<bool> updateProduct(Product oldProduct, Product newProduct) async {
    final newName = newProduct.name.trim();

    bool productExists = productBox.values.any((element) {
      final existingProduct = Product.fromMap(Map<String, dynamic>.from(element));
      return existingProduct.name.toLowerCase() == newName.toLowerCase() && 
            existingProduct.name.toLowerCase() != oldProduct.name.toLowerCase();
    });

    if (productExists) {
      return false; 
    }

    final index = productBox.values.toList().indexWhere(
      (element) => Product.fromMap(Map<String, dynamic>.from(element)).name.toLowerCase() == oldProduct.name.toLowerCase(),
    );

    if (index != -1) {
      await productBox.putAt(index, newProduct.toMap());
      return true; 
    }
    
    return false; 
  }

  
}
