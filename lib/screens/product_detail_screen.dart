import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDeatilScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  ProductDeatilScreen();

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).fingById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
