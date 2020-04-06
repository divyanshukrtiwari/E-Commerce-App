import 'package:flutter/material.dart';

class ProductDeatilScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  ProductDeatilScreen();

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
    );
  }
}