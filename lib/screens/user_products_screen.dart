import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';
import '../providers/products.dart';
import '../screens/edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product-screen';
  @override
  Widget build(BuildContext context) {
    final productsdata = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsdata.item.length,
          itemBuilder: (ctx, index) => UserProductItem(
            productsdata.item[index].title,
            productsdata.item[index].imageUrl,
          ),
        ),
      ),
    );
  }
}
