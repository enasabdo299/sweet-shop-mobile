import 'product_model.dart';

class Order {
  final String orderId;
  final String userId;
  final DateTime orderDate;
  final List<Product> products;
  final double totalAmount;

  Order({
    required this.orderId,
    required this.userId,
    required this.orderDate,
    required this.products,
    required this.totalAmount,
  });

  // تحويل الكائن إلى خريطة
  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'orderDate': orderDate.toIso8601String(),
      'products': products.map((product) => product.toMap()).toList(),
      'totalAmount': totalAmount,
    };
  }

  // تحويل خريطة إلى كائن
  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderId: map['orderId'],
      userId: map['userId'],
      orderDate: DateTime.parse(map['orderDate']),
      products: List<Product>.from(map['products'].map((product) => Product.fromMap(product))),
      totalAmount: map['totalAmount'],
    );
  }
}
