import 'package:flutter/material.dart';
import 'package:sweetshop/core/theme/app_colors.dart';
import 'package:sweetshop/database_helper.dart';

class ManageProductsScreen extends StatefulWidget {
  const ManageProductsScreen({super.key});

  @override
  _ManageProductsScreenState createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts(); // تحميل المنتجات عند فتح الصفحة
  }

  // تحميل المنتجات من قاعدة البيانات
  Future<void> _loadProducts() async {
    List<Map<String, dynamic>> data = await DatabaseHelper.instance.getAllProducts();
    setState(() {
      products = data;
    });
  }

  // إضافة منتج جديد
  Future<void> _addProduct(String name, String price, String quantity, String imageUrl) async {
    Map<String, dynamic> product = {
      'productName': name,
      'price': price,
      'quantity': quantity,
      'image': imageUrl
    };

    print("إضافة المنتج: $product");  // تحقق من القيم قبل الإضافة

    int newId = await DatabaseHelper.instance.insertProduct(product);
    print("تمت إضافة المنتج برقم ID: $newId"); // تحقق مما إذا كان الإضافة ناجحة

    _loadProducts();
  }

  // حذف المنتج
  Future<void> _deleteProduct(int id) async {
    await DatabaseHelper.instance.deleteProduct(id);
    _loadProducts();
  }

  // نافذة إدخال المنتج
  void _showAddProductDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    TextEditingController imageUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Product Name')),
            TextField(controller: priceController, decoration: const InputDecoration(labelText: 'Price')),
            TextField(controller: quantityController, decoration: const InputDecoration(labelText: 'Quantity')),
            TextField(controller: imageUrlController, decoration: const InputDecoration(labelText: 'Image URL')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _addProduct(nameController.text, priceController.text, quantityController.text, imageUrlController.text);
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // استخدام MediaQuery للحصول على أبعاد الشاشة
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: _showAddProductDialog, // فتح نافذة إضافة المنتج
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(screenWidth * 0.05), // استخدام العرض لتحديد الهوامش
        color: Colors.pink.shade50,
        child: Column(
          children: [
            Column(
              children: [
                Icon(Icons.cake, size: 80, color: Colors.pink),
                SizedBox(height: screenHeight * 0.02), // استخدام الارتفاع لتحديد المسافات
                Text(
                  "Product Management",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.pink.shade900),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03), // تغيير المسافة بين العناوين والقائمة

            // قائمة المنتجات
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, spreadRadius: 2),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
                      leading: CircleAvatar(
                        backgroundImage: product['image'] != null && product['image'].isNotEmpty
                            ? NetworkImage(product['image'])
                            : const AssetImage('assets/default_product.png') as ImageProvider,
                      ),
                      title: Text(
                        product['productName'],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink.shade800),
                      ),
                      subtitle: Text('Price: ${product['price']}\nQuantity: ${product['quantity']}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteProduct(product['id']),
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
}
