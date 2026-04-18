import '../models/user_model.dart';
import '../data_providers/api_provider.dart';

class UserRepo {
  final ApiProvider apiProvider;

  UserRepo({required this.apiProvider});

  Future<User> getUserById(String userId) async {
    try {
      final userData = await apiProvider.fetchData('users/$userId');
      return User.fromMap(userData as Map<String, dynamic>);
    } catch (e) {
      throw Exception("Failed to load user");
    }
  }
}
