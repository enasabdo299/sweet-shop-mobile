import '../models/order_model.dart';
import '../data_providers/api_provider.dart';

class OrderRepo {
  final ApiProvider apiProvider;

  OrderRepo({required this.apiProvider});

  Future<List<Order>> getAllOrders() async {
    try {
      final orderData = await apiProvider.fetchData('orders');
      return orderData.map<Order>((order) => Order.fromMap(order)).toList();
    } catch (e) {
      throw Exception("Failed to load orders");
    }
  }
}
