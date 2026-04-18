import 'package:flutter/material.dart';
import 'package:sweetshop/core/theme/app_colors.dart';
import 'package:sweetshop/database_helper.dart';
import 'dashboard_screen.dart';
class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  _ManageUsersScreenState createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  // قائمة المستخدمين
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers(); // تحميل المستخدمين عند بداية تشغيل الشاشة
  }

  // دالة تحميل المستخدمين
  Future<void> _loadUsers() async {
    final data = await DatabaseHelper.instance.getAllUsers(); // استرجاع المستخدمين من قاعدة البيانات
    setState(() {
      users = data;
    });
  }

  // دالة لحذف المستخدم
  void _deleteUser(int id) async {
    await DatabaseHelper.instance.deleteUser(id); // حذف المستخدم من قاعدة البيانات
    _loadUsers(); // إعادة تحميل المستخدمين بعد الحذف
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Users',
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
          children: [
            Column(
              children: [
                Icon(Icons.people, size: 80, color: AppColors.primaryColor),
                const SizedBox(height: 10),
                Text(
                  "User Management",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // زر إضافة مستخدم جديد
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // يمكنك هنا إضافة صفحة لتسجيل المستخدم أو تنفيذ الأكواد مباشرة
                  DatabaseHelper.instance.insertOrUpdateUser("newuser@example.com", "password123", "user"); // إضافة مستخدم اختبار
                  _loadUsers(); // إعادة تحميل المستخدمين بعد إضافة المستخدم الجديد
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  "Add User",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // قائمة المستخدمين
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
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
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      leading: CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(
                        user["email"]!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                        ),
                      ),
                      subtitle: Text(user["role"]!, style: TextStyle(color: Colors.grey[700])),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteUser(user["id"]); // حذف المستخدم
                        },
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
