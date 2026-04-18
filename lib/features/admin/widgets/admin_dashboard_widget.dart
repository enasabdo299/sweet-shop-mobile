import 'package:flutter/material.dart';

class AdminDashboardWidget extends StatelessWidget {
  const AdminDashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text('Dashboard Widget'),
      subtitle: Text('Admin specific details'),
    );
  }
}
