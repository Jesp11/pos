import 'package:pos/models/inventory_product.dart';
import 'package:pos/models/products.dart';
import 'package:pos/services/product_service.dart';

class InventoryService {
  final ProductService productService = ProductService();
  List<InventoryProduct> _inventory = [];

  Future<void> loadProductsFromService() async {
    final products = await productService.getProducts();
    
    _inventory = products.map((product) {
      return InventoryProduct(
        name: product.name,
        price: product.price,
        quantity: product.quantity,
        category: product.category,
        supplier: product.supplier,
        availableQuantity: product.quantity,
      );
    }).toList();
  }

  Future<List<InventoryProduct>> getAllInventoryProducts() async {
    if (_inventory.isEmpty) {
      await loadProductsFromService();
    }
    return _inventory;
  }

  Future<void> addQuantity(InventoryProduct product, int quantity) async {
    product.availableQuantity += quantity;

    final index = productService.productBox.values.toList().indexWhere(
      (element) => Product.fromMap(Map<String, dynamic>.from(element)).name.toLowerCase() == product.name.toLowerCase(),
    );

    if (index != -1) {
      final existingProduct = Product.fromMap(Map<String, dynamic>.from(productService.productBox.getAt(index)));
      
      final updatedProduct = Product(
        name: existingProduct.name,
        category: existingProduct.category,
        supplier: existingProduct.supplier,
        price: existingProduct.price,
        quantity: product.availableQuantity, 
      );

      // Guardar los cambios en la productBox
      await productService.productBox.putAt(index, updatedProduct.toMap());
    }
  }

  Future<List<InventoryProduct>> searchProductByName(String name) async {
    return _inventory.where((product) => product.name.toLowerCase().contains(name.toLowerCase())).toList();
  }

  
}
