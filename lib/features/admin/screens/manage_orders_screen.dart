import 'package:flutter/material.dart';
import 'package:sweetshop/core/theme/app_colors.dart';  // تأكد من أن لديك الألوان المحددة
import 'package:sweetshop/database_helper.dart';

class ManageOrdersScreen extends StatefulWidget {
  const ManageOrdersScreen({super.key});

  @override
  _ManageOrdersScreenState createState() => _ManageOrdersScreenState();
}

class _ManageOrdersScreenState extends State<ManageOrdersScreen> {
  // نموذج بيانات الطلبات
  List<Map<String, String>> orders = [
    {'orderId': '001', 'customerName': 'John Doe', 'status': 'Pending'},
    {'orderId': '002', 'customerName': 'Jane Smith', 'status': 'Shipped'},
    {'orderId': '003', 'customerName': 'Sam Wilson', 'status': 'Delivered'},
  ];

  @override
  void initState() {
    super.initState();
    // قم بإضافة وظيفة لتحميل البيانات إذا كان لديك قاعدة بيانات
  }

  // دالة لحذف الطلب
  void _deleteOrder(int index) {
    setState(() {
      orders.removeAt(index);  // إزالة الطلب من القائمة
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Orders', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink,  // اللون الوردي للـ AppBar
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        color: Colors.pink.shade50,  // خلفية الشاشة بلون وردي فاتح
        child: Column(
          children: [
            Column(
              children: [
                Icon(Icons.shopping_cart, size: 80, color: Colors.pink),  // أيقونة سلة التسوق
                const SizedBox(height: 10),
                Text(
                  "Order Management",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink.shade900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // قائمة الطلبات
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      leading: CircleAvatar(
                        backgroundColor: Colors.pink,
                        child: const Icon(Icons.shopping_cart, color: Colors.white),
                      ),
                      title: Text(
                        'Order ID: ${order['orderId']}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink.shade800,
                        ),
                      ),
                      subtitle: Text(
                        'Customer: ${order['customerName']}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      trailing: Text(
                        'Status: ${order['status']}',
                        style: TextStyle(color: Colors.pink.shade600),
                      ),
                      onTap: () {
                        // عند النقر على الطلب، يمكن عرض التفاصيل أو تعديله
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Order Details'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Order ID: ${order['orderId']}'),
                                Text('Customer Name: ${order['customerName']}'),
                                Text('Status: ${order['status']}'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
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
