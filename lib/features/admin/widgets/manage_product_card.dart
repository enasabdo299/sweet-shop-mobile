import 'package:flutter/material.dart';

class ManageProductCard extends StatelessWidget {
  final String productName;
  final double productPrice;

  const ManageProductCard(
      {super.key, required this.productName, required this.productPrice});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(productName),
        subtitle: Text('\$$productPrice'),
      ),
    );
  }
}
