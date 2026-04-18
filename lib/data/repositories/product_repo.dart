import '../models/product_model.dart';
import '../data_providers/api_provider.dart';

class ProductRepo {
  final ApiProvider apiProvider;

  ProductRepo({required this.apiProvider});

  Future<List<Product>> getAllProducts() async {
    try {
      final productData = await apiProvider.fetchData('products');
      return productData.map<Product>((product) => Product.fromMap(product)).toList();
    } catch (e) {
      throw Exception("Failed to load products");
    }
  }
}
