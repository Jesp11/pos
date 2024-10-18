import 'package:flutter/material.dart';
import 'package:pos/models/inventory_product.dart';
import 'package:pos/services/incentory_serrvice.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final InventoryService inventoryService = InventoryService();
  List<InventoryProduct> inventory = [];
  TextEditingController searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _loadInventory();
  }

  Future<void> _loadInventory() async {
    inventory = await inventoryService.getAllInventoryProducts();
    setState(() {});
  }

  Future<void> _addQuantity(InventoryProduct product, int quantity) async {
    await inventoryService.addQuantity(product, quantity);
    setState(() {});
  }

  Future<void> _searchProduct() async {
    inventory = await inventoryService.searchProductByName(searchController.text);
    setState(() {});
  }

  void _createProduct() {
    Navigator.pushNamed(context, '/product/add');
  }

  void _createCategory() {
    Navigator.pushNamed(context, '/category/add');
  }

  void _createSupplier() {
    Navigator.pushNamed(context, '/supplier/add');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _searchProduct,
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'New Product') {
                _createProduct();
              } else if (value == 'New Category') {
                _createCategory();
              } else if (value == 'New Supplier') {
                _createSupplier();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'New Product',
                child: Text('Add Product'),
              ),
              PopupMenuItem(
                value: 'New Category',
                child: Text('Add Category'),
              ),
              PopupMenuItem(
                value: 'New Supplier',
                child: Text('Add Supplier'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Product',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
              ),
              onSubmitted: (value) => _searchProduct(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: inventory.length,
                itemBuilder: (context, index) {
                  final product = inventory[index];
                  return Card(
                    child: ListTile(
                      title: Text(product.name),
                      subtitle: Text('Available quantity: ${product.availableQuantity}'),
                      trailing: ElevatedButton(
                        onPressed: () => _addQuantityDialog(product),
                        child: const Text('Increase Quantity'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addQuantityDialog(InventoryProduct product) async {
    final TextEditingController quantityController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Increase Quantity'),
          content: TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Quantity to add',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final quantity = int.tryParse(quantityController.text) ?? 0;
                if (quantity > 0) {
                  _addQuantity(product, quantity);
                }
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
