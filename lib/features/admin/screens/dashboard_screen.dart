import 'package:flutter/material.dart';
import 'package:sweetshop/core/theme/app_colors.dart';
import 'package:sweetshop/features/admin/screens/manage_users_screen.dart';
import 'manage_orders_screen.dart';
import 'manage_products_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        color: AppColors.backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildStatisticsCard(), // إضافة كارد الإحصائيات
            const SizedBox(height: 30),

            // زر إدارة الطلبات
            _buildDashboardButton(
              context,
              "Manage Orders",
              Icons.shopping_cart,
              AppColors.primaryColor,
               ManageOrdersScreen(),
            ),

            const SizedBox(height: 15),

            // زر إدارة المنتجات (تم تغيير اللون إلى بنفسجي فاتح)
            _buildDashboardButton(
              context,
              "Manage Products",
              Icons.inventory,
              AppColors.primaryColor,
              const ManageProductsScreen(),
            ),

            const SizedBox(height: 15),

            // زر إدارة العملاء
            _buildDashboardButton(
              context,
              "Manage Customers",
              Icons.people,
              AppColors.primaryColor,
              const ManageUsersScreen(),
            ),
          ],
        ),
      ),
    );
  }

  // كارد الإحصائيات
  Widget _buildStatisticsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Dashboard Overview',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatisticItem(Icons.people, "Customers", "120"),
              _buildStatisticItem(Icons.shopping_cart, "Orders", "250"),
            ],
          ),
        ],
      ),
    );
  }

  // عنصر في كارد الإحصائيات
  Widget _buildStatisticItem(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, size: 40, color: AppColors.primaryColor),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(title),
      ],
    );
  }

  Widget _buildDashboardButton(
      BuildContext context, String title, IconData icon, Color color, Widget screen) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        icon: Icon(icon, color: Colors.white),
        label: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
