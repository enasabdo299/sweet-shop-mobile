import 'package:flutter/material.dart';
import 'package:sweetshop/features/admin/screens/manage_orders_screen.dart';
import 'package:sweetshop/features/admin/screens/manage_users_screen.dart'; // استخدام شاشة إدارة المستخدمين الموجودة
import 'package:sweetshop/features/authentication/screens/login_screen.dart';
import 'package:sweetshop/features/customer/screens/home_screen.dart';
import 'package:sweetshop/features/admin/screens/dashboard_screen.dart';

// استيراد الصفحات الخاصة بالحلوى
import 'package:sweetshop/features/customer/screens/product/pink_sweets_screen.dart';
import 'package:sweetshop/features/customer/screens/product/blue_sweets_screen.dart';
import 'package:sweetshop/features/customer/screens/product/purple_sweets_screen.dart';
import 'package:sweetshop/features/customer/screens/profile_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) =>  HomeScreen());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) =>  DashboardScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) =>  ProfileScreen());
      case '/ManageCustomers':
      // استخدام ManageUsersScreen بدلاً من ManageCustomersScreen
        return MaterialPageRoute(builder: (_) =>  ManageUsersScreen());
      case '/ManageOrders':
        return MaterialPageRoute(builder: (_) =>  ManageOrdersScreen());

    // إضافة مسارات جديدة للصفحات الخاصة بالحلوى
      case '/pinkSweets':
        return MaterialPageRoute(builder: (_) =>  PinkSweetsScreen());
      case '/blueSweets':
        return MaterialPageRoute(builder: (_) =>  BlueSweetsScreen(product: {},));
      case '/purpleSweets':
        return MaterialPageRoute(builder: (_) =>  PurpleSweetsScreen());

    // إضافة مسار لتسجيل الخروج بعد التأكيد
      case '/logout':
        return MaterialPageRoute(builder: (_) {
          // هنا يمكن تنفيذ إجراءات تأكيد الخروج أو عمليات أخرى
          return LoginScreen();
        });

      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}
