
import '../models/order_model.dart';

final List<Order> mockOrders = [
  Order(
    orderId: '1',
    userId: '1',
    orderDate: DateTime.now(),
    //products: [[0]],
    totalAmount: 15.99, products: [],
  ),
  Order(
    orderId: '2',
    userId: '2',
    orderDate: DateTime.now(),
    //products: [mockProducts[1]],
    totalAmount: 12.99, products: [],
  ),
];
